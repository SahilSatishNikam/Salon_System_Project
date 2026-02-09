<%@ page import="java.util.*, model.*, dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
/* 🔐 SECURITY CHECK */
Admin admin = (Admin) session.getAttribute("admin");
if(admin == null){
    response.sendRedirect("login.jsp");
    return;
}

/* DAO instances */
SalonDAO salonDAO = new SalonDAO();
AppointmentDAO appointmentDAO = new AppointmentDAO();
UserDAO userDAO = new UserDAO();
FeedbackDAO feedbackDAO = new FeedbackDAO();

/* Counts */
int totalSalons = 0;
int totalAppointments = 0;
int totalUsers = 0;
int totalFeedback = 0;
int pendingSalons = 0, approvedSalons = 0, rejectedSalons = 0;

try {
    totalSalons = salonDAO.getTotalSalons();
    totalAppointments = appointmentDAO.getTotalAppointments();
    totalUsers = userDAO.getTotalUsers();
    totalFeedback = feedbackDAO.getTotalFeedback();

    List<Salon> allSalons = salonDAO.getAllSalons();
    pendingSalons = (int) allSalons.stream().filter(s -> "Pending".equalsIgnoreCase(s.getStatus())).count();
    approvedSalons = (int) allSalons.stream().filter(s -> "Approved".equalsIgnoreCase(s.getStatus())).count();
    rejectedSalons = (int) allSalons.stream().filter(s -> "Rejected".equalsIgnoreCase(s.getStatus())).count();

} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet" href="sidebar.css">

<style>
body { font-family:Poppins, sans-serif; background:#0f0f0f; color:#fff; display:flex; }

/* MAIN CONTENT */
.main{
    margin-left:260px;
    width:100%;
    padding:30px;
}

/* TOPBAR */
.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:30px;
}
.search{
    width:350px;
    padding:12px 18px;
    border-radius:30px;
    border:1px solid #333;
    background:#151515;
    color:#fff;
}
.profile{
    color:#f5c518;
    font-weight:600;
}

/* CARDS */
.cards{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:20px;
    margin-bottom:30px;
}
.card-box{
    background:#151515;
    border:1px solid #2a2a2a;
    border-radius:15px;
    padding:25px;
}
.card-box h6{
    color:#aaa;
}
.count{
    font-size:28px;
    color:#f5c518;
    font-weight:700;
}

/* GRID */
.grid{
    display:grid;
    grid-template-columns:2fr 1fr;
    gap:20px;
}

.box{
    background:#151515;
    border-radius:15px;
    padding:25px;
    border:1px solid #2a2a2a;
}

/* TABLE */
table{
    width:100%;
    border-collapse:collapse;
}
th,td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #333;
}
th{
    color:#f5c518;
}
</style>
</head>

<body>

<!-- SIDEBAR (External Include) -->
<%@ include file="sidebar.jsp" %>

<!-- MAIN CONTENT -->
<div class="main">

    <!-- TOPBAR -->
    <div class="topbar">
        <input class="search" placeholder="Search services, clients...">
        <div class="profile">
            <i class="bi bi-person-circle"></i>
            Welcome, <%= admin.getName() %>
        </div>
    </div>

    <!-- CARDS -->
    <div class="cards">
        <div class="card-box">
            <h6><i class="bi bi-shop"></i> Salons</h6>
            <div class="count"><%= totalSalons %></div>
        </div>
        <div class="card-box">
            <h6><i class="bi bi-calendar-check"></i> Appointments</h6>
            <div class="count"><%= totalAppointments %></div>
        </div>
        <div class="card-box">
            <h6><i class="bi bi-people"></i> Users</h6>
            <div class="count"><%= totalUsers %></div>
        </div>
        <div class="card-box">
            <h6><i class="bi bi-chat-left-text"></i> Feedback</h6>
            <div class="count"><%= totalFeedback %></div>
        </div>
    </div>

    <!-- LOWER GRID -->
    <div class="grid">

        <!-- SALON STATUS -->
        <div class="box">
            <h5 style="color:#f5c518;">Salon Status</h5>
            <table>
                <tr>
                    <th>Pending</th>
                    <th>Approved</th>
                    <th>Rejected</th>
                </tr>
                <tr>
                    <td><%= pendingSalons %></td>
                    <td><%= approvedSalons %></td>
                    <td><%= rejectedSalons %></td>
                </tr>
            </table>
        </div>

        <!-- RIGHT PANEL -->
        <div class="box">
            <h5 style="color:#f5c518;">Admin Info</h5>
            <p style="color:#aaa">
                Manage salons, therapists, users and appointments using sidebar.
            </p>
        </div>

    </div>

</div>

</body>
</html>
