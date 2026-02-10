package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Feedback;
import model.User;
import dao.FeedbackDAO;

@WebServlet("/submitFeedback")
public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get logged-in user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form parameters
        String message = request.getParameter("message");
        String ratingParam = request.getParameter("rating");

        if(message == null || ratingParam == null || message.trim().isEmpty()) {
            session.setAttribute("feedbackMsg", "Please fill in all fields.");
            response.sendRedirect("user-feedback.jsp");
            return;
        }

        int rating = 0;
        try {
            rating = Integer.parseInt(ratingParam);
            if(rating < 1 || rating > 5) rating = 0;
        } catch(NumberFormatException e) {
            rating = 0;
        }

        if(rating == 0) {
            session.setAttribute("feedbackMsg", "Please select a valid rating.");
            response.sendRedirect("user-feedback.jsp");
            return;
        }

        // Create Feedback object
        Feedback f = new Feedback();
        f.setUser(user.getName());
        f.setMessage(message);
        f.setRating(rating);

        // Save using DAO
        FeedbackDAO dao = new FeedbackDAO();
        boolean saved = dao.saveFeedback(f);

        if(saved) {
            session.setAttribute("feedbackMsg", "Thank you! Your feedback has been submitted.");
        } else {
            session.setAttribute("feedbackMsg", "Oops! Something went wrong. Try again.");
        }

        // Redirect back to feedback page
        response.sendRedirect("user-feedback.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("user-feedback.jsp");
    }
}
