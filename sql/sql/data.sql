--Заполняем таблицу 
INSERT INTO manufacturers VALUES
(1, 'Озон', 'Россия'),
(2, 'Фармстандарт', 'Россия'),
(3, 'Биокад', 'Россия'),
(4, 'Teva', 'Израиль'),
(5, 'Novartis', 'Швейцария'),
(6, 'Озон', 'Россия'),
(7, 'Berlin-Chemie', 'Германия');

INSERT INTO medicines VALUES
(1, 1, 'Амоксициллин', 'таблетки', 250.00),
(2, 1, 'Амоксициллин', 'капсулы', 300.00),
(3, 2, 'Парацетамол', 'таблетки', 120.00),
(4, 3, 'Цефтриаксон', 'раствор', 450.00),
(5, 4, 'Ибупрофен', 'таблетки', 200.00),
(6, 5, 'Ксилометазолин', 'сироп', 180.00),
(7, 6, 'Амоксициллин', 'таблетки', 260.00),
(8, 7, 'Мезим', 'таблетки', 600.00),
(9, 2, 'Парацетамол', 'сироп', 150.00);

INSERT INTO batches VALUES
(1, 1, 'B-001', 100, '2027-01-31', NULL),
(2, 1, 'B-002', 50, '2026-12-31', '2026-12-20'),
(3, 1, 'B-003', 30, '2026-10-01', '2026-10-01'),
(4, 2, 'B-004', 20, '2027-05-31', NULL),
(5, 3, 'B-005', 0, '2026-11-30', '2026-11-20'),
(6, 4, 'B-006', 15, '2028-01-31', NULL),
(7, 5, 'B-007', 40, '2026-10-15', NULL),
(8, 5, 'B-008', 10, '2026-09-15', '2026-09-10'),
(9, 5, 'B-009', 25, '2027-02-28', NULL),
(10, 6, 'B-010', 5, '2026-08-31', '2026-08-25'),
(11, 7, 'B-011', 12, '2026-12-01', NULL),
(12, 7, 'B-012', 0, '2026-10-01', '2026-09-28'),
(13, 3, 'B-013', 7, '2027-01-01', NULL);

В)
Q1. Вывести идентификатор и два содержательных свойства всех объектов
SELECT medicine_id, medicine_name, price
FROM medicines
ORDER BY medicine_id;

--Q2.Вывести записи с числовым свойством не меньше границы (цена >= 200)
SELECT medicine_id, medicine_name, price
FROM medicines
WHERE price >= 200
ORDER BY price DESC, medicine_id;

--Q3.Вывести записи по двум условиям (форма = таблетки И цена <= 150)
SELECT medicine_id, medicine_name, dosage_form, price
FROM medicines
WHERE dosage_form = 'таблетки' AND price <= 150
ORDER BY price;

--Q4. Три записи с наибольшим значением (три самых дорогих)
SELECT medicine_id, medicine_name, price
FROM medicines
ORDER BY price DESC, medicine_id
LIMIT 3;

--Q5.Вывести различные значения (уникальные лекарственные формы)
SELECT DISTINCT dosage_form
FROM medicines
ORDER BY dosage_form;

--Q6.1 Записи с отсутствующим необязательным свойством (страна IS NULL)
SELECT manufacturer_id, manufacturer_name
FROM manufacturers
WHERE country IS NULL
ORDER BY manufacturer_id;


-- Q6.2 Записи с известным необязательным свойством (страна IS NOT NULL)
SELECT manufacturer_id, manufacturer_name, country
FROM manufacturers
WHERE country IS NOT NULL
ORDER BY manufacturer_id;


-- Q7. Препараты двух форм (таблетки, капсулы) с ценой в диапазоне (IN, BETWEEN)
SELECT medicine_id, medicine_name, dosage_form, price
FROM medicines
WHERE dosage_form IN ('таблетки', 'капсулы')
  AND price BETWEEN 100 AND 500
ORDER BY price, medicine_id;


-- Q8. Сведения о партиях с названием препарата и производителя (JOIN)
SELECT m.medicine_name,
       man.manufacturer_name,
       b.batch_code,
       b.quantity,
       b.expiry_date
FROM batches b
JOIN medicines m ON m.medicine_id = b.medicine_id
JOIN manufacturers man ON man.manufacturer_id = m.manufacturer_id
ORDER BY m.medicine_name, b.batch_code;


-- Q9. Партии с положительным остатком и сроком годности раньше 2027-01-01
SELECT m.medicine_name,
       man.manufacturer_name,
       b.batch_code,
       b.quantity,
       b.expiry_date
FROM batches b
JOIN medicines m ON m.medicine_id = b.medicine_id
JOIN manufacturers man ON man.manufacturer_id = m.manufacturer_id
WHERE b.quantity > 0
  AND b.expiry_date < DATE '2027-01-01'
ORDER BY b.expiry_date;

-- Q10. Все препараты и число их партий, включая те, у которых 0 партий (LEFT JOIN)
SELECT m.medicine_id,
       m.medicine_name,
       COUNT(b.batch_id) AS batch_count
FROM medicines m
LEFT JOIN batches b ON b.medicine_id = m.medicine_id
GROUP BY m.medicine_id, m.medicine_name
ORDER BY m.medicine_id;


-- Q11. Суммарный остаток годных партий для каждого препарата (SUM, COALESCE)
SELECT m.medicine_id,
       m.medicine_name,
       COALESCE(SUM(b.quantity), 0) AS total_quantity
FROM medicines m
LEFT JOIN batches b ON b.medicine_id = m.medicine_id
                   AND b.quantity > 0
                   AND b.expiry_date >= DATE '2026-01-01'
GROUP BY m.medicine_id, m.medicine_name
ORDER BY m.medicine_id;

-- Q12. Препараты, у которых 3 и более партий (HAVING)
SELECT m.medicine_id,
       m.medicine_name,
       COUNT(b.batch_id) AS batch_count
FROM medicines m
JOIN batches b ON b.medicine_id = m.medicine_id
GROUP BY m.medicine_id, m.medicine_name
HAVING COUNT(b.batch_id) >= 3
ORDER BY m.medicine_id;
