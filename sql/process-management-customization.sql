-- 流程管理系统界面与组织数据定制（适用于已初始化的数据库）
-- 执行前请先选择项目数据库：USE `tony-flowable-24`;

UPDATE sys_dept SET dept_name = '流程管理中心', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 100;
UPDATE sys_dept SET dept_name = '管理职能部门', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 101;
UPDATE sys_dept SET dept_name = '业务执行部门', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 102;
UPDATE sys_dept SET dept_name = '技术部门', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 103;
UPDATE sys_dept SET dept_name = '项目管理部', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 104;
UPDATE sys_dept SET dept_name = '费控部', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 105;
UPDATE sys_dept SET dept_name = '综合管理部', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 106;
UPDATE sys_dept SET dept_name = '审批运营部', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 107;
UPDATE sys_dept SET dept_name = '项目执行部', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 108;
UPDATE sys_dept SET dept_name = '资料管理部', leader = '系统管理员', email = 'workflow@example.com' WHERE dept_id = 109;

UPDATE sys_user SET nick_name = '系统管理员', email = 'admin@example.com', remark = '系统管理员' WHERE user_name = 'admin';
UPDATE sys_user SET nick_name = '流程测试员', email = 'tester@example.com', remark = '流程测试员' WHERE user_name = 'ry';

-- 仅保留流程所需的系统管理入口（用户、角色、部门、岗位）以及流程/任务菜单。
DROP TEMPORARY TABLE IF EXISTS obsolete_menu_ids;
CREATE TEMPORARY TABLE obsolete_menu_ids (menu_id BIGINT PRIMARY KEY);
INSERT IGNORE INTO obsolete_menu_ids (menu_id)
WITH RECURSIVE obsolete_menu AS (
    SELECT menu_id FROM sys_menu WHERE menu_id IN (2, 3, 4, 102, 105, 106, 107)
    UNION ALL
    SELECT child.menu_id
    FROM sys_menu child
    INNER JOIN obsolete_menu parent ON child.parent_id = parent.menu_id
)
SELECT menu_id FROM obsolete_menu;

DELETE role_menu
FROM sys_role_menu role_menu
INNER JOIN obsolete_menu_ids obsolete ON obsolete.menu_id = role_menu.menu_id;

DELETE menu
FROM sys_menu menu
INNER JOIN obsolete_menu_ids obsolete ON obsolete.menu_id = menu.menu_id;

DROP TEMPORARY TABLE obsolete_menu_ids;
