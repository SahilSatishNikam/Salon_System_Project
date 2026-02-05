package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.ServiceDAO;

@WebServlet("/DeleteServiceServlet")
public class DeleteServiceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int serviceId = Integer.parseInt(request.getParameter("id"));
            int salonId = Integer.parseInt(request.getParameter("salonId"));

            new ServiceDAO().deleteService(serviceId);
            response.sendRedirect("manage-salons.jsp?success=Service+deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-salons.jsp?error=Could+not+delete+service");
        }
    }
}