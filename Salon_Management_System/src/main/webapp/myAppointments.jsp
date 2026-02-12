<%@ page import="java.util.*, model.Appointment, model.User, dao.AppointmentDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    AppointmentDAO dao = new AppointmentDAO();
    List<Appointment> appointments = dao.getAppointmentsByUserId(user.getId());

    String success = (String) session.getAttribute("success");
    String error = (String) session.getAttribute("error");
    session.removeAttribute("success");
    session.removeAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Appointments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* ===== GLOBAL ===== */
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#000;
    color:#fff;
}
.container-fluid{ display:flex; padding:0; }

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
/* ===== MAIN ===== */
.main{
    flex:1;
    margin-left:250px;
    padding:35px;
    background:radial-gradient(circle at top,#111,#000);
}

/* ===== TITLE ===== */
h2 {
    color: #FFD700; /* golden text */
    text-align: center;
    margin-bottom: 25px;
    text-shadow: 0 0 6px #FFD700; /* subtle golden glow */
}


/* ===== TABLE ===== */
.table-custom{
    width:100%;
    background:linear-gradient(180deg,#1a1405,#0f0f0f);
    border-radius:14px;
    overflow:hidden;
    border:1px solid #ffd700;
    box-shadow:0 0 25px rgba(255,215,0,0.45);
}

.table-custom th{
    background:#000;
    color:#ffd700;
    padding:14px;
    border-bottom:2px solid #ffd700;
    text-shadow:0 0 6px rgba(255,215,0,0.6);
}

.table-custom td{
    padding:14px;
    color:#fff;
    border-bottom:1px solid rgba(255,215,0,0.25);
}

.table-custom tr:hover{
    background:rgba(255,215,0,0.08);
}

/* ===== MESSAGES ===== */
.msg{
    margin-bottom:15px;
    padding:12px;
    border-radius:10px;
    font-weight:600;
}
.ok{
    background:#102d1f;
    color:#4cffb0;
    border:1px solid #1f6b4a;
}
.err{
    background:#2d1010;
    color:#ff8080;
    border:1px solid #6b1f1f;
}

/* ===== BUTTONS ===== */
.btn-action{
    padding:6px 14px;
    border-radius:22px;
    font-weight:600;
    border:none;
    margin:2px;
}

.cancel{
    background:#5c0000;
    color:#fff;
}
.cancel:hover{
    background:#a00000;
}

.reschedule{
    background:linear-gradient(135deg,#F5A927,#FFD166);
    color:#000;
    box-shadow:0 0 6px #F5A927;
}
.reschedule:hover{
    filter:brightness(1.1);
}

/* ===== RESPONSIVE ===== */
@media(max-width:768px){
    .sidebar{ position:relative; width:100%; }
    .main{ margin-left:0; }
}

.dashboard-title {
    display: flex;
    align-items: center;
    font-size: 28px; /* heading size */
    color: #ffd700; /* golden text */
    font-weight: bold;
    font-family: "Times New Roman", Times, serif; /* serif font added */
}

.dashboard-icon {
    font-size: 34px; /* thoda motha icon */
    color: #ffd700; /* gold color */
    margin-right: 12px; /* text la thoda gap */
}
</style>
</head>

<body>

<div class="container-fluid">

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h1 class="dashboard-title">
    <i class="fa-solid fa-gem dashboard-icon"></i>
    User Dashboard
</h1>

    <a href="user-dashboard.jsp"><i class="fa fa-chart-line"></i> Dashboard</a>
    <a href="search-salons.jsp"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
    <a href="myAppointments.jsp" class="active"><i class="fa fa-calendar"></i> My Appointments</a>
    <a href="user-feedback.jsp"><i class="fa fa-star"></i> Feedback</a>
    <a href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
    <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- ===== MAIN ===== -->
<div class="main">

<h2><i class="fa fa-calendar-check"></i> My Appointments</h2>

<% if(success != null){ %>
<div class="msg ok"><%= success %></div>
<% } %>

<% if(error != null){ %>
<div class="msg err"><%= error %></div>
<% } %>

<table class="table-custom">
<tr>
    <th>Salon</th>
    <th>Service</th>
    <th>Date</th>
    <th>Time</th>
    <th>Status</th>
    <th>Actions</th>
</tr>

<%
if(appointments.isEmpty()){
%>
<tr>
<td colspan="6" class="text-center">No appointments booked yet.</td>
</tr>
<%
} else {
for(Appointment ap : appointments){
%>
<tr>
<td><%= ap.getSalonId() %></td>
<td><%= ap.getServiceName() %></td>
<td><%= ap.getAppointmentDate() %></td>
<td><%= ap.getAppointmentTime() %></td>
<td><%= ap.getStatus() %></td>
<td>
<% if(!"Cancelled".equals(ap.getStatus())) { %>

<form action="CancelAppointmentServlet" method="post" style="display:inline;">
<input type="hidden" name="id" value="<%= ap.getId() %>">
<button class="btn-action cancel">Cancel</button>
</form>

<form action="reschedule.jsp" method="get" style="display:inline;">
<input type="hidden" name="id" value="<%= ap.getId() %>">
<button class="btn-action reschedule">Reschedule</button>
</form>

<% } else { %> - <% } %>
</td>
</tr>
<%
}}
%>
</table>

</div>
</div>

</body>
</html>
