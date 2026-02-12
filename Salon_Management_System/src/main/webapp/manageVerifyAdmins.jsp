<%@ page import="java.util.*, dao.*, model.*" %>

<%
AdminDAO adminDAO = new AdminDAO();
List<Admin> admins = adminDAO.getAllAdmins();
String msg = (String) session.getAttribute("msg");
session.removeAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage & Verify Admins</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
body{
    margin:0;
    font-family: 'Segoe UI', sans-serif;
    background:#000;
    color:#FFD700;
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

/* MAIN CONTENT */
.main{
    margin-left:250px;
    padding:40px;
    min-height:100vh;
}

/* CARD */
.card{
    background:#111;
    border:2px solid #FFD700;
    border-radius:15px;
    box-shadow:0 8px 25px rgba(255,215,0,0.2);
    padding:25px;
}

/* HEADER */
.card h3{
    color:#FFD700;
    font-weight:bold;
    margin-bottom:25px;
}

/* ALERT */
.alert-success{
    background:#333;
    color:#FFD700;
    border:1px solid #FFD700;
}

/* TABLE */
.table th{
    background:#111;
    color:#FFD700;
    font-weight:600;
}
.table td{
    vertical-align:middle;
    color:#FFD700;
}
.table tr:hover{
    background:rgba(255,215,0,0.1);
}

.table{
       --bs-table-bg: #111;
}

/* STATUS BADGE BIG */
.status-approved{
    display:inline-block;
    font-size:15px;
    font-weight:700;
    padding:8px 18px;
    border-radius:20px;
    min-width:110px;
    text-align:center;
}

/* custom colors */
.status-ok{
    background:#1faa59;
    color:#fff;
}

.status-reject{
    background:#ff4500;
    color:#fff;
}

.status-pending{
    background:#FFA500;
    color:#000;
}


/* BADGES */
.badge{
    font-weight:bold;
    border-radius:12px;
    padding:5px 10px;
}
.bg-success{
    background:#FFD700;
    color:#000;
}
.bg-danger{
    background:#FF4500;
    color:#fff;
}
.bg-warning{
    background:#FFA500;
    color:#000;
}

/* ICON BUTTONS */
.btn-success, .btn-danger, .btn-secondary{
    width:30px;
    height:30px;
    padding:0;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    border-radius:50%;
    font-size:16px;
    transition:0.3s;
}
.btn-success{
    background:#222;
    color:#FFD700;
    border:1px solid #FFD700;
}
.btn-success:hover{
    background:#e6c200;
    transform:scale(1.1);
}
.btn-danger{
    background:#222;
    color:#FFD700;
    border:1px solid #FFD700;
}
.btn-danger:hover{
    background:#e03f00;
    transform:scale(1.1);
}
.btn-secondary{
    background:#222;
    color:#FFD700;
    border:1px solid #FFD700;
}
.btn-secondary:hover{
    background:#FFD700;
    color:#000;
    transform:scale(1.1);
}

/* ACTION BUTTON ROW */
.action-cell{
    display:flex;
    gap:12px;
    align-items:center;
    justify-content:flex-start;
}

/* BIG ROUND BUTTONS */
.action-cell .btn{
    width:30px;
    height:30px;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:18px;
    padding:0;
}

</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2 style="font-size:25px;color:#F5A927"><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a class="active" href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>


<!-- MAIN -->
<div class="main">

<div class="card">
<h3><i class="fa-solid fa-user-shield"></i> Manage & Verify Admins</h3>

<% if(msg != null){ %>
<div class="alert alert-success"><%= msg %></div>
<% } %>

<table class="table table-bordered table-hover">
<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>Status</th>
<th width="130">Action</th>
</tr>

<% for(Admin a: admins){ %>
<tr>
<td><%= a.getId() %></td>
<td><%= a.getName() %></td>
<td><%= a.getEmail() %></td>
<td><%= a.getPhone() %></td>

<td>
<% if("Approved".equals(a.getStatus())){ %>
<span class="status-approved status-ok">Approved</span>

<% } else if("Rejected".equals(a.getStatus())){ %>
<span class="status-approved status-reject">Rejected</span>

<% } else { %>
<span class="status-approved status-pending">Pending</span>
<% } %>
</td>


<td class="action-cell">

<a class="btn btn-success"
href="AdminServlet?id=<%=a.getId()%>&st=Approved"
onclick="return confirm('Approve this admin?')">
<i class="fa-solid fa-check"></i>
</a>

<a class="btn btn-danger"
href="AdminServlet?id=<%=a.getId()%>&st=Rejected"
onclick="return confirm('Reject this admin?')">
<i class="fa-solid fa-xmark"></i>
</a>

<a class="btn btn-secondary"
href="AdminServlet?action=delete&id=<%=a.getId()%>"
onclick="return confirm('Delete this admin?')">
<i class="fa-solid fa-trash"></i>
</a>

</td>

</tr>
<% } %>

</table>
</div>

</div>
</body>
</html>
