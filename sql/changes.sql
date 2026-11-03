-- 1. ДОБАВЛЕНИЕ
INSERT INTO manufacturers VALUES (10, 'КРКА', 'Словения');
INSERT INTO medicines VALUES (20, 10, 'Панангин', 'таблетки', 250.00);
INSERT INTO batches VALUES (100, 20, 'B-NEW-001', 70, '2027-06-30', NULL);

SELECT manufacturer_name FROM manufacturers WHERE manufacturer_id = 10;
SELECT medicine_name FROM medicines WHERE medicine_id = 20;


-- 2. ИЗМЕНЕНИЕ
SELECT price FROM medicines WHERE medicine_id = 3; -- было 120.00
UPDATE medicines SET price = 150.00 WHERE medicine_id = 3;
SELECT price FROM medicines WHERE medicine_id = 3; -- стало 150.00

--3.УДАЛЕНИЕ
INSERT INTO batches VALUES (200, 2, 'TMP', 1, '2027-01-01', NULL);
SELECT batch_code FROM batches WHERE batch_id = 200;
DELETE FROM batches WHERE batch_id = 200;
SELECT batch_code FROM batches WHERE batch_id = 200; -- пусто

-- 4. ОТМЕНА
BEGIN;
UPDATE medicines SET price = 130.00 WHERE medicine_id = 1;
SELECT price FROM medicines WHERE medicine_id = 1; -- 130.00
ROLLBACK;
SELECT price FROM medicines WHERE medicine_id = 1; -- снова 250.00


