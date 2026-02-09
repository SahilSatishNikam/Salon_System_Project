package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.*;

import dao.ClientVisitDAO;
import model.AdminClientView;

@WebServlet("/AdminClientViewServlet")
public class ClientServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ClientVisitDAO dao = new ClientVisitDAO();
        List<AdminClientView> clientViews = new ArrayList<>();

        dao.getAllClients().forEach(client -> {
            AdminClientView view = new AdminClientView();
            view.setId(client.getId());
            view.setName(client.getName());
            view.setPhone(client.getPhone());

            List<Map<String,Object>> visits = dao.getVisitsByClient(client.getId());
            view.setTotalVisits(visits.size());

            if(!visits.isEmpty()){
                Map<String,Object> lastVisit = visits.get(0);
                view.setLastVisit((java.sql.Date) lastVisit.get("date"));
                view.setSalonName((String) lastVisit.get("salon"));
            }

            clientViews.add(view);
        });

        request.setAttribute("clients", clientViews);
        request.getRequestDispatcher("adminClientView.jsp").forward(request, response);
    }
}
