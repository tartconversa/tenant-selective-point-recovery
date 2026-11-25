# 多租户培训库的按时点核验与选择性恢复

各记录目录保存独立的合成业务资料。SQL 文件仅包含原始关系表与已有行。manifest.json 记录库角色、表、行数及运行参数。timeline.json 记录后续客户端行为、来源提交或故障，用 pos 表示可比较的到达次序。同一 pos 按数组顺序。提交位置由相应记录的业务字段指定。

## 接入协议

各表名称的 earliest_ 前缀表示旁库备份断面，live_ 表示恢复审批前的当前库。table 以双方共有的逻辑主键联系。journal 以事务 position 为单位，rows 中的 delete、update 或 insert 带完整行内容；从基线到所选位置包含该位置提交。`shape` 指定历史模式。旧列 sector 和当前 industry 只有参照对应工作分类时才能映射，目录代码 code 是实际外部引用，不凭名称匹配。
班次 course_id、学员 learner_id 及明细 attendance_id 均不可重用。同一机构同名批次的自然键为 tenant、local_no，可能指两个不同班次。共享课程分类可被本次恢复范围外的行引用。`inspect` 和 `approve` 是操作员请求，`concurrent` 是当前库另一连接提交。末端记录的互斥结果由实际数据决定。

## 本地资料

使用 Python 3.11.2 和内置 SQLite 3.40.1。以下命令从记录创建关系库，目标文件需要尚不存在。各角色可以作为独立 SQLite 文件读取。

~~~sh
python3 seed_db.py fixtures/recovery-plan-meets-new-natural-key earliest-local.db --role earliest
python3 seed_db.py fixtures/recovery-plan-meets-new-natural-key live-local.db --role live
~~~

使用 Python 的 sqlite3 打开新文件即可访问原始表。用 python3 -m unittest -v 核对资料可装载、表与原始记录一致、SQLite 可同时打开读写连接。后续事件保存在各自的原始记录中。
