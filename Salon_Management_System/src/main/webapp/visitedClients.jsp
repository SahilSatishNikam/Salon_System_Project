<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.VisitedClient" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
List<VisitedClient> clients = (List<VisitedClient>) request.getAttribute("visitedClients");
if (clients == null) clients = new ArrayList<>();

SimpleDateFormat df = new SimpleDateFormat("dd MMM yyyy");
SimpleDateFormat tf = new SimpleDateFormat("hh:mm a");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Visited Clients | SalonEase Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body{background:#000;color:#e6d8a8;font-family:'Times New Roman',serif;display:flex;}
.sidebar{width:260px;height:100vh;position:fixed;background:#0f0f0f;padding:20px;}
.sidebar a{display:block;color:#fff;padding:12px;margin:8px 0;text-decoration:none;border-radius:10px;}
.sidebar a:hover{background:#d4af37;color:#000;}
.sidebar a.active{background:#d4af37;color:#000;font-weight:bold;}

.main{margin-left:260px;padding:40px;width:100%;}
.header{font-size:28px;color:#ffd700;margin-bottom:25px;}

.table-container{
background:#111;
border:1px solid #d4af37;
border-radius:16px;
padding:25px;
}

.table thead th{
background:#000;
color:#ffd700;
border-bottom:1px solid #d4af37;
}

.badge-service{
background:#ffd700;
color:#000;
padding:6px 14px;
border-radius:20px;
font-size:12px;
font-weight:bold;
}
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
<h4 style="color:#ffd700;"><i class="fa fa-gem"></i> GoldenGlow</h4>

<a href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
<a href="manage-salons.jsp"><i class="fa fa-store"></i> Salons</a>
<a href="visitedClients" class="active"><i class="fa fa-users"></i> Clients</a>
<a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Therapists</a>
<a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
<a href="feedback.jsp"><i class="fa fa-comment"></i> Feedback</a>
<a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
<a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main">

<div class="header">
<i class="fa fa-users"></i> Visited Clients
</div>

<div class="table-container">

<table class="table table-hover">
<thead>
<tr>
<th>#</th>
<th>Client Name</th>
<th>Phone</th>
<th>Service</th>
<th>Amount</th>
<th>Date</th>
<th>Time</th>
<th>Therapist</th>
<th>Salon</th>
</tr>
</thead>

<tbody>

<% if (!clients.isEmpty()) {
    int i = 1;
    for (VisitedClient c : clients) { %>

<tr>
<td><%= i++ %></td>
<td><%= c.getClientName() %></td>
<td><%= c.getClientPhone() %></td>
<td><span class="badge-service"><%= c.getServiceName() %></span></td>
<td>₹<%= c.getAmount() %></td>
<td><%= c.getVisitDate()!=null ? df.format(c.getVisitDate()) : "" %></td>
<td><%= c.getVisitTime()!=null ? tf.format(c.getVisitTime()) : "" %></td>
<td><%= c.getTherapistName() %></td>
<td><%= c.getSalonName() %></td>
</tr>

<% } } else { %>

<tr>
<td colspan="9" class="text-center text-warning">
No visited clients found
</td>
</tr>

<% } %>

</tbody>
</table>

</div>
</div>

</body>
</html>
