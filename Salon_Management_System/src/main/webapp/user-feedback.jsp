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

:root{
    --gold:#F5A927;
}

/* ===== BACKGROUND ===== */
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:
        linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.85)),
        url("https://img.pikbest.com/ai/illus_our/20230422/a466f4fe5f8ca8013088dbbed38f4785.jpg!bw700");
    background-size:cover;
    background-attachment:fixed;
    color:#fff;
}

/* Layout */
.container-fluid{ display:flex; padding:0; }

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

/* ===== MAIN ===== */
.main{
    flex:1;
    display:flex;
    justify-content:center;
    align-items:center;
    min-height:100vh;
}

/* ===== CARD ===== */
.feedback-card{
    width:100%;
    max-width:600px;
    padding:35px;
    border-radius:18px;
    backdrop-filter:blur(12px);
    background:rgba(255,255,255,0.08);
    border:1px solid rgba(255,255,255,0.15);
    box-shadow:0 0 40px rgba(0,0,0,0.4);
    animation:fadeIn 0.8s ease;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(40px);}
    to{opacity:1; transform:translateY(0);}
}

/* Title */
.page-title {
    text-align: center;
    font-weight: 700;
    color: #FFD700; /* golden color */
    margin-bottom: 20px;
    
}


/* Inputs */
.form-control{
    border-radius:10px;
    background:#111;
    border:1px solid #444;
    color:#fff;
}
.form-control:focus{
    border-color:var(--gold);
    box-shadow:0 0 10px var(--gold);
    background:#111;
    color:#fff;
}

/* ===== STARS ===== */
.rating-stars{
    display:flex;
    gap:10px;
}
.rating-stars i{
    font-size:30px;
    color:#555;
    cursor:pointer;
    transition:.3s;
}
.rating-stars i:hover{
    transform:scale(1.2);
    color:var(--gold);
}

/* Button */
.btn-feedback {
    background: linear-gradient(45deg, #FFD700, #FFC107); /* golden gradient */
    border: none;
    font-weight: 600;
    border-radius: 12px;
    padding: 12px;
    transition: 0.3s;
    color: #000; /* text black for contrast */
}

.btn-feedback:hover {
    transform: scale(1.05);
    box-shadow: 0 0 20px #FFD700; /* golden glow on hover */
}


/* Success */
.success-msg{
    text-align:center;
    color:#00ffae;
    font-weight:600;
    margin-bottom:15px;
    animation:fadeIn .5s;
}

.dashboard-title {
    display: flex;
    align-items: center;
    font-size: 28px; /* heading size */
    color: #ffd700; /* golden text */
    font-weight: bold;
    font-family: "Times New Roman", Times, serif; /* serif font added */
}

.dashboard-icon {
    font-size: 34px; /* thoda motha icon */
    color: #ffd700; /* gold color */
    margin-right: 12px; /* text la thoda gap */
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
     <h2 class="dashboard-title">
    <i class="fa-solid fa-gem dashboard-icon"></i>
    User Dashboard
</h2>

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
