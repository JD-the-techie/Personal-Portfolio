# Dynamic Personal Portfolio — Jaydeep Verma

A production-grade dynamic portfolio website built with **JSP + Servlets + MySQL + JDBC** and a dark, animated frontend inspired by carlgordonmedia.com.

## Tech Stack
- **Frontend:** HTML5, CSS3, JavaScript (particles, typewriter, scroll reveal)
- **Backend:** Java 17, Jakarta Servlet 6, JSP
- **Database:** MySQL 8
- **Auth:** BCrypt password hashing, Session-based auth
- **Build:** Apache Maven, deployable on Tomcat 10+

## Setup Instructions

### 1. Database
```bash
mysql -u root -p < portfolio_db.sql
```
Then update the password in `src/main/java/com/portfolio/db/DBConnection.java`:
```java
private static final String PASSWORD = "your_actual_mysql_password";
```

### 2. Build
```bash
cd portfolio
mvn clean package
```
This creates `target/portfolio.war`.

### 3. Deploy
- Copy `target/portfolio.war` into your **Tomcat 10+** `webapps/` folder.
- Start Tomcat.
- Open: `http://localhost:8080/portfolio/`

### 4. Admin Access
- Register at: `http://localhost:8080/portfolio/register.jsp`
- Login at: `http://localhost:8080/portfolio/login.jsp`
- Dashboard: `http://localhost:8080/portfolio/dashboard/index.jsp`

## Project Structure
```
portfolio/
├── pom.xml
├── portfolio_db.sql
├── README.md
└── src/main/
    ├── java/com/portfolio/
    │   ├── db/DBConnection.java
    │   ├── model/ (User, Project, Skill, Education, Message)
    │   ├── dao/   (UserDAO, ProjectDAO, SkillDAO, EducationDAO, MessageDAO)
    │   ├── servlet/ (Login, Register, Logout, Project, Skill, Contact)
    │   └── filter/SessionFilter.java
    └── webapp/
        ├── WEB-INF/web.xml
        ├── assets/css/main.css
        ├── assets/js/main.js
        ├── index.jsp (public portfolio)
        ├── login.jsp, register.jsp
        └── dashboard/ (index, projects, skills)
```

## Features
- Particle canvas hero with typewriter effect
- Glassmorphism skill cards with animated progress bars
- Project filtering/search (live, client-side)
- Scroll-reveal animations (Intersection Observer)
- Animated stat counters
- Custom cursor glow effect
- Horizontal marquee ticker
- Dark admin dashboard with sidebar
- Full CRUD for Projects and Skills
- BCrypt password hashing
- Session-based auth with SessionFilter
- Contact form with client + server validation

## Author
**Jaydeep Verma** — B.Tech CSE, Techno India University
