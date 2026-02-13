<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Therapist, model.TherapistAvailability, java.util.*" %>

<%
Therapist t = (Therapist) session.getAttribute("therapist");
if (t == null) {
    response.sendRedirect("login.jsp");
    return;
}

Integer t1 = (Integer) request.getAttribute("todayCount");
Integer t2 = (Integer) request.getAttribute("completedCount");
Integer t3 = (Integer) request.getAttribute("pendingCount");

int todayCount = (t1 != null) ? t1 : 0;
int completedCount = (t2 != null) ? t2 : 0;
int pendingCount = (t3 != null) ? t3 : 0;

List<TherapistAvailability> avails =
(List<TherapistAvailability>) request.getAttribute("avails");
if (avails == null) avails = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
<title>Therapist Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
body{background:#000;color:#FFD700;font-family:Poppins}

/* SIDEBAR */
.sidebar{
width:240px;height:100vh;position:fixed;
background:#000;border-right:2px solid #FFD700;
padding-top:25px;
}
.sidebar h2{text-align:center;color:#FFD700;margin-bottom:25px;}
.sidebar a{
display:block;padding:14px 25px;color:#FFD700;text-decoration:none;
}
.sidebar a:hover,.sidebar a.active{
background:#FFD700;color:#000;
}

/* MAIN */
.main{margin-left:250px;padding:30px;}

/* CARD */
.card-box{
background:#111;border:1px solid #FFD70033;border-radius:16px;
padding:22px;box-shadow:0 0 20px rgba(255,215,0,.15);
}

/* GRAPH */
.graph{
height:70px;display:flex;align-items:flex-end;gap:4px;margin-top:10px;
}
.bar{
width:6px;background:#FFD700;border-radius:3px;
animation:grow .6s ease forwards;
transform:scaleY(0);transform-origin:bottom;
}
@keyframes grow{to{transform:scaleY(1);}}

/* MUSIC */
.music-card{
background:#111;border:1px solid #FFD700;
border-radius:20px;padding:30px;text-align:center;
}
.disc{
width:80px;height:80px;border-radius:50%;margin:auto;
background:radial-gradient(circle,#FFD700,#b89600);
}

/* DOWNLOAD */
.download-card{
height:230px;border-radius:20px;
background:url('https://images.unsplash.com/photo-1506126613408-eca07ce68773') center/cover;
position:relative;overflow:hidden;border:1px solid #FFD700;
}
.download-card .overlay{
position:absolute;bottom:0;padding:20px;width:100%;
background:linear-gradient(transparent,rgba(0,0,0,.9));
}
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
<h2>Therapist Panel</h2>

<a href="TherapistDashboardServlet" class="active">
<i class="fa fa-chart-line"></i> Dashboard</a>

<a href="therapistAvailability.jsp">
<i class="fa fa-clock"></i> Set Availability</a>

<a href="<%=request.getContextPath()%>/slots?therapistId=<%=t.getId()%>">
<i class="fa fa-calendar"></i> View Slots</a>

<a href="therapist-services?salonId=<%=t.getSalonId()%>">
<i class="fa fa-spa"></i> Services</a>

<a href="TherapistAppointmentServlet">
<i class="fa fa-calendar-check"></i> Appointments</a>

<a href="LogoutServlet">
<i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main">
<h4>Welcome, <%= t.getName() %></h4>

<div class="row g-4">

<!-- LEFT -->
<div class="col-lg-8">

<div class="row g-3">

<!-- TODAY -->
<div class="col-md-4">
<div class="card-box">
Today
<h2><%= todayCount %></h2>
<div class="graph">
<%
int bars = Math.min(todayCount==0?1:todayCount,20);
for(int i=1;i<=bars;i++){
int h=8+(i*3);
%>
<div class="bar" style="height:<%=h%>px"></div>
<% } %>
</div>
</div>
</div>

<!-- COMPLETED -->
<div class="col-md-4">
<div class="card-box">
Completed
<h2><%= completedCount %></h2>
<div class="graph">
<%
bars = Math.min(completedCount==0?1:completedCount,20);
for(int i=1;i<=bars;i++){
int h=8+(i*3);
%>
<div class="bar" style="height:<%=h%>px"></div>
<% } %>
</div>
</div>
</div>

<!-- PENDING -->
<div class="col-md-4">
<div class="card-box">
Pending
<h2><%= pendingCount %></h2>
<div class="graph">
<%
bars = Math.min(pendingCount==0?1:pendingCount,20);
for(int i=1;i<=bars;i++){
int h=8+(i*3);
%>
<div class="bar" style="height:<%=h%>px"></div>
<% } %>
</div>
</div>
</div>

</div>

<!-- TABLE -->
<div class="card-box mt-4">
<h5>Session Schedule</h5>

<table class="table table-dark table-bordered mt-3">
<tr>
<th>Date</th><th>Start</th><th>End</th>
</tr>

<% for(TherapistAvailability a: avails){ %>
<tr>
<td><%= a.getAvailableDate() %></td>
<td><%= a.getStartTime().toString().substring(0,5) %></td>
<td><%= a.getEndTime().toString().substring(0,5) %></td>
</tr>
<% } %>
</table>
</div>

</div>

<!-- RIGHT -->
<div class="col-lg-4">

<div class="music-card mb-4">
<div class="disc"></div>
<h5 class="mt-3">Inner Harmony Hues</h5>
<p style="opacity:.7;font-size:13px">
Take a mental voyage to inner sanctuaries
</p>
<button class="btn btn-warning btn-sm mt-2">
<i class="fa fa-play"></i>
</button>
</div>

<div class="download-card">
<div class="overlay">
Download your mental wellness report<br>
<button class="btn btn-warning btn-sm mt-2">
<i class="fa fa-download"></i> Download
</button>
</div>
</div>

</div>

</div>
</div>

</body>
</html>
