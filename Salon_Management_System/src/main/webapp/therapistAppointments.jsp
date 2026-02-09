<%@ page import="java.util.*, model.*" %>
<%@ page session="true" %>
<%
    Therapist therapist = (Therapist) session.getAttribute("therapist");
    if(therapist == null){
        response.sendRedirect("login.jsp");
        return;
    }

    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    if(appointments == null) appointments = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Therapist Appointments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
body{
    background:#0b0b0b;
    color:#fff;
    font-family:'Segoe UI',sans-serif;
}

/* ===== SIDEBAR ===== */
.sidebar{
    height:100vh;
    background:#111;
    border-right:2px solid #FFD700;
    padding-top:30px;
    position:fixed;
    width:230px;
}

.sidebar h3{
    color:#FFD700;
    text-align:center;
    font-weight:800;
    margin-bottom:35px;
}

.sidebar a{
    display:flex;
    align-items:center;
    gap:10px;
    color:#ccc;
    padding:12px 18px;
    margin:8px 12px;
    border-radius:10px;
    text-decoration:none;
    transition:.3s;
}

.sidebar a:hover,
.sidebar a.active{
    background:#FFD700;
    color:#000;
    transform:translateX(6px);
}

/* ===== MAIN ===== */
.main{
    margin-left:250px;
    padding:40px;
}

.title{
    font-size:28px;
    font-weight:800;
    color:#FFD700;
    margin-bottom:25px;
    text-shadow:0 0 10px rgba(255,215,0,.3);
}

/* ===== TABLE ===== */
.table{
    background:#111;
    border-radius:16px;
    overflow:hidden;
    border:1px solid rgba(255,215,0,.2);
    box-shadow:0 0 25px rgba(255,215,0,.08);
}

.table thead{
    background:linear-gradient(90deg,#000,#1a1a1a);
    color:#FFD700;
    border-bottom:
}

.table thead th{
    padding:18px;
    font-size:17px;
    letter-spacing:1px;
}

.table tbody td{
    padding:16px;
    font-size:16px;
}

.table tbody tr{
    border-bottom:1px solid #222;
    transition:.25s;
}

.table tbody tr:hover{
    background:rgba(255,215,0,.08);
    transform:scale(1.01);
}

/* Highlight service column */
.table tbody td:first-child{
    color:#A67C00;
    font-weight:600;
    font-size:17px;
}

/* ===== BADGES ===== */
.badge{
    padding:6px 14px;
    border-radius:20px;
    font-size:12px;
}

.badge-booked{
    background:#FFD700;
    color:#000;
    font-weight:700;
}

.badge-progress{
    background:#ff9800;
    color:#000;
    font-weight:700;
}

.badge-complete{
    background:#00c853;
    color:#000;
    font-weight:700;
}

/* ===== BUTTONS ===== */
.btn-gold{
    background:linear-gradient(45deg,#FFD700,#ffb300);
    border:none;
    color:#000;
    font-weight:600;
    border-radius:8px;
    padding:6px 14px;
}

.btn-gold:hover{
    background:#FFD700;
    transform:scale(1.05);
}

.btn-outline-gold{
    border:1px solid #FFD700;
    color:#FFD700;
    background:transparent;
    border-radius:8px;
}

.btn-outline-gold:hover{
    background:#FFD700;
    color:#000;
}

/* profile box */
.profile{
    background:#1a1a1a;
    margin:0 15px 25px 15px;
    padding:12px;
    border-radius:10px;
    text-align:center;
    border:1px solid rgba(255,215,0,.2);
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h3><i class="fa-solid fa-hand-sparkles"></i> Therapist</h3>

    <div class="profile">
        <b><%= therapist.getName() %></b><br>
        <small>Therapist</small>
    </div>

    <a href="therapistDashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a>
    <a href="therapistAvailability.jsp"><i class="fa-solid fa-clock"></i> Set Availability</a>
    <a href="TherapistAppointmentServlet" class="active"><i class="fa-solid fa-calendar-check"></i> Appointments</a>
    <a href="ClientLedgerServlet"><i class="fa-solid fa-user"></i> Client Ledger</a>
    <a href="TherapistInsightsServlet"><i class="fa-solid fa-chart-simple"></i> Insights</a>
    <a href="logoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- ===== MAIN ===== -->
<div class="main">

<div class="title">Manage Appointments</div>

<table class="table table-hover">
<thead>
<tr>
    <th>Service</th>
    <th>Customer</th>
    <th>Date</th>
    <th>Time</th>
    <th>Status</th>
    <th>Decision</th>
    <th>Action</th>
</tr>
</thead>

<tbody>
<% for(Appointment a : appointments) { %>
<tr>
    <td><%= a.getServiceName() %></td>
    <td><%= a.getCustomerName() %></td>
    <td><%= a.getAppointmentDate() %></td>
    <td><%= a.getAppointmentTime() %></td>

    <td>
        <% if("BOOKED".equalsIgnoreCase(a.getStatus())){ %>
            <span class="badge badge-booked">BOOKED</span>
        <% } else if("IN_PROGRESS".equalsIgnoreCase(a.getStatus())){ %>
            <span class="badge badge-progress">IN PROGRESS</span>
        <% } else { %>
            <span class="badge badge-complete">COMPLETED</span>
        <% } %>
    </td>

    <td><%= a.getTherapistDecision() %></td>

    <td>
    <form method="post" action="TherapistAppointmentServlet">
        <input type="hidden" name="id" value="<%= a.getId() %>">

        <% if("BOOKED".equalsIgnoreCase(a.getStatus())) { %>
            <button type="submit" name="action" value="start" class="btn btn-gold btn-sm">
                Start
            </button>
        <% } else if("IN_PROGRESS".equalsIgnoreCase(a.getStatus())) { %>
            <button type="submit" name="action" value="complete" class="btn btn-outline-gold btn-sm">
                Complete
            </button>
        <% } else { %>
            <span class="text-muted">No actions</span>
        <% } %>
    </form>
    </td>
</tr>
<% } %>
</tbody>
</table>

</div>
</body>
</html>
