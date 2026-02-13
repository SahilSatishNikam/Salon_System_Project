<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.User, model.Feedback, dao.FeedbackDAO" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String message = request.getParameter("message");
    String ratingParam = request.getParameter("rating");
    String successMsg = null;

    if(message != null && ratingParam != null && !ratingParam.equals("0")) {
        int rating = Integer.parseInt(ratingParam);

        Feedback f = new Feedback();
        f.setUser(user.getName());
        f.setMessage(message);
        f.setRating(rating);

        FeedbackDAO dao = new FeedbackDAO();
        if(dao.saveFeedback(f)) {
            successMsg = "Thank you! Your feedback has been submitted.";
        } else {
            successMsg = "Oops! Something went wrong.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback | SalonEase</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* ===============================
   ULTRA LUXURY SALON BACKGROUND
   Black + Royal Gold Theme
   =============================== */

body{
    margin:0;
    padding:0;
    font-family:"Times New Roman", serif;
    background:
        radial-gradient(circle at 50% 20%, rgba(255,215,0,0.08), transparent 40%),
        linear-gradient(180deg,#000000,#0a0a0a,#111111);
    color:#fff;
    overflow:hidden;
    position:relative;
}

/* ===== FAR PARTICLES (Soft Depth Layer) ===== */
body::before{
    content:"";
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:200%;
    pointer-events:none;

    background-image:
        radial-gradient(2px 2px at 10% 95%, rgba(255,215,0,0.6), transparent),
        radial-gradient(2px 2px at 25% 85%, rgba(212,175,55,0.6), transparent),
        radial-gradient(2px 2px at 40% 90%, rgba(255,215,0,0.6), transparent),
        radial-gradient(2px 2px at 60% 98%, rgba(212,175,55,0.6), transparent),
        radial-gradient(2px 2px at 75% 88%, rgba(255,215,0,0.6), transparent),
        radial-gradient(2px 2px at 90% 92%, rgba(212,175,55,0.6), transparent);

    animation:floatSlow 60s linear infinite,
              twinkleSoft 6s ease-in-out infinite alternate;

    opacity:0.5;
}

/* ===== NEAR PARTICLES (Brighter Layer) ===== */
body::after{
    content:"";
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:200%;
    pointer-events:none;

    background-image:
        radial-gradient(3px 3px at 15% 92%, #FFD700, transparent),
        radial-gradient(3px 3px at 35% 97%, #F5A927, transparent),
        radial-gradient(3px 3px at 55% 88%, #FFD700, transparent),
        radial-gradient(3px 3px at 70% 95%, #F5A927, transparent),
        radial-gradient(3px 3px at 85% 90%, #FFD700, transparent);

    animation:floatFast 35s linear infinite,
              twinkleBright 4s ease-in-out infinite alternate;

    opacity:0.85;
}

/* ===== FLOATING MOTION ===== */
@keyframes floatSlow{
    0%{ transform:translateY(0); }
    100%{ transform:translateY(-50%); }
}

@keyframes floatFast{
    0%{ transform:translateY(0); }
    100%{ transform:translateY(-60%); }
}

/* ===== TWINKLE EFFECTS ===== */
@keyframes twinkleSoft{
    0%{ opacity:0.3; }
    50%{ opacity:0.6; }
    100%{ opacity:0.4; }
}

@keyframes twinkleBright{
    0%{ opacity:0.6; transform:scale(1); }
    50%{ opacity:1; transform:scale(1.15); }
    100%{ opacity:0.7; transform:scale(1); }
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

/* ===== MAIN CENTER ALIGN FIX ===== */
.main{
    flex:1;
    margin-left:260px;
    display:flex;
    justify-content:center;
    align-items:center;
    min-height:100vh;
    padding:40px;
    padding-top:20px;     /* reduce top space */
    padding-bottom:20px;  /* reduce bottom space */
}

/* ===== FEEDBACK CARD PREMIUM EFFECT ===== */
.feedback-card{
    width:100%;
    max-width:650px;
    padding:20px;
    border-radius:20px;
    background:linear-gradient(145deg,#0f0f0f,#000);
    border:1px solid rgba(255,215,0,0.3);
    box-shadow:
        0 0 30px rgba(255,215,0,0.15),
        inset 0 0 20px rgba(255,215,0,0.05);
    position:relative;
    overflow:hidden;
    transition:all 0.4s ease;
    animation:cardEntry 0.9s ease;
}

/* Golden border glow animation */
.feedback-card:hover{
    transform:translateY(-8px) scale(1.02);
    box-shadow:
        0 0 40px rgba(255,215,0,0.4),
        inset 0 0 25px rgba(255,215,0,0.08);
}

/* Entry Animation */
@keyframes cardEntry{
    from{
        opacity:0;
        transform:translateY(60px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* Subtle Shine Sweep Effect */
.feedback-card::before{
    content:"";
    position:absolute;
    top:0;
    left:-75%;
    width:50%;
    height:100%;
    background:linear-gradient(
        120deg,
        transparent,
        rgba(255,215,0,0.15),
        transparent
    );
    transform:skewX(-25deg);
}

.feedback-card:hover::before{
    animation:shineMove 1s ease forwards;
}

@keyframes shineMove{
    100%{ left:125%; }
}

/* ===== INPUT FIELD ANIMATION ===== */
.form-control{
    border-radius:12px;
    background:#111;
    border:1px solid #333;
    color:#fff;
    transition:all 0.3s ease;
}

/* Golden focus glow */
.form-control:focus{
    border-color:#FFD700;
    box-shadow:0 0 15px rgba(255,215,0,0.6);
    transform:scale(1.02);
    background:#111;
    color:#fff;
}

/* ===== LABEL ANIMATION ===== */
label{
    font-weight:600;
    color:#FFD700;
    margin-bottom:6px;
    display:block;
    transition:0.3s ease;
}

/* ===== STAR RATING ANIMATION ===== */
.rating-stars i{
    font-size:30px;
    color:#555;
    cursor:pointer;
    transition:all 0.3s ease;
}

.rating-stars i:hover{
    transform:scale(1.3) rotate(8deg);
    color:#FFD700;
    text-shadow:0 0 10px #FFD700;
}

/* ===== SUBMIT BUTTON PREMIUM EFFECT ===== */
.btn-feedback{
    background:linear-gradient(135deg,#FFD700,#f5c542);
    border:none;
    font-weight:700;
    border-radius:14px;
    padding:14px;
    transition:all 0.3s ease;
    letter-spacing:1px;
}

/* Hover Effect */
.btn-feedback:hover{
    transform:translateY(-4px) scale(1.05);
    box-shadow:0 10px 25px rgba(255,215,0,0.6);
    filter:brightness(1.1);
}

/* Click Effect */
.btn-feedback:active{
    transform:scale(0.97);
}

/* ===== SUCCESS MESSAGE ANIMATION ===== */
.success-msg{
    text-align:center;
    color:#FFD700;
    font-weight:600;
    margin-bottom:15px;
    animation:successPop 0.6s ease;
}

@keyframes successPop{
    0%{ transform:scale(0.8); opacity:0; }
    100%{ transform:scale(1); opacity:1; }
}


</style>

<script>
function setRating(r){
    document.getElementById('rating').value = r;
    const stars = document.querySelectorAll('.rating-stars i');
    stars.forEach((s,idx)=>{
        if(idx < r){
            s.classList.add('fa-solid');
            s.classList.remove('fa-regular');
            s.style.color="#F5A927";
        }else{
            s.classList.remove('fa-solid');
            s.classList.add('fa-regular');
            s.style.color="#555";
        }
    });
}
</script>

</head>

<body>

<div class="container-fluid">

<!-- SIDEBAR -->
<div class="sidebar">
    <h2>User Dashboard</h2>

    <a href="user-dashboard.jsp"><i class="fa fa-chart-line"></i> Dashboard</a>
    <a href="search-salons.jsp"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
    <a href="myAppointments.jsp"><i class="fa fa-calendar"></i> My Appointments</a>
    <a href="user-feedback.jsp" class="active"><i class="fa fa-star"></i> Feedback</a>
    <a href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
    <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN -->
<div class="main">

<div class="feedback-card">

<h3 class="page-title">
<i class="fa fa-comment-dots"></i> Customer Feedback
</h3>

<% if(successMsg != null){ %>
<div class="success-msg"><%= successMsg %></div>
<% } %>

<form method="post">

<div class="mb-3">
<label>Name</label>
<input type="text" class="form-control" value="<%=user.getName()%>" readonly>
</div>

<div class="mb-3">
<label>Email</label>
<input type="email" class="form-control" value="<%=user.getEmail()%>" readonly>
</div>

<div class="mb-3">
<label>Message</label>
<textarea name="message" class="form-control" rows="5" required></textarea>
</div>

<div class="mb-3">
<label>Rating</label>
<div class="rating-stars">
<i class="fa-regular fa-star" onclick="setRating(1)"></i>
<i class="fa-regular fa-star" onclick="setRating(2)"></i>
<i class="fa-regular fa-star" onclick="setRating(3)"></i>
<i class="fa-regular fa-star" onclick="setRating(4)"></i>
<i class="fa-regular fa-star" onclick="setRating(5)"></i>
</div>
<input type="hidden" id="rating" name="rating" value="0">
</div>

<button type="submit" class="btn btn-feedback w-100">
Submit Feedback
</button>

</form>

</div>
</div>
</div>

</body>
</html>
