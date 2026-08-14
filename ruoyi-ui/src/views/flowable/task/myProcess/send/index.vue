<template>
  <div class="approval-compose">
    <el-card class="compose-card" shadow="never">
      <div slot="header" class="compose-header">
        <div>
          <span class="compose-label">NEW APPROVAL</span>
          <h2>{{ processName }}</h2>
        </div>
        <el-button size="mini" plain @click="goBack">返回</el-button>
      </div>

      <el-form ref="approvalForm" :model="form" :rules="rules" label-position="top">
        <el-form-item label="审批主题" prop="subject">
          <el-input v-model.trim="form.subject" maxlength="100" show-word-limit placeholder="请输入本次审批主题" />
        </el-form-item>

        <el-form-item label="审批内容" prop="content">
          <el-input
            v-model="form.content"
            type="textarea"
            :rows="12"
            maxlength="5000"
            show-word-limit
            placeholder="请像撰写邮件一样，完整说明申请背景、具体事项、时间要求及需要审批的内容"
          />
        </el-form-item>

        <el-form-item label="附件">
          <file-upload v-model="form.attachments" :limit="10" :file-size="20" :file-type="allowedFileTypes" />
        </el-form-item>

        <el-form-item label="备注">
          <el-input v-model="form.remark" type="textarea" :rows="3" maxlength="500" show-word-limit placeholder="可补充其他说明（选填）" />
        </el-form-item>

        <div class="compose-actions">
          <el-button @click="resetForm">重置</el-button>
          <el-button type="primary" :loading="submitting" @click="submitForm">发起审批</el-button>
        </div>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { definitionStart } from '@/api/flowable/definition'

export default {
  name: 'ApprovalCompose',
  data() {
    return {
      procDefId: '',
      processKey: '',
      processName: '流程审批表',
      submitting: false,
      allowedFileTypes: ['doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'pdf', 'dwg', 'png', 'jpg', 'jpeg', 'zip', 'rar'],
      form: {
        subject: '',
        content: '',
        attachments: '',
        remark: ''
      },
      rules: {
        subject: [{ required: true, message: '请输入审批主题', trigger: 'blur' }],
        content: [{ required: true, message: '请输入审批内容', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.procDefId = this.$route.query.procDefId || ''
    this.processKey = this.$route.query.processKey || ''
    this.processName = this.$route.query.processName || this.resolveProcessName(this.processKey)
  },
  methods: {
    resolveProcessName(processKey) {
      return processKey === 'resourceRequestApproval'
        ? '电网项目管理部提资流程审批表'
        : '电网项目管理部内部管理流程审批表'
    },
    submitForm() {
      this.$refs.approvalForm.validate(valid => {
        if (!valid || !this.procDefId) return
        this.submitting = true
        const variables = {
          approvalSubject: this.form.subject,
          approvalContent: this.form.content,
          approvalAttachments: this.form.attachments,
          approvalRemark: this.form.remark,
          processFormName: this.processName
        }
        definitionStart(this.procDefId, variables).then(res => {
          this.$modal.msgSuccess(res.msg)
          this.goBack()
        }).finally(() => {
          this.submitting = false
        })
      })
    },
    resetForm() {
      this.$refs.approvalForm.resetFields()
      this.form.attachments = ''
    },
    goBack() {
      this.$tab.closeOpenPage({ path: '/task/process', query: { t: Date.now() }})
    }
  }
}
</script>

<style scoped lang="scss">
.approval-compose { min-height: calc(100vh - 84px); padding: 28px; background: #efefef; }
.compose-card { max-width: 980px; margin: 0 auto; border-color: #cfcfcf; }
.compose-header { display: flex; align-items: center; justify-content: space-between; }
.compose-header h2 { margin: 8px 0 0; color: #222; font-size: 21px; font-weight: 600; }
.compose-label { color: #999; font-size: 10px; letter-spacing: 3px; }
.compose-card ::v-deep .el-card__body { padding: 30px 40px; }
.compose-card ::v-deep .el-form-item__label { color: #333; font-weight: 600; }
.compose-card ::v-deep .el-textarea__inner { line-height: 1.8; resize: vertical; }
.compose-actions { display: flex; justify-content: flex-end; gap: 12px; padding-top: 12px; border-top: 1px solid #ddd; }
@media (max-width: 768px) { .approval-compose { padding: 12px; } .compose-card ::v-deep .el-card__body { padding: 20px; } }
</style>
