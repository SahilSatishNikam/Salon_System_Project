<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Therapist, dao.AppointmentDAO" %>

<%
Therapist t = (Therapist) session.getAttribute("therapist");
if(t == null){
    response.sendRedirect("login.jsp");
    return;
}

/* ===== Dashboard Counts ===== */
AppointmentDAO dao = new AppointmentDAO();

int todayCount = dao.getTodayAppointmentsByTherapist(t.getId());
int completedCount = dao.getCompletedAppointmentsByTherapist(t.getId());
int pendingCount = dao.getPendingAppointmentsByTherapist(t.getId());
%>

<!DOCTYPE html>
<html>
<head>
<title>Therapist Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#0b0b0b;
    font-family:'Segoe UI',sans-serif;
    color:white;
}

.sidebar{
    height:100vh;
    background:black;
    border-right:3px solid gold;
    padding-top:30px;
}

.sidebar h3{
    color:gold;
    text-align:center;
    margin-bottom:30px;
    font-weight:bold;
}

.sidebar a{
    display:block;
    color:white;
    padding:15px;
    text-decoration:none;
    transition:0.3s;
}

.sidebar a:hover{
    background:gold;
    color:black;
    padding-left:25px;
}

.topbar{
    background:black;
    border-bottom:3px solid gold;
    padding:15px;
}

.card-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:25px;
    box-shadow:0 0 20px rgba(255,215,0,0.2);
    transition:0.3s;
}

.card-box:hover{
    transform:translateY(-5px);
    box-shadow:0 0 30px rgba(255,215,0,0.5);
}

.gold-btn{
    background:gold;
    color:black;
    font-weight:bold;
    border:none;
}

.gold-btn:hover{
    background:#e6c200;
}
</style>
</head>

<body>

<div class="container-fluid">
<div class="row">

<!-- SIDEBAR -->
<div class="col-md-2 sidebar">
    <h3>Therapist</h3>

    <a href="therapistDashboard.jsp">🏠 Dashboard</a>
    <a href="therapistAvailability.jsp">🕒 Set Availability</a>
    <a href="TherapistAppointmentServlet">📅 Appointments</a>
    <a href="logoutServlet">🚪 Logout</a>
</div>

<!-- MAIN -->
<div class="col-md-10">

    <!-- TOPBAR -->
    <div class="topbar d-flex justify-content-between align-items-center">
        <h4 style="color:gold;">Therapist Dashboard</h4>
        <div>
            Welcome,
            <span style="color:gold; font-weight:bold;">
                <%= t.getName() %>
            </span>
        </div>
    </div>

    <div class="container mt-5">

        <!-- CARDS -->
        <div class="row g-4">

            <!-- PROFILE -->
            <div class="col-md-4">
                <div class="card-box text-center">
                    <h5 style="color:gold;">👤 Profile</h5>
                    <hr>
                    <p><b>Name:</b> <%= t.getName() %></p>
                    <p><b>Specialty:</b> <%= t.getSpecialty() %></p>

                    <a href="editTherapistProfile.jsp" class="btn gold-btn w-100">
                        Edit Profile
                    </a>
                </div>
            </div>

            <!-- AVAILABILITY -->
            <div class="col-md-4">
                <div class="card-box text-center">
                    <h5 style="color:gold;">🕒 Availability</h5>
                    <hr>
                    <p>Manage your available slots</p>

                    <a href="therapistAvailability.jsp" class="btn gold-btn w-100">
                        Set Availability
                    </a>
                </div>
            </div>

            <!-- APPOINTMENTS -->
            <div class="col-md-4">
                <div class="card-box text-center">
                    <h5 style="color:gold;">📅 Appointments</h5>
                    <hr>
                    <p>View and manage bookings</p>

                    <a href="TherapistAppointmentServlet" class="btn gold-btn w-100">
                        View Appointments
                    </a>
                </div>
            </div>

        </div>

        <!-- SUMMARY -->
        <div class="row mt-5">
            <div class="col-md-12">
                <div class="card-box">
                    <h4 style="color:gold;">Today's Summary</h4>
                    <hr>

                    <div class="row text-center">
                        <div class="col-md-4">
                            <h2 style="color:gold;"><%= todayCount %></h2>
                            <p>Today's Appointments</p>
                        </div>

                        <div class="col-md-4">
                            <h2 style="color:gold;"><%= completedCount %></h2>
                            <p>Completed</p>
                        </div>

                        <div class="col-md-4">
                            <h2 style="color:gold;"><%= pendingCount %></h2>
                            <p>Pending</p>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

</div>
</div>

</body>
</html>
