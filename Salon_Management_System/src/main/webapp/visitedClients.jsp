<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.VisitedClient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Visited Clients | SalonEase Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
       /* ===============================
   GLOBAL RESET
================================ */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Times New Roman', serif;
    background:#000;
    color:#e6d8a8;
    display:flex;
    overflow-x:hidden;
}

/* Smooth Scrollbar */
::-webkit-scrollbar{
    width:8px;
}
::-webkit-scrollbar-track{
    background:#111;
}
::-webkit-scrollbar-thumb{
    background:linear-gradient(#d4af37,#ffd700);
    border-radius:10px;
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
    color:#ffffff;
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
   MAIN AREA
================================ */
.main{
    margin-left:260px;
    padding:40px;
    width:100%;
    min-height:100vh;
    animation:fadeIn 0.8s ease;
}

/* ===============================
   HEADER
================================ */
.header{
    font-size:28px;
    font-weight:bold;
    color:#ffd700;
    display:flex;
    align-items:center;
    gap:12px;
    margin-bottom:35px;
    position:relative;
    animation:slideDown 0.8s ease;
}

.header i{
    animation:iconGlow 2s infinite alternate;
}

/* Animated underline */
.header::after{
    content:"";
    position:absolute;
    bottom:-10px;
    left:0;
    width:140px;
    height:3px;
    background:linear-gradient(90deg,#d4af37,#ffd700,#d4af37);
    background-size:200%;
    animation:shineLine 3s linear infinite;
}

/* ===============================
   TABLE CONTAINER
================================ */
.table-container{
    background:linear-gradient(145deg,#0f0f0f,#151515);
    border:1px solid #d4af37;
    border-radius:18px;
    padding:25px;
    box-shadow:0 0 30px rgba(212,175,55,0.2);
    animation:fadeUp 0.8s ease;
}

/* ===============================
   TABLE
================================ */
.table{
    margin:0;
    color:#eee;
}

.table thead th{
    color:#ffd700;
    background:#111;
    border-bottom:1px solid #d4af37;
    text-transform:uppercase;
    font-size:14px;
    letter-spacing:1px;
}

.table tbody td{
    border-color:#1a1a1a;
    vertical-align:middle;
    font-size:14px;
}

/* Alternate rows */
.table tbody tr:nth-child(even){
    background:rgba(255,255,255,0.02);
}

/* Row Hover Premium Effect */
.table tbody tr{
    transition:0.4s ease;
}

.table tbody tr:hover{
    background:rgba(212,175,55,0.08);
    transform:scale(1.01);
    box-shadow:
        inset 0 0 12px rgba(255,215,0,0.3),
        0 0 10px rgba(212,175,55,0.2);
}

/* ===============================
   BADGE STYLE
================================ */
.badge-service{
    background:linear-gradient(145deg,#d4af37,#ffd700);
    color:#000;
    padding:6px 14px;
    border-radius:20px;
    font-size:12px;
    font-weight:bold;
    transition:0.3s ease;
    box-shadow:0 0 10px rgba(255,215,0,0.4);
}

/* Badge hover */
.badge-service:hover{
    transform:scale(1.1);
    box-shadow:0 0 20px rgba(255,215,0,0.8);
}

/* ===============================
   EMPTY STATE
================================ */
.text-warning{
    color:#ffd700 !important;
    font-size:15px;
    padding:20px 0;
}

/* ===============================
   BACKGROUND GOLD GLOW
================================ */
body::before{
    content:"";
    position:fixed;
    top:-120px;
    right:-120px;
    width:350px;
    height:350px;
    background:radial-gradient(circle,rgba(212,175,55,0.15),transparent 70%);
    animation:floatGlow 6s ease-in-out infinite alternate;
    z-index:-1;
}

/* ===============================
   ANIMATIONS
================================ */

@keyframes slideSidebar{
    from{transform:translateX(-100%);}
    to{transform:translateX(0);}
}

@keyframes fadeIn{
    from{opacity:0;}
    to{opacity:1;}
}

@keyframes fadeUp{
    from{opacity:0; transform:translateY(30px);}
    to{opacity:1; transform:translateY(0);}
}

@keyframes slideDown{
    from{opacity:0; transform:translateY(-30px);}
    to{opacity:1; transform:translateY(0);}
}

@keyframes iconGlow{
    from{text-shadow:0 0 5px #d4af37;}
    to{text-shadow:0 0 20px #ffd700;}
}

@keyframes shineLine{
    0%{background-position:0%;}
    100%{background-position:200%;}
}

@keyframes floatGlow{
    from{transform:translateY(0);}
    to{transform:translateY(40px);}
}


    </style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2><i class="fa fa-gem"></i>GoldenGlow Admin</h2>
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
        <i class="fa fa-users"></i> Visited Clients
    </div>

    <div class="table-container">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Client Name</th>
                    <th>Phone</th>
                    <th>Service</th>
                    <th>Amount</th>
                    <th>Visit Date</th>
                    <th>Visit Time</th>
                    <th>Therapist</th>
                    <th>Salon</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<VisitedClient> clients = (List<VisitedClient>) request.getAttribute("visitedClients");
                    int i = 1;
                    if(clients != null && !clients.isEmpty()){
                        for(VisitedClient c : clients){
                %>
                <tr>
                    <td><%= i++ %></td>
                    <td style="font-weight:400;"><%= c.getBookedBy() %></td>
                    <td><%= c.getClientPhone() %></td>
                    <td><span class="badge badge-service"><%= c.getServiceName() %></span></td>
                    <td style="font-weight:400;">₹<%= c.getAmount() %></td>
                    <td><%= c.getVisitDate() %></td>
                    <td><%= c.getVisitTime() %></td>
                    <td style="font-weight:400;"><%= c.getTherapistName() %></td>
                    <td><%= c.getSalonName() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="9" class="text-center text-warning">No visited clients found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
