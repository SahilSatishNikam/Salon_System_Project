<%@ page import="java.util.*, dao.SalonDAO, model.Salon, model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Search Salons | SalonEase</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* ===== GLOBAL ===== */
body {
    margin:0;
    min-height:100vh;
    background:#000;
    font-family:'Segoe UI', sans-serif;
    color:#fff;
}
.container-fluid {
    display:flex;
    padding:0;
}

/* ===== SIDEBAR ===== */
.sidebar {
    width:250px;
    background:#000;
    min-height:100vh;
    position:fixed;
    border-right:2px solid #F5A927;
    padding-top:15px;
}
.sidebar h2 {
    text-align:center;
    color:#F5A927;
    font-weight:600;
    border-bottom:1px solid #222;
    font-size:1.3rem;
    padding-bottom:10px;
      padding:20px 0px;
}
.sidebar-profile {
    text-align:center;
    margin:20px 0;
}
.sidebar-profile img {
    width:70px;
    height:70px;
    border-radius:50%;
    border:2px solid #F5A927;
    box-shadow:0 0 8px #F5A927;
}
.sidebar-profile h5 {
    color:#F5A927;
    margin-top:10px;
}
.sidebar-profile p {
    color:#fff;
    font-size:0.9rem;
}
.sidebar a {
    display:flex;
    align-items:center;
    color:#fff;
    padding:14px 22px;
    text-decoration:none;
    border-bottom:1px solid #111;
    font-weight:500;
    font-size:19px;
    transition:0.3s;
}
.sidebar a i {
    margin-right:12px;
    font-size:1.1rem;
}
.sidebar a:hover,
.sidebar a.active {
    background:#F5A927;
    color:#000;
    padding-left:28px;
    box-shadow:0 0 8px #F5A927;
}

/* ===== MAIN CONTENT ===== */
.main {
    flex:1;
    margin-left:250px;
    padding:40px;
    background:radial-gradient(circle at top,#111,#000);
}

/* Page Title */
.page-title {
    text-align:center;
    color:#F5A927;
    font-weight:700;
    letter-spacing:1px;
    margin-bottom:40px;
    text-shadow:0 0 6px #F5A927;
}

/* ===== SEARCH BOX ===== */
.search-box {
    background:#0c0c0c;
    padding:35px 30px;
    border-radius:28px;
    border:1px solid #F5A927;
    max-width:900px;
    margin:0 auto 50px auto;
    box-shadow:0 0 25px rgba(245,169,39,.35);
    position:relative;
}
.input-box { position:relative; }
.input-box i {
    position:absolute;
    top:50%;
    left:18px;
    transform:translateY(-50%);
    color:#F5A927;
}
.search-box input {
    padding:12px 20px 12px 45px;
    background:#000;
    border:1px solid #F5A927;
    border-radius:35px;
    color:#fff;
}
.search-box input:focus {
    border-color:#F5A927;
    box-shadow:0 0 15px rgba(245,169,39,.9);
}
.search-btn {
    border:none;
    border-radius:35px;
    padding:12px;
    font-weight:700;
    background:linear-gradient(135deg,#F5A927,#FFD166);
    color:#000;
}

/* ===== SALON CARDS ===== */
.card-container {
    display:grid;
    grid-template-columns: repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
    margin-top:30px;
}
.card-salon {
    background:#0b0b0b;
    border:1px solid #F5A927;
    border-radius:20px;
    overflow:hidden;
    box-shadow:0 0 25px rgba(245,169,39,.25);
    transition: transform 0.3s, box-shadow 0.3s;
}
.card-salon:hover {
    transform: scale(1.03);
    box-shadow:0 0 35px rgba(245,169,39,.5);
}
.card-salon img {
    width:100%;
    height:180px;
    object-fit:cover;
}
.card-body {
    padding:15px 20px;
}
.card-body h5 {
    color:#F5A927;
    margin-bottom:10px;
    font-size:1.2rem;
    text-shadow:0 0 4px #F5A927;
}
.card-body p {
    font-size:0.9rem;
    color:#fff;
    margin-bottom:5px;
}
.btn-group {
    margin-top:10px;
}
.btn-gold {
    background:linear-gradient(135deg,#F5A927,#FFD166);
    color:#000;
    border:none;
    border-radius:25px;
    padding:6px 15px;
    font-weight:600;
    margin-right:8px;
    text-decoration:none;
    box-shadow:0 0 8px #F5A927;
}
.btn-outline {
    border:1px solid #F5A927;
    border-radius:25px;
    padding:6px 15px;
    color:#F5A927;
    text-decoration:none;
}
.btn-outline:hover {
    background:#F5A927;
    color:#000;
}

/* ===== RESPONSIVE ===== */
@media(max-width:768px) {
    .container-fluid { flex-direction:column; }
    .sidebar { width:100%; min-height:auto; }
    .main { margin-left:0; padding:20px; }
}
</style>
</head>

<body>
<div class="container-fluid">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <h2>User Dashboard</h2>
        <a href="user-dashboard.jsp"><i class="fa fa-chart-line"></i> Dashboard</a>
        <a href="search-salons.jsp" class="active"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
        <a href="myAppointments.jsp"><i class="fa fa-calendar"></i> My Appointments</a>
        <a href="user-feedback.jsp"><i class="fa fa-star"></i> Feedback</a>
        <a href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
        <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>

    <!-- MAIN -->
    <div class="main">
        <h2 class="page-title">
            <i class="fa fa-scissors"></i> Find Your Perfect Salon
        </h2>

        <!-- SEARCH BOX -->
        <div class="search-box">
            <form method="get" action="search-salons.jsp" class="row g-4 justify-content-center">
                <div class="col-md-4 input-box">
                    <i class="fa fa-store"></i>
                    <input type="text" name="name" class="form-control" placeholder="Salon Name">
                </div>
                <div class="col-md-4 input-box">
                    <i class="fa fa-location-dot"></i>
                    <input type="text" name="location" class="form-control" placeholder="Location">
                </div>
                <div class="col-md-2">
                    <button class="search-btn w-100"><i class="fa fa-magnifying-glass"></i> Search</button>
                </div>
            </form>
        </div>

        <!-- SALON CARDS -->
        <div class="card-container">
        <%
            SalonDAO salonDAO = new SalonDAO();
            List<Salon> salons = salonDAO.getAllSalons();
            for(Salon s: salons){
        %>
            <div class="card-salon">
                <img src="SalonImageServlet?id=<%=s.getId()%>" alt="Salon Image">
                <div class="card-body">
                    <h5><%= s.getName() %></h5>
                    <p><b>Location:</b> <%= s.getAddress() %></p>
                    <p><b>Phone:</b> <%= s.getPhone() %></p>
                    <div class="btn-group">
                        <a href="<%= request.getContextPath() %>/BookAppointmentServlet?salonId=<%= s.getId() %>" class="btn btn-warning"> Book Now</a>
                        <a href="salon-details.jsp?salonId=<%=s.getId()%>" class="btn-outline">Explore</a>
                    </div>
                </div>
            </div>
        <% } %>
        </div>
    </div>

</div>
</body>
</html>
