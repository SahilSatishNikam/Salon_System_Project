<%@ page import="java.util.*, model.*, dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
SalonDAO salonDAO = new SalonDAO();
AppointmentDAO appointmentDAO = new AppointmentDAO();
UserDAO userDAO = new UserDAO();
FeedbackDAO feedbackDAO = new FeedbackDAO();
AdminDAO adminDAO = new AdminDAO();

int totalSalons=0,totalAppointments=0,totalUsers=0,totalFeedback=0;
int pendingSalons=0,approvedSalons=0,rejectedSalons=0;
int pendingAdmins=0,approvedAdmins=0,rejectedAdmins=0;
List<Admin> allAdmins = new ArrayList<>();

try {
    totalSalons = salonDAO.getTotalSalons();
    totalAppointments = appointmentDAO.getTotalAppointments();
    totalUsers = userDAO.getTotalUsers();
    totalFeedback = feedbackDAO.getTotalFeedback();

    List<Salon> allSalons = salonDAO.getAllSalons();
    pendingSalons = (int) allSalons.stream().filter(s->"Pending".equals(s.getStatus())).count();
    approvedSalons = (int) allSalons.stream().filter(s->"Approved".equals(s.getStatus())).count();
    rejectedSalons = (int) allSalons.stream().filter(s->"Rejected".equals(s.getStatus())).count();

    allAdmins = adminDAO.getAllAdmins();
    pendingAdmins = (int) allAdmins.stream().filter(a->"Pending".equals(a.getStatus())).count();
    approvedAdmins = (int) allAdmins.stream().filter(a->"Approved".equals(a.getStatus())).count();
    rejectedAdmins = (int) allAdmins.stream().filter(a->"Rejected".equals(a.getStatus())).count();

} catch(Exception e){ e.printStackTrace(); }
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
margin:0;
font-family:Poppins,sans-serif;
background:linear-gradient(135deg,#000,#1a1a1a);
color:#fff;
display:flex;
}

