

package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import dao.OwnerDAO;

public class OwnerServlet extends HttpServlet {

 // only view / delete operations for owners

 @Override
 protected void doGet(HttpServletRequest req,
 HttpServletResponse res)
 throws ServletException, IOException {

  String action = req.getParameter("action");

  OwnerDAO dao = new OwnerDAO();

  // DELETE OWNER (if needed)
  if("delete".equals(action)){

   int id = Integer.parseInt(req.getParameter("id"));

   dao.delete(id);
  }

  res.sendRedirect("manageOwners.jsp");
 }
}
