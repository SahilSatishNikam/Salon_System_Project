

package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.CategoryDAO;

public class CategoryServlet extends HttpServlet{

 protected void doPost(HttpServletRequest r,
 HttpServletResponse s)throws IOException{

  new CategoryDAO()
  .add(r.getParameter("name"));

  s.sendRedirect("manageCategory.jsp");
 }

 protected void doGet(HttpServletRequest r,
 HttpServletResponse s)throws IOException{

  int id=Integer.parseInt(r.getParameter("id"));

  new CategoryDAO().delete(id);

  s.sendRedirect("manageCategory.jsp");
 }
}


