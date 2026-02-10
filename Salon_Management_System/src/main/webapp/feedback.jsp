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

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* ===== GLOBAL ===== */
body {
    font-family: 'Poppins', sans-serif;
    background: #111;
    color: #fff;
    margin: 0;
    padding: 0;
}

/* ===== SIDEBAR ===== */
.sidebar {
    width: 250px;
    background: #000;
    min-height: 100vh;
    position: fixed;
    border-right: 2px solid #FFD700;
    padding-top: 10px;
    z-index: 100;
}

.sidebar h2 {
    text-align: center;
    padding: 20px;
    color: #FFD700;
    font-weight: 600;
    border-bottom: 1px solid #222;
    font-size: 1.3rem;
}

.sidebar a {
    display: flex;
    align-items: center;
    color: #fff;
    padding: 14px 22px;
    text-decoration: none;
    border-bottom: 1px solid #111;
    font-weight: 500;
    font-size: 18px;
    transition: all 0.3s ease;
}

.sidebar a i {
    margin-right: 12px;
    font-size: 1.1rem;
    transition: transform 0.3s ease, color 0.3s ease;
}

.sidebar a:hover {
    background: #FFD700;
    color: #000;
    padding-left: 28px;
}

.sidebar a:hover i {
    transform: rotate(15deg);
    color: #000;
}

.sidebar a.active {
    background: #FFD700;
    color: #000;
}

/* ===== MAIN CONTENT ===== */
.main-content {
    margin-left: 260px; /* width of sidebar + some gap */
    padding: 30px;
}

/* ===== PAGE STYLING ===== */
h1 {
    color: #ffc107;
    margin-bottom: 30px;
    text-align: center;
    font-weight: 600;
    letter-spacing: 1px;
}

.feedback-container {
    max-height: 80vh;
    overflow-y: auto;
    padding-right: 5px;
}

.feedback-card {
    background-color: #1a1a1a;
    border: 1px solid #ffc107;
    border-radius: 15px;
    padding: 20px;
    margin-bottom: 20px;
    box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
    transition: all 0.3s ease;
}

.feedback-card:hover {
    box-shadow: 0 8px 25px rgba(255, 193, 7, 0.5);
    transform: translateY(-3px);
}

.feedback-user {
    font-weight: 600;
    color: #ffc107;
    font-size: 1.1em;
}

.feedback-stars {
    color: #ffc107;
    margin-top: 5px;
    font-size: 1.1em;
}

.feedback-message {
    margin-top: 12px;
    color: #e0e0e0;
    font-size: 1em;
}

.feedback-date {
    font-size: 12px;
    color: #aaa;
    margin-top: 8px;
}

.empty {
    text-align: center;
    font-style: italic;
    color: #aaa;
    margin-top: 50px;
    font-size: 1.2em;
}

/* Custom scrollbar */
.feedback-container::-webkit-scrollbar {
    width: 8px;
}
.feedback-container::-webkit-scrollbar-track {
    background: #111;
}
.feedback-container::-webkit-scrollbar-thumb {
    background-color: #ffc107;
    border-radius: 10px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .main-content {
        margin-left: 0;
        padding: 20px;
    }

    .sidebar {
        position: relative;
        width: 100%;
        min-height: auto;
        border-right: none;
    }
}
</style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2><i class="fa-solid fa-gem"></i> SalonEase Admin</h2>
    <a class="active" href="dashboard.jsp"><i class="fa-solid fa-speedometer"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa-solid fa-shop"></i> Manage Salons</a>
    <a href="AdminClientViewServlet"><i class="fa-solid fa-shield-halved"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa-solid fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa-solid fa-calendar-check"></i> Appointments</a>
    <a href="FeedbackServlet"><i class="fa-solid fa-comment"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa-solid fa-chart-simple"></i> Reports</a>
    <a href="logout.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">
    <h1><i class="fa-solid fa-comment"></i> User Feedback</h1>

    <div class="feedback-container">
    <% if(feedbackList.isEmpty()) { %>
        <div class="empty"><i class="fa-solid fa-face-frown"></i> No feedback submitted yet.</div>
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
            <div class="feedback-date"><i class="fa-solid fa-calendar"></i> Submitted on: <%= f.getCreatedAt() %></div>
        </div>
    <% } } %>
    </div>
</div>

</body>
</html>
