

package controller;

import java.io.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import dao.SalonDAO;
import model.Salon;

@WebServlet("/SearchSalonServlet")
public class SearchSalonServlet extends HttpServlet {

 @Override
 protected void doGet(HttpServletRequest req,
 HttpServletResponse res)
 throws ServletException, IOException {

  String name = req.getParameter("name");
  String loc  = req.getParameter("location");

  if(name == null) name="";
  if(loc == null) loc="";

  SalonDAO dao = new SalonDAO();

  List<Salon> result =
   dao.searchByNameLocation(name, loc);

  req.setAttribute("list", result);

  RequestDispatcher rd =
   req.getRequestDispatcher("search-salons.jsp");

  rd.forward(req, res);
 }
}