/* SIDEBAR */
.admin-sidebar{
    position:fixed;
    left:0;
    top:0;
    width:250px;
    height:100vh;
    background:linear-gradient(180deg,#0b0b0b,#141414);
    box-shadow:4px 0 22px rgba(255,215,0,.18);
    padding-top:15px;
    z-index:1000;
    font-family:Poppins, sans-serif;
}

/* LOGO */
.admin-sidebar .logo{
    text-align:center;
    color:#FFD700;
    font-size:22px;
    font-weight:700;
    padding:20px 10px;
    border-bottom:1px solid #222;
    margin-bottom:10px;
    letter-spacing:1px;
}

/* LINKS */
.admin-sidebar a{
    display:block;
    padding:14px 22px;
    color:#ddd;
    text-decoration:none;
    font-size:17px;
    transition:.3s;
    border-left:4px solid transparent;
}

.admin-sidebar a i{
    width:26px;
    color:#FFD700;   /* yellow icons */
    transition:.3s;
}

.admin-sidebar a:hover i{
    color:#000;   /* icon becomes black on yellow hover */
}

/* HOVER */
.admin-sidebar a:hover{
    background:#FFD700;
    color:#000;
    border-left:4px solid #fff;
    transform:translateX(6px);
}

/* LOGOUT */
.admin-sidebar .logout{
    margin-top:15px;
    color:#ff6b6b;
}

.admin-sidebar .logout:hover{
    background:#ff6b6b;
    color:#fff;
}

/* ===== PAGE CONTENT SHIFT ===== */
.main-content{
    margin-left:250px;
    padding:25px;
}


/* MAIN */
.main{
margin-left:240px;
padding:28px;
width:calc(100% - 240px);
}

/* HEADER */
.header{
background:linear-gradient(90deg,#FFD700,#ffbf00);
color:#000;
padding:24px;
border-radius:14px;
font-size:26px;
font-weight:700;
text-align:center;
box-shadow:0 10px 26px rgba(255,215,0,.25);
}

/* WELCOME */
.welcome{
margin-top:22px;
background:#111;
border:2px solid #FFD700;
border-radius:14px;
padding:20px;
display:flex;
justify-content:space-between;
align-items:center;
}
.quick a{
background:#FFD700;
color:#000;
padding:10px 14px;
margin:5px;
border-radius:8px;
text-decoration:none;
font-weight:600;
display:inline-block;
}

/* CARDS */
.cards{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
gap:20px;
margin:25px 0;
}
.card{
background:#111;
border:2px solid #FFD700;
border-radius:14px;
padding:22px;
text-align:center;
transition:.3s;
}
.card:hover{
transform:translateY(-6px);
box-shadow:0 12px 24px rgba(255,215,0,.25);
}
.num{
font-size:28px;
color:#FFD700;
font-weight:bold;
}

/* STATUS SECTION */
.status-wrapper{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(360px,1fr));
gap:24px;
margin-top:30px;
}

.status-card{
background:#111;
border:2px solid #FFD700;
border-radius:16px;
padding:22px;
box-shadow:0 10px 24px rgba(255,215,0,.15);
transition:.3s;
}

.status-card:hover{
transform:translateY(-6px);
box-shadow:0 16px 32px rgba(255,215,0,.25);
}

.status-card h3{
color:#FFD700;
margin-bottom:18px;
text-align:center;
}

.status-row{
display:flex;
justify-content:space-between;
margin-top:12px;
font-weight:600;
}

/* BADGES */
.badge{
padding:6px 12px;
border-radius:20px;
font-size:14px;
}

.badge.pending{ background:orange; color:#000; }
.badge.approved{ background:#00e676; color:#000; }
.badge.rejected{ background:#ff5252; color:#fff; }

/* PROGRESS BAR */
.progress{
height:10px;
background:#333;
border-radius:8px;
overflow:hidden;
margin-top:6px;
}

.progress div{
height:100%;
background:#FFD700;
transition:width .6s;
}


/* PROGRESS */
.progress-box{
background:#111;
border:2px solid #FFD700;
border-radius:12px;
padding:18px;
margin-top:20px;
}
.bar{
height:14px;
background:#333;
border-radius:10px;
overflow:hidden;
margin:10px 0;
}
.bar div{
height:100%;
background:#FFD700;
}

/* TABLE */
table{
width:70%;
margin:18px auto;
border-collapse:collapse;
background:#111;
border-radius:12px;
overflow:hidden;
}
th{
background:#FFD700;
color:#000;
padding:14px;
}
td{
padding:14px;
border-bottom:1px solid #333;
}
tr:hover{background:#1f1f1f;}

.pending{color:orange;font-weight:bold;}
.approved{color:#00e676;font-weight:bold;}
.rejected{color:#ff5252;font-weight:bold;}

/* ACTIVITY */
.activity{
margin-top:25px;
background:#111;
border:2px solid #FFD700;
border-radius:12px;
padding:20px;
}
.activity li{
padding:8px 0;
border-bottom:1px solid #333;
}
</style>
</head>

<body>

<div class="admin-sidebar">

    <div class="logo">
        <i class="fa-solid fa-crown"></i> Admin Panel
    </div>

    <a href="dashboard.jsp">
        <i class="fa fa-gauge"></i> Dashboard
    </a>

    <a href="manage-salons.jsp">
        <i class="fa fa-store"></i> Salons
    </a>

    <a href="manageVerifyAdmins.jsp">
        <i class="fa fa-user-shield"></i> Admins
    </a>

    <a href="AdminTherapistServlet">
        <i class="fa fa-user-doctor"></i> Therapists
    </a>

    <a href="AdminAppointmentServlet">
        <i class="fa fa-calendar-check"></i> Appointments
    </a>

    <a href="user-dashboard.jsp">
        <i class="fa fa-users"></i> Users
    </a>

    <a href="feedback.jsp">
        <i class="fa fa-comments"></i> Feedback
    </a>

    <a href="reports.jsp">
        <i class="fa fa-chart-line"></i> Reports
    </a>

    <a href="logout.jsp" class="logout">
        <i class="fa fa-right-from-bracket"></i> Logout
    </a>

</div>


<div class="main">

<div class="header">
<i class="fa fa-gauge"></i> Admin Control Center
</div>

<div class="welcome">
<div>
<h3>Welcome Back 👑</h3>
<p>Monitor platform activity and approvals in real time.</p>
</div>
<div class="quick">
<a href="manage-salons.jsp">Verify Salons</a>
<a href="manageVerifyAdmins.jsp">Verify Admins</a>
<a href="reports.jsp">Reports</a>
</div>
</div>

<div class="cards">
<div class="card"><i class="fa fa-store"></i><h3>Salons</h3><div class="num"><%=totalSalons%></div></div>
<div class="card"><i class="fa fa-calendar-check"></i><h3>Appointments</h3><div class="num"><%=totalAppointments%></div></div>
<div class="card"><i class="fa fa-users"></i><h3>Users</h3><div class="num"><%=totalUsers%></div></div>
<div class="card"><i class="fa fa-star"></i><h3>Feedback</h3><div class="num"><%=totalFeedback%></div></div>
</div>

<div class="progress-box">
<h3>Approval Insights</h3>

Salon Approval
<div class="bar">
<div style="width:<%= totalSalons==0?0:(approvedSalons*100/totalSalons) %>%"></div>
</div>

Admin Approval
<div class="bar">
<div style="width:<%= allAdmins.size()==0?0:(approvedAdmins*100/allAdmins.size()) %>%"></div>
</div>
</div>

<div class="status-wrapper">

<!-- ===== SALON STATUS CARD ===== -->
<div class="status-card">
    <h3><i class="fa fa-store"></i> Salon Status</h3>

    <div class="status-row">
        <span>Pending</span>
        <span class="badge pending"><%=pendingSalons%></span>
    </div>
    <div class="progress"><div style="width:<%= totalSalons==0?0:(pendingSalons*100/totalSalons)%>%"></div></div>

    <div class="status-row">
        <span>Approved</span>
        <span class="badge approved"><%=approvedSalons%></span>
    </div>
    <div class="progress"><div style="width:<%= totalSalons==0?0:(approvedSalons*100/totalSalons)%>%"></div></div>

    <div class="status-row">
        <span>Rejected</span>
        <span class="badge rejected"><%=rejectedSalons%></span>
    </div>
    <div class="progress"><div style="width:<%= totalSalons==0?0:(rejectedSalons*100/totalSalons)%>%"></div></div>
</div>


<!-- ===== ADMIN STATUS CARD ===== -->
<div class="status-card">
    <h3><i class="fa fa-user-shield"></i> Admin Status</h3>

    <div class="status-row">
        <span>Pending</span>
        <span class="badge pending"><%=pendingAdmins%></span>
    </div>
    <div class="progress"><div style="width:<%= allAdmins.size()==0?0:(pendingAdmins*100/allAdmins.size())%>%"></div></div>

    <div class="status-row">
        <span>Approved</span>
        <span class="badge approved"><%=approvedAdmins%></span>
    </div>
    <div class="progress"><div style="width:<%= allAdmins.size()==0?0:(approvedAdmins*100/allAdmins.size())%>%"></div></div>

    <div class="status-row">
        <span>Rejected</span>
        <span class="badge rejected"><%=rejectedAdmins%></span>
    </div>
    <div class="progress"><div style="width:<%= allAdmins.size()==0?0:(rejectedAdmins*100/allAdmins.size())%>%"></div></div>
</div>

</div>

<div class="activity">
<h3>Recent Activity</h3>
<ul>
<li>New salon registrations today</li>
<li>Appointments booked recently</li>
<li>Admins awaiting verification</li>
<li>New feedback submitted</li>
</ul>
</div>

</div>
</body>
</html>