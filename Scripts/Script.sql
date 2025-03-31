-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;
-- public.assessment_bank definition

-- Drop table

-- DROP TABLE public.assessment_bank;

CREATE TABLE public.assessment_bank (
	id uuid NOT NULL,
	"year" varchar NULL,
	semester varchar NULL,
	"cycle" varchar NULL,
	"level" varchar NULL,
	subject varchar NULL,
	"type" varchar NULL,
	grade varchar NULL,
	maximum_score numeric NULL,
	"show" bool NULL,
	CONSTRAINT assesment_bank_pk PRIMARY KEY (id)
);


-- public.class_date definition

-- Drop table

-- DROP TABLE public.class_date;

CREATE TABLE public.class_date (
	id uuid NOT NULL,
	CONSTRAINT class_date_pk PRIMARY KEY (id)
);


-- public.focus_standard definition

-- Drop table

-- DROP TABLE public.focus_standard;

CREATE TABLE public.focus_standard (
	id uuid NOT NULL,
	"name" varchar NOT NULL,
	description varchar NULL,
	CONSTRAINT focus_standard_pk PRIMARY KEY (id)
);


-- public.notification definition

-- Drop table

-- DROP TABLE public.notification;

CREATE TABLE public.notification (
	id uuid NOT NULL,
	"text" varchar NOT NULL,
	created_at timestamptz NULL,
	notification_type varchar NULL,
	severity varchar NULL,
	title varchar NULL,
	CONSTRAINT notification_pk PRIMARY KEY (id)
);


-- public.partner definition

-- Drop table

-- DROP TABLE public.partner;

CREATE TABLE public.partner (
	id uuid NOT NULL,
	"name" varchar NULL,
	"type" varchar NULL,
	CONSTRAINT partner_pk PRIMARY KEY (id)
);


-- public.program_type definition

-- Drop table

-- DROP TABLE public.program_type;

CREATE TABLE public.program_type (
	id uuid NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT program_type_pk PRIMARY KEY (id)
);


-- public."role" definition

-- Drop table

-- DROP TABLE public."role";

CREATE TABLE public."role" (
	id uuid NOT NULL,
	"role" varchar NULL,
	CONSTRAINT role_pk PRIMARY KEY (id)
);


-- public.state definition

-- Drop table

-- DROP TABLE public.state;

CREATE TABLE public.state (
	id uuid NOT NULL,
	"name" varchar NULL,
	zipcode int4 NULL,
	state_code varchar NOT NULL,
	CONSTRAINT state_pk PRIMARY KEY (id),
	CONSTRAINT state_unique UNIQUE (state_code)
);


-- public.assessment_documents definition

-- Drop table

-- DROP TABLE public.assessment_documents;

CREATE TABLE public.assessment_documents (
	id uuid NOT NULL,
	title varchar NULL,
	file_type varchar NULL,
	file_name varchar NULL,
	file_url varchar NULL,
	created_at timestamptz NULL,
	created_by uuid NULL,
	assesment_bank_id uuid NULL,
	CONSTRAINT assesment_documents_pk PRIMARY KEY (id),
	CONSTRAINT assesment_documents_assesment_bank_fk FOREIGN KEY (assesment_bank_id) REFERENCES public.assessment_bank(id)
);


-- public.district definition

-- Drop table

-- DROP TABLE public.district;

CREATE TABLE public.district (
	id uuid NOT NULL,
	"name" varchar NULL,
	zipcode varchar NULL,
	state_id uuid NOT NULL,
	CONSTRAINT district_pk PRIMARY KEY (id),
	CONSTRAINT district_state_fk FOREIGN KEY (state_id) REFERENCES public.state(id)
);


-- public.partner_state definition

-- Drop table

-- DROP TABLE public.partner_state;

CREATE TABLE public.partner_state (
	partner_id uuid NOT NULL,
	state_id uuid NOT NULL,
	CONSTRAINT partner_state_partner_fk FOREIGN KEY (partner_id) REFERENCES public.partner(id),
	CONSTRAINT partner_state_state_fk FOREIGN KEY (state_id) REFERENCES public.state(id)
);


-- public."program" definition

-- Drop table

-- DROP TABLE public."program";

CREATE TABLE public."program" (
	id uuid NOT NULL,
	"name" varchar NULL,
	type_id uuid NULL,
	CONSTRAINT program_pk PRIMARY KEY (id),
	CONSTRAINT program_program_type_fk FOREIGN KEY (type_id) REFERENCES public.program_type(id)
);


