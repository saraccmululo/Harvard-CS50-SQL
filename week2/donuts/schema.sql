CREATE TABLE "ingredients" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "price_per_unit" REAL NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE "donuts" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "is_gluten_free" INTEGER NOT NULL,
    "price" REAL NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE "donut_ingredients" (
    "id" INTEGER,
    "donut_id" INTEGER NOT NULL,
    "ingredient_id" INTEGER NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id"),
    UNIQUE("donut_id", "ingredient_id")
);

CREATE TABLE "orders" (
    "id" INTEGER,
    "customer_id" INTEGER,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE "order_items" (
    "id" INTEGER,
    "order_id" INTEGER,
    "donut_id" INTEGER,
    "quantity" INTEGER NOT NULL,
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY ("order_id") REFERENCES "orders"("id")
)
