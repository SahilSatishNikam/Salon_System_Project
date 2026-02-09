<%@ page import="java.util.*,model.*" %>
<%
Therapist therapist=(Therapist)session.getAttribute("therapist");
if(therapist==null){
response.sendRedirect("login.jsp");
return;
}

List<ClientLedger> list=(List<ClientLedger>)request.getAttribute("ledgerList");
if(list==null) list=new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
<title>Client Ledger</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{background:#0b0b0b;color:#fff;font-family:Segoe UI;}
.sidebar{width:220px;position:fixed;height:100vh;background:#111;border-right:2px solid #D4AF37;padding:25px;}
.sidebar a{display:block;color:#ccc;padding:10px;margin:8px 0;text-decoration:none;border-radius:8px;}
.sidebar a:hover{background:#D4AF37;color:#000;}

.main{margin-left:240px;padding:40px;}

.table{background:#111;border-radius:12px;color:#fff;}
.table thead{background:#000;color:#D4AF37;}
</style>
</head>

<body>

<div class="sidebar">
<h4 style="color:#D4AF37;">Therapist</h4>
<a href="therapistDashboard.jsp">Dashboard</a>
<a href="TherapistAppointmentServlet">Appointments</a>
<a href="ClientLedgerServlet" style="background:#D4AF37;color:#000;">Client Ledger</a>
<a href="logoutServlet">Logout</a>
</div>

<div class="main">
<h2 style="color:#D4AF37;">Client Ledger</h2>

<table class="table">
<thead>
<tr>
<th>Date</th>
<th>Client</th>
<th>Service</th>
<th>Total</th>
<th>Paid</th>
<th>Balance</th>
</tr>
</thead>

<tbody>
<% for(ClientLedger c:list){ %>
<tr>
<td><%=c.getDate()%></td>
<td><%=c.getCustomerName()%></td>
<td><%=c.getServiceName()%></td>
<td>₹<%=c.getAmount()%></td>
<td>₹<%=c.getPaid()%></td>
<td style="color:#ff4d4d;">₹<%=c.getBalance()%></td>
</tr>
<% } %>
</tbody>
</table>

</div>
</body>
</html>
