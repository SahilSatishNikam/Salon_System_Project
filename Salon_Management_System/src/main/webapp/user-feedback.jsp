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

/* ===== SIDEBAR ===== */
.sidebar{
    width:250px;
    background:#000;
    min-height:100vh;
    border-right:2px solid var(--gold);
}
.sidebar h2{
    text-align:center;
    color:var(--gold);
    padding:20px 0;
    border-bottom:1px solid #222;
}
.sidebar a{
    display:flex;
    align-items:center;
    color:#fff;
    padding:14px 22px;
    text-decoration:none;
    transition:.3s;
}
.sidebar a i{ margin-right:12px; }

.sidebar a:hover,
.sidebar a.active{
    background:var(--gold);
    color:#000;
    padding-left:28px;
    box-shadow:0 0 15px var(--gold);
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
.page-title{
    text-align:center;
    font-weight:700;
    color:var(--gold);
    margin-bottom:20px;
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
.btn-feedback{
    background:linear-gradient(45deg,var(--gold),#ffcc5c);
    border:none;
    font-weight:600;
    border-radius:12px;
    padding:12px;
    transition:.3s;
}
.btn-feedback:hover{
    transform:scale(1.05);
    box-shadow:0 0 20px var(--gold);
}

/* Success */
.success-msg{
    text-align:center;
    color:#00ffae;
    font-weight:600;
    margin-bottom:15px;
    animation:fadeIn .5s;
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
