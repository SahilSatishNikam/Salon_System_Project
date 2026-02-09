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
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>

<!-- Bootstrap & FontAwesome -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* =========================
   GLOBAL
========================= */
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background: #000;
    color: #d4af37;
}

/* =========================
   CONTAINER
========================= */
.container-fluid { display: flex; padding: 0; }

/* =========================
   SIDEBAR
========================= */
.sidebar {
    width: 260px;
    min-height: 100vh;
    background: linear-gradient(180deg, #0f0f0f, #1a1a1a);
    border-right: 2px solid #ffd700;
    padding: 25px 20px;
    display: flex;
    flex-direction: column;
    box-shadow: 2px 0 15px rgba(255,215,0,0.2);
}

.sidebar-profile {
    text-align: center;
    border-bottom: 1px solid #444;
    padding-bottom: 15px;
    margin-bottom: 20px;
}

.sidebar-profile img.profile-img {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    border: 2px solid #ffd700;
    transition: 0.3s;
}

.sidebar-profile img.profile-img:hover {
    transform: scale(1.1);
    box-shadow: 0 0 15px rgba(255,215,0,0.7);
}

.sidebar-profile h5 { color: #ffd700; margin: 10px 0 5px; }
.sidebar-profile p { font-size: 0.9rem; color: #fff; }

/* Sidebar Menu */
.sidebar-menu a {
    display: flex;
    align-items: center;
    padding: 12px 15px;
    margin: 6px 0;
    color: #fff;
    text-decoration: none;
    border-radius: 12px;
    font-weight: 500;
    transition: all 0.3s ease;
}

.sidebar-menu a i { margin-right: 12px; font-size: 18px; transition: all 0.3s ease; }

.sidebar-menu a:hover {
    background: #ffd700;
    color: #0f0f0f;
    transform: translateX(5px);
    box-shadow: 0 0 15px rgba(255,215,0,0.7);
}

.sidebar-menu a.active {
    background: #ffd700;
    color: #0f0f0f;
    box-shadow: 0 0 10px rgba(255,215,0,0.6);
}

/* =========================
   MAIN
========================= */
.main {
    flex: 1;
    padding: 25px;
}

/* =========================
   CARDS
========================= */
.cards {
    display: grid;
    grid-template-columns: repeat(auto-fit,minmax(200px,1fr));
    gap: 20px;
    margin: 20px 0;
}

.card-box {
    background:#0f0f0f;
    border:1px solid #d4af37;
    border-radius:15px;
    padding:20px;
    text-align:center;
    transition:0.4s;
}

.card-box:hover {
    transform:translateY(-6px);
    box-shadow:0 0 25px rgba(212,175,55,0.6);
}

.card-box i { font-size:28px; margin-bottom:10px; color:#ffd700; }
.card-box p { margin:5px 0; font-weight:500; }
.card-box b { font-size:22px; color:#ffd700; }

/* =========================
   TABLE
========================= */
.table-custom {
    background:#0f0f0f;
    border:1px solid #d4af37;
    color:#d4af37;
}

.table-custom th {
    background:#000;
    color:#ffd700;
    border-bottom:1px solid #d4af37;
}

.table-custom td {
    border-bottom:1px solid #333;
}

.table-custom tr:hover {
    background:rgba(212,175,55,0.1);
}
</style>
</head>
<body>

<div class="container-fluid">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="sidebar-profile">
            <img src="images/user.png" class="profile-img" alt="User">
            <h5><%= user.getName() %></h5>
            <p>Loyalty Points: <b><%= user.getLoyaltyPoints() %></b></p>
        </div>

        <div class="sidebar-menu">
            <a href="dashboard.jsp" class="active"><i class="fa fa-chart-line"></i> Dashboard</a>
            <a href="search-salons.jsp"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
            <a href="myAppointments.jsp"><i class="fa fa-calendar"></i> My Appointments</a>
            <a href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
            <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
        </div>
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

        <table class="table table-custom table-striped">
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
            }
        }
        %>
        </tbody>
        </table>
    </div>

</div>

</body>
</html>
