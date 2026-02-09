<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Therapist, dao.AppointmentDAO" %>

<%
Therapist t = (Therapist) session.getAttribute("therapist");
if(t == null){
    response.sendRedirect("login.jsp");
    return;
}

AppointmentDAO dao = new AppointmentDAO();
int todayCount = dao.getTodayAppointmentsByTherapist(t.getId());
int completedCount = dao.getCompletedAppointmentsByTherapist(t.getId());
int pendingCount = dao.getPendingAppointmentsByTherapist(t.getId());
%>

<!DOCTYPE html>
<html>
<head>
<title>Therapist Dashboard</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
/* ===== General Body ===== */
body {
    background: #121212;
    font-family: 'Poppins', sans-serif;
    color: #E0E0E0;
    overflow-x: hidden;
}

/* ===== Sidebar ===== */
.sidebar {
    height: 100vh;
    background: #1B1B1B;
    border-right: 2px solid #FFD700;
    padding-top: 30px;
    position: fixed;
    width: 220px;
    transition: all 0.3s ease;
}
.sidebar h3 {
    color: #FFD700;
    text-align: center;
    margin-bottom: 40px;
    font-weight: 800;
}
.sidebar a {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #E0E0E0;
    padding: 12px 20px;
    margin-bottom: 10px;
    border-radius: 8px;
    transition: all 0.3s ease;
    text-decoration:none;
}
.sidebar a:hover, .sidebar a.active {
    background: #FFD700;
    color: #1B1B1B;
    transform: translateX(5px);
    width:200px;
    
}
.sidebar a i {
    transition: 0.3s ease;
}

/* ===== Main Content ===== */
.main-content {
    margin-left: 220px;
    padding: 30px;
}

/* ===== Topbar ===== */
.topbar {
    background: #1B1B1B;
    border-bottom: 2px solid #FFD700;
    padding: 15px 20px;
    border-radius: 0 0 10px 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    animation: fadeIn 1s ease;
}
.topbar h4 {
    font-weight: 700;
}
.user-info {
    display: flex;
    align-items: center;
    gap: 10px;
}

/* ===== Cards ===== */
.card-box {
    background: #1E1E1E;
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    color: #E0E0E0;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.card-box:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(255,215,0,0.3);
}
.card-box h2 {
    font-size: 2.5rem;
    margin: 10px 0;
    animation: fadeInUp 1s ease;
}
.card-box h5 {
    color: #FFD700;
    font-weight: 600;
    margin-bottom: 5px;
}
.card-box p {
    font-size: 0.9rem;
    color: #ccc;
}

/* Profile Card */
.profile-card {
    background: #1E1E1E;
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    margin-bottom: 20px;
    transition: transform 0.3s ease;
}
.profile-card:hover {
    transform: scale(1.05);
}
.profile-card img {
    border-radius: 50%;
    border: 2px solid #FFD700;
    width: 90px;
    height: 90px;
    object-fit: cover;
    margin-bottom: 10px;
}
.verified {
    background: #FFD700;
    color: #1B1B1B;
    padding: 3px 8px;
    border-radius: 12px;
    font-size: 0.8rem;
    font-weight: bold;
}

/* Upcoming Sessions */
.session-card {
    background: #2A2A2A;
    border-radius: 12px;
    padding: 12px 15px;
    margin-bottom: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    transition: all 0.3s ease;
}
.session-card:hover {
    background: #333333;
    box-shadow: 0 5px 15px rgba(255,215,0,0.2);
}

/* Buttons */
.gold-btn {
    background: #FFD700;
    color: #1B1B1B;
    font-weight: bold;
    border-radius: 8px;
    border: none;
    transition: all 0.3s ease;
}
.gold-btn:hover {
    background: #FFC107;
    transform: scale(1.05);
}

