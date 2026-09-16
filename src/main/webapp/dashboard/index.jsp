<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.portfolio.dao.*" %>
<%
  HttpSession sess = request.getSession(false);
  if (sess == null || sess.getAttribute("userId") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
  }
  int userId = (int) sess.getAttribute("userId");
  String username = (String) sess.getAttribute("username");
  int projectCount = new ProjectDAO().getProjectCount(userId);
  int skillCount   = new SkillDAO().getSkillCount(userId);
  int msgCount     = new MessageDAO().getUnreadCount();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard | Portfolio Admin</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <style>
    body{cursor:auto;display:flex;min-height:100vh}
    .sidebar{width:260px;background:var(--surface);border-right:1px solid var(--border);padding:2rem 1.5rem;display:flex;flex-direction:column;position:fixed;top:0;bottom:0;left:0;z-index:50}
    .sidebar-logo{font-family:var(--font-heading);font-size:2rem;color:var(--accent);letter-spacing:.1em;margin-bottom:2.5rem}
    .sidebar-nav{list-style:none;display:flex;flex-direction:column;gap:.5rem;flex:1}
    .sidebar-nav a{display:flex;align-items:center;gap:.8rem;padding:.85rem 1rem;border-radius:10px;color:var(--muted);text-decoration:none;font-size:.9rem;transition:all .3s}
    .sidebar-nav a:hover,.sidebar-nav a.active{background:rgba(0,212,255,.08);color:var(--accent)}
    .sidebar-nav a i{width:20px;text-align:center}
    .sidebar-bottom{border-top:1px solid var(--border);padding-top:1.5rem}
    .sidebar-bottom a{color:#ff6b6b}
    .sidebar-bottom a:hover{background:rgba(255,77,77,.08)!important;color:#ff6b6b!important}
    .main-content{margin-left:260px;flex:1;padding:2rem 3rem}
    .dash-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:2.5rem}
    .dash-header h1{font-family:var(--font-heading);font-size:2.5rem}
    .dash-header .user-badge{background:var(--glass);border:1px solid var(--border);padding:.5rem 1.2rem;border-radius:50px;color:var(--muted);font-size:.85rem}
    .dash-cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1.5rem;margin-bottom:2.5rem}
    .dash-card{background:var(--glass);border:1px solid var(--border);border-radius:var(--radius);padding:1.8rem;backdrop-filter:blur(12px);transition:all .3s}
    .dash-card:hover{border-color:rgba(0,212,255,.3);transform:translateY(-4px)}
    .dash-card-icon{font-size:1.5rem;color:var(--accent);margin-bottom:.8rem}
    .dash-card-number{font-family:var(--font-heading);font-size:2.8rem;color:var(--text);line-height:1}
    .dash-card-label{font-size:.85rem;color:var(--muted);margin-top:.3rem}
    .dash-card.purple .dash-card-icon{color:#a78bfa}
    .dash-card.red .dash-card-icon{color:#ff6b6b}
  </style>
</head>
<body>
  <aside class="sidebar">
    <div class="sidebar-logo">JV. Admin</div>
    <ul class="sidebar-nav">
      <li><a href="${pageContext.request.contextPath}/dashboard/index.jsp" class="active"><i class="fa-solid fa-house"></i> Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/dashboard/projects"><i class="fa-solid fa-diagram-project"></i> Projects</a></li>
      <li><a href="${pageContext.request.contextPath}/dashboard/skills"><i class="fa-solid fa-code"></i> Skills</a></li>
      <li><a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-eye"></i> View Portfolio</a></li>
    </ul>
    <div class="sidebar-bottom">
      <a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
    </div>
  </aside>

  <main class="main-content">
    <div class="dash-header">
      <h1>Welcome back, <%= username != null ? username : "Admin" %></h1>
      <span class="user-badge"><i class="fa-solid fa-user"></i> &nbsp;<%= username %></span>
    </div>

    <div class="dash-cards">
      <div class="dash-card">
        <div class="dash-card-icon"><i class="fa-solid fa-diagram-project"></i></div>
        <div class="dash-card-number"><%= projectCount %></div>
        <div class="dash-card-label">Total Projects</div>
      </div>
      <div class="dash-card purple">
        <div class="dash-card-icon"><i class="fa-solid fa-code"></i></div>
        <div class="dash-card-number"><%= skillCount %></div>
        <div class="dash-card-label">Total Skills</div>
      </div>
      <div class="dash-card red">
        <div class="dash-card-icon"><i class="fa-solid fa-envelope"></i></div>
        <div class="dash-card-number"><%= msgCount %></div>
        <div class="dash-card-label">Unread Messages</div>
      </div>
    </div>
  </main>
</body>
</html>
