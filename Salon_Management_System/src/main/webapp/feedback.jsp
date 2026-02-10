<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Feedback, dao.FeedbackDAO, model.Admin" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("admin-login.jsp");
        return;
    }

    FeedbackDAO dao = new FeedbackDAO();
    List<Feedback> feedbackList = dao.getAll();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Feedback | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { padding:20px; font-family:Arial; background:#fff8e1; }
        h1 { color:#ffb300; margin-bottom:25px; text-align:center; }
        .feedback-card { background:#fff; border:1px solid #000; border-radius:12px; padding:20px; margin-bottom:15px; box-shadow:0 2px 5px rgba(0,0,0,0.1); transition:all 0.3s ease; }
        .feedback-card:hover { box-shadow:0 6px 12px rgba(0,0,0,0.2); }
        .feedback-user { font-weight:bold; color:#000; }
        .feedback-stars { color:#ffb300; margin-top:5px; }
        .feedback-message { margin-top:10px; color:#333; }
        .feedback-date { font-size:12px; color:#666; margin-top:5px; }
        .empty { text-align:center; font-style:italic; color:#666; margin-top:50px; }
    </style>
</head>
<body>
<div class="container">
    <h1><i class="fa-solid fa-comment"></i> User Feedback</h1>
    <% if(feedbackList.isEmpty()) { %>
        <div class="empty">No feedback submitted yet.</div>
    <% } else {
        for(Feedback f : feedbackList) {
    %>
    <div class="feedback-card">
        <div class="feedback-user"><i class="fa-solid fa-user"></i> <%= f.getUser() %></div>
        <div class="feedback-stars">
            <% for(int i=1;i<=f.getRating();i++){ %>★<% } %>
            <% for(int i=f.getRating()+1;i<=5;i++){ %>☆<% } %>
        </div>
        <div class="feedback-message"><%= f.getMessage() %></div>
        <div class="feedback-date">Submitted on: <%= f.getCreatedAt() %></div>
    </div>
    <% } } %>
</div>
</body>
</html>
