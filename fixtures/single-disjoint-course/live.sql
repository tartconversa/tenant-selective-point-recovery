BEGIN TRANSACTION;
CREATE TABLE "live_attendance" (attendance_id TEXT PRIMARY KEY, learner_id TEXT, marked INTEGER);
CREATE TABLE "live_course" (course_id TEXT PRIMARY KEY, tenant TEXT, local_no TEXT, code TEXT);
CREATE TABLE "live_learner" (learner_id TEXT PRIMARY KEY, course_id TEXT);
CREATE TABLE "live_trade" (code TEXT PRIMARY KEY, industry TEXT, title TEXT);
INSERT INTO "live_trade" VALUES('x','care','陪护');
COMMIT;
