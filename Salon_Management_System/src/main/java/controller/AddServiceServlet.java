package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.ServiceDAO;
import model.Service;

@WebServlet("/AddServiceServlet")
public class AddServiceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int salonId = Integer.parseInt(request.getParameter("salonId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int duration = Integer.parseInt(request.getParameter("durationMinutes"));

        try {
            Service s = new Service();
            s.setSalonId(salonId);
            s.setName(name);
            s.setDescription(description);
            s.setPrice(price);
            s.setDurationMinutes(duration);

            new ServiceDAO().addService(s);
            response.sendRedirect("manage-salons.jsp?success=Service+added");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-salons.jsp?error=Could+not+add+service");
        }
    }
}