package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ReportServlet extends HttpServlet{

 protected void doGet(HttpServletRequest r,
 HttpServletResponse s)throws IOException{

  s.sendRedirect("reports.jsp");
 }
}
