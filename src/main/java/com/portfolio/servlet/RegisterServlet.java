package com.portfolio.servlet;

import com.portfolio.dao.UserDAO;
import com.portfolio.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirmPassword");

        // Server-side validation
        if (username == null || username.trim().length() < 3) {
            request.setAttribute("error", "Username must be at least 3 characters.");
            request.getRequestDispatcher("/register.jsp").forward(request, response); return;
        }
        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("/register.jsp").forward(request, response); return;
        }
        if (password == null || password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.getRequestDispatcher("/register.jsp").forward(request, response); return;
        }
        if (!password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response); return;
        }

        try {
            UserDAO dao = new UserDAO();
            if (dao.usernameExists(username.trim())) {
                request.setAttribute("error", "Username already taken.");
                request.getRequestDispatcher("/register.jsp").forward(request, response); return;
            }
            if (dao.emailExists(email.trim())) {
                request.setAttribute("error", "Email already registered.");
                request.getRequestDispatcher("/register.jsp").forward(request, response); return;
            }

            String hashed = BCrypt.hashpw(password, BCrypt.gensalt(12));
            User user = new User();
            user.setUsername(username.trim());
            user.setEmail(email.trim());
            user.setPasswordHash(hashed);

            if (dao.createUser(user)) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?registered=true");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
