package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.login(email, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());

            switch (user.getRole()) {
                case "ADMIN": res.sendRedirect("admin/dashboard.jsp"); break;
                case "OWNER": res.sendRedirect("owner/dashboard.jsp"); break;
                case "THERAPIST": res.sendRedirect("therapist/dashboard.jsp"); break;
                default: res.sendRedirect("customer/dashboard.jsp");
            }
        } else {
            req.setAttribute("error", "Invalid login");
            req.getRequestDispatcher("auth/login.jsp").forward(req, res);
        }
    }
}
