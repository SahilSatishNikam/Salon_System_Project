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

/* ===== SIDEBAR — SAME STYLE ===== */
.sidebar{
    width:250px;
    background:#000;
    min-height:100vh;
    position:fixed;
    border-right:2px solid #F5A927;
    padding-top:15px;
}
.sidebar h2{
    text-align:center;
    color:#F5A927;
    font-weight:600;
    border-bottom:1px solid #222;
    font-size:1.3rem;
    padding-bottom:10px;
      padding:20px 0px;
}
.sidebar-profile{
    text-align:center;
    margin:20px 0;
}
.sidebar-profile img{
    width:70px;
    height:70px;
    border-radius:50%;
    border:2px solid #F5A927;
    box-shadow:0 0 8px #F5A927;
}
.sidebar-profile h5{ color:#F5A927; margin-top:10px; }
.sidebar-profile p{ color:#fff; font-size:0.9rem; }

.sidebar a{
    display:flex;
    align-items:center;
    color:#fff;
    padding:14px 22px;
    text-decoration:none;
    border-bottom:1px solid #111;
    font-weight:500;
    font-size:18px;
    transition:.3s;
}
.sidebar a i{ margin-right:12px; }
.sidebar a:hover,
.sidebar a.active{
    background:#F5A927;
    color:#000;
    padding-left:28px;
    box-shadow:0 0 8px #F5A927;
}

/* ===== MAIN ===== */
.main{
    flex:1;
    margin-left:250px;
    padding:35px;
    background:radial-gradient(circle at top,#111,#000);
}

/* ===== TITLE ===== */
h2{
    color:#F5A927;
    text-align:center;
    margin-bottom:25px;
    text-shadow:0 0 6px #F5A927;
}

/* ===== TABLE ===== */
.table-custom{
    width:100%;
    background:#0f0f0f;
    border-radius:14px;
    overflow:hidden;
    border:1px solid #F5A927;
    box-shadow:0 0 18px rgba(245,169,39,.25);
}
.table-custom th{
    background:#000;
    color:#F5A927;
    padding:14px;
    border-bottom:2px solid #F5A927;
}
.table-custom td{
    padding:14px;
    color:#fff;
    border-bottom:1px solid #222;
}
.table-custom tr:hover{
    background:#161616;
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
</style>
</head>

<body>

<div class="container-fluid">

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2>User Panel</h2>

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
