## 数据库导入说明
依次执行
    ry_xxx.sql 脚本
    quartz.sql 脚本
    tony-flowable.sql 脚本

## 已有数据库的界面定制

已经完成上述初始化的数据库，不需要重新导入基础脚本。执行以下脚本即可更新组织名称和管理员昵称，精简系统管理/流程管理菜单，并确保流程管理只对超级管理员显示：

```sql
USE `tony-flowable-24`;
SOURCE process-management-customization.sql;
```

执行后退出并重新登录；如果菜单仍显示旧数据，请清空当前项目使用的 Redis 数据库后重启后端。
