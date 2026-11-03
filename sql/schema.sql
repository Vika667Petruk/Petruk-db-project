-- 1. ТАБЛИЦА: manufacturers
-- Описание строки: Одна строка описывает одного уникального производителя лекарств. 
-- Один производитель может выпускать несколько препаратов.
CREATE TABLE manufacturers (
    manufacturer_id   INTEGER PRIMARY KEY,
    manufacturer_name TEXT    NOT NULL,
    country           TEXT
);

-- 2. ТАБЛИЦА: medicines
-- Описание строки: Одна строка описывает один уникальный лекарственный препарат.
-- Каждый препарат относится к одному производителю и может иметь несколько партий.
CREATE TABLE medicines (
    medicine_id     INTEGER       PRIMARY KEY,
    manufacturer_id INTEGER       NOT NULL REFERENCES manufacturers(manufacturer_id),
    medicine_name   TEXT          NOT NULL,
    dosage_form     TEXT          NOT NULL,
    price           NUMERIC(10,2) NOT NULL,
    CHECK (price >= 0)
);

-- 3. ТАБЛИЦА: batches
-- Описание строки: Одна строка описывает одну конкретную партию препарата на складе.
-- Каждая партия относится к одному препарату.
CREATE TABLE batches (
    batch_id      INTEGER PRIMARY KEY,
    medicine_id   INTEGER NOT NULL REFERENCES medicines(medicine_id),
    batch_code    TEXT    NOT NULL,
    quantity      INTEGER NOT NULL,
    expiry_date   DATE    NOT NULL,
    depleted_date DATE,
    CHECK (quantity >= 0)
); 
