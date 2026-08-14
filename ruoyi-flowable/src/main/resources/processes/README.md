# 预置审批流程

本目录提供两份可直接由 Flowable 自动部署、也可在“流程管理 / 流程定义”中导入的 BPMN 2.0 流程：

| 流程定义 key | 名称 | 审批路径 |
| --- | --- | --- |
| `internalManagementApproval` | 电网项目管理部内部管理流程审批表 | 发起人 → 费控主任、项目经理、部门经理（并行会签）→ 刘群、郑向峰（并行阅知） |
| `resourceRequestApproval` | 电网项目管理部提资流程审批表 | 提资人 → 技术部门负责人 → 费控主任（再转经办人）、项目经理（并行）→ 刘群、郑向峰（并行阅知） |

## 启动参数

人员均使用若依的用户 ID，发起接口会自动写入当前登录用户的 `initiator`。启动流程时还需按流程传入以下参数：

- `costControlDirectorUserId`：费控主任用户 ID；
- `projectManagerUserId`：项目经理用户 ID；
- `departmentManagerUserId`：部门经理用户 ID（仅内部管理审批流程）；
- `technicalDepartmentLeaderUserId`：技术部门负责人用户 ID（仅提资申请流程）；
- `handlerUserId`：转经办人用户 ID（仅提资申请流程）；
- `liuQunUserId`：刘群用户 ID；
- `zhengXiangfengUserId`：郑向峰用户 ID。

示例请求体（实际 ID 请以 `sys_user.user_id` 为准）：

```json
{
  "costControlDirectorUserId": "101",
  "projectManagerUserId": "102",
  "departmentManagerUserId": "103",
  "technicalDepartmentLeaderUserId": "104",
  "handlerUserId": "105",
  "liuQunUserId": "106",
  "zhengXiangfengUserId": "107"
}
```

“抄送”使用两个并行的阅知任务实现，确保刘群、郑向峰两人均能在各自待办中看到流程；两人均确认阅知后流程结束。审批拒绝、退回继续使用系统现有的任务操作。
