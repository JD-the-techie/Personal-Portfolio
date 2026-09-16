-- Portfolio Database Schema & Seed Data for Jaydeep Verma
-- Updated with complete Secondary, Higher Secondary, Diploma & B.Tech Education records

CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS about (
  about_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  bio TEXT NOT NULL,
  location VARCHAR(100),
  phone VARCHAR(50),
  profile_image_url VARCHAR(255),
  resume_url VARCHAR(255),
  github_url VARCHAR(255),
  linkedin_url VARCHAR(255),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS skills (
  skill_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  category VARCHAR(50) NOT NULL,
  skill_name VARCHAR(100) NOT NULL,
  proficiency_level INT DEFAULT 75,
  icon_class VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS projects (
  project_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  title VARCHAR(150) NOT NULL,
  description TEXT,
  tech_stack VARCHAR(255),
  project_url VARCHAR(255),
  github_url VARCHAR(255),
  role VARCHAR(100),
  is_featured BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS education (
  edu_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  institution VARCHAR(200) NOT NULL,
  degree VARCHAR(200) NOT NULL,
  score_text VARCHAR(100),
  start_year YEAR,
  end_year YEAR,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS messages (
  message_id INT AUTO_INCREMENT PRIMARY KEY,
  sender_name VARCHAR(100) NOT NULL,
  sender_email VARCHAR(100) NOT NULL,
  subject VARCHAR(200),
  message TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_read BOOLEAN DEFAULT FALSE
);

-- Seed Data
INSERT INTO users (user_id, username, email, password_hash) VALUES
(1, 'jaydeep', 'jaydeepverma.jsr@gmail.com', '$2a$12$PLACEHOLDER_BCRYPT_HASH')
ON DUPLICATE KEY UPDATE username='jaydeep';

INSERT INTO about (user_id, bio, location, phone, github_url, linkedin_url) VALUES
(1, 'Computer Science undergraduate with hands-on experience in software development through academic, personal, and team-based projects. Strong programming foundation in Python, JavaScript, Java, C++, and SQL, with practical experience in React.js, Vite, Node.js, Microsoft Azure, HTML, and CSS. Experienced in building responsive interfaces, backend integration, debugging, and practical technology solutions.', 'Jamshedpur, India', '+91-6204048706', 'https://github.com/JD-the-techie', 'https://www.linkedin.com/in/jaydeep-verma-cse/');

INSERT INTO skills (user_id, category, skill_name, proficiency_level, icon_class) VALUES
(1, 'Programming', 'Python & Java', 90, 'fa-brands fa-python'),
(1, 'Programming', 'C, C++ & OOP', 85, 'fa-solid fa-code'),
(1, 'Frontend Development', 'React.js & Vite', 88, 'fa-brands fa-react'),
(1, 'Backend Development', 'Node.js & REST APIs', 84, 'fa-brands fa-node-js'),
(1, 'Databases', 'MySQL & SQL DBMS', 86, 'fa-solid fa-database'),
(1, 'Tools & Cloud', 'Microsoft Azure & Terraform', 80, 'fa-solid fa-cloud'),
(1, 'IoT & Embedded', 'ESP32 & Sensors', 82, 'fa-solid fa-microchip'),
(1, 'Tools & Platforms', 'Git, GitHub & VS Code', 88, 'fa-brands fa-github');

INSERT INTO projects (user_id, title, description, tech_stack, github_url, role, is_featured) VALUES
(1, 'Bus Tracking System', 'Web-based bus tracking and transportation management application with dedicated User, Driver, and Admin workflows. Implemented responsive interfaces using React.js, React Router, and Context API.', 'React.js, Vite, Node.js, JavaScript, HTML, CSS', 'https://github.com/JD-the-techie', 'Frontend Developer & Backend Support', TRUE),
(1, 'Disaster Management Web App – SIH 2025', 'Developed as part of participation in Smart India Hackathon (SIH 2025) supporting real-time alerts, SOS emergency functions, rescue coordination, and communication.', 'React.js, Vite, JavaScript, HTML, CSS, REST APIs', 'https://github.com/JD-the-techie', 'Frontend Developer & Backend Support', TRUE),
(1, 'Hospital Patient Monitoring System', 'Structured application logic using Object-Oriented Programming principles, modular design, and exception handling across functional scenarios.', 'Python, C++, OOP, Modular Design', 'https://github.com/JD-the-techie', 'Academic Project Lead', FALSE),
(1, 'Vortex – Jet Engine IoT System', 'IoT-based jet engine monitoring system for sensor data acquisition and real-time exhaust gas temperature monitoring using ESP32, MAX6675 and thermocouple.', 'ESP32, MAX6675, K-Type Thermocouple, C++, IoT Sensors', 'https://github.com/JD-the-techie', 'IoT Hardware Engineer & Team Leader', TRUE);

INSERT INTO education (user_id, institution, degree, score_text, start_year, end_year) VALUES
(1, 'Techno India University, West Bengal', 'Bachelor\'s Degree in Computer Science and Engineering', 'CGPA: 7.41 / 10', 2024, 2027),
(1, 'Government Polytechnic, Tekari, Gaya', 'Diploma in Civil Engineering', 'CGPA: 7.62 / 10', 2021, 2024),
(1, 'Kerala Public School, Kadma, Jamshedpur', 'Indian School Certificate Examination (ISC - 12th)', 'Percentage: 73.25%', 2018, 2020),
(1, 'Kerala Public School, Kadma, Jamshedpur', 'Indian Certificate of Secondary Education (ICSE - 10th)', 'Percentage: 86.6%', 2016, 2018);
