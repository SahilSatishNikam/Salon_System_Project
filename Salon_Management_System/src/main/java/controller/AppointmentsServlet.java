package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

import dao.AppointmentDAO;
import dao.ServiceDAO;
import dao.TherapistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Appointment;
import model.User;
import model.EmailUtil;
import model.Therapist;

@WebServlet("/AppointmentServlet")
public class AppointmentsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Read form parameters
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int therapistId = Integer.parseInt(request.getParameter("therapistId"));
            Date date = Date.valueOf(request.getParameter("date"));
            Time time = Time.valueOf(request.getParameter("time") + ":00"); // add seconds

            // Create appointment object
            Appointment appointment = new Appointment();
            appointment.setUserId(user.getId());
            appointment.setSalonId(serviceId);
            appointment.setTherapistId(therapistId);
            appointment.setAppointmentDate(date);
            appointment.setAppointmentTime(time);
            appointment.setStatus("Pending");

            // Book appointment in DB
            boolean booked = new AppointmentDAO().bookAppointment(appointment);

            if (booked) {
                // Send email confirmation
                String serviceName = new ServiceDAO().getServiceById(serviceId).getName();
                Therapist therapist = (Therapist) session.getAttribute("therapist");
                String therapistName = therapist.getName();


                String subject = "Appointment Confirmed - Luxury Salon";
                String body = "Hi " + user.getName() + ",\n\n"
                        + "Your appointment is confirmed.\n"
                        + "Service: " + serviceName + "\n"
                        + "Therapist: " + therapistName + "\n"
                        + "Date: " + date + "\n"
                        + "Time: " + time;

                EmailUtil.sendMail(user.getEmail(), subject, body);

                // Redirect to appointments page
                response.sendRedirect("myAppointments.jsp");
            } else {
                request.setAttribute("error", "Failed to book appointment.");
                request.getRequestDispatcher("user-dashboard.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid service or therapist selection.");
            request.getRequestDispatcher("user-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error booking appointment: " + e.getMessage());
            request.getRequestDispatcher("user-dashboard.jsp").forward(request, response);
        }
    }
}