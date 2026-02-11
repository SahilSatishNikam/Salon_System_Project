<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Therapist, model.Salon" %>

<!DOCTYPE html>
<html>
<head>
<title>Manage Therapists</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:#111;
    color:#FFD700;
}

/* ===== SIDEBAR ===== */
.sidebar{
    width:250px;
    background:#000;
    min-height:100vh;
    position:fixed;
    border-right:2px solid #FFD700;
}
.sidebar h2{
    text-align:center;
    padding:20px;
    color:#FFD700;
    border-bottom:1px solid #222;
}
.sidebar a{
    display:flex;
    align-items:center;
    color:#fff;
    padding:14px 22px;
    text-decoration:none;
    border-bottom:1px solid #111;
}
.sidebar a i{margin-right:12px;}
.sidebar a:hover,.sidebar a.active{
    background:#FFD700;
    color:#000;
    padding-left:28px;
}

/* ===== MAIN ===== */
.main{
    margin-left:250px;
    padding:30px;
}

/* CARD */
.card{
    background:#000;
    border:1px solid #FFD700;
    color:#FFD700;
    border-radius:15px;
}

/* TABLE */
.table{
    background:#fff;
    color:#000;
}
.table th{
    background:#FFD700;
    color:#000;
}

/* BUTTON */
.btn-gold{
    background:#FFD700;
    color:#000;
    font-weight:600;
}
.btn-gold:hover{
    background:#e6c200;
    color:#000;
}
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2><i class="fa fa-gem"></i> SalonEase</h2>
    <a href="dashboard.jsp"><i class="fa fa-chart-line"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="AdminTherapistServlet" class="active"><i class="fa fa-user-tie"></i> Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar"></i> Appointments</a>
    <a href="feedback.jsp"><i class="fa fa-comment"></i> Feedback</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main">

<h3 class="mb-4"><i class="fa fa-user-tie"></i> Manage Therapists</h3>

<!-- ADD THERAPIST -->
<form action="AdminTherapistServlet" method="post" class="card p-4 mb-4 shadow">
<input type="hidden" name="action" value="add">

<h5 class="mb-3"><i class="fa fa-user-plus"></i> Add Therapist</h5>

<div class="row g-3">
<div class="col-md-2">
<input class="form-control" name="name" placeholder="Name" required>
</div>

<div class="col-md-2">
<input class="form-control" name="phone" placeholder="Phone" required>
</div>

<div class="col-md-2">
<input class="form-control" name="email" placeholder="Email" required>
</div>

<div class="col-md-2">
<input class="form-control" name="specialty" placeholder="Specialty">
</div>

<div class="col-md-2">
<select name="salonId" class="form-select" required>
<option value="">Assign Salon</option>
<%
if(request.getAttribute("salons")!=null){
List<Salon> salons=(List<Salon>)request.getAttribute("salons");
for(Salon s:salons){
%>
<option value="<%=s.getId()%>"><%=s.getName()%></option>
<% }} %>
</select>
</div>

<div class="col-md-2">
<input type="password" class="form-control" name="password" placeholder="Password" required>
</div>
</div>

<button class="btn btn-gold mt-3 w-100">
<i class="fa fa-plus-circle"></i> Add Therapist
</button>
</form>

<!-- TABLE -->
<div class="card p-3 shadow">
<h5 class="mb-3"><i class="fa fa-table"></i> Therapist List</h5>

<table class="table table-bordered text-center align-middle">
<tr>
<th>Name</th>
<th>Phone</th>
<th>Email</th>
<th>Specialty</th>
<th>Salon</th>
<th>Status</th>
<th>Approved</th>
<th>Actions</th>
</tr>

<%
if(request.getAttribute("therapists")!=null){
List<Therapist> therapists=(List<Therapist>)request.getAttribute("therapists");

for(Therapist t:therapists){
String statusClass="Active".equals(t.getStatus())?"bg-success":"bg-danger";
String approvedClass=t.getApproved()==1?"bg-success":"bg-warning";
String approvedText=t.getApproved()==1?"Approved":"Pending";
String toggleStatus="Active".equals(t.getStatus())?"Inactive":"Active";
%>

<tr>
<td><%=t.getName()%></td>
<td><%=t.getPhone()%></td>
<td><%=t.getEmail()%></td>
<td><%=t.getSpecialty()%></td>
<td><%=t.getSalonId()%></td>

<td><span class="badge <%=statusClass%>"><%=t.getStatus()%></span></td>
<td><span class="badge <%=approvedClass%>"><%=approvedText%></span></td>

<td>
<form action="AdminTherapistServlet" method="post" class="d-inline">
<input type="hidden" name="action" value="status">
<input type="hidden" name="therapistId" value="<%=t.getId()%>">
<input type="hidden" name="status" value="<%=toggleStatus%>">
<button class="btn btn-sm btn-warning">
<%= "Active".equals(t.getStatus())?"Deactivate":"Activate" %>
</button>
</form>

<% if(t.getApproved()!=1){ %>
<form action="ApproveTherapistServlet" method="post" class="d-inline">
<input type="hidden" name="therapistId" value="<%=t.getId()%>">
<button class="btn btn-sm btn-success">Approve</button>
</form>
<% } %>

</td>
</tr>

<% }} %>
</table>
</div>

</div>
</body>
</html>
