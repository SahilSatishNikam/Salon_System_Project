package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import dao.AdminDAO;
import model.Admin;

public class AdminLoginServlet extends HttpServlet {

 @Override
 protected void doPost(HttpServletRequest req,
 HttpServletResponse res)
 throws ServletException, IOException {

  System.out.println("SERVLET CALLED");

  String action = req.getParameter("action");

  System.out.println("ACTION = " + action);

  AdminDAO dao = new AdminDAO();

  // ===== REGISTER =====
  if("register".equals(action)){

   System.out.println("REGISTER BLOCK");

   Admin a = new Admin();

   a.setName(req.getParameter("name"));
   a.setEmail(req.getParameter("email"));
   a.setPassword(req.getParameter("password"));

   dao.register(a);

   res.sendRedirect("login.jsp?msg=registered");
   return;
  }

  // ===== LOGIN =====
  if("login".equals(action)){

   System.out.println("LOGIN BLOCK");

   String email=req.getParameter("email");
   String pass=req.getParameter("password");

   boolean ok = dao.login(email,pass);

   System.out.println("LOGIN RESULT = " + ok);

   if(ok){

    req.getSession().setAttribute("admin",email);

    res.sendRedirect("dashboard.jsp");
    return;

   }else{
    res.sendRedirect("login.jsp?error=1");
    return;
   }
  }
 }
}
