<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.VisitedClient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Visited Clients | SalonEase Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: Poppins, sans-serif;
            background: #111;
            color: #fff;
            display: flex;
        }

        /* ===== SIDEBAR ===== */
        .sidebar {
            width: 250px;
            background: #000;
            min-height: 100vh;
            position: fixed;
            border-right: 3px solid #FFD700;
            padding-top: 10px;
        }
        .sidebar h2 {
            text-align: center;
            padding: 20px;
            color: #FFD700;
            font-weight: 700;
            border-bottom: 1px solid #222;
            font-size: 1.4rem;
        }
        .sidebar a {
            display: flex;
            align-items: center;
            color: #fff;
            padding: 14px 22px;
            text-decoration: none;
            border-bottom: 1px solid #111;
            font-weight: 500;
            font-size: 18px;
            transition: all 0.3s;
        }
        .sidebar a i {
            margin-right: 12px;
            font-size: 1.1rem;
        }
        .sidebar a:hover, .sidebar a.active {
            background: #FFD700;
            color: #000;
            padding-left: 28px;
            font-weight: 600;
        }

        /* ===== MAIN CONTENT ===== */
        .main {
            margin-left: 250px;
            padding: 28px;
            width: calc(100% - 250px);
        }
        .header {
            background: linear-gradient(90deg, #FFD700, #ffea00);
            color: #000;
            padding: 8px;
            border-radius: 14px;
            font-size: 28px;
            font-weight: 700;
            text-align: center;
            box-shadow: 0 10px 26px rgba(255, 215, 0, 0.3);
            margin-bottom: 20px;
            height:50px;
        }

        /* ===== TABLE STYLING ===== */
        .table-container {
            background: #111;
            border: 3px solid #FFD700;
            border-radius: 15px;
            padding: 15px;
            overflow-x: auto;
            box-shadow: 0 10px 25px rgba(255, 215, 0, 0.3);
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 16px;
        }
        thead th {
            background: linear-gradient(90deg, #FFD700, #ffea00);
            color: #000;
            font-weight: 700;
            padding: 12px;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        tbody tr {
            background: #1a1a1a;
            cursor: default;
        }
        tbody tr:nth-child(even) {
            background: #222;
        }
        td, th {
            padding: 12px;
            text-align: center;
        }
        .badge {
            font-size: 16px;
            padding: 5px 10px;
            border-radius: 12px;
            font-weight: 400;
            
        }
        .badge-service {
           
            color: #111;
        }
    </style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients" class="active"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- ===== MAIN CONTENT ===== -->
<div class="main">
    <div class="header">
        <i class="fa fa-users"></i> Visited Clients
    </div>

    <div class="table-container">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Client Name</th>
                    <th>Phone</th>
                    <th>Service</th>
                    <th>Amount</th>
                    <th>Visit Date</th>
                    <th>Visit Time</th>
                    <th>Therapist</th>
                    <th>Salon</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<VisitedClient> clients = (List<VisitedClient>) request.getAttribute("visitedClients");
                    int i = 1;
                    if(clients != null && !clients.isEmpty()){
                        for(VisitedClient c : clients){
                %>
                <tr>
                    <td><%= i++ %></td>
                    <td style="font-weight:400;"><%= c.getBookedBy() %></td>
                    <td><%= c.getClientPhone() %></td>
                    <td><span class="badge badge-service"><%= c.getServiceName() %></span></td>
                    <td style="font-weight:400;">₹<%= c.getAmount() %></td>
                    <td><%= c.getVisitDate() %></td>
                    <td><%= c.getVisitTime() %></td>
                    <td style="font-weight:400;"><%= c.getTherapistName() %></td>
                    <td><%= c.getSalonName() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="9" class="text-center text-warning">No visited clients found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
