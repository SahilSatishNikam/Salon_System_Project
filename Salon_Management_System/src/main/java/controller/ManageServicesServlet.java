package controller;

import java.io.IOException;
import java.util.List;

import dao.SalonDAO;
import dao.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Salon;
import model.Service;


@WebServlet("/manage-services")
public class ManageServicesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int salonId = Integer.parseInt(req.getParameter("salonId"));
            SalonDAO salonDAO = new SalonDAO();
            ServiceDAO serviceDAO = new ServiceDAO();

            Salon salon = salonDAO.getSalonById(salonId);
            List<Service> services = serviceDAO.getServicesBySalon(salonId);

            req.setAttribute("salon", salon);
            req.setAttribute("services", services);
        } catch(Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Could not load services");
        }
        req.getRequestDispatcher("manage-services.jsp").forward(req, resp);
    }
}

