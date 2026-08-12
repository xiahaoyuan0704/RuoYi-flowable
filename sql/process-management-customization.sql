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

-- 预置流程办理账号，初始密码与 admin 相同（admin123），登录后可在用户管理中修改。
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, create_by, create_time, update_by, update_time, remark) VALUES
(110, 105, 'cost_director', '费控主任', '00', 'cost@example.com', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', NOW(), '', NULL, '流程办理账号'),
(111, 104, 'project_manager', '项目经理', '00', 'project@example.com', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', NOW(), '', NULL, '流程办理账号'),
(112, 106, 'department_manager', '部门经理', '00', 'department@example.com', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', NOW(), '', NULL, '流程办理账号'),
(113, 103, 'technical_leader', '技术部门负责人', '00', 'technical@example.com', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', NOW(), '', NULL, '流程办理账号'),
(114, 108, 'handler', '经办人', '00', 'handler@example.com', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', NOW(), '', NULL, '流程办理账号'),
(115, 107, 'liuqun', '刘群', '00', 'liuqun@example.com', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', NOW(), '', NULL, '抄送阅知账号'),
(116, 107, 'zhengxiangfeng', '郑向峰', '00', 'zhengxiangfeng@example.com', '', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', NOW(), '', NULL, '抄送阅知账号')
ON DUPLICATE KEY UPDATE nick_name = VALUES(nick_name), dept_id = VALUES(dept_id), status = '0', del_flag = '0';

INSERT IGNORE INTO sys_user_role (user_id, role_id) VALUES
(110, 2), (111, 2), (112, 2), (113, 2), (114, 2), (115, 2), (116, 2);

-- 普通流程办理角色可访问任务管理菜单。
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES
(2, 2023), (2, 2024), (2, 2025), (2, 2026);

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