-- public.questions definition

-- Drop table

-- DROP TABLE public.questions;

CREATE TABLE public.questions (
	id uuid NOT NULL,
	question_text varchar NULL,
	question_type varchar NULL,
	created_at timestamptz NULL,
	updated_at timestamptz NULL,
	focus_standard uuid NULL,
	assessments_bank_id uuid NULL,
	CONSTRAINT questions_pk PRIMARY KEY (id),
	CONSTRAINT questions_assessment_bank_fk FOREIGN KEY (assessments_bank_id) REFERENCES public.assessment_bank(id),
	CONSTRAINT questions_focus_standard_fk FOREIGN KEY (focus_standard) REFERENCES public.focus_standard(id)
);


-- public.school definition

-- Drop table

-- DROP TABLE public.school;

CREATE TABLE public.school (
	id uuid NOT NULL,
	"name" varchar NULL,
	"type" varchar NULL,
	short_code varchar NULL,
	address varchar NULL,
	principal_name varchar NULL,
	city varchar NULL,
	district_id uuid NULL,
	principal_mail varchar NULL,
	CONSTRAINT school_pk PRIMARY KEY (id),
	CONSTRAINT school_district_fk FOREIGN KEY (district_id) REFERENCES public.district(id)
);


-- public.school_accounts definition

-- Drop table

-- DROP TABLE public.school_accounts;

CREATE TABLE public.school_accounts (
	id uuid NOT NULL,
	school_id uuid NOT NULL,
	identifier_field varchar NULL,
	identifier varchar NULL,
	created_at timestamptz NULL,
	created_by uuid NULL,
	modified_at timestamptz NULL,
	modified_by uuid NULL,
	CONSTRAINT school_accounts_pk PRIMARY KEY (id),
	CONSTRAINT school_accounts_school_fk FOREIGN KEY (school_id) REFERENCES public.school(id)
);


-- public.school_program definition

-- Drop table

-- DROP TABLE public.school_program;

CREATE TABLE public.school_program (
	school_id uuid NOT NULL,
	program_id uuid NOT NULL,
	created_at timestamptz NULL,
	created_by varchar NULL,
	modified_at timestamptz NULL,
	modified_by varchar NULL,
	CONSTRAINT school_program_program_fk FOREIGN KEY (program_id) REFERENCES public."program"(id),
	CONSTRAINT school_program_school_fk FOREIGN KEY (school_id) REFERENCES public.school(id)
);


-- public.users definition

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	id uuid NOT NULL,
	first_name varchar NULL,
	middle_name varchar NULL,
	last_name varchar NULL,
	phone_number varchar NULL,
	ethnicity varchar NULL,
	active bool NULL,
	created timestamptz NULL,
	updated timestamptz NULL,
	deleted timestamptz NULL,
	delete_reason varchar NULL,
	email_verified timetz NULL,
	email_verification_hash varchar NULL,
	email varchar NULL,
	gender varchar NULL,
	role_id uuid NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_role_fk FOREIGN KEY (role_id) REFERENCES public."role"(id)
);


-- public.answers definition

-- Drop table

-- DROP TABLE public.answers;

CREATE TABLE public.answers (
	id uuid NOT NULL,
	question_id uuid NULL,
	answer_text varchar NULL,
	is_correct bool NULL,
	CONSTRAINT answers_pk PRIMARY KEY (id),
	CONSTRAINT answers_questions_fk FOREIGN KEY (question_id) REFERENCES public.questions(id)
);


-- public.app_users definition

-- Drop table

-- DROP TABLE public.app_users;

CREATE TABLE public.app_users (
	id uuid NOT NULL,
	user_id uuid NULL,
	username varchar NULL,
	"password" varchar NULL,
	last_login timestamptz NULL,
	CONSTRAINT app_users_pk PRIMARY KEY (id),
	CONSTRAINT app_users_users_fk FOREIGN KEY (user_id) REFERENCES public.users(id)
);


-- public.asm definition

-- Drop table

-- DROP TABLE public.asm;

CREATE TABLE public.asm (
	id uuid NOT NULL,
	user_id uuid NULL,
	CONSTRAINT asm_pk PRIMARY KEY (id),
	CONSTRAINT asm_users_fk FOREIGN KEY (user_id) REFERENCES public.users(id)
);


-- public.assessment_bank_program definition

-- Drop table

-- DROP TABLE public.assessment_bank_program;

