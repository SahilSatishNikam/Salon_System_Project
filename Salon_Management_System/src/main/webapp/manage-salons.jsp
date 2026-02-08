<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>
<html>
<head>
<title>Manage Salons</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:#0f0f0f;
    color:#fff;
}
.container{ display:flex; }

/* SIDEBAR */
.sidebar{
    width:240px;
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
    display:block;
    color:#fff;
    padding:15px 22px;
    text-decoration:none;
    border-bottom:1px solid #111;
    transition:0.3s;
}
.sidebar a i{ margin-right:10px; }
.sidebar a:hover{
    background:#FFD700;
    color:#000;
    padding-left:28px;
}

/* CONTENT */
.content{
    margin-left:240px;
    padding:30px;
    width:100%;
}

h2{ color:#FFD700; }

form input{
    padding:10px;
    margin:6px;
    border:1px solid #333;
    border-radius:6px;
    background:#000;
    color:#fff;
}
button{
    padding:10px 18px;
    background:linear-gradient(45deg,#FFD700,#ffb300);
    border:none;
    border-radius:6px;
    font-weight:600;
}

table{
    border-collapse:collapse;
    width:100%;
    margin-top:18px;
    background:#111;
}
th{
    background:#FFD700;
    color:#000;
}
td,th{
    border:1px solid #222;
    padding:12px;
}
.service-table{
    margin-left:30px;
    width:90%;
    background:#000;
}
img{
    border-radius:8px;
    border:2px solid #FFD700;
}
</style>

<script>
function toggleServiceForm(id){
    const f=document.getElementById("serviceForm-"+id);
    f.style.display=(f.style.display==="none")?"block":"none";
}
</script>
</head>

<body>
<div class="container">

<!-- 🔥 NEW SIDEBAR -->
<div class="sidebar">

    <h2><i class="fa fa-crown"></i> Admin Menu</h2>

    <a href="dashboard.jsp"><i class="fa fa-chart-line"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-shop"></i> Manage Salons</a>
    <a href="manageVerifyAdmins.jsp"><i class="fa fa-user-shield"></i> Manage Admins</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-nurse"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="user-dashboard.jsp"><i class="fa fa-users"></i> Users</a>
    <a href="feedback.jsp"><i class="fa fa-comments"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-pie"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>

</div>

<!-- CONTENT -->
<div class="content">

<h2><i class="fa fa-plus-circle"></i> Add New Salon</h2>
<form method="post" action="AddSalonServlet" enctype="multipart/form-data">
<input type="text" name="name" placeholder="Salon Name" required>
<input type="text" name="email" placeholder="Email">
<input type="text" name="phone" placeholder="Phone">
<input type="text" name="address" placeholder="Address">
<input type="file" name="image" required>
<button type="submit"><i class="fa fa-save"></i> Add</button>
</form>

<h2><i class="fa fa-shop"></i> All Salons</h2>

<%
SalonDAO salonDAO=new SalonDAO();
ServiceDAO serviceDAO=new ServiceDAO();
List<Salon> salons=salonDAO.getAllSalons();

for(Salon s:salons){
s.setServices(serviceDAO.getServicesBySalon(s.getId()));
%>

<table>
<tr>
<td rowspan="2" style="width:100px;">
<% if(s.getImage()!=null){ %>
<img src="SalonImageServlet?id=<%=s.getId()%>" width="80" height="80">
<% } %>
</td>

<td><b style="color:#FFD700;"><%=s.getName()%></b></td>
<td><%=s.getEmail()%></td>
<td><%=s.getPhone()%></td>
<td><%=s.getAddress()%></td>

<td>
<a href="EditSalonServlet?id=<%=s.getId()%>"><i class="fa fa-edit"></i></a>
<a href="DeleteSalonServlet?id=<%=s.getId()%>" onclick="return confirm('Delete?')"><i class="fa fa-trash"></i></a>
<a href="javascript:void(0)" onclick="toggleServiceForm(<%=s.getId()%>)"><i class="fa fa-scissors"></i></a>
</td>
</tr>

<tr>
<td colspan="5">

<div id="serviceForm-<%=s.getId()%>" style="display:none">

<h4 style="color:#FFD700;"><i class="fa fa-cut"></i> Services</h4>

<form method="post" action="AddServiceServlet">
<input type="hidden" name="salonId" value="<%=s.getId()%>">
<input type="text" name="name" placeholder="Service Name" required>
<input type="text" name="description" placeholder="Description">
<input type="number" name="price" placeholder="Price" step="0.01" required>
<input type="number" name="durationMinutes" placeholder="Duration" required>
<button type="submit"><i class="fa fa-plus"></i></button>
</form>

<table class="service-table">
<tr>
<th>Name</th>
<th>Price</th>
<th>Duration</th>
<th>Action</th>
</tr>

<% if(s.getServices()!=null){
for(Service srv:s.getServices()){ %>

<tr>
<td><%=srv.getName()%></td>
<td>₹<%=srv.getPrice()%></td>
<td><%=srv.getDurationMinutes()%> min</td>
<td>
<a href="EditServiceServlet?id=<%=srv.getId()%>"><i class="fa fa-edit"></i></a>
<a href="DeleteServiceServlet?id=<%=srv.getId()%>&salonId=<%=s.getId()%>"><i class="fa fa-trash"></i></a>
</td>
</tr>

<% }} %>

</table>

</div>
</td>
</tr>
</table>

<% } %>

</div>
</div>
</body>
</html>
