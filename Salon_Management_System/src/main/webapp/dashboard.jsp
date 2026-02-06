<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

if(role == null || !role.equals("admin")){
    response.sendRedirect("../login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
body{
 background:linear-gradient(to right,#141e30,#243b55);
 font-family:'Segoe UI';
}

.sidebar{
 height:100vh;
 background:rgba(0,0,0,0.4);
 backdrop-filter:blur(10px);
 color:white;
}

.sidebar a{
 color:white;
 text-decoration:none;
 display:block;
 padding:12px;
 border-radius:8px;
 margin-bottom:5px;
}

.sidebar a:hover{
 background:#00c6ff;
 color:black;
}

.topbar{
 background:rgba(255,255,255,0.1);
 backdrop-filter:blur(10px);
 color:white;
 padding:15px;
 border-radius:10px;
}

.card{
 border:none;
 border-radius:15px;
 transition:0.3s;
}

.card:hover{
 transform:scale(1.04);
}

.glass{
 background:rgba(255,255,255,0.1);
 backdrop-filter:blur(10px);
 color:white;
}
</style>
</head>

<body>

<div class="container-fluid">
<div class="row">

<!-- SIDEBAR -->
<div class="col-2 sidebar p-3">

<h4 class="text-center">
<i class="fa fa-spa text-info"></i> ADMIN
</h4>
<hr>

<a href="dashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
<a href="manageUsers.jsp"><i class="fa fa-users"></i> Users</a>
<a href="manageOwners.jsp"><i class="fa fa-user-tie"></i> Salon Owners</a>
<a href="manageSalons.jsp"><i class="fa fa-store"></i> Salons</a>
<a href="verifySalons.jsp"><i class="fa fa-check"></i> Verify Salons</a>
<a href="manageCategory.jsp"><i class="fa fa-list"></i> Categories</a>
<a href="viewAppointments.jsp"><i class="fa fa-calendar"></i> Appointments</a>
<a href="feedback.jsp"><i class="fa fa-comments"></i> Feedback</a>
<a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
<a href="logout.jsp" class="text-danger"><i class="fa fa-sign-out"></i> Logout</a>

</div>

<!-- MAIN -->
<div class="col-10 p-3">

<div class="topbar mb-3">
<h3>
<i class="fa fa-tachometer-alt"></i>
Welcome Admin: <%=session.getAttribute("admin")%>
</h3>
</div>

<!-- CARDS -->
<div class="row">

<div class="col-md-3">
<div class="card glass p-3 text-center">
<i class="fa fa-store fa-2x text-info"></i>
<h5>Total Salons</h5>
<h2>0</h2>
</div>
</div>

<div class="col-md-3">
<div class="card glass p-3 text-center">
<i class="fa fa-calendar fa-2x text-warning"></i>
<h5>Appointments</h5>
<h2>0</h2>
</div>
</div>

<div class="col-md-3">
<div class="card glass p-3 text-center">
<i class="fa fa-users fa-2x text-success"></i>
<h5>Users</h5>
<h2>0</h2>
</div>
</div>

<div class="col-md-3">
<div class="card glass p-3 text-center">
<i class="fa fa-comments fa-2x text-primary"></i>
<h5>Feedback</h5>
<h2>0</h2>
</div>
</div>

</div>

<!-- INFO -->
<div class="row mt-4">

<div class="col-md-6">
<div class="card glass p-3">
<h5>System Features</h5>
<ul>
<li>Salon Verification</li>
<li>Service Categories</li>
<li>Appointments</li>
<li>Feedback</li>
<li>Reports</li>
</ul>
</div>
</div>

<div class="col-md-6">
<div class="card glass p-3">
<h5>Quick Access</h5>

<a href="manageSalons.jsp" class="btn btn-info w-100 mb-2">Manage Salons</a>
<a href="verifySalons.jsp" class="btn btn-success w-100 mb-2">Verify Salons</a>
<a href="reports.jsp" class="btn btn-warning w-100">Reports</a>

</div>
</div>

</div>

</div>
</div>
</div>

</body>
</html>
