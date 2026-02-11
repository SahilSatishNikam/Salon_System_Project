<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Manage Salons | Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:linear-gradient(135deg,#0f0f0f,#1a1a1a);
    color:#fff;
    display:flex;
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
    font-size:18px;
}
.sidebar a i{margin-right:12px;}
.sidebar a:hover,.sidebar a.active{
    background:#FFD700;
    color:#000;
    padding-left:28px;
}

/* ===== MAIN ===== */
.main-content{
    margin-left:250px;
    padding:40px;
    width:calc(100% - 250px);
}

/* FORM */
.salon-form{
    background:rgba(20,20,20,0.7);
    padding:30px;
    border-radius:20px;
    border:2px solid #FFD700;
    max-width:900px;
}
.salon-form h3{
    text-align:center;
    color:#FFD700;
    margin-bottom:20px;
}
.salon-form input{
    background:#111;
    border:2px solid #FFD700;
    color:#fff;
    border-radius:10px;
    padding:10px;
}
.salon-form input:focus{
    box-shadow:0 0 10px #FFD700;
}
.salon-form button{
    width:100%;
    padding:12px;
    font-weight:700;
    background:linear-gradient(45deg,#FFD700,#ffea00);
    border:none;
    border-radius:10px;
    color:#000;
}

/* CARD */
.card.bg-dark{
    border-radius:20px;
    border:2px solid transparent;
    transition:.3s;
}
.card.bg-dark:hover{
    transform:scale(1.05);
    border:2px solid #FFD700;
    box-shadow:0 0 25px rgba(255,215,0,.5);
}
.card-img-top{
    height:220px;
    object-fit:cover;
    border-bottom:2px solid #FFD700;
}
.card-title{color:#FFD700;}
.actions a{
    font-size:22px;
    color:#FFD700;
}
.actions a:hover{color:#fff;}
</style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2><i class="bi bi-scissors"></i> SalonEase</h2>
    <a href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="manage-salons.jsp" class="active"><i class="bi bi-shop"></i> Manage Salons</a>
    <a href="AdminTherapistServlet"><i class="bi bi-person"></i> Therapists</a>
    <a href="AdminAppointmentServlet"><i class="bi bi-calendar"></i> Appointments</a>
    <a href="feedback.jsp"><i class="bi bi-chat"></i> Feedback</a>
    <a href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

<div class="main-content">

<!-- ADD SALON -->
<form method="post" action="AddSalonServlet" enctype="multipart/form-data" class="salon-form">
<h3><i class="bi bi-plus-circle"></i> Add Salon</h3>

<div class="row g-3">
<div class="col-md-6">
<input type="text" name="name" class="form-control" placeholder="Salon Name" required>
</div>
<div class="col-md-6">
<input type="text" name="email" class="form-control" placeholder="Email">
</div>
<div class="col-md-6">
<input type="text" name="phone" class="form-control" placeholder="Phone">
</div>
<div class="col-md-6">
<input type="text" name="address" class="form-control" placeholder="Address">
</div>
<div class="col-12">
<input type="file" name="image" class="form-control" required>
</div>
<div class="col-12">
<button type="submit"><i class="bi bi-save"></i> Add Salon</button>
</div>
</div>
</form>

<!-- LIST -->
<h2 style="margin-top:50px; margin-bottom:30px;"><i class="bi bi-shop" style="color:yellow;padding-right:6px;" ></i>All Salons</h2>

<div class="row g-4">
<%
SalonDAO salonDAO=new SalonDAO();
ServiceDAO serviceDAO=new ServiceDAO();
List<Salon> salons=salonDAO.getAllSalons();

for(Salon s:salons){
s.setServices(serviceDAO.getServicesBySalon(s.getId()));
%>

<div class="col-lg-4">
<div class="card bg-dark text-white h-100">

<% if(s.getImage()!=null){ %>
<img src="SalonImageServlet?id=<%=s.getId()%>" class="card-img-top">
<% } %>

<div class="card-body d-flex flex-column">
<h5 class="card-title"><%=s.getName()%></h5>
<p><i class="bi bi-envelope"></i> <%=s.getEmail()%></p>
<p><i class="bi bi-telephone"></i> <%=s.getPhone()%></p>
<p><i class="bi bi-geo-alt"></i> <%=s.getAddress()%></p>

<div class="mt-auto d-flex justify-content-between actions">
<a href="EditSalonServlet?id=<%=s.getId()%>"><i class="bi bi-pencil"></i></a>
<a href="DeleteSalonServlet?id=<%=s.getId()%>" onclick="return confirm('Delete?')">
<i class="bi bi-trash"></i></a>
<a href="#" data-bs-toggle="modal" data-bs-target="#serviceModal-<%=s.getId()%>">
<i class="bi bi-scissors"></i></a>
</div>
</div>
</div>
</div>

<!-- SERVICE MODAL -->
<div class="modal fade" id="serviceModal-<%=s.getId()%>">
<div class="modal-dialog">
<div class="modal-content p-4 bg-dark text-white">
<h5>Add Service</h5>
<form method="post" action="AddServiceServlet">
<input type="hidden" name="salonId" value="<%=s.getId()%>">
<input type="text" name="name" class="form-control mb-2" placeholder="Service Name" required>
<input type="text" name="description" class="form-control mb-2" placeholder="Description">
<input type="number" name="price" class="form-control mb-2" placeholder="Price">
<input type="number" name="durationMinutes" class="form-control mb-2" placeholder="Duration">
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
