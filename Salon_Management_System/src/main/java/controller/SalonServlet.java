package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.SalonDAO;
import dao.ServiceDAO;
import dao.TherapistDAO;
import model.Salon;
import model.Service;
import model.Therapist;

@WebServlet("/SalonServlet")
public class SalonServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ Match parameter from URL: ?id=3
            int salonId = Integer.parseInt(request.getParameter("id"));

            Salon salon = new SalonDAO().getSalonById(salonId);

            // ✅ Correct method to get services of salon
            List<Service> services = new ServiceDAO().getServicesBySalon(salonId);

            List<Therapist> therapists = new TherapistDAO().getTherapistsBySalon(salonId);

            request.setAttribute("salon", salon);
            request.setAttribute("services", services);
            request.setAttribute("therapists", therapists);

            // ✅ Match your actual JSP file name
            request.getRequestDispatcher("salon-details.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=Salon+not+found");
        }
    }
}