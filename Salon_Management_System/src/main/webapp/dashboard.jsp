<%@ page import="java.util.*, model.*, dao.*" %>
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
   GLOBAL SETTINGS
========================================= */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:"Times New Roman", serif;
    background:#0b0b0b;
    color:#e6d8a8;
    overflow-x:hidden;
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
    background:linear-gradient(to right,#c9a227,#F5A927);
    opacity:0.15;
    transition:0.4s ease;
}

.sidebar a:hover::before{
    width:100%;
}

/* Icon */
.sidebar a i{
    margin-right:14px;
    color:#F5A927;
    transition:0.4s ease;
}

/* Hover Effect */
.sidebar a:hover{
    color:#F5A927;
    transform:translateX(8px);
}

.sidebar a:hover i{
    color:#F5A927;
    transform:scale(1.2);
}

/* =========================================
   ACTIVE MENU ITEM
========================================= */
.sidebar a.active{
    color:#ffd700;
    background:rgba(201,162,39,0.15);
    border-right:4px solid ##F5A927;

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
   MAIN CONTENT
========================================= */
.main{
    margin-left:260px;   /* IMPORTANT for sidebar */
    padding:30px;
    animation:fadeIn 1s ease-in-out;
}

/* =========================================
   HEADER
========================================= */
.header{
    font-size:28px;
    font-weight:bold;
    margin-bottom:25px;
    color:#d4af37;
    display:flex;
    align-items:center;
    gap:10px;
    letter-spacing:1px;
    animation:slideDown 0.8s ease-in-out;
}

.header i{
    color:#F5A927;
}

/* =========================================
   WELCOME SECTION
========================================= */
.welcome{
    background:linear-gradient(145deg,#111,#1a1a1a);
    border:1px solid #d4af37;
    padding:25px;
    border-radius:15px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:30px;
    box-shadow:0 0 20px rgba(212,175,55,0.2);
    transition:0.4s ease;
}

.welcome:hover{
    transform:translateY(-5px);
    box-shadow:0 0 30px rgba(212,175,55,0.4);
}

.welcome h3{
    font-size:22px;
    color:#ffd700;
}

.welcome p{
    margin-top:5px;
    color:#ccc;
}

/* Quick Links */
.quick a{
    text-decoration:none;
    background:#d4af37;
    color:#000;
    padding:8px 16px;
    margin-left:10px;
    border-radius:30px;
    font-weight:bold;
    transition:0.3s;
}

.quick a:hover{
    background:#ffffff;
    transform:scale(1.05);
}

/* =========================================
   DASHBOARD CARDS
========================================= */
/* ===== NEW CIRCLE CARDS UI ===== */

.cards{
     display:flex;
    gap:20px;
    flex-wrap:nowrap;     /* forces single row */
    justify-content:space-between;
}

.card{
    background:#111;
    border-radius:18px;
    padding:25px;
    border:1px solid rgba(212,175,55,0.25);
    position:relative;
    overflow:hidden;
    transition:0.4s;
      flex:1;               /* all cards equal width */
    min-width:220px;
}

.card:hover{
    transform:translateY(-8px);
    box-shadow:0 0 30px rgba(212,175,55,0.45);
    border-color:##F5A927;
}

.card-top{
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.card-left i{
    font-size:26px;
    color:#F5A927;
}

.card-left h3{
    margin-top:8px;
    font-size:18px;
}

.num{
    font-size:28px;
    font-weight:bold;
    color:#ffd700;
    margin-top:5px;
}

/* ==== circle ==== */
.circle{
    width:70px;
    height:70px;
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
    width:52px;
    height:52px;
    background:#0b0b0b;
    border-radius:50%;
}

.circle span{
    position:relative;
    font-size:12px;
    font-weight:bold;
    color:#F5A927;
}

/* ==== Recent Appointments ==== */

.dashboard-bottom{
    display:flex;
    gap:25px;
    margin-top:30px;
}

.box{
    flex:1;
    background:#111;
    padding:20px;
    border-radius:15px;
    color:white;
}

.box h2{
    margin-bottom:15px;
    color:#F5A927;
}

table{
    width:100%;
    border-collapse:collapse;
}

table th, table td{
    padding:10px;
    border-bottom:1px solid #333;
    font-size:14px;
}

.status{
    color:#F5A927;
    font-weight:bold;
}

.actions{
    display:flex;
    flex-direction:column;
    gap:12px;
}

.actions a{
    background:#F5A927;
    color:black;
    padding:10px;
    border-radius:8px;
    text-decoration:none;
    font-weight:600;
    text-align:center;
    transition:0.3s;
}

.actions a:hover{
    background:#F5A927;
}

/* =========================================
   RECENT ACTIVITY
========================================= */
.activity{
    background:#111;
    padding:20px;
    border-radius:15px;
    border:1px solid rgba(212,175,55,0.3);
    transition:0.4s;
}

.activity:hover{
    box-shadow:0 0 20px rgba(212,175,55,0.5);
}

.activity h3{
    color:#F5A927;
    margin-bottom:15px;
}

.activity ul{
    list-style:none;
}

.activity li{
    padding:10px;
    border-bottom:1px solid #333;
    transition:0.3s;
}

.activity li:hover{
    background:#1a1a1a;
    padding-left:15px;
    color:#F5A927;
}

/* =========================================
   ANIMATIONS
========================================= */
@keyframes fadeIn{
    from{opacity:0;}
    to{opacity:1;}
}

@keyframes slideDown{
    from{transform:translateY(-30px); opacity:0;}
    to{transform:translateY(0); opacity:1;}
}

@keyframes fadeUp{
    from{transform:translateY(40px); opacity:0;}
    to{transform:translateY(0); opacity:1;}
}

@keyframes growBar{
    from{width:0;}
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
    <a href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
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


    <!-- QUICK ACTIONS -->
    <div class="box">
        <h2>Quick Actions</h2>

        <div class="actions">
            <a href="manage-salons.jsp">+ Add Salon</a>
            <a href="adminAppointments.jsp">View Appointments</a>
            <a href="admin-therapists.jsp">Manage Therapist</a>
            <a href="feedback.jsp">View Feedback</a>
        </div>
    </div>

</div>



</div>
</body>
</html> 