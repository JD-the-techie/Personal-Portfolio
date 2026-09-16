package com.portfolio.servlet;

import com.portfolio.dao.ProjectDAO;
import com.portfolio.model.Project;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/projects")
public class ProjectServlet extends HttpServlet {

    private final ProjectDAO projectDAO = new ProjectDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userId");
        try {
            List<Project> projects = projectDAO.getProjectsByUser(userId);
            request.setAttribute("projects", projects);
            request.getRequestDispatcher("/dashboard/projects.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading projects: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/projects.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                Project p = buildFromRequest(request, userId);
                projectDAO.addProject(p);
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("project_id"));
                Project p = buildFromRequest(request, userId);
                p.setProjectId(id);
                projectDAO.updateProject(p);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("project_id"));
                projectDAO.deleteProject(id);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Operation failed: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/dashboard/projects");
    }

    private Project buildFromRequest(HttpServletRequest req, int userId) {
        Project p = new Project();
        p.setUserId(userId);
        p.setTitle(req.getParameter("title"));
        p.setDescription(req.getParameter("description"));
        p.setTechStack(req.getParameter("tech_stack"));
        p.setProjectUrl(req.getParameter("project_url"));
        p.setGithubUrl(req.getParameter("github_url"));
        p.setFeatured("on".equals(req.getParameter("is_featured")));
        return p;
    }
}
