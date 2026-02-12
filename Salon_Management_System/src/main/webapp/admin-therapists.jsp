<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Therapist, model.Salon" %>

<!DOCTYPE html>
<html>
<head>
<title>Manage Therapists</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>
body{
    background:#111;
    color:#FFD700;
    font-family:Poppins;
}

/* SIDEBAR BASE */
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

/* ================= YOUR CSS ================= */

/* TOP SECTION */
.sidebar-top{
    display:flex;
    flex-direction:column;
}



.s1{color:#ffffff;font-weight:bold;font-size:19px;}
.s2{color:#c9a227;font-size:19px;}

/* MENU LINKS */
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

/* Hover animation */
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

.sidebar a:hover::before{width:100%;}

.sidebar a i{
    margin-right:14px;
    color:#ffffff;
    transition:0.4s ease;
}

.sidebar a:hover{
    color:#ffd700;
    transform:translateX(8px);
}

.sidebar a:hover i{
    color:#ffd700;
    transform:scale(1.2);
}

/* ACTIVE */
.sidebar a.active{
    color:#ffd700;
    background:rgba(201,162,39,0.15);
    border-right:4px solid #ffd700;
    box-shadow:0 0 12px rgba(201,162,39,0.4), inset 0 0 10px rgba(201,162,39,0.3);
    animation:activePulse 2s infinite;
}

/* LOGOUT */


/* PULSE */
@keyframes activePulse{
    0%,100%{box-shadow:0 0 10px rgba(201,162,39,0.3), inset 0 0 8px rgba(201,162,39,0.2);}
    50%{box-shadow:0 0 20px rgba(255,215,0,0.6), inset 0 0 12px rgba(255,215,0,0.4);}
}

/* MAIN */
.main{
    margin-left:250px;
    padding:30px;
}

/* CARD */
.card{
    background:#000;
    border:1px solid #FFD700;
    color:#FFD700;
}

.table{background:#fff;color:#000;}
.table th{background:#FFD700;}

.btn-gold{
    background:#FFD700;
    color:#000;
    font-weight:600;
}
</style>
</head>

<body>

<!-- ================= SIDEBAR ================= -->
<div class="sidebar">
    <h2 style="font-size:30px;"><i class="fa fa-gem"></i> Golden Admin</h2>
    <a class="active" href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>


<!-- ================= MAIN ================= -->
<div class="main">

<h3 class="mb-4">
<i class="bi bi-people-fill"></i> Manage Therapists
</h3>

<!-- ADD FORM -->
<form action="AdminTherapistServlet" method="post" class="card p-4 mb-4">
<input type="hidden" name="action" value="add">

<div class="row g-3">
<div class="col-md-2"><input class="form-control" name="name" placeholder="Name" required></div>
<div class="col-md-2"><input class="form-control" name="phone" placeholder="Phone" required></div>
<div class="col-md-2"><input class="form-control" name="email" placeholder="Email" required></div>
<div class="col-md-2"><input class="form-control" name="specialty" placeholder="Specialty"></div>

<div class="col-md-2">
<select name="salonId" class="form-select" required>
<option value="">Assign Salon</option>
<%
List<Salon> salons=(List<Salon>)request.getAttribute("salons");
if(salons!=null){
for(Salon s:salons){
%>
<option value="<%=s.getId()%>"><%=s.getName()%></option>
<% }} %>
</select>
</div>

<div class="col-md-2">
<input type="password" class="form-control" name="password" placeholder="Password" required>
</div>
</div>

<button class="btn btn-gold mt-3">Add Therapist</button>
</form>

</div>
</body>
</html>
