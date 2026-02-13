<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="model.*" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // Initialize DAOs
    SalonDAO salonDAO = new SalonDAO();
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    UserDAO userDAO = new UserDAO();
    FeedbackDAO feedbackDAO = new FeedbackDAO();
    AdminDAO adminDAO = new AdminDAO();
    
    // Metrics
    int totalSalons = 0, totalAppointments = 0, totalUsers = 0, totalFeedback = 0;
    int pendingSalons = 0, approvedSalons = 0, rejectedSalons = 0;
    int pendingAdmins = 0, approvedAdmins = 0, rejectedAdmins = 0;

    List<Admin> allAdmins = new ArrayList<>();

    try {
        totalSalons = salonDAO.getTotalSalons();
        totalAppointments = appointmentDAO.getTotalAppointments();
        totalUsers = userDAO.getTotalUsers();
        totalFeedback = feedbackDAO.getTotalFeedback();

        List<Salon> allSalons = salonDAO.getAllSalons();
        pendingSalons = (int) allSalons.stream().filter(s -> "Pending".equals(s.getStatus())).count();
        approvedSalons = (int) allSalons.stream().filter(s -> "Approved".equals(s.getStatus())).count();
        rejectedSalons = (int) allSalons.stream().filter(s -> "Rejected".equals(s.getStatus())).count();

        allAdmins = adminDAO.getAllAdmins();
        pendingAdmins = (int) allAdmins.stream().filter(a -> "Pending".equals(a.getStatus())).count();
        approvedAdmins = (int) allAdmins.stream().filter(a -> "Approved".equals(a.getStatus())).count();
        rejectedAdmins = (int) allAdmins.stream().filter(a -> "Rejected".equals(a.getStatus())).count();

    } catch(Exception e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | SalonEase</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        /* =========================================
   PREMIUM LUXURY ADMIN PANEL
   GOLD + BLACK EDITION
========================================= */

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:"Times New Roman", serif;
    background:
        radial-gradient(circle at 20% 20%, rgba(255,215,0,0.05), transparent 40%),
        radial-gradient(circle at 80% 80%, rgba(255,215,0,0.05), transparent 40%),
        #050505;
    color:#e6d8a8;
    overflow-x:hidden;
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
/* =========================================
   MAIN AREA
========================================= */

.main{
    margin-left:270px;
    padding:40px;
    animation:fadeIn 0.8s ease;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}

/* =========================================
   HEADER
========================================= */

.header{
    font-size:30px;
    font-weight:bold;
    color:#ffd700;
    margin-bottom:30px;
    letter-spacing:1px;
}

/* =========================================
   WELCOME PANEL – GLASS CARD
========================================= */

.welcome{
    background:rgba(20,20,20,0.8);
    backdrop-filter:blur(10px);
    border:1px solid rgba(212,175,55,0.4);
    padding:30px;
    border-radius:18px;
    margin-bottom:35px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:
        0 10px 40px rgba(0,0,0,0.7),
        inset 0 0 25px rgba(212,175,55,0.05);
    transition:0.4s;
}

.welcome:hover{
    box-shadow:
        0 15px 50px rgba(0,0,0,0.9),
        inset 0 0 40px rgba(255,215,0,0.1);
}

.welcome h3{
    color:#ffd700;
    font-size:22px;
}

.quick a{
    background:linear-gradient(135deg,#d4af37,#ffd700);
    color:black;
    padding:10px 20px;
    border-radius:30px;
    text-decoration:none;
    font-weight:bold;
    margin-left:12px;
    transition:0.3s;
    box-shadow:0 0 15px rgba(255,215,0,0.4);
}

.quick a:hover{
    transform:translateY(-4px);
    box-shadow:0 0 25px rgba(255,215,0,0.8);
}

/* =========================================
   STAT CARDS – PREMIUM DEPTH
========================================= */

.cards{
    display:flex;
    gap:25px;
    margin-bottom:40px;
}

.card{
    flex:1;
    background:rgba(15,15,15,0.9);
    border-radius:20px;
    padding:30px;
    border:1px solid rgba(212,175,55,0.25);
    position:relative;
    overflow:hidden;
    transition:0.4s;
    box-shadow:0 8px 35px rgba(0,0,0,0.8);
}

.card::before{
    content:"";
    position:absolute;
    top:-50%;
    left:-50%;
    width:200%;
    height:200%;
    background:radial-gradient(circle,rgba(255,215,0,0.08),transparent 60%);
    transform:rotate(25deg);
}

.card:hover{
    transform:translateY(-10px);
    border-color:#ffd700;
    box-shadow:0 0 40px rgba(255,215,0,0.4);
}

.card-left h3{
    margin-top:8px;
}

.num{
    font-size:30px;
    font-weight:bold;
    color:#ffd700;
}

/* Circle */
.circle{
    width:75px;
    height:75px;
    border-radius:50%;
    background:conic-gradient(#ffd700 var(--percent), #2a2a2a var(--percent));
    display:flex;
    align-items:center;
    justify-content:center;
    position:relative;
}

.circle::after{
    content:"";
    position:absolute;
    width:55px;
    height:55px;
    background:#050505;
    border-radius:50%;
}

.circle span{
    position:relative;
    font-size:13px;
    font-weight:bold;
    color:#ffd700;
}

/* =========================================
   TABLE – EXECUTIVE STYLE
========================================= */

.box{
    flex:1;
    background:rgba(20,20,20,0.9);
    padding:25px;
    border-radius:18px;
    border:1px solid rgba(212,175,55,0.3);
    box-shadow:0 10px 40px rgba(0,0,0,0.7);
}

.box h2{
    color:#ffd700;
    margin-bottom:18px;
}

table{
    width:100%;
    border-collapse:collapse;
}

table th{
    text-align:left;
    padding:12px;
    color:#ffd700;
    border-bottom:1px solid rgba(255,215,0,0.4);
}

table td{
    padding:12px;
    border-bottom:1px solid #222;
    color:#ccc;
}

table tr:hover{
    background:rgba(255,215,0,0.05);
}

.status{
    color:#ffd700;
    font-weight:bold;
}

/* =========================================
   ACTION BUTTONS
========================================= */

.actions a{
    display:block;
    background:linear-gradient(135deg,#d4af37,#ffd700);
    color:black;
    padding:12px;
    border-radius:10px;
    text-decoration:none;
    font-weight:bold;
    margin-bottom:12px;
    text-align:center;
    transition:0.3s;
    box-shadow:0 0 15px rgba(255,215,0,0.4);
}

.actions a:hover{
    transform:translateY(-4px);
    box-shadow:0 0 30px rgba(255,215,0,0.9);
}

/* Stagger Animation */
.cards .card{
    animation:cardEntry 0.8s ease forwards;
    opacity:0;
    transform:translateY(40px);
}

.cards .card:nth-child(1){ animation-delay:0.1s; }
.cards .card:nth-child(2){ animation-delay:0.25s; }
.cards .card:nth-child(3){ animation-delay:0.4s; }
.cards .card:nth-child(4){ animation-delay:0.55s; }

@keyframes cardEntry{
    to{
        opacity:1;
        transform:translateY(0);
    }
}
.card::after{
    content:"";
    position:absolute;
    top:0;
    left:-100%;
    width:60%;
    height:100%;
    background:linear-gradient(
        120deg,
        transparent,
        rgba(255,215,0,0.25),
        transparent
    );
    transform:skewX(-25deg);
}

.card:hover::after{
    animation:shimmer 1s ease;
}

@keyframes shimmer{
    100%{
        left:150%;
    }
}
.card{
    perspective:1000px;
}

.card:hover{
    transform:
        translateY(-12px)
        scale(1.03)
        rotateX(4deg)
        rotateY(-4deg);
    border-color:#ffd700;
    box-shadow:
        0 20px 60px rgba(0,0,0,0.9),
        0 0 35px rgba(255,215,0,0.5);
}
.num{
    position:relative;
    animation:goldPulse 3s infinite ease-in-out;
}

@keyframes goldPulse{
    0%,100%{
        text-shadow:0 0 10px rgba(255,215,0,0.4);
    }
    50%{
        text-shadow:0 0 25px rgba(255,215,0,0.9);
    }
}
.circle{
    transition:0.6s ease;
}

.card:hover .circle{
    transform:rotate(15deg) scale(1.1);
}
.card-left i{
    transition:0.4s ease;
}

.card:hover .card-left i{
    transform:translateY(-6px) scale(1.2);
    color:#ffd700;
    text-shadow:0 0 15px rgba(255,215,0,0.8);
}


    </style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2 style="font-size:25px;color:#F5A927"><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a class="active" href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="AdminFeedbackServlet"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>


<!-- ===== MAIN CONTENT ===== -->
<div class="main">

    <div class="header">
        <i class="fa fa-tachometer-alt"></i> Admin Control Center
    </div>

    <div class="welcome">
        <div>
            <h3>Welcome Back 👑</h3>
            <p>Monitor platform activity and approvals in real time.</p>
        </div>
        <div class="quick">
            <a href="manage-salons.jsp">Verify Salons</a>
            <a href="manageVerifyAdmins.jsp">Verify Admins</a>
            <a href="reports.jsp">Reports</a>
        </div>
    </div>

    <!-- ===== CARDS ===== -->
    <%
   
    /* MAX values for percentage */
    int maxSalons = 100;
    int maxAppointments = 500;
    int maxUsers = 300;
    int maxFeedback = 200;

    int salonPercent = Math.min(100,(totalSalons * 100)/maxSalons);
    int appointPercent = Math.min(100,(totalAppointments * 100)/maxAppointments);
    int userPercent = Math.min(100,(totalUsers * 100)/maxUsers);
    int feedbackPercent = Math.min(100,(totalFeedback * 100)/maxFeedback);
    %>

    <div class="cards">

    <!-- SALONS -->
    <div class="card">
        <div class="card-top">
            <div class="card-left">
                <i class="fa fa-store"></i>
                <h3>Salons</h3>
                <div class="num"><%= totalSalons %></div>
            </div>

            <div class="circle" style="--percent:<%= salonPercent %>%">
                <span><%= salonPercent %>%</span>
            </div>
        </div>
    </div>

    <!-- APPOINTMENTS -->
    <div class="card">
        <div class="card-top">
            <div class="card-left">
                <i class="fa fa-calendar-check"></i>
                <h3>Appointments</h3>
                <div class="num"><%= totalAppointments %></div>
            </div>

            <div class="circle" style="--percent:<%= appointPercent %>%">
                <span><%= appointPercent %>%</span>
            </div>
        </div>
    </div>

    <!-- USERS -->
    <div class="card">
        <div class="card-top">
            <div class="card-left">
                <i class="fa fa-users"></i>
                <h3>Users</h3>
                <div class="num"><%= totalUsers %></div>
            </div>

            <div class="circle" style="--percent:<%= userPercent %>%">
                <span><%= userPercent %>%</span>
            </div>
        </div>
    </div>

    <!-- FEEDBACK -->
    <div class="card">
        <div class="card-top">
            <div class="card-left">
                <i class="fa fa-star"></i>
                <h3>Feedback</h3>
                <div class="num"><%= totalFeedback %></div>
            </div>

            <div class="circle" style="--percent:<%= feedbackPercent %>%">
                <span><%= feedbackPercent %>%</span>
            </div>
        </div>
    </div>

</div>


    <!-- ===== STATUS CARDS ===== -->
   <div class="dashboard-bottom">

    <!-- RECENT APPOINTMENTS -->
    <div class="box">
        <h2>Recent Appointments</h2>

        <table>
            <tr>
                <th>User</th>
                <th>Service</th>
                <th>Date</th>
                <th>Status</th>
            </tr>

            <%
            List<Appointment> recent = appointmentDAO.getRecentAppointments();
            for(Appointment a : recent){
            %>
            <tr>
                <td><%= a.getCustomerName() %></td>
                <td><%= a.getServiceName() %></td>
                <td><%= a.getDate() %></td>
                <td class="status"><%= a.getStatus() %></td>
            </tr>
            <% } %>
        </table>
    </div>

</div>
</body>
</html>