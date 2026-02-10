<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.User" %>
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
/* ========== GLOBAL ========== */
body{
    margin:0;
    min-height:100vh;
    background:#000;
    font-family:'Segoe UI',sans-serif;
    color:#fff;
}

.container-fluid{
    display:flex;
    padding:0;
}

/* ========== SIDEBAR ========== */
.sidebar{
    width:260px;
    min-height:100vh;
    background:linear-gradient(180deg,#0f0f0f,#1a1a1a);
    border-right:2px solid #ffd700;
    padding:25px 20px;
}

.sidebar-profile{
    text-align:center;
    border-bottom:1px solid #444;
    padding-bottom:15px;
    margin-bottom:20px;
}

.sidebar-profile img{
    width:70px;
    height:70px;
    border-radius:50%;
    border:2px solid #ffd700;
}

.sidebar-profile h5{
    color:#ffd700;
    margin-top:10px;
}

.sidebar-menu a{
    display:flex;
    align-items:center;
    padding:12px 15px;
    margin:6px 0;
    color:#fff;
    text-decoration:none;
    border-radius:12px;
    transition:.3s;
}

.sidebar-menu a i{
    margin-right:12px;
}

.sidebar-menu a:hover,
.sidebar-menu a.active{
    background:#ffd700;
    color:#000;
}

/* ========== MAIN CONTENT ========== */
.main{
    flex:1;
    padding:40px;
    background:radial-gradient(circle at top,#111,#000);
}

/* ---------- YOUR EXISTING STYLES ---------- */

/* Title */
.page-title{
    text-align:center;
    color:#ffd700;
    font-weight:700;
    letter-spacing:1px;
    margin-bottom:40px;
}

/* Search box */
.search-box{
    background:#0c0c0c;
    padding:35px 30px;
    border-radius:28px;
    border:1px solid #d4af37;
    max-width:900px;
    margin:0 auto 50px auto;
    box-shadow:0 0 25px rgba(212,175,55,.35);
    position:relative;
    overflow:hidden;
}

/* Inputs */
.input-box{ position:relative; }
.input-box i{
    position:absolute;
    top:50%;
    left:18px;
    transform:translateY(-50%);
    color:#ffd700;
}
.search-box input{
    padding:12px 20px 12px 45px;
    background:#000;
    border:1px solid #d4af37;
    border-radius:35px;
    color:#fff;
}
.search-box input:focus{
    border-color:#ffd700;
    box-shadow:0 0 15px rgba(255,215,0,.9);
}

/* Button */
.search-btn{
    border:none;
    border-radius:35px;
    padding:12px;
    font-weight:700;
    background:linear-gradient(135deg,#d4af37,#ffd700);
    color:#000;
}

/* Salon card */
.salon-card{
    background:#0b0b0b;
    border-radius:25px;
    padding:20px;
    margin-bottom:30px;
    display:flex;
    gap:20px;
    align-items:center;
    border:1px solid rgba(212,175,55,.4);
    box-shadow:0 0 30px rgba(212,175,55,.25);
}
.salon-card img{
    width:150px;
    height:150px;
    border-radius:18px;
    border:3px solid #d4af37;
}
.salon-card h3{ color:#ffd700; }
.rating i{ color:#ffd700; }

/* Buttons */
.gold-btn{
    padding:9px 20px;
    border-radius:30px;
    background:linear-gradient(135deg,#d4af37,#ffd700);
    color:#000;
    font-weight:600;
    text-decoration:none;
}
.outline-btn{
    padding:9px 20px;
    border-radius:30px;
    border:1px solid #ffd700;
    color:#ffd700;
    text-decoration:none;
    margin-left:10px;
}
.outline-btn:hover{
    background:#ffd700;
    color:#000;
}

@media(max-width:768px){
    .container-fluid{ flex-direction:column; }
    .sidebar{ width:100%; min-height:auto; }
    .salon-card{ flex-direction:column; text-align:center; }
}
</style>
</head>

<body>

<div class="container-fluid">

    <!-- SIDEBAR -->
    <div class="sidebar">
       
        <div class="sidebar-menu">
            <a href="dashboard.jsp"><i class="fa fa-chart-line"></i> Dashboard</a>
            <a href="search-salons.jsp" class="active"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
            <a href="myAppointments.jsp"><i class="fa fa-calendar"></i> My Appointments</a>
            <a href="user-feedback.jsp"><i class="fa fa-star"></i> Feedback</a>
            <a href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
            <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>

    <!-- MAIN -->
    <div class="main">

        <h2 class="page-title">
            <i class="fa fa-scissors"></i> Find Your Perfect Salon
        </h2>

        <!-- SEARCH -->
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
                    <button class="search-btn w-100">
                        <i class="fa fa-magnifying-glass"></i> Search
                    </button>
                </div>
            </form>
        </div>

        <%
        SalonDAO salonDAO = new SalonDAO();
        List<Salon> salons = salonDAO.getAllSalons();
        for(Salon s: salons){
        %>

        <div class="salon-card">
            <img src="SalonImageServlet?id=<%=s.getId()%>">
            <div>
                <h3><%=s.getName()%></h3>
                <p><b>Location:</b> <%=s.getAddress()%></p>
                <p><b>Phone:</b> <%=s.getPhone()%></p>

                <a href="BookAppointmentServlet?salonId=<%=s.getId()%>" class="gold-btn">Book Now</a>
                <a href="salon-details.jsp?salonId=<%=s.getId()%>" class="outline-btn">Explore</a>
            </div>
        </div>

        <% } %>

    </div>
</div>

</body>
</html>
