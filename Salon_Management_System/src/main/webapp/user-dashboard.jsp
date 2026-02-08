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
int pendingFeedback = 0;

try{
    upcoming = appointmentDAO.getUpcomingAppointments(userId);
    completed = appointmentDAO.getCompletedAppointments(userId);
   
}catch(Exception e){
    out.println("<p style='color:red'>Error: "+e.getMessage()+"</p>");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#000;
    color:#d4af37;
}

/* layout */
.container-fluid{display:flex;padding:0}

/* sidebar */
.sidebar{
    width:230px;
    background:#0f0f0f;
    min-height:100vh;
    padding:20px;
    border-right:1px solid #d4af37;
}

.sidebar h3{
    color:#ffd700;
    text-align:center;
    margin-bottom:25px;
}

.sidebar a{
    color:#d4af37;
    text-decoration:none;
    display:block;
    padding:10px 15px;
    margin:8px 0;
    border-radius:8px;
    transition:0.3s;
}

.sidebar a:hover{
    background:#d4af37;
    color:#000;
}

/* main */
.main{
    flex:1;
    padding:25px;
}

/* cards */
.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
    gap:20px;
    margin:20px 0;
}

.card-box{
    background:#0f0f0f;
    border:1px solid #d4af37;
    border-radius:15px;
    padding:20px;
    text-align:center;
    transition:0.4s;
}

.card-box:hover{
    transform:translateY(-6px);
    box-shadow:0 0 25px rgba(212,175,55,0.6);
}

.card-box i{
    font-size:28px;
    margin-bottom:10px;
    color:#ffd700;
}

.card-box p{
    margin:5px 0;
}

.card-box b{
    font-size:22px;
    color:#ffd700;
}

/* table */
.table-custom{
    background:#0f0f0f;
    border:1px solid #d4af37;
    color:#d4af37;
}

.table-custom th{
    background:#000;
    color:#ffd700;
    border-bottom:1px solid #d4af37;
}

.table-custom td{
    border-bottom:1px solid #333;
}

.table-custom tr:hover{
    background:rgba(212,175,55,0.1);
}
</style>
</head>

<body>

<div class="container-fluid">

<!-- SIDEBAR -->
<div class="sidebar">
    <h3>SalonEase</h3>

    <a href="dashboard.jsp"><i class="fa fa-chart-line me-2"></i>Dashboard</a>
    <a href="search-salons.jsp"><i class="fa fa-search me-2"></i>Search Salons</a>
    <a href="myAppointments.jsp"><i class="fa fa-calendar me-2"></i>My Appointments</a>
    <a href="profile.jsp"><i class="fa fa-user me-2"></i>Profile</a>
    <a href="LogoutServlet"><i class="fa fa-sign-out-alt me-2"></i>Logout</a>
</div>

<!-- MAIN -->
<div class="main">

<h2 class="mb-3">Welcome, <span style="color:#ffd700"><%=user.getName()%></span></h2>

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

<table class="table table-custom">
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

<%
if(upcoming.isEmpty()){
%>
<tr>
<td colspan="5" class="text-center">No upcoming appointments</td>
</tr>
<%
}else{
for(Appointment appt: upcoming){
Salon salon = salonDAO.getSalonById(appt.getSalonId());
%>
<tr>
<td><%=salon!=null ? salon.getName() : "Salon"%></td>
<td><%=appt.getServiceName()%></td>
<td><%=appt.getAppointmentDate()%></td>
<td><%=appt.getAppointmentTime()%></td>
<td><%=appt.getStatus()%></td>
</tr>
<%
}}
%>

</tbody>
</table>

</div>
</div>

</body>
</html>
