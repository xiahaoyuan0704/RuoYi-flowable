<template>
  <div class="workflow-home">
    <section class="hero-panel">
      <div>
        <span class="eyebrow">WORKFLOW CENTER</span>
        <h1>流程管理系统</h1>
        <p>面向内部审批、提资申请与任务协同的统一工作台。</p>
      </div>
      <div class="hero-mark">流程 · 审批 · 协同</div>
    </section>

    <el-row :gutter="18" class="entry-grid">
      <el-col v-for="entry in entries" :key="entry.path" :xs="24" :sm="12" :lg="6">
        <button class="entry-card" type="button" @click="$router.push(entry.path)">
          <span class="entry-index">{{ entry.index }}</span>
          <i :class="entry.icon" />
          <strong>{{ entry.title }}</strong>
          <small>{{ entry.description }}</small>
        </button>
      </el-col>
    </el-row>

    <section class="guide-panel">
      <div class="section-title">
        <span>办理指引</span>
        <small>PROCESS GUIDE</small>
      </div>
      <el-row :gutter="24">
        <el-col :xs="24" :md="12">
          <div class="guide-item">
            <span class="guide-number">01</span>
            <div><strong>内部管理审批</strong><p>发起后由费控主任、项目经理、部门经理并行审批，全部完成后进入阅知。</p></div>
          </div>
        </el-col>
        <el-col :xs="24" :md="12">
          <div class="guide-item">
            <span class="guide-number">02</span>
            <div><strong>提资申请</strong><p>技术部门负责人审批后并行办理，费控分支转经办人，全部完成后进入阅知。</p></div>
          </div>
        </el-col>
      </el-row>
    </section>
  </div>
</template>

<script>
export default {
  name: 'Index',
  data() {
    return {
      entries: [
        { index: '01', title: '发起流程', description: '提交新的内部审批申请', icon: 'el-icon-edit-outline', path: '/task/process' },
        { index: '02', title: '待办任务', description: '处理当前待审批任务', icon: 'el-icon-tickets', path: '/task/todo' },
        { index: '03', title: '已办任务', description: '查询个人办理记录', icon: 'el-icon-finished', path: '/task/finished' },
        { index: '04', title: '流程定义', description: '维护审批流程模型', icon: 'el-icon-connection', path: '/flowable/definition' }
      ]
    }
  }
}
</script>

<style scoped lang="scss">
.workflow-home { min-height: calc(100vh - 84px); padding: 28px; background: #f1f1f1; color: #1d1d1d; }
.hero-panel { display: flex; justify-content: space-between; align-items: flex-end; min-height: 210px; padding: 42px 48px; color: #fff; background: #181818; border-left: 8px solid #777; }
.eyebrow { font-size: 12px; letter-spacing: 4px; color: #aaa; }
.hero-panel h1 { margin: 18px 0 10px; font-size: 38px; letter-spacing: 3px; }
.hero-panel p { margin: 0; color: #bbb; font-size: 15px; }
.hero-mark { padding-bottom: 7px; color: #8e8e8e; font-size: 13px; letter-spacing: 5px; }
.entry-grid { margin-top: 18px; }
.entry-card { position: relative; width: 100%; min-height: 164px; margin-bottom: 18px; padding: 30px; text-align: left; color: #222; background: #fff; border: 1px solid #d4d4d4; cursor: pointer; transition: .2s ease; }
.entry-card:hover { color: #fff; background: #303030; border-color: #303030; transform: translateY(-3px); }
.entry-card i { display: block; margin-bottom: 24px; font-size: 27px; }
.entry-card strong, .entry-card small { display: block; }
.entry-card strong { margin-bottom: 8px; font-size: 16px; }
.entry-card small { color: #888; }
.entry-card:hover small { color: #bbb; }
.entry-index { position: absolute; top: 20px; right: 22px; color: #aaa; font-family: monospace; }
.guide-panel { padding: 30px 36px; background: #fff; border: 1px solid #d4d4d4; }
.section-title { display: flex; align-items: baseline; gap: 14px; margin-bottom: 28px; font-size: 18px; font-weight: 600; }
.section-title small { color: #aaa; font-size: 10px; letter-spacing: 3px; }
.guide-item { display: flex; gap: 20px; padding: 20px 0; border-top: 1px solid #ddd; }
.guide-number { color: #aaa; font: 24px monospace; }
.guide-item strong { font-size: 15px; }
.guide-item p { margin: 9px 0 0; color: #777; line-height: 1.7; }
@media (max-width: 768px) { .workflow-home { padding: 14px; } .hero-panel { padding: 28px; } .hero-mark { display: none; } .hero-panel h1 { font-size: 28px; } }
</style>
