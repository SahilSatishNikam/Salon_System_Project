package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import dao.AdminDAO;
import dao.TherapistDAO;
import dao.UserDAO;

import model.Admin;
import model.Therapist;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            // 🔴 ADMIN LOGIN
            AdminDAO adminDAO = new AdminDAO();
            Admin admin = adminDAO.login(email, password);

            if (admin != null) {
                HttpSession session = req.getSession();
                session.setAttribute("admin", admin);  // store full object
                session.setAttribute("role", "admin");
                resp.sendRedirect("dashboard.jsp");
                return;
            }

            // 🟢 THERAPIST LOGIN
            TherapistDAO therapistDAO = new TherapistDAO();
            Therapist therapist = therapistDAO.login(email, password);

            if (therapist != null) {
                HttpSession session = req.getSession();
                session.setAttribute("therapist", therapist); // store full object
                session.setAttribute("role", "therapist");
                resp.sendRedirect("therapist-dashboard.jsp");
                return;
            }

            // 🔵 USER LOGIN
            UserDAO userDAO = new UserDAO();
            User user = userDAO.login(email, password);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user); // store full object
                session.setAttribute("role", "user");
                resp.sendRedirect("user-dashboard.jsp");
                return;
            }

            // ❌ INVALID LOGIN
            resp.sendRedirect("login.jsp?error=Invalid Email or Password");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("login.jsp?error=Server+error");
        }
    }
}
