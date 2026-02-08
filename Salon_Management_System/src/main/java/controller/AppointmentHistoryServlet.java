package controller;

import dao.AppointmentDAO;
import dao.SalonDAO;
import dao.TherapistDAO;
import model.Admin;
import model.Appointment;
import model.Salon;
import model.Therapist;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/AppointmentHistoryServlet")
public class AppointmentHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        Admin admin = (Admin) session.getAttribute("admin");

        if(user == null && admin == null){
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            SalonDAO salonDAO = new SalonDAO();
            TherapistDAO therapistDAO = new TherapistDAO();

            // 1️⃣ Fetch all appointments for this user
            List<Appointment> history = appointmentDAO.getAppointmentHistory(user.getId());
            request.setAttribute("history", history);

            // 2️⃣ Pre-fetch all Salon & Therapist objects into Maps for quick lookup
            Map<Integer, Salon> salons = new HashMap<>();
            Map<Integer, Therapist> therapists = new HashMap<>();

            for(Appointment a : history){
                if(!salons.containsKey(a.getSalonId())){
                    salons.put(a.getSalonId(), salonDAO.getSalonById(a.getSalonId()));
                }
                if(!therapists.containsKey(a.getTherapistId())){
                    therapists.put(a.getTherapistId(), therapistDAO.getTherapistById(a.getTherapistId()));
                }
            }

            request.setAttribute("salonsMap", salons);
            request.setAttribute("therapistsMap", therapists);

            request.getRequestDispatcher("appointmentHistory.jsp").forward(request, response);

        } catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("user-dashboard.jsp?error=Unable+to+load+appointments");
        }
    }
}