CREATE TABLE public.assessment_bank_program (
	assesment_bank_id uuid NOT NULL,
	program_id uuid NOT NULL,
	CONSTRAINT assesment_bank_program_assesment_bank_fk FOREIGN KEY (assesment_bank_id) REFERENCES public.assessment_bank(id),
	CONSTRAINT assesment_bank_program_program_fk FOREIGN KEY (program_id) REFERENCES public."program"(id)
);


-- public.notification_setup definition

-- Drop table

-- DROP TABLE public.notification_setup;

CREATE TABLE public.notification_setup (
	id uuid NOT NULL,
	device_type varchar NULL,
	"token" varchar NULL,
	user_id uuid NULL,
	CONSTRAINT newtable_pk PRIMARY KEY (id),
	CONSTRAINT notification_setup_app_users_fk FOREIGN KEY (user_id) REFERENCES public.app_users(id)
);


-- public.tutor definition

-- Drop table

-- DROP TABLE public.tutor;

CREATE TABLE public.tutor (
	id uuid NOT NULL,
	username varchar NULL,
	"password" varchar NULL,
	force_password_change bool NULL,
	paassword_reset_hash varchar NULL,
	last_action_time time NULL,
	logout_token varchar NULL,
	maintenance_mode bool NULL,
	mobile_app_prod_version varchar NULL,
	user_id uuid NULL,
	CONSTRAINT tutor_pk PRIMARY KEY (id),
	CONSTRAINT tutor_users_fk FOREIGN KEY (user_id) REFERENCES public.users(id)
);


-- public.tutor_additional_info definition

-- Drop table

-- DROP TABLE public.tutor_additional_info;

CREATE TABLE public.tutor_additional_info (
	id uuid NOT NULL,
	tutor_id uuid NULL,
	prefered_district varchar NULL,
	max_school_distance numeric NULL,
	CONSTRAINT tutor_additional_info_pk PRIMARY KEY (id),
	CONSTRAINT tutor_additional_info_tutor_fk FOREIGN KEY (tutor_id) REFERENCES public.tutor(id)
);


-- public.tutor_school_list definition

-- Drop table

-- DROP TABLE public.tutor_school_list;

CREATE TABLE public.tutor_school_list (
	tutor_id uuid NULL,
	school_id uuid NULL,
	active bool NULL,
	created_at timestamptz NULL,
	created_by uuid NULL,
	modified_at timestamptz NULL,
	modified_by uuid NULL,
	CONSTRAINT tutor_school_list_school_fk FOREIGN KEY (school_id) REFERENCES public.school(id),
	CONSTRAINT tutor_school_list_tutor_fk FOREIGN KEY (tutor_id) REFERENCES public.tutor(id)
);


-- public.tutor_score definition

-- Drop table

-- DROP TABLE public.tutor_score;

CREATE TABLE public.tutor_score (
	id uuid NULL,
	tutor_id uuid NULL,
	attended_sessions int4 NULL,
	sessions_number int4 NULL,
	missing_info int4 NULL,
	student_pre_test_success_percentage numeric NULL,
	student_post_test_success_percentage numeric NULL,
	CONSTRAINT tutor_score_tutor_fk FOREIGN KEY (tutor_id) REFERENCES public.tutor(id)
);


-- public.tutor_student_groups definition

-- Drop table

-- DROP TABLE public.tutor_student_groups;

CREATE TABLE public.tutor_student_groups (
	id uuid NOT NULL,
	tutor_id uuid NOT NULL,
	created_at timestamptz NULL,
	created_by uuid NULL,
	modified_at timestamptz NULL,
	modified_by uuid NULL,
	partner_id uuid NULL,
	CONSTRAINT tutor_student_list_pk PRIMARY KEY (id),
	CONSTRAINT tutor_student_groups_partner_fk FOREIGN KEY (partner_id) REFERENCES public.partner(id),
	CONSTRAINT tutor_student_list_tutor_fk FOREIGN KEY (tutor_id) REFERENCES public.tutor(id)
);


-- public.user_accounts definition

-- Drop table

-- DROP TABLE public.user_accounts;

CREATE TABLE public.user_accounts (
	id uuid NOT NULL,
	user_id uuid NOT NULL,
	"source" varchar NULL,
	"type" varchar NULL,
	identifier varchar NULL,
	verified bool NULL,
	created_at timestamptz NULL,
	created_by uuid NULL,
	modified_at timestamptz NULL,
	modified_by uuid NULL,
	CONSTRAINT user_accounts_pk PRIMARY KEY (id),
	CONSTRAINT user_accounts_users_fk FOREIGN KEY (user_id) REFERENCES public.users(id)
);


