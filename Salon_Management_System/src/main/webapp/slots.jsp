<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Slot, model.Therapist" %>

<%
Therapist t = (Therapist) session.getAttribute("therapist");
if (t == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Get slots from request
List<Slot> slots = (List<Slot>) request.getAttribute("slots");
if (slots == null) slots = new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Therapist Slots</title>

    <!-- Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: #121212;
            color: #eee;
            font-family: "Times New Roman", Times, serif;
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
        /* Main Content */
        .main {
            margin-left: 250px;
            padding: 30px;
        }

        /* Slot Cards */
.slot-card {
    background: #1E1E1E;
    border-radius: 12px;
    padding: 18px;
    width: 260px;
    border: 1px solid #FFD700;          /* golden border */
    transition: 0.3s;
    cursor: pointer;
    position: relative;
}

.slot-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 0 20px rgba(255,215,0,0.45);  /* golden glow */
    border-color: #FFD700;
}

/* Golden Badge */
.badge-gold {
    background: linear-gradient(135deg,#FFD700,#FFC700);
    color: #000;
    font-weight: 600;
}

/* Info Icon */
.slot-card .info-icon {
    position: absolute;
    top: 12px;
    right: 12px;
    font-size: 1.1rem;
    color: #FFD700;
}

    </style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
<h2>Therapist Panel</h2>

<a href="TherapistDashboardServlet" >
<i class="fa fa-chart-line"></i> Dashboard
</a>

<a href="therapistAvailability.jsp">
<i class="fa fa-clock"></i> Set Availability
</a>

<!-- ✅ FIXED LINK -->
<a href="<%=request.getContextPath()%>/slots?therapistId=<%=t.getId()%>" class="active">
<i class="fa fa-calendar"></i> View Slots
</a>

<a href="therapist-services?salonId=<%=t.getSalonId()%>">
<i class="fa fa-spa"></i> Services
</a>

<a href="TherapistAppointmentServlet">
<i class="fa fa-calendar-check"></i> Appointments
</a>


<a href="LogoutServlet">
<i class="fa fa-sign-out-alt"></i> Logout
</a>
</div>


<!-- Main Content -->
<div class="main">
   <h3 class="mb-4" style="color:#FFD700;">
    <i class="fa fa-calendar-check"></i> Available Slots
</h3>


    <div class="d-flex flex-wrap gap-4">
        <% for(Slot s : slots) { %>

        <!-- Slot Card -->
        <div class="slot-card" data-bs-toggle="modal" data-bs-target="#slot<%=s.getId()%>">
            <i class="fa fa-info-circle info-icon" title="Slot Details"></i>
            <h6> <i class="fa fa-calendar-day"></i> <%= s.getAvailableDate() %> </h6>
            <p class="mb-1"> <i class="fa fa-clock"></i> <%= s.getStartTime() %> - <%= s.getEndTime() %> </p>
            <span class="badge badge-gold mb-2"> <%= s.getSlotDuration() %> mins </span>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="slot<%=s.getId()%>">
            <div class="modal-dialog">
                <div class="modal-content bg-dark text-light">
                    <div class="modal-header border-secondary">
                        <h5>Slot Details</h5>
                        <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p><b>Date:</b> <%= s.getAvailableDate() %></p>
                        <p><b>Time:</b> <%= s.getStartTime() %> - <%= s.getEndTime() %></p>
                        <p><b>Duration:</b> <%= s.getSlotDuration() %> mins</p>
                    </div>
                    <div class="modal-footer border-secondary">
                        <button class="btn btn-outline-warning" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
