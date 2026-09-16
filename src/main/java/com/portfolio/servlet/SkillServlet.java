package com.portfolio.servlet;

import com.portfolio.dao.SkillDAO;
import com.portfolio.model.Skill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/skills")
public class SkillServlet extends HttpServlet {

    private final SkillDAO skillDAO = new SkillDAO();

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
            List<Skill> skills = skillDAO.getSkillsByUser(userId);
            request.setAttribute("skills", skills);
            request.getRequestDispatcher("/dashboard/skills.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error loading skills: " + e.getMessage());
            request.getRequestDispatcher("/dashboard/skills.jsp").forward(request, response);
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
                Skill s = buildFromRequest(request, userId);
                skillDAO.addSkill(s);
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("skill_id"));
                Skill s = buildFromRequest(request, userId);
                s.setSkillId(id);
                skillDAO.updateSkill(s);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("skill_id"));
                skillDAO.deleteSkill(id);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Operation failed: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/dashboard/skills");
    }

    private Skill buildFromRequest(HttpServletRequest req, int userId) {
        Skill s = new Skill();
        s.setUserId(userId);
        s.setCategory(req.getParameter("category"));
        s.setSkillName(req.getParameter("skill_name"));
        String profStr = req.getParameter("proficiency_level");
        s.setProficiencyLevel(profStr != null && !profStr.isBlank() ? Integer.parseInt(profStr) : 70);
        s.setIconClass(req.getParameter("icon_class"));
        return s;
    }
}
