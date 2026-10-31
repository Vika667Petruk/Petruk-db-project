CREATE TABLE manufacturers (
    manufacturer_id INTEGER PRIMARY KEY,
    manufacturer_name TEXT NOT NULL,
    country TEXT NOT NULL
);

CREATE TABLE medicines (
    medicine_id INTEGER PRIMARY KEY,
    manufacturer_id INTEGER NOT NULL REFERENCES manufacturers(manufacturer_id),
    medicine_name TEXT NOT NULL,
    dosage_form TEXT NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    CONSTRAINT chk_medicines_price_positive CHECK (price > 0),
    CONSTRAINT chk_medicines_dosage_form CHECK (dosage_form IN ('таблетки', 'капсулы', 'раствор', 'мазь', 'сироп'))
);

CREATE TABLE batches (
    batch_id INTEGER PRIMARY KEY,
    medicine_id INTEGER NOT NULL REFERENCES medicines(medicine_id),
    batch_code TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    expiry_date DATE NOT NULL,
    depleted_date DATE,
    CONSTRAINT chk_batches_quantity_positive CHECK (quantity >= 0),
    CONSTRAINT chk_batches_dates CHECK (depleted_date IS NULL OR depleted_date >= expiry_date)
);
