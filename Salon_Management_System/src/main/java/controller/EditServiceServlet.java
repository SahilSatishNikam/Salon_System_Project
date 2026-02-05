package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.ServiceDAO;
import model.Service;

@WebServlet("/EditServiceServlet")
public class EditServiceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int duration = Integer.parseInt(request.getParameter("durationMinutes"));

            Service s = new Service();
            s.setId(id);
            s.setName(name);
            s.setDescription(description);
            s.setPrice(price);
            s.setDurationMinutes(duration);

            new ServiceDAO().updateService(s);  // You need to implement updateService in ServiceDAO
            response.sendRedirect("manage-salons.jsp?success=Service+updated");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-salons.jsp?error=Could+not+update+service");
        }
    }
}
