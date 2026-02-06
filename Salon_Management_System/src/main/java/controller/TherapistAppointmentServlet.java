package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import dao.AppointmentDAO;
import model.Appointment;

@WebServlet("/TherapistAppointmentServlet")
public class TherapistAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer therapistId = (Integer) session.getAttribute("therapistId");

        if (therapistId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            AppointmentDAO dao = new AppointmentDAO();
            List<Appointment> appointments = dao.getAppointmentsByTherapistId(therapistId);
            req.setAttribute("appointments", appointments);
            req.getRequestDispatcher("therapistAppointments.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        Integer therapistId = (Integer) req.getSession().getAttribute("therapistId");

        if (therapistId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            AppointmentDAO dao = new AppointmentDAO();
            int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));

            switch (action) {
                case "start":
                    dao.startAppointment(appointmentId);
                    break;

                case "complete":
                    Appointment appt = dao.getAppointmentById(appointmentId);
                    if (appt != null) {
                        dao.markAppointmentCompleted(appointmentId, appt.getUserId());
                    }
                    break;
            }

            resp.sendRedirect("TherapistAppointmentServlet");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
