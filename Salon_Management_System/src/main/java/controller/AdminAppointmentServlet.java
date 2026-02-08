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

private AppointmentDAO dao = new AppointmentDAO();

// LOAD PAGE (when you open URL in browser)
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    List<Appointment> list = dao.getAllAppointments();
    request.setAttribute("appointments", list);
    request.getRequestDispatcher("adminAppointments.jsp")
           .forward(request, response);
}

// UPDATE STATUS (when form submitted)
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    int id = Integer.parseInt(request.getParameter("appointmentId"));
    String status = request.getParameter("status");

    dao.updateAppointmentStatus(id, status);

    response.sendRedirect("AdminAppointmentServlet");
}

}
