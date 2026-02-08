<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Appointment" %>

<%
List<Appointment> upcoming =
(List<Appointment>) request.getAttribute("upcomingAppointments");

List<Appointment> completed =
(List<Appointment>) request.getAttribute("completedAppointments");
%>

<!DOCTYPE html>
<html>
<head>
<title>User Appointments</title>

<!-- ICON CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{
    font-family:'Segoe UI', Arial, sans-serif;
    background:#111;
    margin:0;
    padding:0;
    color:#f5f5f5;
}

.container{
    width:90%;
    max-width:1100px;
    margin:30px auto;
}

/* CENTER HEADING WITH ICON */
.section-title{
    background:#000;
    color:#d4af37;
    padding:14px 20px;
    border-radius:8px 8px 0 0;
    margin-bottom:0;
    border-bottom:2px solid #d4af37;
    display:flex;
    justify-content:center;
    align-items:center;
    gap:10px;
    font-size:22px;
    letter-spacing:0.5px;
}

.card{
    background:#1a1a1a;
    padding:20px;
    border-radius:0 0 10px 10px;
    box-shadow:0 4px 12px rgba(212,175,55,0.15);
    margin-bottom:30px;
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#000;
    color:#d4af37;
    padding:12px;
    text-align:left;
    border-bottom:1px solid #333;
}

td{
    padding:12px;
    border-bottom:1px solid #333;
    color:#eee;
}

tr:hover{
    background:#222;
}

.status{
    font-weight:bold;
    padding:5px 12px;
    border-radius:20px;
    font-size:13px;
}

.status.confirmed{
    background:rgba(212,175,55,0.15);
    color:#d4af37;
}

.status.cancelled{
    background:#2a0000;
    color:#ff6b6b;
}

.status.completed{
    background:#1c1c1c;
    color:#d4af37;
}

.btn{
    padding:7px 14px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-size:13px;
    transition:0.2s;
}

.cancel-btn{
    background:#8b0000;
    color:#fff;
}

.cancel-btn:hover{
    background:#b30000;
}

.reschedule-btn{
    background:#d4af37;
    color:#000;
    font-weight:600;
}

.reschedule-btn:hover{
    background:#c9a227;
}

input[type="date"],
input[type="time"]{
    padding:6px;
    border:1px solid #444;
    border-radius:5px;
    background:#000;
    color:#d4af37;
    margin-right:5px;
}

.empty{
    text-align:center;
    color:#aaa;
    padding:20px;
}

@media(max-width:768px){
    table, thead, tbody, th, td, tr{
        display:block;
    }
    th{ display:none; }
    tr{
        margin-bottom:15px;
        background:#1a1a1a;
        padding:10px;
        border-radius:8px;
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

<!-- UPCOMING -->
<div class="section-title">
    <i class="fa-solid fa-calendar-check"></i>
    Upcoming Appointments
</div>

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
<tr>
<td colspan="5" class="empty">No upcoming appointments</td>
</tr>
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
<span class="status <%=status%>"><%=a.getStatus()%></span>
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

<% } } %>
</table>
</div>

<!-- COMPLETED -->
<div class="section-title">
    <i class="fa-solid fa-clock-rotate-left"></i>
    Completed / Cancelled
</div>

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
<tr>
<td colspan="4" class="empty">No history</td>
</tr>
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
<span class="status <%=status%>"><%=a.getStatus()%></span>
</td>
</tr>

<% } } %>
</table>
</div>

</div>
</body>
</html>