/* Next Slots */
.slot-btn {
    background: #FFD700;
    color: #1B1B1B;
    border: none;
    border-radius: 8px;
    margin: 3px;
    font-weight: bold;
    transition: all 0.3s ease;
}
.slot-btn:hover {
    background: #FFC107;
    transform: scale(1.1);
}

/* Animations */
@keyframes fadeIn {
    from {opacity:0;}
    to {opacity:1;}
}
@keyframes fadeInUp {
    from {opacity:0; transform: translateY(20px);}
    to {opacity:1; transform: translateY(0);}
}

/* Scrollbar */
.main-content {
    max-height: 100vh;
    overflow-y: auto;
    padding-bottom: 20px;
}
</style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3><i class="fa-solid fa-hand-sparkles"></i> Therapist</h3>
    <a href="therapistDashboard.jsp" class="active"><i class="fa-solid fa-house"></i> Dashboard</a>
    <a href="therapistAvailability.jsp"><i class="fa-solid fa-clock"></i> Set Availability</a>
    <a href="TherapistAppointmentServlet"><i class="fa-solid fa-calendar-check"></i> Appointments</a>
    <a href="logoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">

    <!-- Topbar -->
    <div class="topbar">
        <h4>THERAPIST DASHBOARD</h4>
        <div class="user-info">
            <span>Welcome, <b><%= t.getName() %></b></span>
            <i class="fa-solid fa-bell"></i>
        </div>
    </div>

    <!-- Summary Cards -->
    <div class="row g-3 mt-3">
        <div class="col-md-4">
            <div class="card-box">
                <h5><i class="fa-solid fa-clock"></i> Today's Appointments</h5>
                <h2><%= todayCount %></h2>
                <p>Next session in 15 minutes</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-box">
                <h5><i class="fa-solid fa-check"></i> Completed</h5>
                <h2><%= completedCount %></h2>
                <p>66% of daily goal reached</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-box">
                <h5><i class="fa-solid fa-clipboard"></i> Pending Tasks</h5>
                <h2><%= pendingCount %></h2>
                <p>Patient intake forms remaining</p>
            </div>
        </div>
    </div>

    <div class="row mt-4">

        <!-- Profile -->
        <div class="col-md-4">
            <div class="profile-card">
                <img src="https://via.placeholder.com/90" alt="Therapist">
                <h5><%= t.getName() %></h5>
                <p><%= t.getSpecialty() %></p>
                <span class="verified">VERIFIED EXPERT</span>
                <a href="editTherapistProfile.jsp" class="btn gold-btn w-100 mt-2">Edit Profile</a>
            </div>
        </div>

        <!-- Upcoming Sessions -->
        <div class="col-md-8">
            <div class="card-box">
                <div class="d-flex justify-content-between align-items-center">
                    <h5><i class="fa-solid fa-calendar-days"></i> Upcoming Sessions</h5>
                    <button class="btn gold-btn btn-sm">New Appointment</button>
                </div>
                <div class="mt-3">
                    <div class="session-card">
                        <div>
                            <strong>Eleanor Rigby</strong><br>
                            <span class="time">10:30 AM - 11:30 AM</span>
                        </div>
                        <button class="btn gold-btn btn-sm"><i class="fa-solid fa-eye"></i> View</button>
                    </div>
                    <div class="session-card">
                        <div>
                            <strong>Desmond Jones</strong><br>
                            <span class="time">01:00 PM - 02:00 PM</span>
                        </div>
                        <button class="btn gold-btn btn-sm"><i class="fa-solid fa-eye"></i> View</button>
                    </div>
                </div>

                <!-- Next Available Slots -->
                <div class="mt-3">
                    <h6>Next Available Slots</h6>
                    <button class="slot-btn">Today 04:30 PM</button>
                    <button class="slot-btn">Tomorrow 09:00 AM</button>
                    <button class="slot-btn">Tomorrow 11:30 AM</button>
                    <button class="slot-btn"><i class="fa-solid fa-plus"></i> Edit</button>
                </div>
            </div>
        </div>

    </div>

</div>

</body>
</html>
