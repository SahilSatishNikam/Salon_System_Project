<%@ page import="java.util.*, model.*" %>
<%@ page session="true" %>
<%
Therapist t = (Therapist) session.getAttribute("therapist");
if (t == null) {
    response.sendRedirect("login.jsp");
    return;
}

    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    if(appointments == null) appointments = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Therapist Appointments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
body{
    background:#0b0b0b;
    color:#fff;
    font-family:'Times New Roman',sans-serif;
}
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
/* =====================================
   MAIN CONTAINER
===================================== */
.main{
    margin-left:260px;
    padding:50px;
    min-height:100vh;
    background:linear-gradient(135deg,#0f0f0f,#1a1a1a);
    animation:fadeIn 0.6s ease;
}

/* =====================================
   TITLE
===================================== */
.title{
    font-size:28px;
    font-weight:bold;
    color:#d4af37;
    margin-bottom:30px;
    text-align:center;
    letter-spacing:1px;
}

/* =====================================
   TABLE DESIGN
===================================== */
.table{
    background:#111;
    color:#fff;
    border-radius:12px;
    overflow:hidden;
    box-shadow:0 10px 30px rgba(0,0,0,0.5);
}

/* Table Header */
.table thead{
    background:#1a1a1a;
}

.table thead th{
    color:#d4af37;
    font-weight:bold;
    border-bottom:1px solid #333;
    padding:15px;
    text-align:center;
}

/* Table Body */
.table tbody td{
    padding:14px;
    text-align:center;
    border-bottom:1px solid #222;
    transition:0.3s ease;
}

/* Row Hover Animation */
.table tbody tr{
    transition:0.3s ease;
}

.table tbody tr:hover{
    background:rgba(212,175,55,0.08);
    transform:scale(1.01);
}

/* =====================================
   STATUS BADGES
===================================== */
.badge{
    padding:6px 12px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
    letter-spacing:0.5px;
}

/* Booked */
.badge-booked{
    background:#444;
    color:#ffd700;
    border:1px solid #ffd700;
}

/* In Progress */
.badge-progress{
    background:#d4af37;
    color:#000;
}

/* Completed */
.badge-complete{
    background:#2e7d32;
    color:#fff;
}

/* =====================================
   BUTTONS
===================================== */
.btn-gold{
    background:#d4af37;
    color:#000;
    border:none;
    transition:0.3s ease;
}

.btn-gold:hover{
    background:#ffd700;
    box-shadow:0 5px 15px rgba(212,175,55,0.6);
    transform:translateY(-2px);
}

/* Outline Gold */
.btn-outline-gold{
    background:transparent;
    border:1px solid #d4af37;
    color:#d4af37;
    transition:0.3s ease;
}

.btn-outline-gold:hover{
    background:#d4af37;
    color:#000;
    box-shadow:0 5px 15px rgba(212,175,55,0.6);
    transform:translateY(-2px);
}

/* =====================================
   MUTED TEXT
===================================== */
.text-muted{
    color:#777 !important;
}

/* =====================================
   ANIMATION
===================================== */
@keyframes fadeIn{
    from{opacity:0;}
    to{opacity:1;}
}

/* =====================================
   RESPONSIVE
===================================== */
@media(max-width:768px){
    .main{
        margin-left:0;
        padding:30px;
    }

    .table{
        font-size:14px;
    }
}

</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
<h2>Therapist Panel</h2>

<a href="TherapistDashboardServlet" class="active">
<i class="fa fa-chart-line"></i> Dashboard
</a>

<a href="therapistAvailability.jsp">
<i class="fa fa-clock"></i> Set Availability
</a>

<!-- ✅ FIXED LINK -->
<a href="<%=request.getContextPath()%>/slots?therapistId=<%=t.getId()%>">
<i class="fa fa-calendar"></i> View Slots
</a>

<a href="therapist-services?salonId=<%=t.getSalonId()%>">
<i class="fa fa-spa"></i> Services
</a>

<a href="TherapistAppointmentServlet" class="active">
<i class="fa fa-calendar-check"></i> Appointments
</a>

<a href="LogoutServlet">
<i class="fa fa-sign-out-alt"></i> Logout
</a>
</div>


<!-- ===== MAIN ===== -->
<div class="main">

<div class="title">Manage Appointments</div>

<table class="table table-hover">
<thead>
<tr>
    <th>Service</th>
    <th>Customer</th>
    <th>Date</th>
    <th>Time</th>
    <th>Status</th>
    <th>Decision</th>
    <th>Action</th>
</tr>
</thead>

<tbody>
<% for(Appointment a : appointments) { %>
<tr>
    <td><%= a.getServiceName() %></td>
    <td><%= a.getCustomerName() %></td>
    <td><%= a.getAppointmentDate() %></td>
    <td><%= a.getAppointmentTime() %></td>

    <td>
        <% if("BOOKED".equalsIgnoreCase(a.getStatus())){ %>
            <span class="badge badge-booked">BOOKED</span>
        <% } else if("IN_PROGRESS".equalsIgnoreCase(a.getStatus())){ %>
            <span class="badge badge-progress">IN PROGRESS</span>
        <% } else { %>
            <span class="badge badge-complete">COMPLETED</span>
        <% } %>
    </td>

    <td><%= a.getTherapistDecision() %></td>

    <td>
    <form method="post" action="TherapistAppointmentServlet">
        <input type="hidden" name="id" value="<%= a.getId() %>">

        <% if("BOOKED".equalsIgnoreCase(a.getStatus())) { %>
            <button type="submit" name="action" value="start" class="btn btn-gold btn-sm">
                Start
            </button>
        <% } else if("IN_PROGRESS".equalsIgnoreCase(a.getStatus())) { %>
            <button type="submit" name="action" value="complete" class="btn btn-outline-gold btn-sm">
                Complete
            </button>
        <% } else { %>
            <span class="text-muted">No actions</span>
        <% } %>
    </form>
    </td>
</tr>
<% } %>
</tbody>
</table>

</div>
</body>
</html>
