package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import dao.AppointmentDAO;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");

            AppointmentDAO dao = new AppointmentDAO();
            dao.updateStatus(id, status,status);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // redirect back to dashboard
        res.sendRedirect("TherapistDashboardServlet");
    }
}
