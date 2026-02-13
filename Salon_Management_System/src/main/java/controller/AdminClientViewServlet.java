package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

import dao.VisitedClientDAO;
import model.VisitedClient;

@WebServlet("/visitedClients")
public class AdminClientViewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            VisitedClientDAO dao = new VisitedClientDAO();

            // fetch all visited client records
            List<VisitedClient> list = dao.getAllVisitedClients();

            // send to JSP
            request.setAttribute("visitedClients", list);
            request.getRequestDispatcher("visitedClients.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            // fallback redirect
            response.sendRedirect("dashboard.jsp?error=visited_clients_load_failed");
        }
    }
}
