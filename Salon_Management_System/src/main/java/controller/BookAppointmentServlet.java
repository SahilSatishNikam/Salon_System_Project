package controller;

import dao.AppointmentDAO;
import dao.ServiceDAO;
import dao.TherapistDAO;
import dao.SalonDAO;
import model.Appointment;
import model.Salon;
import model.Service;
import model.Therapist;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;


@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("user") == null){
            response.sendRedirect("login.jsp");
            return;
        }

        int salonId = Integer.parseInt(request.getParameter("salonId"));

        Salon salon = null;
		try {
			salon = new SalonDAO().getSalonById(salonId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        List<Service> services = null;
		try {
			services = new ServiceDAO().getServicesBySalon(salonId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        List<Therapist> therapists = null;
		try {
			therapists = new TherapistDAO().getTherapistsBySalon(salonId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        request.setAttribute("salon", salon);
        request.setAttribute("services", services);
        request.setAttribute("therapists", therapists);

        request.getRequestDispatcher("book-appointment.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        try {
            int salonId = Integer.parseInt(request.getParameter("salonId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int therapistId = Integer.parseInt(request.getParameter("therapistId"));

            LocalDate date = LocalDate.parse(request.getParameter("date"));
            LocalTime time = LocalTime.parse(request.getParameter("time"));

            Service service = new ServiceDAO().getServiceById(serviceId);

            Appointment ap = new Appointment();
            ap.setUserId(user.getId());
            ap.setSalonId(salonId);
            ap.setTherapistId(therapistId);
            ap.setServiceName(service.getName());
            ap.setAppointmentDate(java.sql.Date.valueOf(date));
            ap.setAppointmentTime(java.sql.Time.valueOf(time));
            ap.setStatus("BOOKED");
            ap.setFeedbackGiven(false);

            boolean booked = new AppointmentDAO().bookAppointment(ap);

            if(booked){
                response.sendRedirect("user-dashboard.jsp?success=1");
            } else {
                request.setAttribute("error", "Booking failed");
                doGet(request, response);
            }

        } catch(Exception e){
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
        }
    }
}