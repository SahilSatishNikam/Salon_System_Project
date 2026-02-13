<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.*, dao.*" %>

<%
User user = (User) session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

int userId = user.getId();

AppointmentDAO appointmentDAO = new AppointmentDAO();
SalonDAO salonDAO = new SalonDAO();

List<Appointment> upcoming = new ArrayList<>();
List<Appointment> completed = new ArrayList<>();

try{
    upcoming = appointmentDAO.getUpcomingAppointments(userId);
    completed = appointmentDAO.getCompletedAppointments(userId);
}catch(Exception e){
    out.println("<p style='color:red'>Error: "+e.getMessage()+"</p>");
}

// pending feedback
int pendingFeedback = 0;
for(Appointment a : completed){
    if(!a.isFeedbackGiven()){
        pendingFeedback++;
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* =========================
   GLOBAL LUXURY THEME
========================= */
:root{
    --gold:#d4af37;
    --gold-light:#ffd700;
    --card:#0f1115;
    --card-2:#15181e;
    --border:#23262d;
    --text:#e6e6e6;
    --muted:#9aa0a6;
}

*{box-sizing:border-box;margin:0;padding:0;}

body{
    font-family:Times new roman,Segoe UI,Roboto;
    background:#07090c;
    color:var(--text);
}

/* layout */
.container-fluid{display:flex}

/* =====================================
   SIDEBAR
===================================== */
.sidebar{
    width:260px;
    height:100vh;
    position:fixed;
    top:0;
    left:0;
    background:linear-gradient(180deg,#0b0b0b,#111);
    border-right:1px solid #1a1a1a;
    padding-top:25px;
    display:flex;
    flex-direction:column;
}

.sidebar h2{
    text-align:center;
    color:#d4af37;
    margin-bottom:25px;
    font-weight:bold;
}

.sidebar a{
    padding:14px 22px;
    margin:6px 14px;
    border-radius:8px;
    text-decoration:none;
    color:#fff;
    font-size:17px;
    transition:0.3s ease;
    display:flex;
    align-items:center;
}

.sidebar a i{
    margin-right:12px;
}

.sidebar a:hover{
    background:rgba(212,175,55,0.15);
    color:#ffd700;
    transform:translateX(6px);
}

.sidebar a.active{
    background:rgba(212,175,55,0.2);
    border-right:4px solid #ffd700;
    color:#ffd700;
}

.sidebar a:last-child{
    margin-top:auto;
    margin-bottom:20px;
    background:#2a0000;
}

.sidebar a:last-child:hover{
    background:#5a0000;
}
/* =========================================
   SIDEBAR CONTAINER
========================================= */
.sidebar{
    width:260px;
    height:100vh;
    position:fixed;
    top:0;
    left:0;
    background:linear-gradient(180deg,#0b0b0b,#111);
    border-right:1px solid #1a1a1a;
    backdrop-filter:blur(6px);
    padding-top:10px;
    overflow:hidden;

    display:flex;
    flex-direction:column;
    justify-content:space-between;

    animation:sidebarSlide 0.8s ease;
}

/* Golden vertical glow line */
.sidebar::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:3px;
    height:100%;
    background:linear-gradient(to bottom,#d4af37,#ffd700,#d4af37);
    box-shadow:0 0 15px #d4af37;
}

/* =========================================
   TOP SECTION (LOGO + MENU)
========================================= */
.sidebar-top{
    display:flex;
    flex-direction:column;
}

/* Logo */
.logo{
    padding:26px 22px;
    display:flex;
    align-items:center;
    gap:10px;
}

.logo-img{
    width:30px;
    filter:drop-shadow(0 0 6px #c9a227);
    transition:0.4s;
}

.logo:hover .logo-img{
    transform:rotate(10deg) scale(1.1);
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

/* =========================================
   MENU LINKS
========================================= */
.sidebar a{
    position:relative;
    display:flex;
    align-items:center;
    padding:16px 26px;
    margin:6px 10px;
    border-radius:14px;
    font-size:17px;
    color:#ffffff;
    text-decoration:none;
    transition:all 0.4s ease;
    overflow:hidden;
}

/* Hover golden background animation */
.sidebar a::before{
    content:"";
    position:absolute;
    left:0;
    top:0;
    height:100%;
    width:0;
    background:linear-gradient(to right,#c9a227,#ffd700);
    opacity:0.15;
    transition:0.4s ease;
}

.sidebar a:hover::before{
    width:100%;
}

/* Icon */
.sidebar a i{
    margin-right:14px;
    color:#ffffff;
    transition:0.4s ease;
}

/* Hover Effect */
.sidebar a:hover{
    color:#ffd700;
    transform:translateX(8px);
}

.sidebar a:hover i{
    color:#ffd700;
    transform:scale(1.2);
}

/* =========================================
   ACTIVE MENU ITEM
========================================= */
.sidebar a.active{
    color:#ffd700;
    background:rgba(201,162,39,0.15);
    border-right:4px solid #ffd700;

    box-shadow:
        0 0 12px rgba(201,162,39,0.4),
        inset 0 0 10px rgba(201,162,39,0.3);

    animation:activePulse 2s infinite;
}

/* =========================================
   LOGOUT BUTTON (BOTTOM)
========================================= */
.logout{
    margin:20px 10px;
    padding:16px;
    border-radius:14px;
    font-size:17px;
    font-weight:bold;

    display:flex;
    align-items:center;
    justify-content:center;

    background:linear-gradient(145deg,#2a0000,#110000);
    border:1px solid rgba(255,80,80,0.4);
    color:#ffdddd;

    transition:all 0.4s ease;
    text-decoration:none;
}

.logout i{
    margin-right:12px;
    color:#ff6b6b;
    transition:0.4s;
}

.logout:hover{
    background:linear-gradient(145deg,#5a0000,#2a0000);
    color:#ffffff;
    transform:translateY(-4px);

    box-shadow:
        0 0 20px rgba(255,80,80,0.6),
        inset 0 0 10px rgba(255,100,100,0.3);
}

.logout:hover i{
    color:#ffffff;
    transform:rotate(-10deg) scale(1.2);
}

/* =========================================
   ANIMATIONS
========================================= */

/* Sidebar Slide */
@keyframes sidebarSlide{
    from{
        transform:translateX(-100%);
        opacity:0;
    }
    to{
        transform:translateX(0);
        opacity:1;
    }
}

/* Active Glow Pulse */
@keyframes activePulse{
    0%,100%{
        box-shadow:
        0 0 10px rgba(201,162,39,0.3),
        inset 0 0 8px rgba(201,162,39,0.2);
    }
    50%{
        box-shadow:
        0 0 20px rgba(255,215,0,0.6),
        inset 0 0 12px rgba(255,215,0,0.4);
    }
}


/* =========================
   MAIN AREA
========================= */
.main{
    margin-left:260px;
    padding:40px 50px;
    width:100%;
}

/* heading */
.main h2{
	color:#ffd700;
    font-size:34px;
    font-weight:600;
    margin-bottom:35px;
}
.main h2 span{color:var(--gold)}

/* =========================
   STATS CARDS
========================= */
.cards{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:22px;
    margin-bottom:40px;
}

.card-box{
    background:linear-gradient(145deg,var(--card),var(--card-2));
    border:1px solid var(--border);
    border-radius:18px;
    padding:24px;
    position:relative;
    transition:.3s;
}

.card-box:hover{
    transform:translateY(-6px);
    border-color:var(--gold);
    box-shadow:0 10px 25px rgba(0,0,0,.6);
}

.card-box i{
    width:42px;
    height:42px;
    display:flex;
    align-items:center;
    justify-content:center;
    border-radius:10px;
    background:#1a1e24;
    color:var(--gold);
    margin-bottom:12px;
}

.card-box p{
    color:var(--muted);
    font-size:14px;
}

.card-box b{
    font-size:28px;
    font-weight:600;
}

/* growth tag */
.card-box::after{
    content:"+8%";
    position:absolute;
    right:18px;
    top:18px;
    color:#27d17f;
    font-size:13px;
}

/* =========================
   CHART PANEL (STATIC)
========================= */
.main::after{
    content:"";
    display:block;
    height:260px;
    margin:40px 0;
    border-radius:18px;
    background:
    linear-gradient(180deg,rgba(255,215,0,.12),transparent),
    repeating-linear-gradient(
        to right,
        transparent 0 80px,
        rgba(255,255,255,.03) 80px 81px
    ),
    linear-gradient(#0f1115,#0f1115);
    border:1px solid var(--border);
}

/* ===============================
   GOLDEN TABLE CONTAINER
================================ */
.table-custom{
    background:linear-gradient(180deg,#0a0a0a,#121212);
    border-radius:16px;
    overflow:hidden;
    border:1px solid rgba(212,175,55,.35);
    box-shadow:
        inset 0 0 35px rgba(255,215,0,.05),
        0 8px 25px rgba(0,0,0,.8);
}

/* ===============================
   HEADER
================================ */
.table-custom thead th{
    background:#0b0b0b;
    color:#e6d395;
    font-family:"Times New Roman", serif;
    letter-spacing:.7px;
    font-weight:bold;
    border-bottom:1px solid rgba(212,175,55,.45);
}

/* golden divider line */
.table-custom thead{
    box-shadow:0 2px 12px rgba(212,175,55,.25);
}

/* ===============================
   BODY ROWS
================================ */
.table-custom td{
    color:#f3e7b5;
    border-top:1px solid rgba(212,175,55,.12);
    font-family:"Times New Roman", serif;
}

/* alternating luxury rows */
.table-custom tbody tr:nth-child(odd){
    background:rgba(255,215,0,.02);
}
.table-custom tbody tr:nth-child(even){
    background:rgba(255,255,255,.01);
}

/* hover glow */
.table-custom tbody tr{
    transition:.35s ease;
}
.table-custom tbody tr:hover{
    background:rgba(255,215,0,.08);
    box-shadow:
        inset 0 0 25px rgba(255,215,0,.15);
    transform:scale(1.01);
}

/* ===============================
   STATUS COLUMN HIGHLIGHT
================================ */
.table-custom td:last-child{
    color:#ffd700;
    font-weight:bold;
    text-shadow:0 0 8px rgba(255,215,0,.6);
}

/* ===============================
   EMPTY MESSAGE ROW
================================ */
.table-custom tbody tr td[colspan]{
    color:#cbbd83;
    font-style:italic;
}


/* =========================
   RESPONSIVE
========================= */
@media(max-width:1200px){
    .cards{grid-template-columns:repeat(2,1fr);}
}

@media(max-width:700px){
    .sidebar{width:200px}
    .main{margin-left:200px;padding:25px}
    .cards{grid-template-columns:1fr}
}


</style>
</head>

<body>

<div class="container-fluid">

 <!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2>User Dashboard</h2>

    <a href="user-dashboard.jsp" class="active"><i class="fa fa-chart-line"></i> Dashboard</a>
    <a href="search-salons.jsp"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
    <a href="myAppointments.jsp"><i class="fa fa-calendar"></i> My Appointments</a>
    <a href="user-feedback.jsp"><i class="fa fa-star"></i> Feedback</a>
    <a href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
    <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>
    <!-- MAIN CONTENT -->
    <div class="main">
        <h2>Welcome, <span style="color:#f5e6b0"><%=user.getName()%></span></h2>

        <!-- CARDS -->
        <div class="cards">
            <div class="card-box">
                <i class="fa fa-calendar"></i>
                <p>Upcoming</p>
                <b><%=upcoming.size()%></b>
            </div>
            <div class="card-box">
                <i class="fa fa-check"></i>
                <p>Completed</p>
                <b><%=completed.size()%></b>
            </div>
            <div class="card-box">
                <i class="fa fa-star"></i>
                <p>Pending Feedback</p>
                <b><%=pendingFeedback%></b>
            </div>
            <div class="card-box">
                <i class="fa fa-gem"></i>
                <p>Loyalty Points</p>
                <b><%=user.getLoyaltyPoints()%></b>
            </div>
        </div>

        <!-- UPCOMING TABLE -->
        <h4 class="mt-4 mb-3">Upcoming Appointments</h4>
        <table class="table table-custom table-striped">
            <thead>
                <tr>
                    <th>Salon</th>
                    <th>Service</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <% if(upcoming.isEmpty()){ %>
                <tr>
                    <td colspan="5" class="text-center">No upcoming appointments</td>
                </tr>
            <% } else {
                for(Appointment appt : upcoming){
                    Salon salon = salonDAO.getSalonById(appt.getSalonId());
            %>
                <tr>
                    <td><%= salon != null ? salon.getName() : "Salon" %></td>
                    <td><%= appt.getServiceName() %></td>
                    <td><%= appt.getAppointmentDate() %></td>
                    <td><%= appt.getAppointmentTime() %></td>
                    <td><%= appt.getStatus() %></td>
                </tr>
            <% }} %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>