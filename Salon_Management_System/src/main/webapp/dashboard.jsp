<%@ page import="java.util.*, model.*, dao.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // DAO instances
    SalonDAO salonDAO = new SalonDAO();
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    UserDAO userDAO = new UserDAO();
    FeedbackDAO feedbackDAO = new FeedbackDAO();
    AdminDAO adminDAO = new AdminDAO();

    // Initialize counts
    int totalSalons = 0;
    int totalAppointments = 0;
    int totalUsers = 0;
    int totalFeedback = 0;
    int pendingSalons = 0, approvedSalons = 0, rejectedSalons = 0;
    int pendingAdmins = 0, approvedAdmins = 0, rejectedAdmins = 0;

    try {
        totalSalons = salonDAO.getTotalSalons();
        totalAppointments = appointmentDAO.getTotalAppointments();
        totalUsers = userDAO.getTotalUsers();
        totalFeedback = feedbackDAO.getTotalFeedback();

        List<Salon> allSalons = salonDAO.getAllSalons();
        pendingSalons = (int) allSalons.stream().filter(s -> "Pending".equals(s.getStatus())).count();
        approvedSalons = (int) allSalons.stream().filter(s -> "Approved".equals(s.getStatus())).count();
        rejectedSalons = (int) allSalons.stream().filter(s -> "Rejected".equals(s.getStatus())).count();

        List<Admin> allAdmins = adminDAO.getAllAdmins();
        pendingAdmins = (int) allAdmins.stream().filter(a -> "Pending".equals(a.getStatus())).count();
        approvedAdmins = (int) allAdmins.stream().filter(a -> "Approved".equals(a.getStatus())).count();
        rejectedAdmins = (int) allAdmins.stream().filter(a -> "Rejected".equals(a.getStatus())).count();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        /* Page layout */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #1a1a1a;
            color: #fff;
            margin: 0;
            padding: 0;
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            background-color: #111;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.5);
        }

        .sidebar h2 {
            color: #FFD700;
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar a {
            display: block;
            color: #fff;
            padding: 12px 20px;
            text-decoration: none;
            font-weight: bold;
        }

        .sidebar a:hover {
            background-color: #333;
            color: #FFD700;
        }

        /* Main content */
        .main-content {
            margin-left: 220px;
            padding: 20px;
            width: calc(100% - 220px);
        }

        h1 {
            background-color: #FFD700;
            color: #1a1a1a;
            text-align: center;
            padding: 25px 0;
            margin: 0 0 20px 0;
            font-size: 2.5em;
            letter-spacing: 2px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
        }

        h2.section-title {
            color: #FFD700;
            margin-top: 30px;
            text-align: center;
            font-size: 1.8em;
            letter-spacing: 1px;
        }

        table {
            border-collapse: collapse;
            width: 60%;
            margin: 15px auto;
            background-color: #1a1a1a;
            border: 2px solid #FFD700;
            box-shadow: 0 4px 10px rgba(0,0,0,0.5);
        }

        th, td {
            padding: 12px 20px;
            text-align: center;
            border-bottom: 1px solid #FFD700;
            font-size: 1.1em;
        }

        th {
            background-color: #FFD700;
            color: #1a1a1a;
            font-weight: bold;
            text-transform: uppercase;
        }

        td {
            color: #fff;
        }

        tr:hover {
            background-color: #333;
        }

        .count {
            font-size: 1.3em;
            font-weight: bold;
            color: #FFD700;
        }

        @media screen and (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .main-content {
                margin-left: 0;
                width: 100%;
            }
            table {
                width: 90%;
            }
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>Admin Menu</h2>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="manage-salons.jsp">Manage Salons</a>
    <a href="manageVerifyAdmins.jsp">Manage Admins</a>
    <a href="AdminTherapistServlet" class="btn btn-dark">Manage Therapists</a>
    <a href="AdminAppointmentServlet">Appointments</a>
    <a href="user-dashboard.jsp">Users</a>
    <a href="feedback.jsp">Feedback</a>
    <a href="reports.jsp">Reports</a>
    <a href="logout.jsp">Logout</a>
</div>

<div class="main-content">
    <h1>Admin Dashboard</h1>

    <h2 class="section-title">Summary Counts</h2>
    <table>
        <tr><th>Total Salons</th><td class="count"><%= totalSalons %></td></tr>
        <tr><th>Total Appointments</th><td class="count"><%= totalAppointments %></td></tr>
        <tr><th>Total Users</th><td class="count"><%= totalUsers %></td></tr>
        <tr><th>Total Feedback</th><td class="count"><%= totalFeedback %></td></tr>
    </table>

    <h2 class="section-title">Salon Status</h2>
    <table>
        <tr><th>Pending</th><td class="count"><%= pendingSalons %></td></tr>
        <tr><th>Approved</th><td class="count"><%= approvedSalons %></td></tr>
        <tr><th>Rejected</th><td class="count"><%= rejectedSalons %></td></tr>
    </table>

    <h2 class="section-title">Admin Status</h2>
    <table>
        <tr><th>Pending</th><td class="count"><%= pendingAdmins %></td></tr>
        <tr><th>Approved</th><td class="count"><%= approvedAdmins %></td></tr>
        <tr><th>Rejected</th><td class="count"><%= rejectedAdmins %></td></tr>
    </table>
</div>

</body>
</html>
