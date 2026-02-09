<%@ page import="java.util.*, dao.*, model.*" %>

<%
AdminDAO adminDAO = new AdminDAO();
List<Admin> admins = adminDAO.getAllAdmins();
String msg = (String) session.getAttribute("msg");
session.removeAttribute("msg");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage & Verify Admins</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
body{
    margin:0;
    font-family: 'Segoe UI', sans-serif;
    background:#000;
    color:#FFD700;
}

/* SIDEBAR */
.sidebar{
    width:240px;
    height:100vh;
    background:#111;
    color:#FFD700;
    position:fixed;
    padding-top:20px;
    border-right:2px solid #FFD700;
}
.sidebar h2{
    text-align:center;
    margin-bottom:25px;
    font-size:24px;
    font-weight:bold;
    letter-spacing:1px;
}
.sidebar a{
    display:block;
    color:#FFD700;
    padding:15px 20px;
    text-decoration:none;
    font-size:16px;
    transition:0.3s;
}
.sidebar a i{
    margin-right:10px;
}
.sidebar a:hover{
    background:#FFD700;
    color:#000;
    font-weight:600;
}
.sidebar a.active{
    background:#FFD700;
    color:#000;
    font-weight:700;
}

/* MAIN CONTENT */
.main{
    margin-left:250px;
    padding:40px;
    min-height:100vh;
}

/* CARD */
.card{
    background:#111;
    border:2px solid #FFD700;
    border-radius:15px;
    box-shadow:0 8px 25px rgba(255,215,0,0.2);
    padding:25px;
}

/* HEADER */
.card h3{
    color:#FFD700;
    font-weight:bold;
    margin-bottom:25px;
}

/* ALERT */
.alert-success{
    background:#333;
    color:#FFD700;
    border:1px solid #FFD700;
}

/* TABLE */
.table th{
    background:#111;
    color:#FFD700;
    font-weight:600;
}
.table td{
    vertical-align:middle;
    color:#FFD700;
}
.table tr:hover{
    background:rgba(255,215,0,0.1);
}

.table{
       --bs-table-bg: #111;
}

/* STATUS BADGE BIG */
.status-approved{
    display:inline-block;
    font-size:15px;
    font-weight:700;
    padding:8px 18px;
    border-radius:20px;
    min-width:110px;
    text-align:center;
}

/* custom colors */
.status-ok{
    background:#1faa59;
    color:#fff;
}

.status-reject{
    background:#ff4500;
    color:#fff;
}

.status-pending{
    background:#FFA500;
    color:#000;
}


/* BADGES */
.badge{
    font-weight:bold;
    border-radius:12px;
    padding:5px 10px;
}
.bg-success{
    background:#FFD700;
    color:#000;
}
.bg-danger{
    background:#FF4500;
    color:#fff;
}
.bg-warning{
    background:#FFA500;
    color:#000;
}

/* ICON BUTTONS */
.btn-success, .btn-danger, .btn-secondary{
    width:30px;
    height:30px;
    padding:0;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    border-radius:50%;
    font-size:16px;
    transition:0.3s;
}
.btn-success{
    background:#222;
    color:#FFD700;
    border:1px solid #FFD700;
}
.btn-success:hover{
    background:#e6c200;
    transform:scale(1.1);
}
.btn-danger{
    background:#222;
    color:#FFD700;
    border:1px solid #FFD700;
}
.btn-danger:hover{
    background:#e03f00;
    transform:scale(1.1);
}
.btn-secondary{
    background:#222;
    color:#FFD700;
    border:1px solid #FFD700;
}
.btn-secondary:hover{
    background:#FFD700;
    color:#000;
    transform:scale(1.1);
}

/* ACTION BUTTON ROW */
.action-cell{
    display:flex;
    gap:12px;
    align-items:center;
    justify-content:flex-start;
}

/* BIG ROUND BUTTONS */
.action-cell .btn{
    width:30px;
    height:30px;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:18px;
    padding:0;
}

</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="admin-sidebar">

    <div class="logo">
        <i class="fa-solid fa-crown"></i> Admin Panel
    </div>

    <a href="dashboard.jsp">
        <i class="fa fa-gauge"></i> Dashboard
    </a>

    <a href="manage-salons.jsp">
        <i class="fa fa-store"></i> Salons
    </a>

    <a href="manageVerifyAdmins.jsp">
        <i class="fa fa-user-shield"></i> Admins
    </a>

    <a href="AdminTherapistServlet">
        <i class="fa fa-user-doctor"></i> Therapists
    </a>

    <a href="AdminAppointmentServlet">
        <i class="fa fa-calendar-check"></i> Appointments
    </a>

    <a href="user-dashboard.jsp">
        <i class="fa fa-users"></i> Users
    </a>

    <a href="feedback.jsp">
        <i class="fa fa-comments"></i> Feedback
    </a>

    <a href="reports.jsp">
        <i class="fa fa-chart-line"></i> Reports
    </a>

    <a href="logout.jsp" class="logout">
        <i class="fa fa-right-from-bracket"></i> Logout
    </a>

</div>

<!-- MAIN -->
<div class="main">

<div class="card">
<h3><i class="fa-solid fa-user-shield"></i> Manage & Verify Admins</h3>

<% if(msg != null){ %>
<div class="alert alert-success"><%= msg %></div>
<% } %>

<table class="table table-bordered table-hover">
<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>Status</th>
<th width="130">Action</th>
</tr>

<% for(Admin a: admins){ %>
<tr>
<td><%= a.getId() %></td>
<td><%= a.getName() %></td>
<td><%= a.getEmail() %></td>
<td><%= a.getPhone() %></td>

<td>
<% if("Approved".equals(a.getStatus())){ %>
<span class="status-approved status-ok">Approved</span>

<% } else if("Rejected".equals(a.getStatus())){ %>
<span class="status-approved status-reject">Rejected</span>

<% } else { %>
<span class="status-approved status-pending">Pending</span>
<% } %>
</td>


<td class="action-cell">

<a class="btn btn-success"
href="AdminServlet?id=<%=a.getId()%>&st=Approved"
onclick="return confirm('Approve this admin?')">
<i class="fa-solid fa-check"></i>
</a>

<a class="btn btn-danger"
href="AdminServlet?id=<%=a.getId()%>&st=Rejected"
onclick="return confirm('Reject this admin?')">
<i class="fa-solid fa-xmark"></i>
</a>

<a class="btn btn-secondary"
href="AdminServlet?action=delete&id=<%=a.getId()%>"
onclick="return confirm('Delete this admin?')">
<i class="fa-solid fa-trash"></i>
</a>

</td>

</tr>
<% } %>

</table>
</div>

</div>
</body>
</html>