-- public.user_notification definition

-- Drop table

-- DROP TABLE public.user_notification;

CREATE TABLE public.user_notification (
	user_id uuid NOT NULL,
	notification_id uuid NOT NULL,
	is_read bool NULL,
	CONSTRAINT user_notification_app_users_fk FOREIGN KEY (user_id) REFERENCES public.app_users(id),
	CONSTRAINT user_notification_notification_fk FOREIGN KEY (notification_id) REFERENCES public.notification(id)
);


-- public.asm_schools_list definition

-- Drop table

-- DROP TABLE public.asm_schools_list;

CREATE TABLE public.asm_schools_list (
	id uuid NOT NULL,
	asm_id uuid NULL,
	school_id uuid NULL,
	tutor_id uuid NULL,
	program_id uuid NULL,
	CONSTRAINT asm_schools_list_pk PRIMARY KEY (id),
	CONSTRAINT asm_schools_list_asm_fk FOREIGN KEY (asm_id) REFERENCES public.asm(id),
	CONSTRAINT asm_schools_list_program_fk FOREIGN KEY (program_id) REFERENCES public."program"(id),
	CONSTRAINT asm_schools_list_school_fk FOREIGN KEY (school_id) REFERENCES public.school(id),
	CONSTRAINT asm_schools_list_tutor_fk FOREIGN KEY (tutor_id) REFERENCES public.tutor(id)
);


-- public."session" definition

-- Drop table

-- DROP TABLE public."session";

CREATE TABLE public."session" (
	id uuid NOT NULL,
	long_code varchar NULL,
	short_code varchar NULL,
	status varchar NULL,
	scheduled_timestamp timestamptz NULL,
	started_timestamp timestamptz NULL,
	closed_timestamp timetz NULL,
	"date" date NULL,
	"time" time NULL,
	duration int4 NULL,
	created_at timestamptz NULL,
	modified_at timestamptz NULL,
	deleted_at timestamptz NULL,
	created_by varchar NULL,
	modified_by varchar NULL,
	deleted_by varchar NULL,
	tutor_id uuid NULL,
	subtutor_id uuid NULL,
	seesion_type varchar NULL,
	meta varchar NULL,
	subjects varchar NULL,
	num_students int4 NULL,
	grades varchar NULL,
	teacher varchar NULL,
	lead_tutor_id varchar NULL,
	class_date_id uuid NULL,
	CONSTRAINT session_pk PRIMARY KEY (id),
	CONSTRAINT session_class_date_fk FOREIGN KEY (class_date_id) REFERENCES public.class_date(id),
	CONSTRAINT session_tutor_fk FOREIGN KEY (tutor_id) REFERENCES public.tutor(id),
	CONSTRAINT session_tutor_fk_1 FOREIGN KEY (subtutor_id) REFERENCES public.tutor(id)
);


-- public.student definition

-- Drop table

-- DROP TABLE public.student;

CREATE TABLE public.student (
	grade varchar NULL,
	school_id uuid NULL,
	id uuid NOT NULL,
	first_name varchar NULL,
	middle_name varchar NULL,
	last_name varchar NULL,
	verified bool NULL,
	created_by uuid NULL,
	CONSTRAINT student_pk PRIMARY KEY (id),
	CONSTRAINT student_school_fk FOREIGN KEY (school_id) REFERENCES public.school(id),
	CONSTRAINT student_tutor_fk FOREIGN KEY (created_by) REFERENCES public.tutor(id)
);


-- public.student_partner definition

-- Drop table

-- DROP TABLE public.student_partner;

CREATE TABLE public.student_partner (
	partner_id uuid NOT NULL,
	student_id uuid NOT NULL,
	CONSTRAINT student_partner_partner_fk FOREIGN KEY (partner_id) REFERENCES public.partner(id),
	CONSTRAINT student_partner_student_fk FOREIGN KEY (student_id) REFERENCES public.student(id)
);


-- public.student_tsg definition

-- Drop table

-- DROP TABLE public.student_tsg;

CREATE TABLE public.student_tsg (
	group_id uuid NOT NULL,
	student_id uuid NOT NULL,
	CONSTRAINT student_tsg_student_fk FOREIGN KEY (student_id) REFERENCES public.student(id),
	CONSTRAINT student_tsg_tutor_student_groups_fk FOREIGN KEY (group_id) REFERENCES public.tutor_student_groups(id)
);


