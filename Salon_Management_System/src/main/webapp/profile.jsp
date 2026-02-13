<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.User" %>

<%
User user = (User) session.getAttribute("user");
if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Profile | SalonEase</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

/* ================= GLOBAL ================= */
body{
    margin:0;
    font-family:'Times New Roman',serif;
    background:#000;
    color:#fff;
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


/* =====================================================
   PERFECT CENTER SCREEN MAIN AREA
   ===================================================== */
.main{
    position:fixed;
    top:0;
    left:260px; /* sidebar width */
    right:0;
    bottom:0;

    display:flex;
    justify-content:center;
    align-items:center;

    overflow:hidden;

    background:
        radial-gradient(circle at 25% 25%, rgba(255,215,0,0.06), transparent 40%),
        radial-gradient(circle at 75% 75%, rgba(255,215,0,0.05), transparent 40%),
        #000;
}

/* =====================================================
   PROFILE CARD
   ===================================================== */
.info-box{
    width:520px;
    max-width:92vw;
    max-height:90vh;

    padding:22px 24px;
    border-radius:18px;

    background:linear-gradient(145deg,#0a0a0a,#000);
    border:1px solid rgba(255,215,0,0.35);

    box-shadow:
        0 0 18px rgba(255,215,0,0.15),
        inset 0 0 8px rgba(255,215,0,0.08);

    overflow:hidden;
    transition:0.3s;

    animation:fadeUp 0.6s ease;
}

.info-box:hover{
    transform:translateY(-4px);
    box-shadow:
        0 0 30px rgba(255,215,0,0.30),
        inset 0 0 12px rgba(255,215,0,0.18);
}

/* =====================================================
   HEADER TEXT
   ===================================================== */
.info-box h2{
    text-align:center;
    font-size:22px;
    color:#FFD700;
    margin-bottom:2px;
}

.email{
    text-align:center;
    font-size:13px;
    color:#d4af37;
    margin-bottom:14px;
}

/* =====================================================
   FORM GRID (COMPACT 2 COLUMN)
   ===================================================== */
.profile-form{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:10px 14px;
}

.profile-form label{
    margin-top:4px;
    font-size:13px;
    color:#FFD700;
    font-weight:600;
}

/* =====================================================
   INPUT FIELDS
   ===================================================== */
.profile-form input{
    padding:8px 9px;
    font-size:14px;
    border-radius:9px;
    border:1px solid rgba(255,215,0,0.45);
    background:#050505;
    color:#fff;
    transition:0.25s;
}

.profile-form input:hover{
    border-color:#FFD700;
    transform:translateY(-1px);
    box-shadow:0 0 6px rgba(255,215,0,0.25);
}

.profile-form input:focus{
    outline:none;
    border-color:#FFD700;
    box-shadow:
        0 0 12px rgba(255,215,0,0.55),
        inset 0 0 5px rgba(255,215,0,0.25);
    background:#0a0a0a;
}

.profile-form input:disabled{
    background:#111;
    color:#aaa;
}

/* FULL WIDTH FIELD (password) */
.full{
    grid-column:1 / -1;
}

/* =====================================================
   BUTTON
   ===================================================== */
.update-btn{
    grid-column:1 / -1;
    margin-top:10px;
    padding:10px;
    font-size:14px;
    border:none;
    border-radius:25px;

    background:linear-gradient(135deg,#FFD700,#f3b300);
    color:#000;
    font-weight:bold;
    letter-spacing:1px;

    transition:0.3s;
}

.update-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 0 18px rgba(255,215,0,0.7);
}

/* =====================================================
   ANIMATION
   ===================================================== */
@keyframes fadeUp{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}

/* =====================================================
   MOBILE RESPONSIVE
   ===================================================== */
@media(max-width:768px){

    .main{
        left:0;
        padding:12px;
    }

    .info-box{
        width:100%;
        max-height:none;
    }

    .profile-form{
        grid-template-columns:1fr;
    }
}

</style>
</head>

<body>

<div class="container-fluid">

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2>User Dashboard</h2>

    <a href="user-dashboard.jsp"><i class="fa fa-chart-line"></i> Dashboard</a>
    <a href="search-salons.jsp"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
    <a href="myAppointments.jsp"><i class="fa fa-calendar"></i> My Appointments</a>
    <a href="user-feedback.jsp"><i class="fa fa-star"></i> Feedback</a>
    <a href="profile.jsp" class="active"><i class="fa fa-user"></i> Profile</a>
    <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- ===== MAIN ===== -->
<div class="main">
    <!-- RIGHT INFO -->
    <div class="info-box">
        <h2><%= user.getName() %></h2>
        <p class="email"><i class="fa fa-envelope"></i> <%= user.getEmail() %></p>

        <form action="UserServlet" method="post" class="profile-form">
            <input type="hidden" name="action" value="update">

            <label>Full Name</label>
            <input type="text" name="name" value="<%= user.getName() %>" required>

            <label>Email</label>
            <input type="email" value="<%= user.getEmail() %>" disabled>

            <label>New Password</label>
            <input type="password" name="password" placeholder="Enter new password">

            <label>Phone</label>
            <input type="text" name="phone" value="<%= user.getPhone() %>">

            <button class="update-btn">
                <i class="fa fa-save"></i> Update Profile
            </button>
        </form>
    </div>

</div>
</div>
</div>

</body>
</html>
