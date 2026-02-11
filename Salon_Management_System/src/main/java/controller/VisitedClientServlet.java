package controller;

import dao.VisitedClientDAO;
import model.VisitedClient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/visitedClients")
public class VisitedClientServlet extends HttpServlet {

    private VisitedClientDAO dao = new VisitedClientDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<VisitedClient> clients = dao.getAllVisitedClients();
        request.setAttribute("visitedClients", clients);

        request.getRequestDispatcher("visitedClients.jsp").forward(request, response);
    }
}
