<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.*, dao.*" %>

<%
User user = (User) session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

int userId = user.getId();

AppointmentDAO appointmentDAO = new AppointmentDAO();
SalonDAO salonDAO = new SalonDAO();

List<Appointment> upcoming = new ArrayList<>();
List<Appointment> completed = new ArrayList<>();

try{
    upcoming = appointmentDAO.getUpcomingAppointments(userId);
    completed = appointmentDAO.getCompletedAppointments(userId);
}catch(Exception e){
    out.println("<p style='color:red'>Error: "+e.getMessage()+"</p>");
}

// pending feedback
int pendingFeedback = 0;
for(Appointment a : completed){
    if(!a.isFeedbackGiven()){
        pendingFeedback++;
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* ===============================
   GLOBAL
================================ */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Times New Roman', serif;
    background:#000;
    color:#d4af37;
    overflow-x:hidden;
    animation:fadePage 0.8s ease;
}

@keyframes fadePage{
    from{opacity:0;}
    to{opacity:1;}
}

.container-fluid{
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
   MAIN CONTENT (CENTERED)
================================ */
.main{
    margin-left:260px;
    width:100%;
    min-height:100vh;
    padding:40px;

    display:flex;
    flex-direction:column;
    align-items:center;
}

.main h2{
    font-size:28px;
    margin-bottom:30px;
    color:#ffd700;
    text-align:center;
}

/* ===============================
   ADVANCED CARD ANIMATIONS
================================ */

.cards{
    display: flex;
    flex-wrap: nowrap;   /* keeps all cards in one line */
    gap: 25px;
    width:100%;
    max-width:1100px;
}

/* Base Card */
.card-box{
    background:#111;
    border:1px solid #d4af37;
    border-radius:14px;
    padding:25px;
    text-align:center;
    width:220px;
    position:relative;
    overflow:hidden;
    transition:all 0.5s ease;
    transform-style:preserve-3d;
    animation:cardFadeUp 0.8s ease forwards;
    opacity:0;
}

/* Stagger Animation */
.card-box:nth-child(1){ animation-delay:0.2s; }
.card-box:nth-child(2){ animation-delay:0.4s; }
.card-box:nth-child(3){ animation-delay:0.6s; }
.card-box:nth-child(4){ animation-delay:0.8s; }

@keyframes cardFadeUp{
    from{
        transform:translateY(40px);
        opacity:0;
    }
    to{
        transform:translateY(0);
        opacity:1;
    }
}

/* Shine Sweep Effect */
.card-box::before{
    content:"";
    position:absolute;
    top:0;
    left:-75%;
    width:50%;
    height:100%;
    background:linear-gradient(
        120deg,
        transparent,
        rgba(255,215,0,0.25),
        transparent
    );
    transform:skewX(-25deg);
}

.card-box:hover::before{
    animation:shineMove 0.8s ease forwards;
}

@keyframes shineMove{
    100%{ left:125%; }
}

/* Hover Lift + Glow */
.card-box:hover{
    transform:translateY(-12px) scale(1.05);
    box-shadow:
        0 0 25px rgba(212,175,55,0.7),
        0 10px 25px rgba(0,0,0,0.6);
}

/* Soft Pulse Glow (continuous) */
.card-box{
    animation:cardFadeUp 0.8s ease forwards, pulseGlow 3s ease-in-out infinite;
}

@keyframes pulseGlow{
    0%,100%{
        box-shadow:0 0 10px rgba(212,175,55,0.2);
    }
    50%{
        box-shadow:0 0 18px rgba(212,175,55,0.5);
    }
}

/* Icon Animation */
.card-box i{
    font-size:28px;
    margin-bottom:10px;
    color:#ffd700;
    transition:all 0.4s ease;
}

.card-box:hover i{
    transform:rotate(10deg) scale(1.3);
    color:#fff;
}

/* Text */
.card-box p{
    color:#ccc;
    margin:5px 0;
}

.card-box b{
    font-size:24px;
    color:#fff;
    transition:0.3s ease;
}

.card-box:hover b{
    color:#ffd700;
    letter-spacing:1px;
}

/* ===============================
   TABLE SECTION
================================ */
h4{
    color:#ffd700;
    margin-top:40px;
    text-align:center;
}

.table-custom{
    background:#111;
    border:1px solid #d4af37;
    border-radius:10px;
    overflow:hidden;
    width:100%;
    max-width:1100px;
    margin-top:15px;
}

.table-custom th{
    background:#000;
    color:#ffd700;
    text-align:center;
}

.table-custom td{
    color:#fff;
    text-align:center;
}

.table-custom tbody tr{
    transition:0.3s ease;
}

.table-custom tbody tr:hover{
    background:rgba(212,175,55,0.15);
}

/* ===============================
   RESPONSIVE
================================ */
@media(max-width:768px){
    .sidebar{
        width:200px;
    }

    .main{
        margin-left:200px;
        padding:20px;
    }

    .card-box{
        width:100%;
        max-width:300px;
    }
}
/* =====================================
   EXTRA PREMIUM ANIMATIONS
===================================== */

/* 1️⃣ Animated Golden Heading Gradient */
.main h2{
    background:linear-gradient(90deg,#d4af37,#ffd700,#d4af37);
    background-size:200% auto;
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
    animation:goldFlow 4s linear infinite;
}

@keyframes goldFlow{
    0%{background-position:0% center;}
    100%{background-position:200% center;}
}

/* 2️⃣ Stagger Card Animation */
.card-box:nth-child(1){ animation-delay:0.2s; }
.card-box:nth-child(2){ animation-delay:0.4s; }
.card-box:nth-child(3){ animation-delay:0.6s; }
.card-box:nth-child(4){ animation-delay:0.8s; }

.card-box{
    opacity:0;
    animation:fadeUp 0.8s ease forwards;
}

/* 3️⃣ Icon Floating Animation */
.card-box i{
    animation:iconFloat 3s ease-in-out infinite;
}

@keyframes iconFloat{
    0%,100%{ transform:translateY(0); }
    50%{ transform:translateY(-6px); }
}

/* 4️⃣ Sidebar Link Shine Sweep */
.sidebar a::after{
    content:"";
    position:absolute;
    top:0;
    left:-75%;
    width:50%;
    height:100%;
    background:linear-gradient(120deg,transparent,rgba(255,215,0,0.3),transparent);
    transform:skewX(-25deg);
}

.sidebar a:hover::after{
    animation:shineSweep 0.8s ease;
}

@keyframes shineSweep{
    100%{ left:125%; }
}

/* 5️⃣ Table Smooth Reveal */
.table-custom tbody tr{
    opacity:0;
    animation:tableFade 0.6s ease forwards;
}

.table-custom tbody tr:nth-child(1){ animation-delay:0.2s; }
.table-custom tbody tr:nth-child(2){ animation-delay:0.4s; }
.table-custom tbody tr:nth-child(3){ animation-delay:0.6s; }
.table-custom tbody tr:nth-child(4){ animation-delay:0.8s; }
.table-custom tbody tr:nth-child(5){ animation-delay:1s; }

@keyframes tableFade{
    from{
        opacity:0;
        transform:translateX(-20px);
    }
    to{
        opacity:1;
        transform:translateX(0);
    }
}

.table-custom td {
    color: #000;
}
/* 6️⃣ Subtle Floating Golden Background Glow */
body::before{
    content:"";
    position:fixed;
    top:-200px;
    right:-200px;
    width:400px;
    height:400px;
    background:radial-gradient(circle,rgba(212,175,55,0.15),transparent 70%);
    animation:glowMove 8s ease-in-out infinite alternate;
    z-index:-1;
}

@keyframes glowMove{
    from{ transform:translateY(0); }
    to{ transform:translateY(60px); }
}

/* 7️⃣ Smooth Page Fade-In */
body{
    animation:pageFade 1s ease;
}

@keyframes pageFade{
    from{opacity:0;}
    to{opacity:1;}
}



</style>
</head>

<body>

<div class="container-fluid">

 <!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2>User Dashboard</h2>

    <a href="user-dashboard.jsp" class="active"><i class="fa fa-chart-line"></i> Dashboard</a>
    <a href="search-salons.jsp"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
    <a href="myAppointments.jsp"><i class="fa fa-calendar"></i> My Appointments</a>
    <a href="user-feedback.jsp"><i class="fa fa-star"></i> Feedback</a>
    <a href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
    <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>
    <!-- MAIN CONTENT -->
    <div class="main">
        <h2>Welcome, <span style="color:#f5e6b0"><%=user.getName()%></span></h2>

        <!-- CARDS -->
        <div class="cards">
            <div class="card-box">
                <i class="fa fa-calendar"></i>
                <p>Upcoming</p>
                <b><%=upcoming.size()%></b>
            </div>
            <div class="card-box">
                <i class="fa fa-check"></i>
                <p>Completed</p>
                <b><%=completed.size()%></b>
            </div>
            <div class="card-box">
                <i class="fa fa-star"></i>
                <p>Pending Feedback</p>
                <b><%=pendingFeedback%></b>
            </div>
            <div class="card-box">
                <i class="fa fa-gem"></i>
                <p>Loyalty Points</p>
                <b><%=user.getLoyaltyPoints()%></b>
            </div>
        </div>

        <!-- UPCOMING TABLE -->
        <h4 class="mt-4 mb-3">Upcoming Appointments</h4>
        <table class="table table-custom table-striped">
            <thead>
                <tr>
                    <th>Salon</th>
                    <th>Service</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <% if(upcoming.isEmpty()){ %>
                <tr>
                    <td colspan="5" class="text-center">No upcoming appointments</td>
                </tr>
            <% } else {
                for(Appointment appt : upcoming){
                    Salon salon = salonDAO.getSalonById(appt.getSalonId());
            %>
                <tr>
                    <td><%= salon != null ? salon.getName() : "Salon" %></td>
                    <td><%= appt.getServiceName() %></td>
                    <td><%= appt.getAppointmentDate() %></td>
                    <td><%= appt.getAppointmentTime() %></td>
                    <td><%= appt.getStatus() %></td>
                </tr>
            <% }} %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>
