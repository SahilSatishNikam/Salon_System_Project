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

/* =====================================
   SIDEBAR
===================================== */
.sidebar{
    width:260px;
    height:100vh;
    position:fixed;
    top:0;
    left:0;
    background:linear-gradient(180deg,#0b0b0b,#111);
    border-right:1px solid #1a1a1a;
    padding-top:25px;
    display:flex;
    flex-direction:column;
}

.sidebar h2{
    text-align:center;
    color:#d4af37;
    margin-bottom:25px;
    font-weight:bold;
    
}

.sidebar a{
    padding:14px 22px;
    margin:6px 14px;
    border-radius:8px;
    text-decoration:none;
    color:#fff;
    font-size:17px;
    transition:0.3s ease;
    display:flex;
    align-items:center;
    font-family: "Times New Roman", Times, serif;
}

.sidebar a i{
    margin-right:12px;
}

.sidebar a:hover{
    background:rgba(212,175,55,0.15);
    color:#ffd700;
    transform:translateX(6px);
}

.sidebar a.active{
    background:rgba(212,175,55,0.2);
    border-right:4px solid #ffd700;
    color:#ffd700;
}

.sidebar a:last-child{
    margin-top:auto;
    margin-bottom:20px;
    background:#2a0000;
}

.sidebar a:last-child:hover{
    background:#5a0000;
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

.page-title {
    text-align: center;
    color: #FFD700; /* bright gold */
    font-family: "Times New Roman", Times, serif; /* Times New Roman font */
    font-weight: 700;
    letter-spacing: 1px;
    margin-bottom: 40px;
    text-shadow: 0 0 6px #FFD700; /* glowing gold effect */
}


.lux-search-wrapper{
    margin:40px 20px;
    padding:30px;
    border-radius:18px;
    background:linear-gradient(180deg,#111,#0a0a0a);
    border:1px solid rgba(255,215,0,0.35);
    box-shadow:0 0 40px rgba(255,215,0,0.25);
    font-family: "Times New Roman", Times, serif;
}

.lux-search-title{
    color:#FFD700;
    font-size:22px;
    margin-bottom:20px;
    letter-spacing:1px;
    font-family: "Times New Roman", Times, serif;
}

.lux-search-bar{
    display:grid;
    grid-template-columns: 1fr 1fr auto;
    gap:20px;
    align-items:center;
    font-family: "Times New Roman", Times, serif;
}

/* Input field */
.lux-field{
    display:flex;
    align-items:center;
    gap:12px;
    padding:16px 18px;
    border-radius:14px;
    background:#0b0b0b;
    border:1px solid rgba(255,215,0,0.4);
}

.lux-field i{
    color:#FFD700;
    font-size:18px;
}

.lux-field input{
    background:none;
    border:none;
    outline:none;
    color:#fff;
    font-size:16px;
    width:100%;
}

/* Button */
.lux-btn{
    padding:16px 30px;
    border-radius:14px;
    border:none;
    background:linear-gradient(135deg,#FFD700,#FFC400);
    color:#000;
    font-size:16px;
    font-weight:600;
    cursor:pointer;
    box-shadow:0 0 20px rgba(255,215,0,0.6);
    transition:0.3s;
}

.lux-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 0 30px rgba(255,215,0,0.9);
}

/* Responsive */
@media(max-width:768px){
    .lux-search-bar{
        grid-template-columns:1fr;
    }
}

/* ===== SALON CARDS ===== */
.card-container {
    display:grid;
    grid-template-columns: repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
    margin-top:30px;
}

.card-salon {
    background:#0b0b0b; /* dark background to highlight gold */
    border:1px solid #FFD700; /* bright gold border */
    border-radius:20px;
    overflow:hidden;
    box-shadow:0 0 25px rgba(255,215,0,0.25); /* gold shadow */
    transition: transform 0.3s, box-shadow 0.3s;
    font-family: "Times New Roman", Times, serif;
}

.card-salon:hover {
    transform: scale(1.03);
    box-shadow:0 0 35px rgba(255,215,0,0.5); /* brighter on hover */
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
    color:#FFD700; /* golden text */
    margin-bottom:10px;
    font-size:1.2rem;
    text-shadow:0 0 4px #FFD700; /* glowing gold */
}

.card-body p {
    font-size:0.9rem;
    color:#fff; /* keep paragraph readable */
    margin-bottom:5px;
}

.btn-group {
    margin-top:10px;
}

.btn-gold {
    background:linear-gradient(135deg,#FFD700,#FFC700); /* golden gradient button */
    color:#000;
    border:none;
    border-radius:25px;
    padding:6px 15px;
    font-weight:600;
    margin-right:8px;
    text-decoration:none;
    box-shadow:0 0 8px #FFD700;
    transition:0.3s;
}

.btn-gold:hover {
    background:linear-gradient(135deg,#FFC700,#FFD700); /* hover effect */
}

.btn-outline {
    border:1px solid #FFD700;
    border-radius:25px;
    padding:6px 15px;
    color:#FFD700;
    text-decoration:none;
    transition:0.3s;
}

.btn-outline:hover {
    background:#FFD700;
    color:#000;
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


</style>
</head>

<body>
<div class="container-fluid">

    <!-- SIDEBAR -->
    <div class="sidebar">
       <h1 class="dashboard-title">
    
    User Dashboard
</h1>
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
        <form action="searchSalon.jsp" method="get">
    <div class="lux-search-wrapper">

        <!-- Search Heading (optional) -->
        <div class="lux-search-title">
            Search Salons
        </div>

        <div class="lux-search-bar">

            <!-- Salon Name -->
            <div class="lux-field">
                <i class="fa fa-store"></i>
                <input type="text" name="salonName"
                       placeholder="Search by salon name">
            </div>

            <!-- Location -->
            <div class="lux-field">
                <i class="fa fa-location-dot"></i>
                <input type="text" name="location"
                       placeholder="Search by location">
            </div>

            <!-- Button -->
            <button class="lux-btn">
                <i class="fa fa-search"></i>
                Search
            </button>

        </div>
    </div>
</form>


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
