package controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import dao.SalonDAO;
import dao.ServiceDAO;
import model.Salon;

@WebServlet("/search-salons")
public class SearchSalonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String location = req.getParameter("location");

        try {
            SalonDAO salonDAO = new SalonDAO();
            ServiceDAO serviceDAO = new ServiceDAO();

            // Fetch all salons or search
            List<Salon> salons;
            boolean searched = (name != null && !name.trim().isEmpty())
                    || (location != null && !location.trim().isEmpty());

            if (searched) {
                salons = salonDAO.searchSalons(name, location, null);
            } else {
                salons = salonDAO.getAllSalons();
            }

            // Only approved salons
            salons = salons.stream()
                    .filter(s -> "Approved".equals(s.getStatus()))
                    .collect(Collectors.toList());

            // Populate services
            for (Salon s : salons) {
                s.setServices(serviceDAO.getServicesBySalon(s.getId()));
            }

            req.setAttribute("salons", salons);
            req.setAttribute("searchName", name);
            req.setAttribute("searchLocation", location);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error fetching salons: " + e.getMessage());
        }

        RequestDispatcher rd = req.getRequestDispatcher("search-salons.jsp");
        rd.forward(req, resp);
    }
}
