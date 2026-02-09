package controller;

import dao.AppointmentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/CompleteAppointmentServlet")
public class CompleteAppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            int userId = Integer.parseInt(request.getParameter("userId"));

            AppointmentDAO appointmentDAO = new AppointmentDAO();

            // ✅ This method will mark completed AND save client & visit
            boolean completed = appointmentDAO.markAppointmentCompleted(appointmentId, userId);

            if (completed) {
                response.sendRedirect("user-dashboard.jsp?completed=1");
            } else {
                response.sendRedirect("user-dashboard.jsp?completed=0");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user-dashboard.jsp?completed=0");
        }
    }
}
