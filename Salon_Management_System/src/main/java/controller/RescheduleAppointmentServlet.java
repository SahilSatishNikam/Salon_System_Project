package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

import dao.AppointmentDAO;

@WebServlet("/RescheduleAppointmentServlet")
public class RescheduleAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
        LocalDate date = LocalDate.parse(req.getParameter("date"));
        LocalTime time = LocalTime.parse(req.getParameter("time"));

        AppointmentDAO dao = new AppointmentDAO();
        try {
			dao.rescheduleAppointment(appointmentId, date, time);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        resp.sendRedirect("UserAppointmentServlet");
    }
}
