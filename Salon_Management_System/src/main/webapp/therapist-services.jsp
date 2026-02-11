<%@ page import="java.util.*, model.Service, model.Therapist" %>
<%
List<Service> list = (List<Service>) request.getAttribute("services");
Therapist t = (Therapist) session.getAttribute("therapist");
if(t == null){ response.sendRedirect("login.jsp"); return; }
%>

<!DOCTYPE html>
<html>
<head>
<title>Therapist Services</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>

/* ===== BODY ===== */
body{
    margin:0;
    background:#000;
    font-family:'Segoe UI', sans-serif;
    color:#F5A927;
}

/* ===== SIDEBAR ===== */
.sidebar{
    width:250px;
    background:#111;
    min-height:100vh;
    position:fixed;
    border-right:2px solid #F5A927;
}

.sidebar h2{
    text-align:center;
    padding:20px;
    font-weight:800;
    text-shadow:0 0 10px #F5A927;
}

.sidebar a{
    display:flex;
    align-items:center;
    gap:10px;
    padding:14px 22px;
    color:#fff;
    text-decoration:none;
    border-bottom:1px solid #222;
    transition:0.3s;
}

.sidebar a:hover{
    background:#F5A927;
    color:#000;
    padding-left:28px;
    box-shadow:0 0 12px #F5A927;
}

.sidebar a.active{
    background:#F5A927;
    color:#000;
}

/* ===== MAIN ===== */
.main{
    margin-left:250px;
    padding:40px;
}

/* ===== HEADER ===== */
.page-title{
    font-weight:800;
    margin-bottom:30px;
    text-shadow:0 0 12px #F5A927;
}

/* ===== SERVICE CARD ===== */
.service-card{
    background:#111;
    border:1px solid #F5A927;
    border-radius:18px;
    padding:22px;
    height:100%;
    transition:0.35s;
    box-shadow:0 0 20px rgba(245,169,39,0.15);
    position:relative;
    overflow:hidden;
}

.service-card:hover{
    transform:translateY(-8px) scale(1.02);
    box-shadow:0 0 35px rgba(245,169,39,0.45);
}

/* glow line */
.service-card::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:4px;
    background:#F5A927;
}

/* ===== TEXT ===== */
.service-name{
    font-size:20px;
    font-weight:700;
    color:#F5A927;
}

.service-desc{
    color:#bbb;
    margin-top:10px;
    min-height:60px;
}

/* ===== BADGES ===== */
.badge-gold{
    background:#F5A927;
    color:#000;
    font-weight:600;
    padding:6px 10px;
    border-radius:8px;
}

/* ===== PRICE ===== */
.price{
    font-size:22px;
    font-weight:800;
    margin-top:12px;
    color:#F5A927;
    text-shadow:0 0 8px rgba(245,169,39,0.6);
}

/* ===== EMPTY ===== */
.empty-box{
    background:#111;
    border:1px dashed #F5A927;
    padding:30px;
    border-radius:14px;
    text-align:center;
    color:#aaa;
    box-shadow:0 0 15px rgba(245,169,39,0.15);
}

</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2>Therapist Panel</h2>

    <a href="therapistDashboard.jsp">
        <i class="fa fa-chart-line"></i> Dashboard
    </a>

    <a href="therapistAvailability.jsp">
        <i class="fa fa-clock"></i> Availability
    </a>

    <a class="active" href="therapist-services?salonId=<%=t.getSalonId()%>">
        <i class="fa fa-spa"></i> Services
    </a>

    <a href="TherapistAppointmentServlet">
        <i class="fa fa-calendar"></i> Appointments
    </a>

    <a href="editTherapistProfile.jsp">
        <i class="fa fa-user"></i> Profile
    </a>

    <a href="LogoutServlet">
        <i class="fa fa-sign-out-alt"></i> Logout
    </a>
</div>

<!-- ===== MAIN ===== -->
<div class="main">

<h2 class="page-title">
    <i class="fa fa-spa"></i> Available Services
</h2>

<div class="row">

<% if(list != null && !list.isEmpty()) {
   for(Service s : list) { %>

<div class="col-md-4 mb-4">

<div class="service-card">

<div class="service-name">
    <i class="fa fa-scissors"></i>
    <%= s.getName() %>
</div>

<div class="service-desc">
    <%= s.getDescription() %>
</div>

<div class="mt-3">
    <span class="badge-gold">
        <i class="fa fa-hourglass-half"></i>
        <%= s.getDurationMinutes() %> mins
    </span>
</div>

<div class="price">
    Rs <%= s.getPrice() %>
</div>

</div>
</div>

<% }} else { %>

<div class="col-12">
    <div class="empty-box">
        <i class="fa fa-info-circle fa-2x mb-2"></i>
        <h5>No services available for this salon</h5>
        <p>Services will appear here once added by admin.</p>
    </div>
</div>

<% } %>

</div>
</div>

</body>
</html>
