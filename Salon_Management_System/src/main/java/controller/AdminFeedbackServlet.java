package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;

import java.io.IOException;
import java.util.List;

import dao.FeedbackDAO;

/**
 * Servlet implementation class AdminFeedbackServlet
 */
@WebServlet("/AdminFeedbackServlet")
public class AdminFeedbackServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        FeedbackDAO dao = new FeedbackDAO();
        List<Feedback> feedbackList = dao.getAllFeedback();

        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("admin-feedback.jsp").forward(request, response);
    }
}