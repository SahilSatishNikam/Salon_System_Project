<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Salons</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Poppins;
    background:#0f0f0f;
    color:#fff;
}

/* ===== SIDEBAR ===== */
.sidebar{
    width:250px;
    position:fixed;
    height:100vh;
    background:#000;
    border-right:2px solid #FFD700;
}

.sidebar h2{
    text-align:center;
    padding:20px;
    color:#FFD700;
}

.sidebar a{
    display:flex;
    align-items:center;
    padding:15px 25px;
    color:#fff;
    text-decoration:none;
}

.sidebar a:hover,
.sidebar a.active{
    background:#FFD700;
    color:#000;
}

/* ===== MAIN ===== */
.main-content{
    margin-left:250px;
    padding:40px;
}

/* FORM */
.salon-form{
    background:#111;
    padding:30px;
    border-radius:20px;
    border:2px solid #FFD700;
    margin-bottom:40px;
}

.salon-form input{
    margin-bottom:15px;
}

/* CARD */
.card{
    border-radius:20px;
    background:#111;
    border:2px solid #FFD700;
}

.card p{
    color:#ffffff;
    font-size:14px;
    margin-top:6px;
    opacity:0.9;
}
/* ===============================
   CARD ICON STYLE (VISIBLE)
================================ */
.card i{
    font-size:15px;
    

    /* GOLD ICON */
    color:#ffd700;

    /* glow */
    text-shadow:0 0 10px rgba(255,215,0,0.6);

    /* circle background */
    background:rgba(255,215,0,0.08);
   
    border-radius:12px;

    display:inline-block;
}

/* hover animation */
.card:hover i{
    transform:scale(1.15) rotate(5deg);
    color:#ffffff;

    box-shadow:0 0 20px rgba(255,215,0,0.6);
    background:linear-gradient(145deg,#c9a227,#ffd700);
}

</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
<h2>SalonEase Admin</h2>

<a href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
<a class="active" href="manage-salons.jsp"><i class="bi bi-shop"></i> Manage Salons</a>
<a href="visitedClients"><i class="bi bi-people"></i> Clients</a>
<a href="AdminTherapistServlet"><i class="bi bi-person"></i> Therapists</a>
<a href="AdminAppointmentServlet"><i class="bi bi-calendar-check"></i> Appointments</a>
<a href="feedback.jsp"><i class="bi bi-chat"></i> Feedback</a>
<a href="reports.jsp"><i class="bi bi-bar-chart"></i> Reports</a>
<a href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main-content">

<!-- ADD SALON -->
<form method="post" action="AddSalonServlet" enctype="multipart/form-data" class="salon-form">
<h3 class="text-warning mb-3">Add New Salon</h3>
<input type="text" name="name" placeholder="Salon Name" class="form-control" required>
<input type="text" name="email" placeholder="Email" class="form-control">
<input type="text" name="phone" placeholder="Phone" class="form-control">
<input type="text" name="address" placeholder="Address" class="form-control">
<input type="file" name="image" class="form-control" required>

<button class="btn btn-warning w-100 mt-2">Add Salon</button>
</form>

<h3 class="text-warning mb-4">All Salons</h3>

<div class="row g-4">

<%
SalonDAO salonDAO = new SalonDAO();
ServiceDAO serviceDAO = new ServiceDAO();
List<Salon> salons = salonDAO.getAllSalons();

for(Salon s : salons){
s.setServices(serviceDAO.getServicesBySalon(s.getId()));
%>

<div class="col-md-4">
<div class="card p-3 h-100">

<% if(s.getImage()!=null){ %>
<img src="SalonImageServlet?id=<%=s.getId()%>" class="img-fluid mb-3" style="border-radius:15px;">
<% } %>

<h5 class="text-warning"><%=s.getName()%></h5>
<p><i class="bi bi-envelope"></i> <%=s.getEmail()%></p>
<p><i class="bi bi-telephone"></i> <%=s.getPhone()%></p>
<p><i class="bi bi-geo-alt"></i> <%=s.getAddress()%></p>

<div class="d-flex justify-content-between mt-3">
<a href="EditSalonServlet?id=<%=s.getId()%>"><i class="bi bi-pencil"></i></a>
<a href="DeleteSalonServlet?id=<%=s.getId()%>" onclick="return confirm('Delete?')">
<i class="bi bi-trash"></i></a>
<a data-bs-toggle="modal" data-bs-target="#serviceModal-<%=s.getId()%>">
<i class="bi bi-scissors"></i></a>
</div>

</div>
</div>

<!-- SERVICE MODAL -->
<div class="modal fade" id="serviceModal-<%=s.getId()%>">
<div class="modal-dialog">
<div class="modal-content p-4">

<form method="post" action="AddServiceServlet">
<input type="hidden" name="salonId" value="<%=s.getId()%>">

<input name="name" class="form-control mb-2" placeholder="Service name" required>
<input name="description" class="form-control mb-2" placeholder="Description">
<input name="price" class="form-control mb-2" placeholder="Price">
<input name="durationMinutes" class="form-control mb-2" placeholder="Duration">

<button class="btn btn-warning w-100">Add Service</button>
</form>

</div>
</div>
</div>

<% } %>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
