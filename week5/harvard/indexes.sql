CREATE INDEX "enrollments_student_course" ON "enrollments"("student_id","course_id");

CREATE INDEX "enrollments_course_id" ON "enrollments"("course_id");
CREATE INDEX "course_depart_num_sem" ON "courses"("department", "number", "semester");

CREATE INDEX "courses_sem" ON "courses"("semester");

CREATE INDEX "satisfies_course_id" ON "satisfies"("course_id");
CREATE INDEX "courses_title_sem" ON "courses"("title", "semester");
