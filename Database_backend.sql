

-- Create the employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    job_title VARCHAR(50),
    salary INT,
    department VARCHAR(50),
    joined_date DATE
);

-- Insert data into the employees table
INSERT INTO employees (employee_id, name, job_title, salary, department, joined_date) VALUES
(1, 'John Smith', 'Manager', 60000, 'Sales', '2022-01-15'),
(2, 'Jane Doe', 'Analyst', 45000, 'Marketing', '2022-02-01'),
(3, 'Mike Brown', 'Developer', 55000, 'IT', '2022-03-10'),
(4, 'Anna Lee', 'Manager', 65000, 'Sales', '2021-12-05'),
(5, 'Mark Wong', 'Developer', 50000, 'IT', '2023-05-20'),
(6, 'Emily Chen', 'Analyst', 48000, 'Marketing', '2023-06-02');

-- Create the sales_data table
CREATE TABLE sales_data (
    sales_id INT PRIMARY KEY,
    employee_id INT,
    sales INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Insert data into the sales_data table
INSERT INTO sales_data (sales_id, employee_id, sales) VALUES
(1, 1, 15000),
(2, 2, 12000),
(3, 3, 18000),
(4, 1, 20000),
(5, 4, 22000),
(6, 5, 19000),
(7, 6, 13000),
(8, 2, 14000);

## Tampilkan seluruh data dari tabel "employees" (5 Points)
SELECT * FROM employees;
## Berapa banyak karyawan yang memiliki posisi pekerjaan (job title) "Manager"? (5 Points)
SELECT COUNT(*) AS jumlah_manager FROM employees WHERE job_title = 'Manager';
## Tampilkan daftar nama dan gaji (salary) dari karyawan yang bekerja di departemen "Sales" atau "Marketing" (10 Points)
SELECT name, salary 
FROM employees 
WHERE department = 'Sales' OR department = 'Marketing';
## Hitung rata-rata gaji (salary) dari karyawan yang bergabung (joined) dalam 5 tahun terakhir (berdasarkan kolom "joined_date") (10 Points)
SELECT AVG(salary) AS rata_rata_gaji
FROM employees
WHERE joined_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
## Tampilkan 5 karyawan dengan total penjualan (sales) tertinggi dari tabel "employees" dan "sales_data" (10 Points)
SELECT e.name, SUM(sd.sales) AS total_sales
FROM employees e
JOIN sales_data sd ON e.employee_id = sd.employee_id
GROUP BY e.employee_id, e.name
ORDER BY total_sales DESC
LIMIT 5;
## Tampilkan nama, gaji (salary), dan rata-rata gaji (salary) dari semua karyawan yang bekerja di departemen yang memiliki rata-rata gaji lebih tinggi dari gaji rata-rata di semua departemen (15 Points)
SELECT e.name, e.salary, dept_avg.avg_salary
FROM employees e
JOIN (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
    HAVING AVG(salary) > (SELECT AVG(salary) FROM employees)
) AS dept_avg ON e.department = dept_avg.department;
## Tampilkan nama dan total penjualan (sales) dari setiap karyawan, bersama dengan peringkat (ranking) masing-masing karyawan berdasarkan total penjualan. Peringkat 1 adalah karyawan dengan total penjualan tertinggi (25 Points)
SELECT e.name, SUM(sd.sales) AS total_sales,
       RANK() OVER (ORDER BY SUM(sd.sales) DESC) AS ranking
FROM employees e
JOIN sales_data sd ON e.employee_id = sd.employee_id
GROUP BY e.employee_id, e.name
ORDER BY total_sales DESC;
## Buat sebuah stored procedure yang menerima nama departemen sebagai input, dan mengembalikan daftar karyawan dalam departemen tersebut bersama dengan total gaji (salary) yang mereka terima (20 Points)
DELIMITER //

CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(100))
BEGIN
    SELECT name, SUM(salary) AS total_salary
    FROM employees
    WHERE department = dept_name
    GROUP BY name;
END //

DELIMITER ;
