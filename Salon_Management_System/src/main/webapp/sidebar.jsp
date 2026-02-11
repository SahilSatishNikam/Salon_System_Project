<%@ page contentType="text/html;charset=UTF-8" %>

<div class="sidebar">

<!-- ===== LOGO FROM GOOGLE LINK ===== -->
<div class="logo">
    <img class="logo-img"
         src="https://cdn-icons-png.flaticon.com/512/1040/1040230.png" />

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

<!-- ===== STYLE ===== -->
<style>

body{
    font-family:"Times New Roman", serif;
}

/* ===== SIDEBAR BASE ===== */
.sidebar{
    width:260px;
    background:#0b0b0b;
    height:100vh;
    position:fixed;
    border-right:1px solid #1a1a1a;

    backdrop-filter:blur(6px);
}

/* ===== LOGO ===== */
.logo{
    padding:26px 22px;
    display:flex;
    align-items:center;
    gap:10px;
}

.logo-img{
    width:30px;
    filter:drop-shadow(0 0 6px #c9a227);
}

.s1{
    color:#ffffff;
    font-weight:bold;
    font-size:19px;
}

.s2{
    color:#c9a227;
    font-size:19px;
}

/* ===== MENU LINKS ===== */
.sidebar a{
    display:flex;
    align-items:center;
    padding:18px 26px;
    color:#ffffff;              /* WHITE DEFAULT */
    font-size:18px;
    text-decoration:none;
    transition:0.3s;
    margin:6px 10px;
    border-radius:14px;
}

.sidebar a i{
    margin-right:14px;
    color:#ffffff;
    transition:0.3s;
}

/* ===== HOVER → GOLD ===== */
.sidebar a:hover{
    color:#c9a227;
    background:rgba(201,162,39,0.08);
}

.sidebar a:hover i{
    color:#c9a227;
}

/* ===== ACTIVE MENU (GLOW EFFECT) ===== */
.sidebar a.active{
    color:#c9a227;
    background:rgba(201,162,39,0.15);

    box-shadow:
        0 0 12px rgba(201,162,39,0.3),
        inset 0 0 8px rgba(201,162,39,0.2);

    border-right:4px solid #c9a227;
}

.sidebar a.active i{
    color:#c9a227;
}

/* ===== LOGOUT ===== */
.logout{
    position:absolute;
    bottom:18px;
    width:90%;
    color:#ff5c5c !important;
}

.logout:hover{
    background:rgba(255,0,0,0.1) !important;
}

</style>
