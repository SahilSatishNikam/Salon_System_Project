package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.AdminDAO;
import dao.UserDAO;
import model.Admin;
import model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String role = req.getParameter("role");

        try {
            if ("admin".equals(role)) {

                Admin admin = new Admin();
                admin.setName(name);
                admin.setEmail(email);
                admin.setPassword(password);

                AdminDAO adminDAO = new AdminDAO();
                if (adminDAO.register(admin)) {
                    res.sendRedirect("login.jsp?msg=Registered as Admin");
                } else {
                    res.sendRedirect("register.jsp?error=Registration Failed");
                }

            } else if ("user".equals(role)) {

                User user = new User();
                user.setName(name);
                user.setEmail(email);
                user.setPassword(password);
                user.setPhone(phone);

                UserDAO userDAO = new UserDAO();
                if (userDAO.registerUser(user)) {
                    res.sendRedirect("login.jsp?msg=Registered as User");
                } else {
                    res.sendRedirect("register.jsp?error=Registration Failed");
                }

            } else {
                res.sendRedirect("register.jsp?error=Invalid Role");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("register.jsp?error=Server Error");
        }
    }
}
