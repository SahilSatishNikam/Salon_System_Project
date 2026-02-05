package controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.SalonDAO;

@WebServlet("/DeleteSalonServlet")
public class DeleteSalonServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            new SalonDAO().deleteSalon(id);
            response.sendRedirect("manage-salons.jsp?success=Salon+deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-salons.jsp?error=Could+not+delete+salon");
        }
    }
}