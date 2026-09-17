# Dynamic Personal Portfolio — Jaydeep Verma

A modern, high-performance dynamic portfolio website with a dark/light animated frontend, particle canvas, typewriter effect, project filtering, and client-side administrative capabilities.

## Tech Stack
- **Frontend:** HTML5, Vanilla CSS3, JavaScript ES6+ (Canvas particles, typewriter, Intersection Observer scroll reveal, live filtering, theme switcher)
- **Data & State:** Persistent client-side state with `localStorage` (Zero external database configuration required)
- **Deployment:** Standalone static web application (Can be run locally or hosted directly on GitHub Pages, Vercel, Netlify, or any web server)

## Running the Application

### 1. Local Run
You can open `index.html` directly in any web browser or serve it via a lightweight local server:
```bash
python -m http.server 8080 --directory src/main/webapp
```
Open: `http://localhost:8080/`

### 2. Available Pages
- **Public Portfolio:** `http://localhost:8080/index.html`
- **Admin Login:** `http://localhost:8080/login.html`
- **Admin Register:** `http://localhost:8080/register.html`
- **Admin Dashboard:** `http://localhost:8080/dashboard/index.html`
- **Project Management:** `http://localhost:8080/dashboard/projects.html`
- **Skills Management:** `http://localhost:8080/dashboard/skills.html`

## Project Structure
```
portfolio/
├── README.md
├── index.html
├── login.html
├── register.html
└── src/main/webapp/
    ├── assets/
    │   ├── css/main.css
    │   ├── js/main.js
    │   └── img/
    ├── index.html (public portfolio)
    ├── login.html, register.html
    └── dashboard/ (index.html, projects.html, skills.html)
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
