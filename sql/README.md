## 数据库导入说明
依次执行
    ry_xxx.sql 脚本
    quartz.sql 脚本
    tony-flowable.sql 脚本

## 已有数据库的界面定制

已经完成上述初始化的数据库，不需要重新导入基础脚本。执行以下脚本即可更新组织名称、管理员昵称，并移除系统监控、系统工具、官网及其他非流程菜单：

```sql
USE `tony-flowable-24`;
SOURCE process-management-customization.sql;
```

执行后退出并重新登录；如果菜单仍显示旧数据，请清空当前项目使用的 Redis 数据库后重启后端。
