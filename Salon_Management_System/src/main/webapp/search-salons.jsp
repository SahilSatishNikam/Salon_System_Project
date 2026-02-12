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

/* =========================================
   SIDEBAR CONTAINER
========================================= */
.sidebar{
    width:260px;
    height:100vh;
    position:fixed;
    top:0;
    left:0;
    background:linear-gradient(180deg,#0b0b0b,#111);
    border-right:1px solid #1a1a1a;
    backdrop-filter:blur(6px);
    padding-top:10px;
    overflow:hidden;

    display:flex;
    flex-direction:column;
    justify-content:space-between;

    animation:sidebarSlide 0.8s ease;
}

/* Golden vertical glow line */
.sidebar::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:3px;
    height:100%;
    background:linear-gradient(to bottom,#d4af37,#ffd700,#d4af37);
    box-shadow:0 0 15px #d4af37;
}

/* =========================================
   TOP SECTION (LOGO + MENU)
========================================= */
.sidebar-top{
    display:flex;
    flex-direction:column;
}

/* Logo */
.logo{
    padding:26px 22px;
    display:flex;
    align-items:center;
    gap:10px;
}

.logo-img{
    width:30px;
    filter:drop-shadow(0 0 6px #c9a227);
    transition:0.4s;
}

.logo:hover .logo-img{
    transform:rotate(10deg) scale(1.1);
}

.s1{
    color:#ffffff;
    font-weight:bold;
    font-size:19px;
}

.s2{
    color:#c9a227;
    font-size:19px;
}

/* =========================================
   MENU LINKS
========================================= */
.sidebar a{
    position:relative;
    display:flex;
    align-items:center;
    padding:16px 26px;
    margin:6px 10px;
    border-radius:14px;
    font-size:17px;
    color:#ffffff;
    text-decoration:none;
    transition:all 0.4s ease;
    overflow:hidden;
}

/* Hover golden background animation */
.sidebar a::before{
    content:"";
    position:absolute;
    left:0;
    top:0;
    height:100%;
    width:0;
    background:linear-gradient(to right,#c9a227,#ffd700);
    opacity:0.15;
    transition:0.4s ease;
}

.sidebar a:hover::before{
    width:100%;
}

/* Icon */
.sidebar a i{
    margin-right:14px;
    color:#ffffff;
    transition:0.4s ease;
}

/* Hover Effect */
.sidebar a:hover{
    color:#ffd700;
    transform:translateX(8px);
}

.sidebar a:hover i{
    color:#ffd700;
    transform:scale(1.2);
}

/* =========================================
   ACTIVE MENU ITEM
========================================= */
.sidebar a.active{
    color:#ffd700;
    background:rgba(201,162,39,0.15);
    border-right:4px solid #ffd700;

    box-shadow:
        0 0 12px rgba(201,162,39,0.4),
        inset 0 0 10px rgba(201,162,39,0.3);

    animation:activePulse 2s infinite;
}

/* =========================================
   LOGOUT BUTTON (BOTTOM)
========================================= */
.logout{
    margin:20px 10px;
    padding:16px;
    border-radius:14px;
    font-size:17px;
    font-weight:bold;

    display:flex;
    align-items:center;
    justify-content:center;

    background:linear-gradient(145deg,#2a0000,#110000);
    border:1px solid rgba(255,80,80,0.4);
    color:#ffdddd;

    transition:all 0.4s ease;
    text-decoration:none;
}

.logout i{
    margin-right:12px;
    color:#ff6b6b;
    transition:0.4s;
}

.logout:hover{
    background:linear-gradient(145deg,#5a0000,#2a0000);
    color:#ffffff;
    transform:translateY(-4px);

    box-shadow:
        0 0 20px rgba(255,80,80,0.6),
        inset 0 0 10px rgba(255,100,100,0.3);
}

.logout:hover i{
    color:#ffffff;
    transform:rotate(-10deg) scale(1.2);
}

/* =========================================
   ANIMATIONS
========================================= */

/* Sidebar Slide */
@keyframes sidebarSlide{
    from{
        transform:translateX(-100%);
        opacity:0;
    }
    to{
        transform:translateX(0);
        opacity:1;
    }
}

/* Active Glow Pulse */
@keyframes activePulse{
    0%,100%{
        box-shadow:
        0 0 10px rgba(201,162,39,0.3),
        inset 0 0 8px rgba(201,162,39,0.2);
    }
    50%{
        box-shadow:
        0 0 20px rgba(255,215,0,0.6),
        inset 0 0 12px rgba(255,215,0,0.4);
    }
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
    text-align: center;
    color: #FFD700; /* golden color */
    font-weight: 700;
    letter-spacing: 1px;
    margin-bottom: 40px;
    text-shadow: 0 0 6px #FFD700; /* golden glow */
}

/* ===== SEARCH BOX ===== */
.search-box {
    background: #0c0c0c; /* dark background stays */
    padding: 35px 30px;
    border-radius: 28px;
    border: 1px solid #FFD700; /* golden border */
    max-width: 900px;
    margin: 0 auto 50px auto;
    box-shadow: 0 0 25px rgba(255, 215, 0, 0.35); /* golden glow */
    position: relative;
}

.input-box { 
    position: relative; 
}

.input-box i {
    position: absolute;
    top: 50%;
    left: 18px;
    transform: translateY(-50%);
    color: #FFD700; /* golden icon */
}

.search-box input {
    padding: 12px 20px 12px 45px;
    background: #000; /* dark background stays */
    border: 1px solid #FFD700; /* golden border */
    border-radius: 35px;
    color: #fff;
}

.search-box input:focus {
    border-color: #FFD700; /* golden focus border */
    box-shadow: 0 0 15px rgba(255, 215, 0, 0.9); /* golden glow */
}

.search-btn {
    border: none;
    border-radius: 35px;
    padding: 12px;
    font-weight: 700;
    background: linear-gradient(135deg, #FFD700, #FFC107); /* golden gradient button */
    color: #000; /* text color stays black for contrast */
    cursor: pointer;
    transition: 0.3s;
}

.search-btn:hover {
    box-shadow: 0 0 15px rgba(255, 215, 0, 0.8); /* golden hover glow */
}

/* ===== SALON CARDS ===== */
.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 25px;
    margin-top: 30px;
}

.card-salon {
    background: #0b0b0b; /* dark card background */
    border: 1px solid #FFD700; /* golden border */
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 0 25px rgba(255, 215, 0, 0.25); /* golden shadow */
    transition: transform 0.3s, box-shadow 0.3s;
}

.card-salon:hover {
    transform: scale(1.03);
    box-shadow: 0 0 35px rgba(255, 215, 0, 0.5); /* golden hover glow */
}

.card-salon img {
    width: 100%;
    height: 180px;
    object-fit: cover;
}

.card-body {
    padding: 15px 20px;
}

.card-body h5 {
    color: #FFD700; /* golden title */
    margin-bottom: 10px;
    font-size: 1.2rem;
    text-shadow: 0 0 4px #FFD700; /* subtle golden glow */
}

.card-body p {
    font-size: 0.9rem;
    color: #fff; /* text stays white */
    margin-bottom: 5px;
}

.btn-group {
    margin-top: 10px;
}

/* Solid Golden Button */
.btn-gold {
    background: linear-gradient(135deg, #FFD700, #FFC107); /* golden gradient */
    color: #000;
    border: none;
    border-radius: 25px;
    padding: 6px 15px;
    font-weight: 600;
    margin-right: 8px;
    text-decoration: none;
    box-shadow: 0 0 8px #FFD700; /* golden glow */
    transition: 0.3s;
}

.btn-gold:hover {
    box-shadow: 0 0 15px #FFD700; /* stronger golden glow on hover */
}

/* Outline Golden Button */
.btn-outline {
    border: 1px solid #FFD700;
    border-radius: 25px;
    padding: 6px 15px;
    color: #FFD700;
    text-decoration: none;
    transition: 0.3s;
}

.btn-outline:hover {
    background: #FFD700;
    color: #000; /* black text on hover for contrast */
}

/* ===== RESPONSIVE ===== */
@media(max-width:768px) {
    .container-fluid { flex-direction:column; }
    .sidebar { width:100%; min-height:auto; }
    .main { margin-left:0; padding:20px; }
}

.dashboard-title {
    display: flex;
    align-items: center;
    font-size: 28px; /* heading size */
    color: #ffd700; /* golden text */
    font-weight: bold;
    font-family: "Times New Roman", Times, serif; /* serif font added */
}

.dashboard-icon {
    font-size: 34px; /* thoda motha icon */
    color: #ffd700; /* gold color */
    margin-right: 12px; /* text la thoda gap */
}
</style>
</head>

<body>
<div class="container-fluid">

    <!-- SIDEBAR -->
    <div class="sidebar">
       <h2 class="dashboard-title">
    <i class="fa-solid fa-gem dashboard-icon"></i>
    User Dashboard
</h2>
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
                        <a href="BookAppointmentServlet?salonId=<%=s.getId()%>" class="btn-gold">Book Now</a>
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
