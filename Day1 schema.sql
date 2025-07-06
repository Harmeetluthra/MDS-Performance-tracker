Create database if not exists MDS_Performance_DB;

Use MDS_Performance_DB;

create table if not exists mds_staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    shift_time ENUM('PST', 'EST', 'CST', 'Other') NOT NULL,
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    join_date DATE, 
    primary_account Varchar (100) NOT NULL
);

create table if not exists accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(100) NOT NULL,
    speciality ENUM('FM/IM', 'Oncology', 'Pedes', 'Allergy & Immunology', 'Other') NOT NULL,
    ehr_system ENUM('Epic', 'Cerner', 'eClinicalWorks', 'Athena', 'Other') NOT NULL
);

create table if not exists performance_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT,
    account_id INT,
    log_date DATE NOT NULL,
    charts_completed INT NOT NULL,
    avg_ttc_minutes DECIMAL(5,2),
    error_percent DECIMAL(4,2),
    remarks TEXT,
    FOREIGN KEY (staff_id) REFERENCES mds_staff(staff_id),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

create table if not exists performance_flags (
    flag_id INT PRIMARY KEY AUTO_INCREMENT,
    log_id INT,
    flag_reason VARCHAR(255),
    flag_type ENUM('Underperformance', 'QA Review', 'Red Line Audit'),
    flagged_by VARCHAR(100),
    flag_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (log_id) REFERENCES performance_logs(log_id)
);

