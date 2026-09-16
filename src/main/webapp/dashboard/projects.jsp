<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.portfolio.model.Project" %>
<%
  HttpSession sess = request.getSession(false);
  if (sess == null || sess.getAttribute("userId") == null) { response.sendRedirect(request.getContextPath() + "/login.jsp"); return; }
  List<Project> projects = (List<Project>) request.getAttribute("projects");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Projects | Admin</title>
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
    .fb{background:rgba(0,212,255,.15);color:var(--accent);padding:.2rem .6rem;border-radius:20px;font-size:.75rem;font-weight:600}
    .ab{padding:.4rem .8rem;border:1px solid var(--border);border-radius:8px;background:transparent;color:var(--muted);cursor:pointer;font-size:.8rem;font-family:var(--font-body);transition:.3s;margin-right:.3rem}
    .ab:hover{border-color:var(--accent);color:var(--accent)}
    .ab.del{color:#ff6b6b;border-color:rgba(255,77,77,.3)}
    .ab.del:hover{background:rgba(255,77,77,.1);border-color:#ff6b6b}
    .mo{display:none;position:fixed;inset:0;background:rgba(0,0,0,.7);z-index:100;align-items:center;justify-content:center}
    .mo.show{display:flex}
    .md{background:var(--surface);border:1px solid var(--border);border-radius:var(--radius);padding:2rem;width:100%;max-width:500px}
    .md h2{font-family:var(--font-heading);font-size:1.8rem;margin-bottom:1.2rem}
    .md .form-group{margin-bottom:1rem}
    .br{display:flex;gap:1rem;margin-top:1rem}
    .bc{padding:.7rem 1.2rem;background:transparent;border:1px solid var(--border);border-radius:50px;color:var(--muted);cursor:pointer;font-family:var(--font-body)}
    .cl{display:flex;align-items:center;gap:.5rem;color:var(--muted);font-size:.9rem}
    .cl input{accent-color:var(--accent)}
  </style>
</head>
<body>
  <aside class="sb">
    <div class="sb-logo">JV. Admin</div>
    <ul>
      <li><a href="${pageContext.request.contextPath}/dashboard/index.jsp"><i class="fa-solid fa-house"></i> Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/dashboard/projects" class="active"><i class="fa-solid fa-diagram-project"></i> Projects</a></li>
      <li><a href="${pageContext.request.contextPath}/dashboard/skills"><i class="fa-solid fa-code"></i> Skills</a></li>
      <li><a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-eye"></i> View Site</a></li>
    </ul>
    <div class="sb-bot"><a href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></div>
  </aside>
  <main class="mc">
    <div class="dh"><h1>Projects</h1><button class="btn-primary" onclick="openM('add')">+ Add Project</button></div>
    <table>
      <thead><tr><th>Title</th><th>Tech Stack</th><th>Featured</th><th>Actions</th></tr></thead>
      <tbody>
      <% if(projects!=null){for(Project p:projects){ %>
        <tr>
          <td><strong><%= p.getTitle() %></strong></td>
          <td style="color:var(--muted)"><%= p.getTechStack()!=null?p.getTechStack():"-" %></td>
          <td><% if(p.isFeatured()){ %><span class="fb">Featured</span><% } %></td>
          <td>
            <button class="ab" onclick="openM('edit',<%= p.getProjectId() %>,'<%= p.getTitle().replace("'","\\'") %>','<%= p.getDescription()!=null?p.getDescription().replace("'","\\'").replace("\n"," "):"" %>','<%= p.getTechStack()!=null?p.getTechStack().replace("'","\\'"):"" %>','<%= p.getProjectUrl()!=null?p.getProjectUrl():"" %>','<%= p.getGithubUrl()!=null?p.getGithubUrl():"" %>',<%= p.isFeatured() %>)">Edit</button>
            <form method="post" action="${pageContext.request.contextPath}/dashboard/projects" style="display:inline" onsubmit="return confirm('Delete this project?')">
              <input type="hidden" name="action" value="delete"><input type="hidden" name="project_id" value="<%= p.getProjectId() %>">
              <button type="submit" class="ab del">Delete</button>
            </form>
          </td>
        </tr>
      <% }} %>
      </tbody>
    </table>
  </main>
  <div class="mo" id="pm">
    <div class="md">
      <h2 id="mt">Add Project</h2>
      <form method="post" action="${pageContext.request.contextPath}/dashboard/projects">
        <input type="hidden" name="action" id="ma" value="add">
        <input type="hidden" name="project_id" id="mi">
        <div class="form-group"><label>Title</label><input type="text" id="ft" name="title" required></div>
        <div class="form-group"><label>Description</label><textarea id="fd" name="description" rows="3"></textarea></div>
        <div class="form-group"><label>Tech Stack</label><input type="text" id="fs" name="tech_stack"></div>
        <div class="form-group"><label>Project URL</label><input type="text" id="fp" name="project_url"></div>
        <div class="form-group"><label>GitHub URL</label><input type="text" id="fg" name="github_url"></div>
        <label class="cl"><input type="checkbox" name="is_featured" id="ff"> Featured</label>
        <div class="br"><button type="submit" class="btn-primary">Save</button><button type="button" class="bc" onclick="closeM()">Cancel</button></div>
      </form>
    </div>
  </div>
  <script>
  function openM(m,id,t,d,s,p,g,f){
    document.getElementById('pm').classList.add('show');
    document.getElementById('ma').value=m;
    if(m==='edit'){document.getElementById('mt').textContent='Edit Project';document.getElementById('mi').value=id;document.getElementById('ft').value=t;document.getElementById('fd').value=d;document.getElementById('fs').value=s;document.getElementById('fp').value=p;document.getElementById('fg').value=g;document.getElementById('ff').checked=f;}
    else{document.getElementById('mt').textContent='Add Project';document.getElementById('mi').value='';document.getElementById('ft').value='';document.getElementById('fd').value='';document.getElementById('fs').value='';document.getElementById('fp').value='';document.getElementById('fg').value='';document.getElementById('ff').checked=false;}
  }
  function closeM(){document.getElementById('pm').classList.remove('show');}
  document.getElementById('pm').addEventListener('click',function(e){if(e.target===this)closeM();});
  </script>
</body>
</html>