-- public.substitutes definition

-- Drop table

-- DROP TABLE public.substitutes;

CREATE TABLE public.substitutes (
	id uuid NOT NULL,
	tutor_id uuid NULL,
	subtutor_id uuid NULL,
	status varchar NULL,
	approved_at timestamptz NULL,
	approved_by uuid NULL,
	revoked_at time NULL,
	revoked_by uuid NULL,
	created_at timestamptz NULL,
	created_by uuid NULL,
	modified_at timestamptz NULL,
	modified_by uuid NULL,
	start_date timestamptz NULL,
	end_date timestamptz NULL,
	CONSTRAINT substitutes_pk PRIMARY KEY (id),
	CONSTRAINT substitutes_tutor_fk FOREIGN KEY (tutor_id) REFERENCES public.tutor(id),
	CONSTRAINT substitutes_tutor_fk_1 FOREIGN KEY (subtutor_id) REFERENCES public.tutor(id)
);


-- public.teacher definition

-- Drop table

-- DROP TABLE public.teacher;

CREATE TABLE public.teacher (
	id uuid NOT NULL,
	full_name varchar NULL,
	created_at timestamptz NULL,
	created_by uuid NULL,
	modified_by uuid NULL,
	modified_at timestamptz NULL,
	school_id uuid NULL,
	tutor_id uuid NULL,
	CONSTRAINT teacher_unique UNIQUE (id),
	CONSTRAINT teacher_school_fk FOREIGN KEY (school_id) REFERENCES public.school(id),
	CONSTRAINT teacher_tutor_fk FOREIGN KEY (tutor_id) REFERENCES public.tutor(id)
);


-- public.roster definition

-- Drop table

-- DROP TABLE public.roster;

CREATE TABLE public.roster (
	id uuid NOT NULL,
	student_id uuid NULL,
	session_id uuid NULL,
	attendance_status bool NULL,
	attendance_minutes numeric NULL,
	created_at timestamptz NULL,
	modified_at timestamptz NULL,
	created_by uuid NULL,
	modified_by uuid NULL,
	note varchar NULL,
	tardy varchar NULL,
	teacher varchar NULL,
	CONSTRAINT roster_unique UNIQUE (id),
	CONSTRAINT roster_session_fk FOREIGN KEY (session_id) REFERENCES public."session"(id),
	CONSTRAINT roster_student_fk FOREIGN KEY (student_id) REFERENCES public.student(id)
);


-- public.assessment definition

-- Drop table

-- DROP TABLE public.assessment;

CREATE TABLE public.assessment (
	id uuid NOT NULL,
	assesmnet_bank_id uuid NULL,
	score numeric NULL,
	score_percentage float8 NULL,
	focus_standards varchar NULL,
	"level" int2 NULL,
	roster_id uuid NULL,
	CONSTRAINT assesment_pk PRIMARY KEY (id),
	CONSTRAINT assesment_assesment_bank_fk FOREIGN KEY (assesmnet_bank_id) REFERENCES public.assessment_bank(id),
	CONSTRAINT assesment_roster_fk FOREIGN KEY (roster_id) REFERENCES public.roster(id)
);


-- public.question_assessment definition

-- Drop table

-- DROP TABLE public.question_assessment;

CREATE TABLE public.question_assessment (
	assessment_id uuid NOT NULL,
	question_id uuid NOT NULL,
	is_correct bool NULL,
	CONSTRAINT question_assessment_assessment_fk FOREIGN KEY (assessment_id) REFERENCES public.assessment(id),
	CONSTRAINT question_assessment_questions_fk FOREIGN KEY (question_id) REFERENCES public.questions(id)
);


-- public.student_answers definition

-- Drop table

-- DROP TABLE public.student_answers;

CREATE TABLE public.student_answers (
	id uuid NOT NULL,
	answer_id uuid NULL,
	question_id uuid NULL,
	assessment_id uuid NULL,
	CONSTRAINT student_answers_pk PRIMARY KEY (id),
	CONSTRAINT student_answers_answers_fk FOREIGN KEY (answer_id) REFERENCES public.answers(id),
	CONSTRAINT student_answers_assesment_fk FOREIGN KEY (assessment_id) REFERENCES public.assessment(id),
	CONSTRAINT student_answers_questions_fk FOREIGN KEY (question_id) REFERENCES public.questions(id)
);