package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class FeedbackServlet extends HttpServlet{

 protected void doGet(HttpServletRequest r,
 HttpServletResponse s)throws IOException{

  // only view page
  s.sendRedirect("feedback.jsp");
 }
}