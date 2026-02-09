package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/TherapistInsightsServlet")
public class TherapistInsightsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){
            response.sendRedirect("login.jsp");
            return;
        }

        model.Therapist t = (model.Therapist) session.getAttribute("therapist");

        if(t == null){
            response.sendRedirect("login.jsp");
            return;
        }

        request.getRequestDispatcher("therapistInsights.jsp")
               .forward(request, response);
    }
}
