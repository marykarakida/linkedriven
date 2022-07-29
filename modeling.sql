CREATE TABLE states (
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(255) NOT NULL
)

CREATE TABLE cities (
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(255) NOT NULL,
	"stateId" INT,
	FOREIGN KEY("stateId")
		REFERENCES states(id)
        ON DELETE CASCADE
);

CREATE TABLE customers (
	id SERIAL PRIMARY KEY NOT NULL,
	"fullName" TEXT NOT NULL,
	cpf CHAR(11) UNIQUE NOT NULL,
	email TEXT UNIQUE NOT NULL,
	password TEXT NOT NULL
);

CREATE TABLE "customerAdresses" (
	id SERIAL PRIMARY KEY NOT NULL,
	"customerId" INT,
	street TEXT NOT NULL,
	number INT NOT NULL,
	complement TEXT,
	"postalCode" VARCHAR(10) NOT NULL,
	"cityId" INT,
	FOREIGN KEY("customerId")
		REFERENCES customers(id)
		ON DELETE CASCADE,
	FOREIGN KEY("cityId")
		REFERENCES cities(id)
		ON DELETE CASCADE
);

CREATE TABLE "customerPhones" (
	id SERIAL PRIMARY KEY NOT NULL,
	"customerId" INT,
	number VARCHAR(11) NOT NULL,
	type VARCHAR(255) CHECK(type = 'landline' OR type = 'mobile'),
	FOREIGN KEY("customerId")
		REFERENCES customers(id)
		ON DELETE CASCADE
);

CREATE TABLE "bankAccount" (
	id SERIAL PRIMARY KEY NOT NULL,
	"customerId" INT,
	"accountNumber" INT UNIQUE NOT NULL,
	agency TEXT NOT NULL,
	"openDate" DATE NOT NULL,
	"closeDate" DATE DEFAULT NULL,
	FOREIGN KEY("customerId")
		REFERENCES customers(id)
		ON DELETE CASCADE
);

CREATE TABLE "creditCards" (
	id SERIAL PRIMARY KEY NOT NULL,
	"bankAccountId" INT,
	name TEXT NOT NULL,
	number TEXT UNIQUE NOT NULL,
	"securityCode" INT NOT NULL,
	"expirationMonth" DATE NOT NULL,
	"expirationYear" DATE NOT NULL,
	password TEXT NOT NULL,
	limit TEXT NOT NULL,
	FOREIGN KEY("bankAccountId")
		REFERENCES "bankAccount"(id)
		ON DELETE CASCADE
);

CREATE TABLE "transactions" (
	id SERIAL PRIMARY KEY NOT NULL,
	"bankAccountId" INT,
	ammount INT NOT NULL CHECK(ammount > 0),
	type VARCHAR(255) NOT NULL CHECK(type = 'deposit' OR type = 'withdraw'),
	"time" TIMESTAMP NOT NULL,
	description TEXT,
	cancelled BOOLEAN NOT NULL,
	FOREIGN KEY("bankAccountId")
		REFERENCES "bankAccount"(id)
		ON DELETE CASCADE
);