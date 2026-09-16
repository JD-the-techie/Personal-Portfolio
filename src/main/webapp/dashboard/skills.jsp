<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.portfolio.model.Skill" %>
<%
  HttpSession sess = request.getSession(false);
  if (sess == null || sess.getAttribute("userId") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
  List<Skill> skills = (List<Skill>) request.getAttribute("skills");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Skills | Admin</title>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <style>
    body{cursor:auto;display:flex;min-height:100vh}
    .sb{width:240px;background:var(--surface);border-right:1px solid var(--border);padding:2rem 1.2rem;display:flex;flex-direction:column;position:fixed;top:0;bottom:0;left:0}
    .sb-logo{font-family:var(--font-heading);font-size:2rem;color:var(--accent);margin-bottom:2rem;letter-spacing:.1em}
    .sb ul{list-style:none;display:flex;flex-direction:column;gap:.4rem;flex:1}
    .sb a{display:flex;align-items:center;gap:.7rem;padding:.8rem 1rem;border-radius:10px;color:var(--muted);text-decoration:none;font-size:.9rem;transition:.3s}
    .sb a:hover,.sb a.active{background:rgba(0,212,255,.08);color:var(--accent)}
    .sb-bot{border-top:1px solid var(--border);padding-top:1rem}
    .sb-bot a{color:#ff6b6b}
    .mc{margin-left:240px;flex:1;padding:2rem 3rem}
    .dh{display:flex;align-items:center;justify-content:space-between;margin-bottom:2rem}
    .dh h1{font-family:var(--font-heading);font-size:2.5rem}
    table{width:100%;border-collapse:collapse}
    th,td{padding:.9rem;text-align:left;border-bottom:1px solid var(--border)}
    th{color:var(--muted);font-size:.8rem;text-transform:uppercase;letter-spacing:.1em}
    tr:hover{background:var(--glass)}
    .prof-bar{width:100px;height:6px;background:rgba(255,255,255,.05);border-radius:4px;overflow:hidden;display:inline-block;vertical-align:middle;margin-left:.5rem}
    .prof-fill{height:100%;background:linear-gradient(90deg,var(--accent),var(--accent2));border-radius:4px}
    .ab{padding:.4rem .8rem;border:1px solid var(--border);border-radius:8px;background:transparent;color:var(--muted);cursor:pointer;font-size:.8rem;font-family:var(--font-body);transition:.3s;margin-right:.3rem}
    .ab:hover{border-color:var(--accent);color:var(--accent)}
    .ab.del{color:#ff6b6b;border-color:rgba(255,77,77,.3)}
    .ab.del:hover{background:rgba(255,77,77,.1);border-color:#ff6b6b}
    .mo{display:none;position:fixed;inset:0;background:rgba(0,0,0,.7);z-index:100;align-items:center;justify-content:center}
    .mo.show{display:flex}
    .md{background:var(--surface);border:1px solid var(--border);border-radius:var(--radius);padding:2rem;width:100%;max-width:460px}
    .md h2{font-family:var(--font-heading);font-size:1.8rem;margin-bottom:1.2rem}
    .md .form-group{margin-bottom:1rem}
    .br{display:flex;gap:1rem;margin-top:1rem}
    .bc{padding:.7rem 1.2rem;background:transparent;border:1px solid var(--border);border-radius:50px;color:var(--muted);cursor:pointer;font-family:var(--font-body)}
  </style>
</head>
<body>
  <aside class="sb">
    <div class="sb-logo">JV. Admin</div>
    <ul>
      <li><a href="${pageContext.request.contextPath}/dashboard/index.jsp"><i class="fa-solid fa-house"></i> Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/dashboard/projects"><i class="fa-solid fa-diagram-project"></i> Projects</a></li>
      <li><a href="${pageContext.request.contextPath}/dashboard/skills" class="active"><i class="fa-solid fa-code"></i> Skills</a></li>
      <li><a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-eye"></i> View Site</a></li>
    </ul>
    <div class="sb-bot"><a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
  </aside>
  <main class="mc">
    <div class="dh"><h1>Skills</h1><button class="btn-primary" onclick="openM('add')">+ Add Skill</button></div>
    <table>
      <thead><tr><th>Skill</th><th>Category</th><th>Proficiency</th><th>Icon Class</th><th>Actions</th></tr></thead>
      <tbody>
      <% if(skills!=null){for(Skill s:skills){ %>
        <tr>
          <td><strong><%= s.getSkillName() %></strong></td>
          <td style="color:var(--muted)"><%= s.getCategory() %></td>
          <td><%= s.getProficiencyLevel() %>%<div class="prof-bar"><div class="prof-fill" style="width:<%= s.getProficiencyLevel() %>%"></div></div></td>
          <td style="color:var(--muted);font-size:.8rem"><%= s.getIconClass()!=null?s.getIconClass():"-" %></td>
          <td>
            <button class="ab" onclick="openM('edit',<%= s.getSkillId() %>,'<%= s.getSkillName().replace("'","\\'") %>','<%= s.getCategory().replace("'","\\'") %>',<%= s.getProficiencyLevel() %>,'<%= s.getIconClass()!=null?s.getIconClass().replace("'","\\'"):"" %>')">Edit</button>
            <form method="post" action="${pageContext.request.contextPath}/dashboard/skills" style="display:inline" onsubmit="return confirm('Delete this skill?')">
              <input type="hidden" name="action" value="delete"><input type="hidden" name="skill_id" value="<%= s.getSkillId() %>">
              <button type="submit" class="ab del">Delete</button>
            </form>
          </td>
        </tr>
      <% }} %>
      </tbody>
    </table>
  </main>
  <div class="mo" id="sm">
    <div class="md">
      <h2 id="mt">Add Skill</h2>
      <form method="post" action="${pageContext.request.contextPath}/dashboard/skills">
        <input type="hidden" name="action" id="ma" value="add">
        <input type="hidden" name="skill_id" id="mi">
        <div class="form-group"><label>Skill Name</label><input type="text" id="fn" name="skill_name" required></div>
        <div class="form-group"><label>Category</label><input type="text" id="fc" name="category" required placeholder="e.g. Languages, Web, Core"></div>
        <div class="form-group"><label>Proficiency (0-100)</label><input type="number" id="fp" name="proficiency_level" min="0" max="100" value="70"></div>
        <div class="form-group"><label>Icon Class</label><input type="text" id="fi" name="icon_class" placeholder="e.g. fa-brands fa-java"></div>
        <div class="br"><button type="submit" class="btn-primary">Save</button><button type="button" class="bc" onclick="closeM()">Cancel</button></div>
      </form>
    </div>
  </div>
  <script>
  function openM(m,id,n,c,p,i){
    document.getElementById('sm').classList.add('show');
    document.getElementById('ma').value=m;
    if(m==='edit'){document.getElementById('mt').textContent='Edit Skill';document.getElementById('mi').value=id;document.getElementById('fn').value=n;document.getElementById('fc').value=c;document.getElementById('fp').value=p;document.getElementById('fi').value=i;}
    else{document.getElementById('mt').textContent='Add Skill';document.getElementById('mi').value='';document.getElementById('fn').value='';document.getElementById('fc').value='';document.getElementById('fp').value='70';document.getElementById('fi').value='';}
  }
  function closeM(){document.getElementById('sm').classList.remove('show');}
  document.getElementById('sm').addEventListener('click',function(e){if(e.target===this)closeM();});
  </script>
</body>
</html>
