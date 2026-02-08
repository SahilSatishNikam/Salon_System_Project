package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import model.Therapist;
import model.Appointment;
import dao.AppointmentDAO;

@WebServlet("/todayAppointmentsServlet")
public class TodayAppointmentsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Therapist t = (Therapist) req.getSession().getAttribute("therapist");
        if(t == null){ resp.sendRedirect("login.jsp"); return; }

        List<Appointment> list = new AppointmentDAO().getTodayAppointments(t.getId());
        req.setAttribute("appointmentList", list);

        req.getRequestDispatcher("therapistAppointments.jsp").forward(req, resp);
    }
}
