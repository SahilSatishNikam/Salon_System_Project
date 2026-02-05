package controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.UserDAO;
import model.User;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if("update".equals(action)) {
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");

                user.setName(request.getParameter("name"));
                user.setPassword(request.getParameter("password"));
                user.setPhone(request.getParameter("phone"));

                new UserDAO().updateUser(user);
                session.setAttribute("user", user);

                response.sendRedirect("profile.jsp?success=Profile+Updated");
            }
        } catch(Exception e){ e.printStackTrace(); }
    }
}
 