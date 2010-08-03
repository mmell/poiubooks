CREATE TABLE "books" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "title" varchar(255) NOT NULL, "category_id" integer NOT NULL, "reward" varchar(255), "license_id" integer NOT NULL, "terms" text NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "chapters" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "type" varchar(255), "title" varchar(255) NOT NULL, "position" integer NOT NULL, "content" text NOT NULL, "created_at" datetime, "updated_at" datetime, "parent_id" integer, "parent_type" varchar(255));
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "commentable_type" varchar(255) NOT NULL, "commentable_id" integer NOT NULL, "content" text NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "licenses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "url" varchar(255), "image_src" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "notifications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "book_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(100) DEFAULT '', "email" varchar(100), "image_src" varchar(255), "description" text, "is_admin" boolean DEFAULT 'f', "login" varchar(40), "crypted_password" varchar(40), "salt" varchar(40), "remember_token" varchar(40), "remember_token_expires_at" datetime, "activation_code" varchar(40), "activated_at" datetime, "state" varchar(255) DEFAULT 'passive', "deleted_at" datetime, "created_at" datetime, "updated_at" datetime, "image_thumb_src" varchar(255));
CREATE TABLE "votes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "comment_id" integer NOT NULL, "vote" boolean, "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_books_on_category_id" ON "books" ("category_id");
CREATE INDEX "index_books_on_user_id" ON "books" ("user_id");
CREATE UNIQUE INDEX "index_categories_on_name" ON "categories" ("name");
CREATE INDEX "index_chapters_on_parent_id_and_parent_type_and_type" ON "chapters" ("type");
CREATE INDEX "index_comments_on_user_id" ON "comments" ("user_id");
CREATE UNIQUE INDEX "index_licenses_on_url" ON "licenses" ("url");
CREATE UNIQUE INDEX "index_notifications_on_user_id_and_book_id" ON "notifications" ("user_id", "book_id");
CREATE UNIQUE INDEX "index_users_on_login" ON "users" ("login");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20100713165651');

INSERT INTO schema_migrations (version) VALUES ('20100729220531');

INSERT INTO schema_migrations (version) VALUES ('20100730000748');

INSERT INTO schema_migrations (version) VALUES ('20100730015116');

INSERT INTO schema_migrations (version) VALUES ('20100802202941');

INSERT INTO schema_migrations (version) VALUES ('20100803144205');