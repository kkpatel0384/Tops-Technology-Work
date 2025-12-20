CREATE DATABASE assessment;
USE assessment;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    signup_date DATE NOT NULL
);

CREATE TABLE logins (
    login_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    login_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE feature_usage (
    usage_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    feature_name VARCHAR(50) NOT NULL,
    timestamp DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


INSERT INTO users (email, signup_date) VALUES
('amit@gmail.com', '2025-01-01'),
('neha@gmail.com', '2025-01-02'),
('rahul@gmail.com', '2025-01-03'),
('priya@gmail.com', '2025-01-04'),
('karan@gmail.com', '2025-01-05'),
('pooja@gmail.com', '2025-01-06'),
('rohit@gmail.com', '2025-01-07'),
('anjali@gmail.com', '2025-01-08'),
('suresh@gmail.com', '2025-01-09'),
('kavita@gmail.com', '2025-01-10');



INSERT INTO logins (user_id, login_date) VALUES
(1, '2025-01-01'),
(1, '2025-01-03'),
(2, '2025-01-02'),
(3, '2025-01-04'),
(4, '2025-01-05'),
(5, '2025-01-06'),
(6, '2025-01-08'),
(7, '2025-01-09'),
(8, '2025-01-10'),
(9, '2025-01-12');


INSERT INTO feature_usage (user_id, feature_name, timestamp) VALUES
(1, 'Dashboard', '2025-01-01 10:00:00'),
(1, 'Profile', '2025-01-01 10:10:00'),
(2, 'Dashboard', '2025-01-02 11:00:00'),
(3, 'Reports', '2025-01-04 12:00:00'),
(4, 'Dashboard', '2025-01-05 09:30:00'),
(5, 'Settings', '2025-01-06 14:00:00'),
(6, 'Dashboard', '2025-01-08 15:00:00'),
(7, 'Reports', '2025-01-09 16:00:00'),
(8, 'Profile', '2025-01-10 17:00:00'),
(9, 'Dashboard', '2025-01-12 18:00:00');


SELECT login_date,
       COUNT(DISTINCT user_id) AS daily_active_users
FROM logins
GROUP BY login_date
ORDER BY login_date;

SELECT feature_name,
       COUNT(DISTINCT user_id) * 100.0 /
       (SELECT COUNT(*) FROM users) AS adoption_rate_percent
FROM feature_usage
GROUP BY feature_name;

SELECT u.user_id,
       MIN(f.timestamp) - u.signup_date AS time_to_first_use
FROM users u
JOIN feature_usage f ON u.user_id = f.user_id
WHERE f.feature_name = 'Dashboard'
GROUP BY u.user_id, u.signup_date;


SELECT DATE_FORMAT(u.signup_date, '%Y-%m') AS signup_month,
       f.feature_name,
       COUNT(*) AS usage_count
FROM users u
JOIN feature_usage f ON u.user_id = f.user_id
GROUP BY signup_month, f.feature_name
ORDER BY signup_month, usage_count DESC;

SELECT COUNT(DISTINCT u.user_id) * 100.0 /
       (SELECT COUNT(*) FROM users) AS retention_rate_percent
FROM users u
JOIN logins l
  ON u.user_id = l.user_id
 AND DATEDIFF(l.login_date, u.signup_date) = 7;
 
 SELECT user_id,
       DATE(timestamp) AS usage_date,
       COUNT(DISTINCT feature_name) AS features_used
FROM feature_usage
GROUP BY user_id, DATE(timestamp)
HAVING COUNT(DISTINCT feature_name) > 5;

SELECT user_id,
       AVG(DATEDIFF(next_login, login_date)) AS avg_gap_days
FROM (
    SELECT user_id,
           login_date,
           LEAD(login_date) OVER (PARTITION BY user_id ORDER BY login_date) AS next_login
    FROM logins
) t
WHERE next_login IS NOT NULL
GROUP BY user_id;


SELECT f.feature_name,
       COUNT(*) AS usage_count
FROM users u
JOIN feature_usage f ON u.user_id = f.user_id
WHERE DATEDIFF(f.timestamp, u.signup_date) BETWEEN 0 AND 7
GROUP BY f.feature_name
ORDER BY usage_count DESC
LIMIT 1;


SELECT u.user_id, u.email
FROM users u
LEFT JOIN logins l ON u.user_id = l.user_id
WHERE l.user_id IS NULL;

SELECT AVG(feature_count) AS avg_features_per_login
FROM (
    SELECT l.user_id,
           l.login_date,
           COUNT(DISTINCT f.feature_name) AS feature_count
    FROM logins l
    LEFT JOIN feature_usage f
      ON l.user_id = f.user_id
     AND DATE(f.timestamp) = l.login_date
    GROUP BY l.user_id, l.login_date
)t;


