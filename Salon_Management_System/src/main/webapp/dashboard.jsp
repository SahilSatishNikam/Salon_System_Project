<%@ page import="java.util.*, model.*, dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // Initialize DAOs
    SalonDAO salonDAO = new SalonDAO();
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    UserDAO userDAO = new UserDAO();
    FeedbackDAO feedbackDAO = new FeedbackDAO();
    AdminDAO adminDAO = new AdminDAO();

    // Metrics
    int totalSalons = 0, totalAppointments = 0, totalUsers = 0, totalFeedback = 0;
    int pendingSalons = 0, approvedSalons = 0, rejectedSalons = 0;
    int pendingAdmins = 0, approvedAdmins = 0, rejectedAdmins = 0;

    List<Admin> allAdmins = new ArrayList<>();

    try {
        totalSalons = salonDAO.getTotalSalons();
        totalAppointments = appointmentDAO.getTotalAppointments();
        totalUsers = userDAO.getTotalUsers();
        totalFeedback = feedbackDAO.getTotalFeedback();

        List<Salon> allSalons = salonDAO.getAllSalons();
        pendingSalons = (int) allSalons.stream().filter(s -> "Pending".equals(s.getStatus())).count();
        approvedSalons = (int) allSalons.stream().filter(s -> "Approved".equals(s.getStatus())).count();
        rejectedSalons = (int) allSalons.stream().filter(s -> "Rejected".equals(s.getStatus())).count();

        allAdmins = adminDAO.getAllAdmins();
        pendingAdmins = (int) allAdmins.stream().filter(a -> "Pending".equals(a.getStatus())).count();
        approvedAdmins = (int) allAdmins.stream().filter(a -> "Approved".equals(a.getStatus())).count();
        rejectedAdmins = (int) allAdmins.stream().filter(a -> "Rejected".equals(a.getStatus())).count();

    } catch(Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | SalonEase</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        /* ===== BODY & SIDEBAR ===== */
        body { margin:0; font-family:Poppins,sans-serif; background:linear-gradient(135deg,#000,#1a1a1a); color:#fff; display:flex; }
.sidebar { width:250px; background:#000; min-height:100vh; position:fixed; border-right:2px solid #FFD700; padding-top:10px; }
        .sidebar h2 { text-align:center; color:#FFD700; font-weight:600; border-bottom:1px solid #222; font-size:1.3rem; }
        .sidebar a { display:flex; align-items:center; color:#fff; padding:14px 22px; text-decoration:none; border-bottom:1px solid #111; font-weight:500; font-size:19px; }
        .sidebar a i { margin-right:12px; font-size:1.1rem; }
        .sidebar a:hover { background:#FFD700; color:#000; padding-left:28px; }
        .sidebar a.active { background:#FFD700; color:#000; }

        /* ===== MAIN CONTENT ===== */
        .main { margin-left:250px; padding:28px; width:calc(100% - 250px); }
        .header { background:linear-gradient(90deg,#FFD700,#ffbf00); color:#000; padding:24px; border-radius:14px; font-size:26px; font-weight:700; text-align:center; box-shadow:0 10px 26px rgba(255,215,0,.25); }
        .welcome { margin-top:22px; background:#111; border:2px solid #FFD700; border-radius:14px; padding:20px; display:flex; justify-content:space-between; align-items:center; }
        .quick a { background:#FFD700; color:#000; padding:10px 14px; margin:5px; border-radius:8px; text-decoration:none; font-weight:600; display:inline-block; }

        /* ===== CARDS ===== */
        .cards { display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:20px; margin:25px 0; }
        .card { background:#111; border:2px solid #FFD700; border-radius:14px; padding:22px; text-align:center; transition:.3s; }
        .card:hover { transform:translateY(-6px); box-shadow:0 12px 24px rgba(255,215,0,.25); }
        .card h3 { margin:12px 0; }
        .num { font-size:28px; color:#FFD700; font-weight:bold; }

        /* ===== STATUS CARDS ===== */
        .status-wrapper { display:grid; grid-template-columns:repeat(auto-fit,minmax(360px,1fr)); gap:24px; margin-top:30px; }
        .status-card { background:#111; border:2px solid #FFD700; border-radius:16px; padding:22px; box-shadow:0 10px 24px rgba(255,215,0,.15); transition:.3s; }
        .status-card:hover { transform:translateY(-6px); box-shadow:0 16px 32px rgba(255,215,0,.25); }
        .status-card h3 { color:#FFD700; margin-bottom:18px; text-align:center; }
        .status-row { display:flex; justify-content:space-between; margin-top:12px; font-weight:600; }
        .badge { padding:6px 12px; border-radius:20px; font-size:14px; }
        .badge.pending{ background:orange; color:#000; }
        .badge.approved{ background:#00e676; color:#000; }
        .badge.rejected{ background:#ff5252; color:#fff; }
        .progress{ height:10px; background:#333; border-radius:8px; overflow:hidden; margin-top:6px; }
        .progress div{ height:100%; background:#FFD700; transition:width .6s; }

        /* ===== ACTIVITY ===== */
        .activity { margin-top:25px; background:#111; border:2px solid #FFD700; border-radius:12px; padding:20px; }
        .activity li { padding:8px 0; border-bottom:1px solid #333; }
    </style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a class="active" href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>


<!-- ===== MAIN CONTENT ===== -->
<div class="main">

    <div class="header">
        <i class="fa fa-tachometer-alt"></i> Admin Control Center
    </div>

    <div class="welcome">
        <div>
            <h3>Welcome Back 👑</h3>
            <p>Monitor platform activity and approvals in real time.</p>
        </div>
        <div class="quick">
            <a href="manage-salons.jsp">Verify Salons</a>
            <a href="manageVerifyAdmins.jsp">Verify Admins</a>
            <a href="reports.jsp">Reports</a>
        </div>
    </div>

    <!-- ===== CARDS ===== -->
    <div class="cards">
        <div class="card"><i class="fa fa-store"></i><h3>Salons</h3><div class="num"><%= totalSalons %></div></div>
        <div class="card"><i class="fa fa-calendar-check"></i><h3>Appointments</h3><div class="num"><%= totalAppointments %></div></div>
        <div class="card"><i class="fa fa-users"></i><h3>Users</h3><div class="num"><%= totalUsers %></div></div>
        <div class="card"><i class="fa fa-star"></i><h3>Feedback</h3><div class="num"><%= totalFeedback %></div></div>
    </div>

    <!-- ===== STATUS CARDS ===== -->
    <div class="status-wrapper">

        <!-- Salon Status -->
        <div class="status-card">
            <h3><i class="fa fa-store"></i> Salon Status</h3>
            <div class="status-row"><span>Pending</span><span class="badge pending"><%= pendingSalons %></span></div>
            <div class="progress"><div style="width:<%= totalSalons==0?0:(pendingSalons*100/totalSalons) %>%"></div></div>
            <div class="status-row"><span>Approved</span><span class="badge approved"><%= approvedSalons %></span></div>
            <div class="progress"><div style="width:<%= totalSalons==0?0:(approvedSalons*100/totalSalons) %>%"></div></div>
            <div class="status-row"><span>Rejected</span><span class="badge rejected"><%= rejectedSalons %></span></div>
            <div class="progress"><div style="width:<%= totalSalons==0?0:(rejectedSalons*100/totalSalons) %>%"></div></div>
        </div>


    </div>

    <!-- Recent Activity -->
    <div class="activity">
        <h3>Recent Activity</h3>
        <ul>
            <li>New salon registrations today</li>
            <li>Appointments booked recently</li>
            <li>Admins awaiting verification</li>
            <li>New feedback submitted</li>
        </ul>
    </div>

</div>
</body>
</html>
