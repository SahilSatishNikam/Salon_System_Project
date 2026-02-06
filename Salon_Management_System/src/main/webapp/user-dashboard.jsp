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
    pendingFeedback = appointmentDAO.getPendingFeedbackCount(userId);
}catch(Exception e){
    out.println("<p style='color:red'>Error: "+e.getMessage()+"</p>");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{margin:0;font-family:Arial;background:#f4f4f4;}
.container{display:flex}
.sidebar{width:220px;background:#333;color:#fff;height:100vh;padding:20px}
.sidebar a{color:#fff;text-decoration:none;display:block;margin:12px 0}
.main{flex:1;padding:20px}
.cards{display:flex;gap:20px;margin:20px 0}
.card{background:#fff;padding:20px;border-radius:10px;flex:1;text-align:center}
table{width:100%;background:#fff;border-collapse:collapse}
th,td{padding:10px;border-bottom:1px solid #ddd}
</style>
</head>

<body>

<div class="container">

<!-- SIDEBAR -->
<div class="sidebar">
<h3>SalonEase</h3>

<a href="dashboard.jsp">Dashboard</a>
<a href="search-salons.jsp">Search Salons</a>
<a href="myAppointments.jsp">My Appointments</a>
<a href="profile.jsp">Profile</a>
<a href="LogoutServlet">Logout</a>
</div>

<!-- MAIN -->
<div class="main">

<h2>Welcome <%=user.getName()%></h2>

<!-- CARDS -->
<div class="cards">

<div class="card">
<i class="fa fa-calendar"></i>
<p>Upcoming</p>
<b><%=upcoming.size()%></b>
</div>

<div class="card">
<i class="fa fa-check"></i>
<p>Completed</p>
<b><%=completed.size()%></b>
</div>

<div class="card">
<i class="fa fa-star"></i>
<p>Pending Feedback</p>
<b><%=pendingFeedback%></b>
</div>

<div class="card">
<i class="fa fa-gem"></i>
<p>Loyalty Points</p>
<b><%=user.getLoyaltyPoints()%></b>
</div>

</div>

<!-- UPCOMING TABLE -->
<h3>Upcoming Appointments</h3>

<table>
<tr>
<th>Salon</th>
<th>Service</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>
</tr>

<%
if(upcoming.isEmpty()){
%>
<tr>
<td colspan="5">No upcoming appointments</td>
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

</table>

</div>
</div>

</body>
</html>