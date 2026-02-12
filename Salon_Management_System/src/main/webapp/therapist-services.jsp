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
/* ===============================
   GLOBAL
================================= */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:"Times New Roman", Times, serif;
}

body{
    background:#000;
    color:#F5A927;
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

/* ===============================
   MAIN SECTION
================================= */
.main{
    margin-left:260px;
    padding:40px;
    min-height:100vh;
    background:linear-gradient(135deg,#0f0f0f,#1a1a1a);
}

/* ===============================
   PAGE TITLE
================================= */
.page-title{
    text-align:center;
    color:#d4af37;
    font-weight:bold;
    margin-bottom:40px;
    letter-spacing:1px;
    animation:fadeDown 0.8s ease;
}

/* ===============================
   SERVICE CARD
================================= */
.service-card{
    background:#111;
    border-radius:16px;
    padding:25px;
    color:#eee;
    transition:0.4s ease;
    border:1px solid rgba(212,175,55,0.2);
    box-shadow:0 8px 20px rgba(0,0,0,0.4);
    height:100%;
    animation:fadeUp 0.8s ease;
}

.service-card:hover{
    transform:translateY(-10px);
    box-shadow:0 15px 35px rgba(212,175,55,0.4);
    border:1px solid #d4af37;
}

/* ===============================
   SERVICE CONTENT
================================= */
.service-name{
    font-size:20px;
    font-weight:bold;
    color:#d4af37;
    margin-bottom:10px;
}

.service-desc{
    font-size:15px;
    color:#ccc;
    min-height:50px;
    margin-bottom:10px;
}

.badge-gold{
    background:linear-gradient(45deg,#b8860b,#d4af37);
    color:#000;
    padding:6px 14px;
    border-radius:20px;
    font-size:14px;
    font-weight:bold;
}

.price{
    font-size:22px;
    font-weight:bold;
    margin-top:15px;
    color:#fff;
}

/* ===============================
   EMPTY BOX
================================= */
.empty-box{
    background:#111;
    padding:40px;
    border-radius:15px;
    text-align:center;
    border:1px dashed #d4af37;
    color:#ccc;
}

/* ===============================
   ANIMATIONS
================================= */
@keyframes fadeUp{
    from{
        opacity:0;
        transform:translateY(30px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

@keyframes fadeDown{
    from{
        opacity:0;
        transform:translateY(-20px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

@keyframes sidebarSlide{
    from{
        transform:translateX(-100%);
    }
    to{
        transform:translateX(0);
    }
}

/* ===============================
   RESPONSIVE
================================= */
@media(max-width:992px){
    .sidebar{
        width:220px;
    }
    .main{
        margin-left:220px;
    }
}

@media(max-width:768px){
    .sidebar{
        position:relative;
        width:100%;
        height:auto;
    }
    .main{
        margin-left:0;
    }
}

</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2>Therapist Panel</h2>

    <a href="TherapistDashboardServlet">
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
