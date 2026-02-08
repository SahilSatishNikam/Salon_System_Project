package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.AppointmentDAO;

/**
 * Servlet implementation class RejectAppointmentServlet
 */
@WebServlet("/RejectAppointmentServlet")
public class RejectAppointmentServlet extends HttpServlet{
 protected void doPost(HttpServletRequest req,HttpServletResponse res)throws IOException
 
 {

  int id=Integer.parseInt(req.getParameter("id"));

  new AppointmentDAO().updateStatus(id,"REJECTED","Rejected by admin");

  res.sendRedirect("admin/admin_appointments.jsp");
 }
}
