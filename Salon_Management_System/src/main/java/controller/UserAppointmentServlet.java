package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import dao.AppointmentDAO;
import model.Appointment;

@WebServlet("/UserAppointmentServlet")
public class UserAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        AppointmentDAO dao = new AppointmentDAO();

        List<Appointment> upcoming = dao.getUpcomingAppointments(userId);
        List<Appointment> completed = dao.getCompletedAppointments(userId);

        req.setAttribute("upcomingAppointments", upcoming);
        req.setAttribute("completedAppointments", completed);

        RequestDispatcher rd = req.getRequestDispatcher("userAppointments.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
        String action = req.getParameter("action");

        AppointmentDAO dao = new AppointmentDAO();

        if ("cancel".equals(action)) {
            dao.cancelAppointment(appointmentId);
        }

        resp.sendRedirect("UserAppointmentServlet");
    }
}
