<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="dao.FeedbackDAO" %>
<%@ page import="model.Feedback" %>

<%
    FeedbackDAO dao = new FeedbackDAO();
    List<Feedback> list = dao.getFeedbackBySalon(1); // salonId
%>

<h2>Customer Reviews</h2>

<% if (list != null && !list.isEmpty()) { %>

    <% for (Feedback f : list) { %>
        <div class="review">
            <p>Salon Rating: ⭐ <%= f.getSalonRating() %> / 5</p>
            <p>Therapist Rating: ⭐ <%= f.getTherapistRating() %> / 5</p>
            <p><%= f.getComments() %></p>
            <hr>
        </div>
    <% } %>

<% } else { %>
    <p>No reviews available.</p>
<% } %>
