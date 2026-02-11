package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

import java.io.IOException;
import java.util.List;

import dao.ServiceDAO;

/**
 * Servlet implementation class TherapistServicesServlet
 */
@WebServlet("/therapist-services")
public class TherapistServicesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int salonId = Integer.parseInt(request.getParameter("salonId"));

        ServiceDAO dao = new ServiceDAO();
        List<Service> services = dao.getServicesBySalon(salonId);

        request.setAttribute("services", services);
        request.getRequestDispatcher("therapist-services.jsp")
               .forward(request, response);
    }
}
