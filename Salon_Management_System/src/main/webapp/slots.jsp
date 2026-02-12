<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Slot, model.Therapist" %>

<%
Therapist t = (Therapist) session.getAttribute("therapist");
if (t == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Get slots from request
List<Slot> slots = (List<Slot>) request.getAttribute("slots");
if (slots == null) slots = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Therapist Slots</title>

    <!-- Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: #121212;
            color: #eee;
            font-family: Poppins, sans-serif;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: #111;
            min-height: 100vh;
            position: fixed;
            border-right: 2px solid #F5A927;
        }
        .sidebar h2 {
            text-align: center;
            color: #F5A927;
            padding: 20px;
            border-bottom: 1px solid #333;
        }
        .sidebar a {
            display: block;
            padding: 14px 20px;
            color: #fff;
            text-decoration: none;
            border-bottom: 1px solid #222;
        }
        .sidebar a:hover,
        .sidebar a.active {
            background: #F5A927;
            color: #000;
        }

        /* Main Content */
        .main {
            margin-left: 250px;
            padding: 30px;
        }

        /* Slot Cards */
        .slot-card {
            background: #1E1E1E;
            border-radius: 12px;
            padding: 18px;
            width: 260px;
            border: 1px solid #333;
            transition: 0.3s;
            cursor: pointer;
            position: relative;
        }
        .slot-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 0 18px rgba(245,169,39,.35);
            border-color: #F5A927;
        }
        .badge-gold {
            background: #F5A927;
            color: #000;
        }
        .slot-card .info-icon {
            position: absolute;
            top: 12px;
            right: 12px;
            font-size: 1.1rem;
            color: #F5A927;
        }
    </style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
<h2>Therapist Panel</h2>

<a href="TherapistDashboardServlet" class="active">
<i class="fa fa-chart-line"></i> Dashboard
</a>

<a href="therapistAvailability.jsp">
<i class="fa fa-clock"></i> Set Availability
</a>

<!-- ✅ FIXED LINK -->
<a href="<%=request.getContextPath()%>/slots?therapistId=<%=t.getId()%>">
<i class="fa fa-calendar"></i> View Slots
</a>

<a href="therapist-services?salonId=<%=t.getSalonId()%>">
<i class="fa fa-spa"></i> Services
</a>

<a href="TherapistAppointmentServlet">
<i class="fa fa-calendar-check"></i> Appointments
</a>


<a href="LogoutServlet">
<i class="fa fa-sign-out-alt"></i> Logout
</a>
</div>


<!-- Main Content -->
<div class="main">
    <h3 class="mb-4" style="color:#F5A927;"> <i class="fa fa-calendar-check"></i> Available Slots </h3>

    <div class="d-flex flex-wrap gap-4">
        <% for(Slot s : slots) { %>

        <!-- Slot Card -->
        <div class="slot-card" data-bs-toggle="modal" data-bs-target="#slot<%=s.getId()%>">
            <i class="fa fa-info-circle info-icon" title="Slot Details"></i>
            <h6> <i class="fa fa-calendar-day"></i> <%= s.getAvailableDate() %> </h6>
            <p class="mb-1"> <i class="fa fa-clock"></i> <%= s.getStartTime() %> - <%= s.getEndTime() %> </p>
            <span class="badge badge-gold mb-2"> <%= s.getSlotDuration() %> mins </span>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="slot<%=s.getId()%>">
            <div class="modal-dialog">
                <div class="modal-content bg-dark text-light">
                    <div class="modal-header border-secondary">
                        <h5>Slot Details</h5>
                        <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p><b>Date:</b> <%= s.getAvailableDate() %></p>
                        <p><b>Time:</b> <%= s.getStartTime() %> - <%= s.getEndTime() %></p>
                        <p><b>Duration:</b> <%= s.getSlotDuration() %> mins</p>
                    </div>
                    <div class="modal-footer border-secondary">
                        <button class="btn btn-outline-warning" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
