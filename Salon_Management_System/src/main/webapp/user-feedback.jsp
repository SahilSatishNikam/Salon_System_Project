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
<title>Submit Feedback | SalonEase</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>

body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#000;
    color:#fff;
}

.container-fluid{
    display:flex;
    padding:0;
}

/* ===== SIDEBAR ===== */
.sidebar{
    width:250px;
    background:#000;
    min-height:100vh;
    border-right:2px solid #F5A927;
    padding-top:10px;
}

.sidebar h2{
    text-align:center;
    color:#F5A927;
    font-weight:600;
    border-bottom:1px solid #222;
    font-size:1.3rem;
    padding:20px 0;
}

.sidebar a{
    display:flex;
    align-items:center;
    color:#fff;
    padding:14px 22px;
    text-decoration:none;
    border-bottom:1px solid #111;
    font-size:18px;
}

.sidebar a i{ margin-right:12px; }

.sidebar a:hover,
.sidebar a.active{
    background:#F5A927;
    color:#000;
    padding-left:28px;
}

/* ===== MAIN ===== */
.main{
    flex:1;
    padding:40px;
    background: radial-gradient(circle at top,#111,#000);
}

/* ===== PAGE TITLE ===== */
.page-title{
    text-align:center;
    color:#F5A927;
    font-weight:700;
    margin-bottom:30px;
    text-shadow:0 0 4px #F5A927;
}

/* ===== FORM CARD ===== */
.feedback-card{
    max-width:650px;
    margin:auto;
    background:#0b0b0b;
    border:1px solid #F5A927;
    border-radius:20px;
    padding:30px;
    box-shadow:0 0 15px rgba(245,169,39,.25);
    transition:.3s;
}

.feedback-card:hover{
    box-shadow:0 0 35px rgba(245,169,39,.5);
}

/* ===== INPUTS ===== */
.form-control{
    background:#000;
    border:1px solid #F5A927;
    color:#fff;
    border-radius:12px;
}

.form-control:focus{
    background:#000;
    color:#fff;
    border-color:#F5A927;
    box-shadow:0 0 12px rgba(245,169,39,.7);
}

label{
    color:#F5A927;
    font-weight:600;
}

/* ===== RATING ===== */
.rating-stars{
    display:flex;
    gap:12px;
    margin-top:10px;
}

.rating-stars i{
    font-size:30px;
    color:#F5A927;
    cursor:pointer;
    transition:.2s;
}

.rating-stars i:hover{
    transform:scale(1.2);
    text-shadow:0 0 8px #F5A927;
}

/* ===== BUTTON ===== */
.btn-gold{
    background:linear-gradient(135deg,#F5A927,#FFD166);
    color:#000;
    border:none;
    border-radius:30px;
    padding:12px;
    font-weight:700;
    box-shadow:0 0 5px #F5A927;
}

.btn-gold:hover{
    transform:scale(1.05);
}

/* ===== MESSAGE ===== */
.success-msg{
    text-align:center;
    color:#7CFCB2;
    font-weight:600;
    margin-bottom:15px;
}

@media(max-width:768px){
    .container-fluid{ flex-direction:column; }
    .sidebar{ width:100%; }
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
        }else{
            s.classList.remove('fa-solid');
            s.classList.add('fa-regular');
        }
    });
}
</script>

</head>

<body>

<div class="container-fluid">

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2>User Dashboard</h2>

    <a href="user-dashboard.jsp"><i class="fa fa-chart-line"></i> Dashboard</a>
    <a href="search-salons.jsp"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
    <a href="myAppointments.jsp"><i class="fa fa-calendar"></i> My Appointments</a>
    <a href="user-feedback.jsp" class="active"><i class="fa fa-star"></i> Feedback</a>
    <a href="profile.jsp"><i class="fa fa-user"></i> Profile</a>
    <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- ===== MAIN ===== -->
<div class="main">

<h2 class="page-title">
    <i class="fa fa-comment-dots"></i> Submit Feedback
</h2>

<% if(successMsg != null){ %>
<div class="success-msg"><%= successMsg %></div>
<% } %>

<div class="feedback-card">

<form method="post">

<div class="mb-3">
<label>Your Feedback</label>
<textarea name="message" class="form-control" rows="5"
placeholder="Share your experience..." required></textarea>
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

<button class="btn btn-gold w-100">
<i class="fa fa-paper-plane"></i> Submit Feedback
</button>

</form>

</div>
</div>
</div>

</body>
</html>
