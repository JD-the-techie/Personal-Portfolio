<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | Jaydeep Verma Portfolio</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <style>
    .auth-wrapper{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:2rem;background:var(--bg)}
    .auth-card{background:var(--surface);border:1px solid var(--border);border-radius:var(--radius);padding:3rem;width:100%;max-width:440px;backdrop-filter:blur(12px)}
    .auth-logo{font-family:var(--font-heading);font-size:3rem;color:var(--accent);text-align:center;margin-bottom:0.5rem;letter-spacing:0.1em}
    .auth-subtitle{text-align:center;color:var(--muted);margin-bottom:2rem;font-size:0.9rem}
    .auth-card .form-group{margin-bottom:1.2rem}
    .auth-card .btn-primary{width:100%;padding:1rem;font-size:1rem;margin-top:0.5rem}
    .auth-link{text-align:center;margin-top:1.5rem;color:var(--muted);font-size:0.9rem}
    .auth-link a{color:var(--accent);text-decoration:none}
    .auth-link a:hover{text-decoration:underline}
    .auth-error{background:rgba(255,77,77,0.1);border:1px solid rgba(255,77,77,0.3);color:#ff6b6b;padding:0.8rem 1rem;border-radius:10px;margin-bottom:1.5rem;font-size:0.85rem;text-align:center}
    .auth-success{background:rgba(0,212,255,0.1);border:1px solid rgba(0,212,255,0.3);color:var(--accent);padding:0.8rem 1rem;border-radius:10px;margin-bottom:1.5rem;font-size:0.85rem;text-align:center}
  </style>
</head>
<body>
<div class="auth-wrapper">
  <div class="auth-card">
    <div class="auth-logo">JV.</div>
    <p class="auth-subtitle">Sign in to your dashboard</p>
    <% if (request.getAttribute("error") != null) { %>
      <div class="auth-error"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if ("true".equals(request.getParameter("registered"))) { %>
      <div class="auth-success">Account created! Please sign in.</div>
    <% } %>
    <% if ("true".equals(request.getParameter("logout"))) { %>
      <div class="auth-success">You have been logged out.</div>
    <% } %>
    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" placeholder="Enter username" required>
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Enter password" required>
      </div>
      <button type="submit" class="btn-primary">Sign In</button>
    </form>
    <div class="auth-link">
      Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp">Register</a>
    </div>
    <div class="auth-link">
      <a href="${pageContext.request.contextPath}/">&#8592; Back to Portfolio</a>
    </div>
  </div>
</div>
</body>
</html>
