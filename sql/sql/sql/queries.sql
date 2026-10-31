-- Q1
SELECT manufacturer_id, manufacturer_name, country FROM manufacturers ORDER BY manufacturer_id;

-- Q2
SELECT medicine_id, medicine_name, dosage_form, price FROM medicines WHERE price >= 200.00 ORDER BY price, medicine_id;

-- Q3
SELECT medicine_id, medicine_name, dosage_form, price FROM medicines WHERE dosage_form = 'таблетки' AND price <= 260.00 ORDER BY price, medicine_id;

-- Q4
SELECT medicine_id, medicine_name, price FROM medicines ORDER BY price DESC, medicine_id ASC LIMIT 3;

-- Q5
SELECT DISTINCT dosage_form FROM medicines ORDER BY dosage_form;

-- Q6a
SELECT batch_id, batch_code, medicine_id, depleted_date FROM batches WHERE depleted_date IS NULL ORDER BY batch_id;

-- Q6b
SELECT batch_id, batch_code, medicine_id, depleted_date FROM batches WHERE depleted_date IS NOT NULL ORDER BY batch_id;

-- Q7
SELECT medicine_id, medicine_name, dosage_form, price FROM medicines WHERE dosage_form IN ('таблетки', 'капсулы') 
  AND price BETWEEN 200.00 AND 450.00 ORDER BY price, medicine_id;

-- Q8
SELECT m.medicine_name, mf.manufacturer_name, b.batch_code, b.quantity, b.expiry_date FROM batches b JOIN medicines m 
  ON m.medicine_id = b.medicine_id JOIN manufacturers mf ON mf.manufacturer_id = m.manufacturer_id ORDER BY m.medicine_name, b.batch_code;

-- Q9
SELECT m.medicine_name, mf.manufacturer_name, b.batch_code, b.quantity, b.expiry_date FROM batches b JOIN medicines m 
  ON m.medicine_id = b.medicine_id JOIN manufacturers mf ON mf.manufacturer_id = m.manufacturer_id 
  WHERE b.quantity > 0 AND b.expiry_date < DATE '2026-10-01' ORDER BY b.expiry_date, b.batch_code;

-- Q10
SELECT m.medicine_id, m.medicine_name, COUNT(b.batch_id) AS batch_count FROM medicines m LEFT JOIN batches b 
  ON b.medicine_id = m.medicine_id GROUP BY m.medicine_id, m.medicine_name ORDER BY m.medicine_id;

-- Q11
SELECT m.medicine_id, m.medicine_name, COALESCE(SUM(b.quantity), 0) AS total_quantity FROM medicines m 
  LEFT JOIN batches b ON b.medicine_id = m.medicine_id AND b.quantity > 0 AND b.expiry_date >= DATE '2026-10-01' 
  GROUP BY m.medicine_id, m.medicine_name ORDER BY m.medicine_id;

-- Q12
SELECT m.medicine_id, m.medicine_name, COUNT(b.batch_id) AS batch_count FROM medicines m JOIN batches b ON b.medicine_id = m.medicine_id 
  GROUP BY m.medicine_id, m.medicine_name HAVING COUNT(b.batch_id) >= 3 ORDER BY m.medicine_id;
