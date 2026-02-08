package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import dao.SalonDAO;
import dao.ServiceDAO;
import model.Salon;

@WebServlet("/manage-salons")
public class ManageSalonsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            SalonDAO salonDAO = new SalonDAO();
            ServiceDAO serviceDAO = new ServiceDAO();

            // Fetch all salons
            List<Salon> salons = salonDAO.getAllSalons();

            // Populate services for each salon
            for (Salon s : salons) {
                s.setServices(serviceDAO.getServicesBySalon(s.getId()));
            }

            // Set as request attribute
            req.setAttribute("salons", salons);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error fetching salons: " + e.getMessage());
        }

        // Forward to JSP
        RequestDispatcher rd = req.getRequestDispatcher("manage-salons.jsp");
        rd.forward(req, resp);
    }
}
