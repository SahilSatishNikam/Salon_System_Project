package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.AdminDAO;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String st = req.getParameter("st");
        int id = req.getParameter("id") != null ? Integer.parseInt(req.getParameter("id")) : 0;

        AdminDAO dao = new AdminDAO();

        if("delete".equals(action) && id > 0){
            dao.delete(id);
            req.getSession().setAttribute("msg", "Admin deleted successfully");
        } else if(st != null && id > 0){
            dao.updateStatus(id, st);
            req.getSession().setAttribute("msg", "Admin status updated to " + st);
        }

        res.sendRedirect("manageVerifyAdmins.jsp");
    }
}
