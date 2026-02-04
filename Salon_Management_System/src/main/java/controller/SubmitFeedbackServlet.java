package controller;

import dao.FeedbackDAO;
import model.Feedback;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class SubmitFeedbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
    throws IOException {

        Feedback f = new Feedback();
        f.setUserId(Integer.parseInt(req.getParameter("userId")));
        f.setSalonId(Integer.parseInt(req.getParameter("salonId")));
        f.setTherapistId(Integer.parseInt(req.getParameter("therapistId")));
        f.setSalonRating(Integer.parseInt(req.getParameter("salonRating")));
        f.setTherapistRating(Integer.parseInt(req.getParameter("therapistRating")));
        f.setComments(req.getParameter("comments"));

        new FeedbackDAO().addFeedback(f);

        res.sendRedirect("feedback/viewFeedback.jsp");
    }
}
