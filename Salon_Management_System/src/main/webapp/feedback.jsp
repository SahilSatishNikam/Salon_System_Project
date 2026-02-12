<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Admin, model.Feedback, dao.FeedbackDAO" %>

<%
Admin admin = (Admin) session.getAttribute("admin");
if(admin == null){
    response.sendRedirect("login.jsp");
    return;
}

String message = request.getParameter("message");
String ratingParam = request.getParameter("rating");
String successMsg = null;

if(message != null && ratingParam != null && !ratingParam.equals("0")){
    int rating = Integer.parseInt(ratingParam);

    Feedback f = new Feedback();
    f.setUser(admin.getName());
    f.setMessage(message);
    f.setRating(rating);

    FeedbackDAO dao = new FeedbackDAO();
    if(dao.saveFeedback(f)){
        successMsg = "Feedback submitted successfully!";
    }else{
        successMsg = "Something went wrong!";
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Feedback</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

/* ================= GLOBAL ================= */

body{
    margin:0;
    background: radial-gradient(circle at 20% 20%, #111 0%, #0b0b0b 40%, #000 100%);
    color:#fff;
    font-family:"Times New Roman", Times, serif;
    overflow-x:hidden;
    animation:backgroundMove 15s infinite alternate ease-in-out;
}

@keyframes backgroundMove{
    0%{background-position:0% 50%;}
    100%{background-position:100% 50%;}
}

/* ================= FLOATING PARTICLES ================= */

.particles{
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    z-index:-1;
    overflow:hidden;
    pointer-events:none;
}

.particles span{
    position:absolute;
    width:6px;
    height:6px;
    background:rgba(255,215,0,0.7);
    border-radius:50%;
    animation:float 15s linear infinite;
    bottom:-20px;
}

@keyframes float{
    0%{transform:translateY(0);opacity:0;}
    10%{opacity:1;}
    100%{transform:translateY(-110vh);opacity:0;}
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

/* ================= MAIN ================= */

.main{
    margin-left:260px;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    animation:fadeUp 0.8s ease;
}

@keyframes fadeUp{
    from{opacity:0;transform:translateY(30px);}
    to{opacity:1;transform:translateY(0);}
}

/* ================= GLASS CARD ================= */

.feedback-card{
    width:520px;
    padding:45px;
    border-radius:25px;
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(18px);
    -webkit-backdrop-filter:blur(18px);
    position:relative;
    overflow:hidden;
    transition:0.5s ease;
    animation:cardFloat 6s ease-in-out infinite;
}

.feedback-card:hover{
    transform:translateY(-10px) scale(1.02);
    box-shadow:0 30px 60px rgba(255,215,0,0.3);
}

@keyframes cardFloat{
    0%,100%{transform:translateY(0px);}
    50%{transform:translateY(-8px);}
}

/* Animated Golden Border */

.feedback-card::before{
    content:"";
    position:absolute;
    inset:0;
    padding:2px;
    border-radius:25px;
    background:linear-gradient(120deg,#FFD700,#c9a227,#FFD700,#fff3b0,#FFD700);
    background-size:300% 300%;
    animation:goldBorder 6s linear infinite;
    -webkit-mask:
        linear-gradient(#000 0 0) content-box,
        linear-gradient(#000 0 0);
    -webkit-mask-composite:xor;
            mask-composite:exclude;
}

@keyframes goldBorder{
    0%{background-position:0% 50%;}
    50%{background-position:100% 50%;}
    100%{background-position:0% 50%;}
}

/* ================= TITLE ================= */

.page-title{
    text-align:center;
    color:#ffd700;
    margin-bottom:30px;
    font-weight:bold;
    text-shadow:0 0 15px rgba(255,215,0,0.7);
}

/* ================= INPUTS ================= */

.form-control{
    background:#000;
    border:1px solid rgba(255,215,0,0.4);
    color:#fff;
    border-radius:12px;
    transition:0.3s ease;
}

.form-control:hover{
    border-color:#ffd700;
    box-shadow:0 0 15px rgba(255,215,0,0.4);
}

.form-control:focus{
    box-shadow:0 0 0 3px rgba(255,215,0,0.5);
    transform:translateY(-2px);
}

/* ================= STARS ================= */

.rating-stars{
    display:flex;
    gap:10px;
}

.rating-stars i{
    font-size:28px;
    color:#444;
    cursor:pointer;
    transition:0.3s ease;
}

.rating-stars i:hover{
    transform:scale(1.3);
}

.rating-stars i.active{
    color:#ffd700;
    text-shadow:0 0 15px rgba(255,215,0,0.9);
    animation:starPulse 0.4s ease;
}

@keyframes starPulse{
    0%{transform:scale(1);}
    50%{transform:scale(1.4);}
    100%{transform:scale(1);}
}

/* ================= BUTTON ================= */

.btn-feedback{
    background:linear-gradient(45deg,#FFD700,#c9a227);
    border:none;
    color:#000;
    font-weight:bold;
    padding:14px;
    border-radius:14px;
    position:relative;
    overflow:hidden;
    transition:0.4s ease;
}

.btn-feedback::before{
    content:"";
    position:absolute;
    top:0;
    left:-100%;
    width:100%;
    height:100%;
    background:linear-gradient(120deg,transparent,rgba(255,255,255,0.6),transparent);
    transition:0.6s;
}

.btn-feedback:hover::before{
    left:100%;
}

.btn-feedback:hover{
    transform:translateY(-4px);
    box-shadow:0 15px 35px rgba(255,215,0,0.6);
}

/* ================= FORM FADE-IN ================= */

.feedback-card form > div{
    animation:fadeInUp 0.8s ease forwards;
    opacity:0;
}

.feedback-card form > div:nth-child(1){animation-delay:0.2s;}
.feedback-card form > div:nth-child(2){animation-delay:0.4s;}
.feedback-card form > div:nth-child(3){animation-delay:0.6s;}
.feedback-card form button{
    animation:fadeInUp 0.8s ease forwards;
    animation-delay:0.8s;
    opacity:0;
}

@keyframes fadeInUp{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}


</style>
</head>

<body>

<div class="particles"></div>

<div class="sidebar">
    <h2><i class="fa fa-gem"></i> Admin</h2>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="manage-salons.jsp">Manage Salons</a>
    <a href="visitedClients">Clients</a>
    <a href="AdminTherapistServlet">Manage Therapists</a>
    <a href="AdminAppointmentServlet">Appointments</a>
    <a class="active" href="feedback.jsp">Feedback</a>
    <a href="reports.jsp">Reports</a>
    <a href="logout.jsp">Logout</a>
</div>

<div class="main">
<div class="feedback-card">

<h3 class="page-title">
<i class="fa fa-star"></i> User Feedback
</h3>

<% if(successMsg!=null){ %>
<div class="alert alert-warning text-center">
<%=successMsg%>
</div>
<% } %>

<form method="post">

<div class="mb-3">
<label>Admin Name</label>
<input type="text" class="form-control" value="<%=admin.getName()%>" readonly>
</div>

<div class="mb-3">
<label>Message</label>
<textarea name="message" class="form-control" required></textarea>
</div>

<div class="mb-3">
<label>Rating</label>
<div class="rating-stars">
<i class="fa-regular fa-star"></i>
<i class="fa-regular fa-star"></i>
<i class="fa-regular fa-star"></i>
<i class="fa-regular fa-star"></i>
<i class="fa-regular fa-star"></i>
</div>
<input type="hidden" name="rating" id="rating" value="0">
</div>

<button class="btn btn-feedback w-100">Submit</button>

</form>

</div>
</div>

<script>

/* Particle Generator */
const particleContainer = document.querySelector(".particles");
for(let i=0;i<30;i++){
    let span = document.createElement("span");
    span.style.left = Math.random()*100 + "vw";
    span.style.animationDuration = (10 + Math.random()*10) + "s";
    span.style.opacity = Math.random();
    particleContainer.appendChild(span);
}

/* Star Hover Preview */
const stars = document.querySelectorAll(".rating-stars i");
const ratingInput = document.getElementById("rating");

stars.forEach((star, index) => {

    star.addEventListener("mouseenter", () => {
        highlightStars(index + 1);
    });

    star.addEventListener("click", () => {
        ratingInput.value = index + 1;
        highlightStars(index + 1);
    });

});

document.querySelector(".rating-stars")
.addEventListener("mouseleave", () => {
    highlightStars(ratingInput.value);
});

function highlightStars(count){
    stars.forEach((star, i) => {
        if(i < count){
            star.classList.add("fa-solid","active");
            star.classList.remove("fa-regular");
        } else{
            star.classList.remove("fa-solid","active");
            star.classList.add("fa-regular");
        }
    });
}

</script>

</body>
</html>
