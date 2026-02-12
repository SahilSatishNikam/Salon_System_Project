<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Therapist, model.TherapistAvailability, java.util.*" %>

<%
Therapist t = (Therapist) session.getAttribute("therapist");
if (t == null) {
    response.sendRedirect("login.jsp");
    return;
}

int todayCount = (Integer) request.getAttribute("todayCount");
int completedCount = (Integer) request.getAttribute("completedCount");
int pendingCount = (Integer) request.getAttribute("pendingCount");

List<TherapistAvailability> avails =
        (List<TherapistAvailability>) request.getAttribute("avails");
%>

<!DOCTYPE html>
<html>
<head>
<title>Therapist Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
body{background:#121212;font-family:Poppins;color:#E0E0E0;}
.sidebar{width:250px;background:#111;min-height:100vh;position:fixed;border-right:2px solid #F5A927;padding-top:10px;}
.sidebar h2{text-align:center;color:#F5A927;font-weight:700;border-bottom:1px solid #333;padding:20px 0;}
.sidebar a{display:flex;align-items:center;color:#fff;padding:14px 22px;text-decoration:none;border-bottom:1px solid #222;font-size:18px;}
.sidebar a i{margin-right:12px;}
.sidebar a:hover,.sidebar a.active{background:#F5A927;color:#000;padding-left:28px;}

.main-content{margin-left:250px;padding:30px;}

.topbar{
background:#1B1B1B;
border-bottom:2px solid #FFD700;
padding:15px 20px;
border-radius:0 0 10px 10px;
display:flex;
justify-content:space-between;
}

.card-box{
background:#1E1E1E;
border-radius:12px;
padding:20px;
text-align:center;
}

.card-box h5{color:#FFD700;}

.profile-card{
background:#1E1E1E;
border-radius:12px;
padding:20px;
text-align:center;
}

.profile-card img{
border-radius:50%;
border:2px solid #FFD700;
width:90px;
height:90px;
}

.session-card{
background:#2A2A2A;
border-radius:12px;
padding:12px 15px;
margin-bottom:10px;
display:flex;
justify-content:space-between;
align-items:center;
}

.gold-btn{
background:#FFD700;
color:#1B1B1B;
font-weight:bold;
border:none;
border-radius:8px;
}

.slot-btn{
background:#FFD700;
color:#1B1B1B;
border:none;
border-radius:8px;
margin:3px;
font-weight:bold;
}
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2>Therapist Panel</h2>

    <a href="TherapistDashboardServlet" class="active">
        <i class="fa fa-chart-line"></i> Dashboard
    </a>

    <a href="therapistAvailability.jsp">
        <i class="fa fa-clock"></i> Set Availability
    </a>

    <a href=""<%=request.getContextPath()%>/slots?therapistId=<%=t.getId()%>"">
        View Slots
    </a>

    <a href="therapist-services?salonId=<%=t.getSalonId()%>">
        <i class="fa fa-spa"></i> Services
    </a>

    <a href="TherapistAppointmentServlet">
        <i class="fa fa-calendar"></i> Appointments
    </a>

    <a href="editTherapistProfile.jsp">
        <i class="fa fa-user"></i> Profile
    </a>

    <a href="LogoutServlet">
        <i class="fa fa-sign-out-alt"></i> Logout
    </a>
</div>

<!-- MAIN -->
<div class="main-content">

<div class="topbar">
    <h4>THERAPIST DASHBOARD</h4>
    <div>Welcome, <b><%= t.getName() %></b></div>
</div>

<!-- SUMMARY -->
<div class="row g-3 mt-3">

<div class="col-md-4">
<div class="card-box">
<h5>Today's Appointments</h5>
<h2><%= todayCount %></h2>
</div>
</div>

<div class="col-md-4">
<div class="card-box">
<h5>Completed</h5>
<h2><%= completedCount %></h2>
</div>
</div>

<div class="col-md-4">
<div class="card-box">
<h5>Pending</h5>
<h2><%= pendingCount %></h2>
</div>
</div>

</div>

<!-- PROFILE + AVAILABILITY -->
<div class="row mt-4">

<div class="col-md-4">
<div class="profile-card">
<img src="https://via.placeholder.com/90">
<h5><%= t.getName() %></h5>
<p><%= t.getSpecialty() %></p>
<a href="editTherapistProfile.jsp" class="btn gold-btn w-100 mt-2">
Edit Profile
</a>
</div>
</div>

<div class="col-md-8">
<div class="card-box text-start">

<h5>Upcoming Availability</h5>

<div class="mt-3">

<%
if (avails == null || avails.isEmpty()) {
%>
<p>No upcoming availability found</p>
<%
} else {
for (TherapistAvailability a : avails) {
%>

<div class="session-card">
<div>
<strong><%= a.getAvailableDate() %></strong><br>
<%= a.getStartTime() %> — <%= a.getEndTime() %>
</div>

<span class="badge bg-warning text-dark">
<%= a.getSlotDuration() %> min
</span>
</div>

<%
}
}
%>

</div>

</div>
</div>

</div>
</div>

</body>
</html>
