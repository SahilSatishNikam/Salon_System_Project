package controller;

import java.io.IOException;

import dao.AppointmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CancelAppointmentServlet")
public class CancelAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        try {
            int id = Integer.parseInt(req.getParameter("id"));

            AppointmentDAO dao = new AppointmentDAO();
            boolean status = dao.cancelAppointment(id);

            if (status) {
                session.setAttribute("success", "Appointment cancelled successfully");
            } else {
                session.setAttribute("error", "Cancel failed");
            }

        } catch (Exception e) {
            session.setAttribute("error", "Error cancelling appointment");
            e.printStackTrace();
        }

        resp.sendRedirect("myAppointments.jsp");
    }
}
