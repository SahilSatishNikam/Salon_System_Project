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

.admin-sidebar{
    position:fixed;
    left:0;
    top:0;
    width:250px;
    height:100vh;
    background:linear-gradient(180deg,#0b0b0b,#141414);
    box-shadow:4px 0 22px rgba(255,215,0,.18);
    padding-top:15px;
    z-index:1000;
    font-family:Poppins, sans-serif;
}

/* LOGO */
.admin-sidebar .logo{
    text-align:center;
    color:#FFD700;
    font-size:22px;
    font-weight:700;
    padding:20px 10px;
    border-bottom:1px solid #222;
    margin-bottom:10px;
    letter-spacing:1px;
}

/* LINKS */
.admin-sidebar a{
    display:block;
    padding:14px 22px;
    color:#ddd;
    text-decoration:none;
    font-size:17px;
    transition:.3s;
    border-left:4px solid transparent;
}

.admin-sidebar a i{
    width:26px;
    color:#FFD700;   /* yellow icons */
    transition:.3s;
}

.admin-sidebar a:hover i{
    color:#000;   /* icon becomes black on yellow hover */
}

/* HOVER */
.admin-sidebar a:hover{
    background:#FFD700;
    color:#000;
    border-left:4px solid #fff;
    transform:translateX(6px);
}

/* LOGOUT */
.admin-sidebar .logout{
    margin-top:15px;
    color:#ff6b6b;
}

.admin-sidebar .logout:hover{
    background:#ff6b6b;
    color:#fff;
}

/* ===== PAGE CONTENT SHIFT ===== */
.main-content{
    margin-left:250px;
    padding:25px;
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
