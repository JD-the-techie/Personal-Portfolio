package com.portfolio.servlet;

import com.portfolio.dao.MessageDAO;
import com.portfolio.model.Message;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String subject = request.getParameter("subject");
        String msgText = request.getParameter("message");

        // Server-side validation
        if (name == null || name.trim().length() < 3) {
            response.sendRedirect(request.getContextPath() + "/index.jsp?contact=error&reason=name");
            return;
        }
        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            response.sendRedirect(request.getContextPath() + "/index.jsp?contact=error&reason=email");
            return;
        }
        if (msgText == null || msgText.trim().length() < 20) {
            response.sendRedirect(request.getContextPath() + "/index.jsp?contact=error&reason=message");
            return;
        }

        try {
            Message msg = new Message();
            msg.setSenderName(name.trim());
            msg.setSenderEmail(email.trim());
            msg.setSubject(subject != null ? subject.trim() : "");
            msg.setMessage(msgText.trim());

            MessageDAO dao = new MessageDAO();
            dao.saveMessage(msg);
            response.sendRedirect(request.getContextPath() + "/index.jsp?contact=success");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/index.jsp?contact=error&reason=db");
        }
    }
}
