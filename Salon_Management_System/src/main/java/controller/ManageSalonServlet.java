


package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import dao.SalonDAO;
import model.Salon;

@MultipartConfig
public class ManageSalonServlet extends HttpServlet{

 // ===== ADD SALON =====
 protected void doPost(HttpServletRequest r,
 HttpServletResponse s)
 throws IOException,ServletException{

  Salon sl = new Salon();

  sl.setSalon_name(r.getParameter("name"));
  sl.setOwner_name(r.getParameter("owner"));
  sl.setDescription(r.getParameter("desc"));

  // ===== IMAGE FIX =====
  Part p = r.getPart("file");

  String fileName = p.getSubmittedFileName();

  if(fileName==null || fileName.trim().equals("")){
      fileName="default.jpg";
  }

  sl.setImage_name(fileName);

  new SalonDAO().addSalon(sl);

  s.sendRedirect("manageSalons.jsp");
 }

 // ===== SEARCH + DELETE =====
 protected void doGet(HttpServletRequest r,
 HttpServletResponse s)throws IOException{

  String action = r.getParameter("action");

  SalonDAO dao = new SalonDAO();

  // DELETE
  if("delete".equals(action)){

   int id=Integer.parseInt(r.getParameter("id"));

   dao.delete(id);

   s.sendRedirect("manageSalons.jsp");
   return;
  }

  // SEARCH
  String key=r.getParameter("key");

  r.getSession().setAttribute(
  "search", dao.search(key));

  s.sendRedirect("manageSalons.jsp");
 }
}


