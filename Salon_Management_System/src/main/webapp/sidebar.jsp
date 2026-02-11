<%@ page contentType="text/html;charset=UTF-8" %>

<!-- SIDEBAR -->
<div class="sidebar">

    <!-- LOGO / TITLE -->
    <h2><i class="bi bi-gem"></i> SalonEase Admin</h2>

    <!-- MENU LINKS -->
    <a class="active" href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="bi bi-shop"></i> Manage Salons</a>
    <a href="VisitedClientServlet"><i class="bi bi-shield-check"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="bi bi-person-badge"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="bi bi-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="bi bi-chat-left-text"></i> Feedback</a>
    <a href="reports.jsp"><i class="bi bi-bar-chart"></i> Reports</a>
    <a href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>

</div>

<!-- SIDEBAR.CSS -->
<style>
body {
    margin:0;
    font-family:'Poppins', sans-serif;
}

.sidebar {
    width:250px;
    background:#000;
    min-height:100vh;
    position:fixed;
    border-right:2px solid #FFD700;
    padding-top:10px;
}

.sidebar h2 {
    text-align:center;
    padding:20px;
    color:#FFD700;
    font-weight:600;
    border-bottom:1px solid #222;
    font-size:1.3rem;
}

.sidebar a {
    display:flex;
    align-items:center;
    color:#fff;
    padding:14px 22px;
    text-decoration:none;
    border-bottom:1px solid #111;
    font-weight:500;
    font-size:19px;
}

.sidebar a i {
    margin-right:12px;
    font-size:1.1rem;
    
}

.sidebar a:hover {
    background:#FFD700;
    color:#000;
    padding-left:28px;
}

.sidebar a:hover i {
    transform: rotate(15deg);
    color:#000;
}

.sidebar a.active {
    background:#FFD700;
    color:#000;
}
</style>
