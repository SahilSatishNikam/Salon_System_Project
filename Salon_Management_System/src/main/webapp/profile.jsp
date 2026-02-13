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


/* MAIN AREA */
.main{
    margin-left:260px;
    min-height:100vh;
    padding:40px 60px;
    background:linear-gradient(90deg,#0a0a0a,#111);
}

/* WRAPPER */
.profile-wrapper{
    max-width:1200px;
    margin:auto;
}

/* HEADER */
.profile-header{
    display:flex;
    align-items:center;
    gap:20px;
    margin-bottom:35px;
}

/* Avatar circle */
.avatar{
    width:90px;
    height:90px;
    border-radius:50%;
    background:linear-gradient(145deg,#d4af37,#ffd700);
    color:#000;
    font-size:38px;
    font-weight:bold;
    display:flex;
    align-items:center;
    justify-content:center;
    box-shadow:0 0 20px rgba(255,215,0,0.5);
}

.user-titles h1{
    margin:0;
    font-size:32px;
    color:#fff;
}

.user-titles span{
    color:#d4af37;
    font-size:13px;
    letter-spacing:1px;
}

/* BODY GRID */
.profile-body{
    display:grid;
    grid-template-columns:2fr 1fr;
    gap:40px;
}

/* LEFT PANEL */
.left-panel{
    background:#0d0d0d;
    padding:30px;
    border-radius:18px;
    border:1px solid rgba(255,215,0,0.25);
}

/* FORM SECTIONS */
.left-panel h3{
    color:#ffd700;
    margin-bottom:20px;
}

/* FORM GRID */
.profile-form{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:18px 22px;
}

/* FULL WIDTH FIELD */
.profile-form textarea,
.profile-form .full{
    grid-column:1/-1;
}

/* LABELS */
.profile-form label{
    font-size:12px;
    color:#c9a227;
    letter-spacing:1px;
}

/* INPUTS */
.profile-form input{
    padding:12px;
    border-radius:10px;
    border:1px solid #2a2a2a;
    background:#0a0a0a;
    color:#fff;
    transition:0.3s;
}

.profile-form input:focus{
    outline:none;
    border-color:#ffd700;
    box-shadow:0 0 10px rgba(255,215,0,0.4);
}

/* BUTTON */
.update-btn{
    grid-column:1/-1;
    margin-top:10px;
    padding:14px;
    border:none;
    border-radius:30px;
    background:linear-gradient(90deg,#ffd700,#f1b000);
    color:#000;
    font-weight:bold;
    letter-spacing:1px;
    transition:0.3s;
}

.update-btn:hover{
    transform:translateY(-2px);
    box-shadow:0 0 18px rgba(255,215,0,0.7);
}

/* RIGHT PANEL */
.right-panel{
    display:flex;
    flex-direction:column;
    gap:20px;
}

/* SECURITY CARD */
.security-card{
    background:#0d0d0d;
    padding:25px;
    border-radius:18px;
    border:1px solid rgba(255,215,0,0.25);
}

.security-card h3{
    color:#ffd700;
    margin-bottom:18px;
}

.reset-btn{
    width:100%;
    padding:12px;
    border-radius:25px;
    border:1px solid #ffd700;
    background:transparent;
    color:#ffd700;
    transition:0.3s;
}

.reset-btn:hover{
    background:#ffd700;
    color:#000;
}

/* RESPONSIVE */
@media(max-width:900px){
    .profile-body{
        grid-template-columns:1fr;
    }

    .main{
        padding:20px;
    }
}
/* ================= PAGE LOAD ANIMATION ================= */
.profile-header,
.left-panel,
.right-panel{
    opacity:0;
    transform:translateY(25px);
    animation:fadeSlide 0.7s ease forwards;
}

.left-panel{ animation-delay:.15s; }
.right-panel{ animation-delay:.3s; }

@keyframes fadeSlide{
    to{
        opacity:1;
        transform:translateY(0);
    }
}


/* ================= AVATAR GLOW RING ================= */
.avatar{
    position:relative;
    overflow:hidden;
    transition:.4s;
}

.avatar::after{
    content:"";
    position:absolute;
    inset:-6px;
    border-radius:50%;
    border:2px solid transparent;
    background:linear-gradient(45deg,#ffd700,#ffb700,#ffd700);
    opacity:0;
    filter:blur(6px);
    transition:.4s;
}

.avatar:hover::after{
    opacity:.9;
    animation:rotateRing 3s linear infinite;
}

@keyframes rotateRing{
    from{transform:rotate(0deg);}
    to{transform:rotate(360deg);}
}

.avatar:hover{
    transform:scale(1.07);
    box-shadow:0 0 25px rgba(255,215,0,.7);
}


/* ================= CARD HOVER FLOAT ================= */
.left-panel,
.security-card{
    transition:.35s cubic-bezier(.22,.61,.36,1);
}

.left-panel:hover,
.security-card:hover{
    transform:translateY(-6px);
    box-shadow:
        0 12px 30px rgba(0,0,0,.7),
        0 0 20px rgba(255,215,0,.25);
}


/* ================= INPUT INTERACTION ================= */
.profile-form input{
    position:relative;
}

.profile-form input:focus{
    transform:scale(1.02);
}

.profile-form input:hover{
    border-color:#caa83a;
}


/* ================= BUTTON SHINE EFFECT ================= */
.update-btn{
    position:relative;
    overflow:hidden;
}

.update-btn::after{
    content:"";
    position:absolute;
    top:0;
    left:-120%;
    width:60%;
    height:100%;
    background:linear-gradient(
        120deg,
        transparent,
        rgba(255,255,255,.6),
        transparent
    );
    transform:skewX(-25deg);
}

.update-btn:hover::after{
    animation:shine 0.9s ease forwards;
}

@keyframes shine{
    to{ left:130%; }
}

.update-btn:active{
    transform:scale(.97);
}


/* ================= SECURITY BUTTON EFFECT ================= */
.reset-btn{
    position:relative;
    overflow:hidden;
}

.reset-btn:hover{
    box-shadow:0 0 15px rgba(255,215,0,.5);
    letter-spacing:.5px;
}


/* ================= SECTION TITLE ICON BOUNCE ================= */
.left-panel h3 i,
.security-card h3 i{
    transition:.3s;
}

.left-panel h3:hover i,
.security-card h3:hover i{
    transform:translateY(-3px) scale(1.15);
    color:#ffd700;
}


/* ================= SMOOTH PAGE TRANSITION ================= */
.main{
    animation:bgFade 1s ease;
}

@keyframes bgFade{
    from{opacity:.3;}
    to{opacity:1;}
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

    <div class="profile-wrapper">

        <!-- HEADER -->
        <div class="profile-header">
            <div class="avatar">
                <%= user.getName().substring(0,1).toUpperCase() %>
            </div>

            <div class="user-titles">
                <h1><%= user.getName() %></h1>
                <span>USER PROFILE SETTINGS</span>
            </div>
        </div>


        <!-- BODY -->
        <div class="profile-body">

            <!-- LEFT PANEL (FORM) -->
            <div class="left-panel">

                <h3><i class="fa fa-user"></i> Account Information</h3>

                <form action="UserServlet" method="post" class="profile-form">
                    <input type="hidden" name="action" value="update">

                    <label>Full Name</label>
                    <input type="text" name="name" value="<%= user.getName() %>" required>

                    <label>Email Address</label>
                    <input type="email" value="<%= user.getEmail() %>" disabled class="full">

                    <label>New Password</label>
                    <input type="password" name="password" placeholder="Enter new password" class="full">

                    <label>Phone Number</label>
                    <input type="text" name="phone" value="<%= user.getPhone() %>">

                    <div></div>

                    <button class="update-btn">
                        <i class="fa fa-save"></i> Save Changes
                    </button>
                </form>

            </div>


            <!-- RIGHT PANEL -->
            <div class="right-panel">

                <!-- SECURITY CARD -->
                <div class="security-card">
                    <h3><i class="fa fa-shield"></i> Security & Privacy</h3>

                    <p style="color:#aaa;font-size:14px;margin-bottom:15px;">
                        Protect your account by updating password regularly.
                    </p>

                    <button class="reset-btn">
                        <i class="fa fa-key"></i> Reset Password
                    </button>
                </div>

                <!-- SESSION CARD -->
                <div class="security-card">
                    <h3><i class="fa fa-clock"></i> Active Session</h3>

                    <p style="color:#aaa;font-size:14px;">
                        Logged in now from this device
                    </p>

                    <button class="reset-btn" style="border-color:#ff4d4d;color:#ff4d4d;">
                        Logout Other Devices
                    </button>
                </div>

            </div>

        </div>

    </div>

</div>



</body>
</html>
