<%@ page import="model.*" %>
<%
Therapist therapist = (Therapist) session.getAttribute("therapist");
if(therapist==null){
    response.sendRedirect("login.jsp");
    return;
}

int todayIncome = (request.getAttribute("todayIncome")!=null)
? (Integer)request.getAttribute("todayIncome") : 0;

int todayAppointments = (request.getAttribute("todayAppointments")!=null)
? (Integer)request.getAttribute("todayAppointments") : 0;

int pendingAmount = (request.getAttribute("pendingAmount")!=null)
? (Integer)request.getAttribute("pendingAmount") : 0;

String topService = (String)request.getAttribute("topService");
if(topService==null) topService="None";
%>

<!DOCTYPE html>
<html>
<head>
<title>Therapist Insights</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{background:#0b0b0b;color:#fff;font-family:Segoe UI;}
.sidebar{width:220px;position:fixed;height:100vh;background:#111;border-right:2px solid #D4AF37;padding:25px;}
.sidebar a{display:block;color:#ccc;padding:10px;margin:8px 0;text-decoration:none;border-radius:8px;}
.sidebar a:hover{background:#D4AF37;color:#000;}

.main{margin-left:240px;padding:40px;}

.card{
background:#111;
border:1px solid #D4AF37;
border-radius:12px;
padding:25px;
text-align:center;
}

.value{
font-size:28px;
font-weight:700;
color:#D4AF37;
}
</style>
</head>

<body>

<div class="sidebar">
<h4 style="color:#D4AF37;">Therapist</h4>
<a href="therapistDashboard.jsp">Dashboard</a>
<a href="TherapistAppointmentServlet">Appointments</a>
<a href="ClientLedgerServlet">Client Ledger</a>
<a href="TherapistInsightsServlet" style="background:#D4AF37;color:#000;">Insights</a>
<a href="logoutServlet">Logout</a>
</div>

<div class="main">
<h2 style="color:#D4AF37;">Business Insights</h2>

<div class="row mt-4">

<div class="col-md-3">
<div class="card">
<h6>Today Income</h6>
<div class="value">₹<%=todayIncome%></div>
</div>
</div>

<div class="col-md-3">
<div class="card">
<h6>Appointments Today</h6>
<div class="value"><%=todayAppointments%></div>
</div>
</div>

<div class="col-md-3">
<div class="card">
<h6>Pending Payments</h6>
<div class="value">₹<%=pendingAmount%></div>
</div>
</div>

<div class="col-md-3">
<div class="card">
<h6>Top Service</h6>
<div class="value"><%=topService%></div>
</div>
</div>

</div>
</div>

</body>
</html>
