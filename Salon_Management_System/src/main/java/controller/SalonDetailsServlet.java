package controller;

import java.io.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.SalonDAO;
import dao.ServiceDAO;
import model.Salon;
import model.Service;

public class SalonDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Salon salon = new SalonDAO().getSalonById(id);

            ServiceDAO serviceDAO = new ServiceDAO();
            List<Service> services = serviceDAO.getServicesBySalon(id);

            request.setAttribute("salon", salon);
            request.setAttribute("services", services);

            request.getRequestDispatcher("salon-details.jsp").forward(request, response);

        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("search-salons.jsp?error=Salon+not+found");
        }
    }
}