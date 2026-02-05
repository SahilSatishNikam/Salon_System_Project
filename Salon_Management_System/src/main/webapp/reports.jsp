<%@ page import="dao.ReportDAO" %>

<%
ReportDAO d = new ReportDAO();
%>

<!DOCTYPE html>
<html>
<head>

<title>System Reports</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

body{
 background:linear-gradient(to right,#141e30,#243b55);
 font-family:'Segoe UI';
}

.card{
 border:none;
 border-radius:15px;
 transition:0.3s;
}

.card:hover{
 transform:scale(1.03);
}

.glass{
 background:rgba(255,255,255,0.1);
 backdrop-filter:blur(10px);
 color:white;
 border-radius:15px;
}

.count{
 font-size:40px;
 font-weight:bold;
}

</style>

</head>

<body>

<div class="container mt-5">

<div class="glass p-4 shadow">

<h3 class="text-info">
<i class="fa fa-chart-bar"></i>
System Reports
</h3>

<hr class="text-light">

<div class="row mt-4">

<!-- ===== TOTAL APPOINTMENTS ===== -->
<div class="col-md-6">
<div class="card glass p-4 text-center">

<i class="fa fa-calendar fa-3x text-warning"></i>

<h5 class="mt-3">Total Appointments</h5>

<div class="count">
<%=d.totalAppointments()%>
</div>

</div>
</div>

<!-- ===== TOTAL SALONS ===== -->
<div class="col-md-6">
<div class="card glass p-4 text-center">

<i class="fa fa-store fa-3x text-info"></i>

<h5 class="mt-3">Total Salons</h5>

<div class="count">
<%=d.totalSalons()%>
</div>

</div>
</div>

</div>

<!-- EXTRA INFO -->
<div class="mt-4 text-light">

<h5><i class="fa fa-info-circle"></i> Summary</h5>

<p>
This report shows overall system statistics including
total registered salons and total appointments
booked by users.
</p>

</div>

</div>
</div>

</body>
</html>

