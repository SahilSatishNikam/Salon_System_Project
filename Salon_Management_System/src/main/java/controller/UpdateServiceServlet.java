package controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.ServiceDAO;
import model.Service;

public class UpdateServiceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int salonId = Integer.parseInt(request.getParameter("salonId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int duration = Integer.parseInt(request.getParameter("durationMinutes"));

            Service s = new Service();
            s.setId(id);
            s.setSalonId(salonId);
            s.setName(name);
            s.setDescription(description);
            s.setPrice(price);
            s.setDurationMinutes(duration);

            new ServiceDAO().updateService(s);

            response.sendRedirect("admin/manage-salons.jsp?success=Service+updated");

        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/manage-salons.jsp?error=Could+not+update+service");
        }
    }
}