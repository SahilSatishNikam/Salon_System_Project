package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import dao.TherapistDAO;

@WebServlet("/ApproveTherapistServlet")
public class ApproveTherapistServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int therapistId = Integer.parseInt(req.getParameter("therapistId"));

        try {
            TherapistDAO therapistDAO = new TherapistDAO();
            therapistDAO.approveTherapist(therapistId);

            // ✅ Redirect to AdminTherapistServlet to reload page correctly
            resp.sendRedirect("AdminTherapistServlet");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("AdminTherapistServlet?error=Server+Error");
        }
    }
}
