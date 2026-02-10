package controller;

import dao.ServiceDAO;
import dao.TherapistDAO;
import model.Service;
import model.Therapist;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/bookPage")
public class BookAppointmentPageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int salonId = Integer.parseInt(req.getParameter("salonId"));

        ServiceDAO serviceDAO = new ServiceDAO();
        TherapistDAO therapistDAO = new TherapistDAO();

        List<Service> services = null;
		try {
			services = serviceDAO.getServicesBySalon(salonId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        List<Therapist> therapists = null;
		try {
			therapists = therapistDAO.getTherapistsBySalon(salonId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        req.setAttribute("services", services);
        req.setAttribute("therapists", therapists);
        req.setAttribute("salonId", salonId);

        req.getRequestDispatcher("book-appointment.jsp")
           .forward(req, resp);
    }
}
