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
<<<<<<< Updated upstream
<title>Feedback | SalonEase</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

:root{
    --gold:#d4af37;
    --gold-light:#ffd700;
    --black:#0b0b0b;
}

/* =====================================================
   GLOBAL
===================================================== */
*{
    box-sizing:border-box;
}

=======
<title>User Feedback | Admin Panel</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
>>>>>>> Stashed changes
body{
    margin:0;
    font-family:"Times New Roman", Times, serif;
    background:
        linear-gradient(rgba(0,0,0,0.80), rgba(0,0,0,0.90)),
        url("https://img.pikbest.com/ai/illus_our/20230422/a466f4fe5f8ca8013088dbbed38f4785.jpg!bw700");
    background-size:cover;
    background-attachment:fixed;
    color:#fff;
<<<<<<< Updated upstream
}

/* Layout */
.container-fluid{
    display:flex;
    padding:0;
}

/* =========================================
   SIDEBAR CONTAINER
========================================= */
.sidebar{
    width:260px;
    height:100vh;
=======
}

/* SIDEBAR */
.sidebar{
    width:250px;
    background:#000;
    min-height:100vh;
>>>>>>> Stashed changes
    position:fixed;
    top:0;
    left:0;
    background:linear-gradient(180deg,#0b0b0b,#111);
    border-right:1px solid #1a1a1a;
    backdrop-filter:blur(6px);
    padding-top:10px;
<<<<<<< Updated upstream
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
   MAIN AREA
===================================================== */
.main{
    margin-left:260px;
    width:100%;
    min-height:100vh;

    display:flex;
    justify-content:center;
    align-items:center;

    padding:40px;
    animation:fadeIn 0.8s ease;
}

/* =====================================================
   FEEDBACK CARD
===================================================== */
.feedback-card{
    width:100%;
    max-width:520px;
    background:linear-gradient(145deg,#111,#0a0a0a);
    padding:35px;
    border-radius:18px;
    border:1px solid rgba(212,175,55,0.3);
    box-shadow:0 0 30px rgba(212,175,55,0.15);
    transition:0.4s ease;
    animation:slideUp 0.7s ease;
}

.feedback-card:hover{
    box-shadow:0 0 40px rgba(255,215,0,0.25);
}

/* Title */
.page-title{
    text-align:center;
    font-size:24px;
    color:var(--gold-light);
    margin-bottom:30px;
    animation:glowText 2s infinite alternate;
}

.page-title i{
    margin-right:10px;
=======
}
.sidebar h2{
    text-align:center;
    padding:20px;
    color:#FFD700;
    font-weight:600;
    border-bottom:1px solid #222;
}
.sidebar a{
    display:flex;
    align-items:center;
    color:#fff;
    padding:15px 22px;
    text-decoration:none;
    border-bottom:1px solid #111;
    font-size:17px;
}
.sidebar a i{ margin-right:12px; }
.sidebar a:hover,
.sidebar a.active{
    background:#FFD700;
    color:#000;
    padding-left:28px;
}

/* MAIN */
.main-content{
    margin-left:250px;
    padding:30px 40px;
}

.page-title{
    text-align:center;
    font-size:2rem;
    font-weight:700;
    color:#FFD700;
    margin-bottom:30px;
}

/* FEEDBACK CARD */
.feedback-card{
    display:flex;
    background:rgba(30,30,30,0.7);
    border-radius:15px;
    border:1.5px solid #FFD700;
    padding:15px 20px;
    margin-bottom:15px;
    backdrop-filter: blur(6px);
    box-shadow:0 5px 15px rgba(255,215,0,0.15);
    transition:0.3s;
}
.feedback-card:hover{
    transform:scale(1.02);
    box-shadow:0 12px 25px rgba(255,215,0,0.4);
}

.feedback-avatar{
    font-size:2rem;
    color:#FFD700;
    margin-right:15px;
}

.feedback-user{
    font-weight:700;
    color:#FFD700;
}

.feedback-stars{
    color:#ffea00;
    font-size:18px;
}

.feedback-message{
    margin-top:5px;
}

.feedback-date{
    font-size:12px;
    color:#ccc;
}

.empty{
    text-align:center;
    margin-top:50px;
    color:#aaa;
    font-size:18px;
>>>>>>> Stashed changes
}

/* Labels */
label{
    color:var(--gold-light);
    font-weight:500;
}

/* Inputs */
.form-control{
    background:#000 !important;
    border:1px solid rgba(212,175,55,0.4) !important;
    color:#fff !important;
    border-radius:10px;
    transition:0.3s ease;
}

.form-control:focus{
    border-color:var(--gold-light) !important;
    box-shadow:0 0 12px rgba(255,215,0,0.6) !important;
}

/* Rating Stars */
.rating-stars{
    font-size:26px;
    display:flex;
    gap:12px;
    cursor:pointer;
}

.rating-stars i{
    color:#555;
    transition:0.3s ease;
}

.rating-stars i:hover{
    color:var(--gold-light);
    transform:scale(1.3);
}

/* Button */
.btn-feedback{
    background:linear-gradient(145deg,var(--gold),var(--gold-light));
    border:none;
    color:#000;
    font-weight:bold;
    border-radius:10px;
    padding:10px;
    transition:0.3s ease;
}

.btn-feedback:hover{
    transform:translateY(-3px);
    box-shadow:0 0 20px rgba(255,215,0,0.7);
}

/* Success Message */
.success-msg{
    background:rgba(212,175,55,0.12);
    border:1px solid var(--gold-light);
    color:var(--gold-light);
    padding:10px;
    border-radius:8px;
    text-align:center;
    margin-bottom:20px;
}

/* =====================================================
   ANIMATIONS
===================================================== */
@keyframes slideSidebar{
    from{transform:translateX(-100%);}
    to{transform:translateX(0);}
}

@keyframes fadeIn{
    from{opacity:0;}
    to{opacity:1;}
}

@keyframes slideUp{
    from{opacity:0; transform:translateY(30px);}
    to{opacity:1; transform:translateY(0);}
}

@keyframes glowText{
    from{ text-shadow:0 0 5px var(--gold); }
    to{ text-shadow:0 0 18px var(--gold-light); }
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

 <!-- ===== SIDEBAR ===== -->
<div class="sidebar">
<<<<<<< Updated upstream
    <h2><i class="fa fa-gem"></i>User Dashboard</h2>
    <a class="active" href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
=======
    <h2><i class="fa fa-gem"></i> SalonEase Admin</h2>

    <a href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
>>>>>>> Stashed changes
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="AdminClientViewServlet"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN -->
<<<<<<< Updated upstream
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
=======
<div class="main-content">

    <div class="page-title">
        <i class="fa fa-comment"></i> User Feedback
    </div>

    <% if(feedbackList.isEmpty()) { %>
        <div class="empty">
            <i class="fa fa-face-frown"></i> No feedback submitted yet.
        </div>
    <% } else {
        for(Feedback f : feedbackList) {
    %>

    <div class="feedback-card">
        <div class="feedback-avatar">
            <i class="fa fa-user-circle"></i>
        </div>

        <div>
            <div class="d-flex justify-content-between">
                <div class="feedback-user"><%= f.getUser() %></div>
                <div class="feedback-stars">
                    <% for(int i=1;i<=f.getRating();i++){ %>★<% } %>
                    <% for(int i=f.getRating()+1;i<=5;i++){ %>☆<% } %>
                </div>
            </div>

            <div class="feedback-message">
                <i class="fa fa-quote-left"></i>
                <%= f.getMessage() %>
            </div>

            <div class="feedback-date">
                <i class="fa fa-calendar"></i>
                <%= f.getCreatedAt() %>
            </div>
        </div>
    </div>

    <% } } %>

>>>>>>> Stashed changes
</div>

</body>
</html>