CREATE TABLE "public.users" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.products" (
	"id" serial NOT NULL,
	"category_id" int NOT NULL,
	"size_id" int NOT NULL,
	"stock_total" int NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	"price" numeric NOT NULL,
	CONSTRAINT "products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.photos" (
	"id" serial NOT NULL,
	"product_id" int NOT NULL,
	"image_url" TEXT NOT NULL,
	"main_image" BOOLEAN NOT NULL,
	CONSTRAINT "photos_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.purchase" (
	"id" serial NOT NULL,
	"user_id" int NOT NULL,
	"address_id" int NOT NULL,
	"product_id" int NOT NULL,
	"quantity" int NOT NULL,
	"purchase_date" TIMESTAMP NOT NULL,
	"status" TEXT NOT NULL DEFAULT 'criado',
	CONSTRAINT "purchase_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.categories" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	CONSTRAINT "categories_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.sizes" (
	"id" serial NOT NULL,
	"name" serial NOT NULL,
	CONSTRAINT "sizes_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.adresses" (
	"id" serial NOT NULL,
	"city_id" int NOT NULL,
	"street" TEXT NOT NULL,
	"number" TEXT NOT NULL,
	"complement" TEXT,
	"postal_code" TEXT NOT NULL,
	CONSTRAINT "adresses_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.city" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"state_id" int NOT NULL,
	CONSTRAINT "city_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.states" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	CONSTRAINT "states_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

ALTER TABLE "products" ADD CONSTRAINT "products_fk0" FOREIGN KEY ("category_id") REFERENCES "categories"("id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk1" FOREIGN KEY ("size_id") REFERENCES "sizes"("id");

ALTER TABLE "photos" ADD CONSTRAINT "photos_fk0" FOREIGN KEY ("product_id") REFERENCES "products"("id");

ALTER TABLE "purchase" ADD CONSTRAINT "purchase_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("id");
ALTER TABLE "purchase" ADD CONSTRAINT "purchase_fk1" FOREIGN KEY ("address_id") REFERENCES "adresses"("id");
ALTER TABLE "purchase" ADD CONSTRAINT "purchase_fk2" FOREIGN KEY ("product_id") REFERENCES "products"("id");

ALTER TABLE "adresses" ADD CONSTRAINT "adresses_fk0" FOREIGN KEY ("city_id") REFERENCES "city"("id");

ALTER TABLE "city" ADD CONSTRAINT "city_fk0" FOREIGN KEY ("state_id") REFERENCES "states"("id");










