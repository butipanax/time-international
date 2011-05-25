CREATE TABLE "carts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "parent_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "ckeditor_assets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "data_file_name" varchar(255) NOT NULL, "data_content_type" varchar(255), "data_file_size" integer, "assetable_id" integer, "assetable_type" varchar(30), "type" varchar(25), "guid" varchar(10), "locale" integer(1) DEFAULT 0, "user_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "discount_details" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "discount_rate" decimal DEFAULT 1, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "line_items" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "product_id" integer, "cart_id" integer, "created_at" datetime, "updated_at" datetime, "quantity" integer DEFAULT 1, "order_id" integer, "price" decimal);
CREATE TABLE "order_statuses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "orders" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "name" varchar(255), "address" varchar(255), "email" varchar(255), "postcode" varchar(255), "telephone" varchar(255), "pay_type" varchar(255), "taobao_url" varchar(255), "taobao_invoice_number" varchar(255), "total_price" decimal, "discount_price" decimal, "invoice_number" varchar(255), "order_status" integer, "shipping_date" datetime, "payment_date" datetime, "close_date" datetime, "cancel_reason" text, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "category_id" integer, "description" text, "price" decimal, "created_at" datetime, "updated_at" datetime, "photo_file_name" varchar(255), "photo_content_type" varchar(255), "photo_file_size" integer, "photo_updated_at" datetime, "intro" text, "weight" decimal(6,2) DEFAULT 0);
CREATE TABLE "profiles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "address" varchar(255), "postcode" varchar(255), "telephone" varchar(255), "discount_rank" integer DEFAULT 1, "created_at" datetime, "updated_at" datetime, "user_id" integer, "sex" boolean, "bonus_score" integer DEFAULT 0);
CREATE TABLE "roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "serial_numbers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "serial_number_name" varchar(255), "current_max_number" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "shipping_fees" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "weight" decimal, "price" decimal(8,2), "created_at" datetime, "updated_at" datetime);
CREATE INDEX "fk_assetable" ON "ckeditor_assets" ("assetable_type", "assetable_id");
CREATE INDEX "fk_user" ON "ckeditor_assets" ("user_id");
CREATE INDEX "idx_assetable_type" ON "ckeditor_assets" ("assetable_type", "type", "assetable_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20110516124017');

INSERT INTO schema_migrations (version) VALUES ('20110516125048');

INSERT INTO schema_migrations (version) VALUES ('20110516221051');

INSERT INTO schema_migrations (version) VALUES ('20110517154814');

INSERT INTO schema_migrations (version) VALUES ('20110517180547');

INSERT INTO schema_migrations (version) VALUES ('20110517180714');

INSERT INTO schema_migrations (version) VALUES ('20110518000059');

INSERT INTO schema_migrations (version) VALUES ('20110518151532');

INSERT INTO schema_migrations (version) VALUES ('20110518151533');

INSERT INTO schema_migrations (version) VALUES ('20110518171332');

INSERT INTO schema_migrations (version) VALUES ('20110518171333');

INSERT INTO schema_migrations (version) VALUES ('20110518202144');

INSERT INTO schema_migrations (version) VALUES ('20110520170150');

INSERT INTO schema_migrations (version) VALUES ('20110520170709');

INSERT INTO schema_migrations (version) VALUES ('20110520175205');

INSERT INTO schema_migrations (version) VALUES ('20110520215636');

INSERT INTO schema_migrations (version) VALUES ('20110520220312');

INSERT INTO schema_migrations (version) VALUES ('20110520222328');

INSERT INTO schema_migrations (version) VALUES ('20110521224701');

INSERT INTO schema_migrations (version) VALUES ('20110521225121');

INSERT INTO schema_migrations (version) VALUES ('20110521225446');

INSERT INTO schema_migrations (version) VALUES ('20110521230326');

INSERT INTO schema_migrations (version) VALUES ('20110521230821');

INSERT INTO schema_migrations (version) VALUES ('20110521233201');

INSERT INTO schema_migrations (version) VALUES ('20110522140219');

INSERT INTO schema_migrations (version) VALUES ('20110523001447');

INSERT INTO schema_migrations (version) VALUES ('20110524151932');

INSERT INTO schema_migrations (version) VALUES ('20110525104620');