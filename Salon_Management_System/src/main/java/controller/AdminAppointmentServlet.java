package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

import dao.AppointmentDAO;
import model.Appointment;

@WebServlet("/AdminAppointmentServlet")
public class AdminAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            AppointmentDAO dao = new AppointmentDAO();
            List<Appointment> appointments = dao.getAll();
            req.setAttribute("appointments", appointments);
            req.getRequestDispatcher("adminAppointments.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        int appointmentId = Integer.parseInt(req.getParameter("appointmentId"));
        String status = req.getParameter("status");

        try {
            AppointmentDAO dao = new AppointmentDAO();
            dao.updateStatus(appointmentId, status); // Admin can override status
            resp.sendRedirect("AdminAppointmentServlet");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}
