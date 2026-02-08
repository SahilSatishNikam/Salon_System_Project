package controller;

import dao.AppointmentDAO;
import dao.TherapistDAO;
import model.Appointment;
import model.Therapist;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/TherapistAppointmentServlet")
public class TherapistAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Therapist t = (Therapist) req.getSession().getAttribute("therapist");

        AppointmentDAO dao = new AppointmentDAO();
        req.setAttribute("appointments", dao.getAppointmentsByTherapist(t.getId()));

        req.getRequestDispatcher("therapistAppointments.jsp").forward(req,res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String action = req.getParameter("action");

        AppointmentDAO dao = new AppointmentDAO();

        if(action.equals("start")){
            dao.updateStatus(id,"IN_PROGRESS","APPROVED");
        }
        else if(action.equals("complete")){
            dao.updateStatus(id,"COMPLETED","APPROVED");
        }

        res.sendRedirect("TherapistAppointmentServlet");
    }
}

