<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Appointment" %>

<%
List<Appointment> upcoming =
(List<Appointment>) request.getAttribute("upcomingAppointments");

List<Appointment> completed =
(List<Appointment>) request.getAttribute("completedAppointments");
%>

<html>
<head>
<title>User Appointments</title>

<style>
body{
    font-family: 'Segoe UI', Arial, sans-serif;
    background:#f4f6f9;
    margin:0;
    padding:0;
}

.container{
    width:90%;
    max-width:1100px;
    margin:30px auto;
}

h2{
    background:#6c63ff;
    color:white;
    padding:12px 20px;
    border-radius:8px 8px 0 0;
    margin-bottom:0;
}

.card{
    background:white;
    padding:20px;
    border-radius:0 0 10px 10px;
    box-shadow:0 4px 10px rgba(0,0,0,0.08);
    margin-bottom:30px;
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#6c63ff;
    color:white;
    padding:12px;
    text-align:left;
}

td{
    padding:12px;
    border-bottom:1px solid #eee;
}

tr:hover{
    background:#f9f9ff;
}

.status{
    font-weight:bold;
    padding:5px 10px;
    border-radius:20px;
    font-size:13px;
}

.status.confirmed{ background:#e6f7ee; color:#1a7f4b;}
.status.cancelled{ background:#ffeaea; color:#d11a2a;}
.status.completed{ background:#e8f0ff; color:#2a4dff;}

.btn{
    padding:7px 14px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-size:13px;
    transition:0.2s;
}

.cancel-btn{
    background:#ff4d4d;
    color:white;
}

.cancel-btn:hover{
    background:#e60000;
}

.reschedule-btn{
    background:#00b894;
    color:white;
}

.reschedule-btn:hover{
    background:#019875;
}

input[type="date"],
input[type="time"]{
    padding:6px;
    border:1px solid #ccc;
    border-radius:5px;
    margin-right:5px;
}

.empty{
    text-align:center;
    color:#888;
    padding:20px;
}

@media(max-width:768px){
    table, thead, tbody, th, td, tr{
        display:block;
    }
    th{
        display:none;
    }
    tr{
        margin-bottom:15px;
        background:white;
        padding:10px;
        border-radius:8px;
        box-shadow:0 2px 5px rgba(0,0,0,0.05);
    }
    td{
        border:none;
        padding:8px 0;
    }
}
</style>

</head>
<body>

<div class="container">

<!-- Upcoming -->
<h2>Upcoming Appointments</h2>
<div class="card">

<table>
<tr>
<th>Service</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>
<th>Action</th>
</tr>

<%
if(upcoming==null || upcoming.isEmpty()){
%>
<tr><td colspan="5" class="empty">No upcoming appointments</td></tr>
<%
}else{
for(Appointment a: upcoming){
String status = a.getStatus().toLowerCase();
%>

<tr>
<td><%=a.getServiceName()%></td>
<td><%=a.getAppointmentDate()%></td>
<td><%=a.getAppointmentTime()%></td>

<td>
<span class="status <%=status%>">
<%=a.getStatus()%>
</span>
</td>

<td>

<form method="post" action="controller/UserAppointmentServlet" style="display:inline;">
<input type="hidden" name="appointmentId" value="<%=a.getId()%>">
<input type="hidden" name="action" value="cancel">
<input type="submit" value="Cancel" class="btn cancel-btn">
</form>

<br><br>

<form method="post" action="../RescheduleAppointmentServlet">
<input type="hidden" name="appointmentId" value="<%=a.getId()%>">
<input type="date" name="date" required>
<input type="time" name="time" required>
<input type="submit" value="Reschedule" class="btn reschedule-btn">
</form>

</td>
</tr>

<% }} %>
</table>

</div>


<!-- Completed -->
<h2>Completed / Cancelled</h2>
<div class="card">

<table>
<tr>
<th>Service</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>
</tr>

<%
if(completed==null || completed.isEmpty()){
%>
<tr><td colspan="4" class="empty">No history</td></tr>
<%
}else{
for(Appointment a: completed){
String status = a.getStatus().toLowerCase();
%>

<tr>
<td><%=a.getServiceName()%></td>
<td><%=a.getAppointmentDate()%></td>
<td><%=a.getAppointmentTime()%></td>
<td>
<span class="status <%=status%>">
<%=a.getStatus()%>
</span>
</td>
</tr>

<% }} %>
</table>

</div>
</div>

</body>
</html>
