<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Appointment, dao.AppointmentDAO, model.Salon, dao.SalonDAO, model.User" %>

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

    try {
        upcoming = appointmentDAO.getUpcomingAppointments(userId);
        completed = appointmentDAO.getCompletedAppointments(userId);
        pendingFeedback = appointmentDAO.getPendingFeedbackCount(userId);
    } catch(Exception e){
        out.println("<p style='color:red;'>Error fetching appointments: "+ e.getMessage() +"</p>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard | SalonEase</title>

    <!-- CSS -->
    <link rel="stylesheet" href="css/user-dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body { font-family: Arial, sans-serif; margin:0; padding:0; background:#f4f4f4; }
        .container { display:flex; }
        .sidebar { width:220px; background:#333; color:#fff; height:100vh; padding:20px; }
        .sidebar h2.logo { text-align:center; margin-bottom:30px; }
        .sidebar ul { list-style:none; padding:0; }
        .sidebar ul li { margin:15px 0; }
        .sidebar ul li a { color:#fff; text-decoration:none; display:flex; align-items:center; }
        .sidebar ul li a i { margin-right:10px; }
        .sidebar ul li.active { font-weight:bold; }
        .main { flex:1; padding:20px; }
        .gold { color:gold; }
        .cards { display:flex; gap:20px; margin-top:20px; margin-bottom:30px; }
        .card { background:#fff; padding:20px; flex:1; border-radius:10px; box-shadow:0 2px 5px rgba(0,0,0,0.2); text-align:center; }
        .card i { font-size:24px; margin-bottom:10px; color:#333; display:block; }
        table { width:100%; border-collapse:collapse; background:#fff; border-radius:5px; overflow:hidden; box-shadow:0 2px 5px rgba(0,0,0,0.1); }
        th, td { padding:12px; border-bottom:1px solid #ddd; text-align:left; }
        th { background:#f2f2f2; }
        tr:last-child td { border-bottom:none; }
        .msg.ok { color:green; margin:10px 0; }
    </style>
</head>
<body>

<div class="container">

    <!-- Sidebar -->
    <div class="sidebar">
        <h2 class="logo">SalonEase</h2>
        <ul>
            <li class="active"><i class="fa-solid fa-house"></i> Dashboard</li>
            <li><a href="search-salons.jsp"><i class="fa-solid fa-store"></i> Salons</a></li>
            <li><a href="manage-salons.jsp"><i class="fa-solid fa-store"></i> Add salons</a></li>
            <li><a href="myAppointments.jsp"><i class="fa-solid fa-book"></i> My Appointments</a></li>
            <li><a href="profile.jsp"><i class="fa-solid fa-user"></i> Profile</a></li>
            <li><a href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main">

        <!-- Welcome -->
        <h1>Welcome, <span class="gold"><%= user.getName() %></span></h1>
        <p class="tagline">Your luxury beauty experience starts here</p>

        <!-- Success messages -->
        <% if("1".equals(request.getParameter("booked"))) { %>
            <div class="msg ok">Appointment booked successfully!</div>
        <% } %>
        <% if("1".equals(request.getParameter("completed"))) { %>
            <div class="msg ok">Appointment completed! Loyalty points added.</div>
        <% } %>

        <!-- Cards -->
        <div class="cards">
            <div class="card">
                <i class="fa-solid fa-calendar"></i>
                <p>Upcoming</p>
                <b><%= upcoming != null ? upcoming.size() : 0 %></b>
            </div>

            <div class="card">
                <i class="fa-solid fa-check"></i>
                <p>Completed</p>
                <b><%= completed != null ? completed.size() : 0 %></b>
            </div>

            <div class="card">
                <i class="fa-solid fa-star"></i>
                <p>Pending Feedback</p>
                <b><%= pendingFeedback %></b>
            </div>

            <div class="card">
                <i class="fa-solid fa-gem"></i>
                <p>Loyalty Points</p>
                <b><%= user.getLoyaltyPoints() %></b>
            </div>
        </div>

        <!-- Upcoming Appointments Table -->
        <h2>Upcoming Appointments</h2>
        <table>
            <tr>
                <th>Salon</th>
                <th>Service</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
            </tr>
            <% if(upcoming == null || upcoming.isEmpty()) { %>
                <tr><td colspan="5">No upcoming appointments. Book your next glow-up now!</td></tr>
            <% } else {
                for(Appointment appt : upcoming){
                    Salon salon = null;
                    try { salon = salonDAO.getSalonById(appt.getSalonId()); } catch(Exception e){}
            %>
                <tr>
                    <td><%= salon != null ? salon.getName() : "Salon" %></td>
                    <td><%= appt.getServiceName() != null ? appt.getServiceName() : "Service" %></td>
                    <td><%= appt.getAppointmentDate() != null ? appt.getAppointmentDate() : "-" %></td>
                    <td><%= appt.getAppointmentTime() != null ? appt.getAppointmentTime() : "-" %></td>
                    <td><%= appt.getStatus() != null ? appt.getStatus() : "-" %></td>
                </tr>
            <% }} %>
        </table>

    </div>
</div>

</body>
</html>



