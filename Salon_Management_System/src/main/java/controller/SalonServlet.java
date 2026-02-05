package controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import dao.SalonDAO;

@WebServlet("/SalonServlet")
public class SalonServlet extends HttpServlet {

 @Override
 protected void doGet(HttpServletRequest req,
 HttpServletResponse res)
 throws ServletException, IOException {

  int id = Integer.parseInt(req.getParameter("id"));
  String st = req.getParameter("st");

  SalonDAO dao = new SalonDAO();

  dao.updateStatus(id, st);

  req.getSession().setAttribute("msg",
  "Salon " + st + " Successfully");

  res.sendRedirect("verifySalons.jsp");
 }
}

