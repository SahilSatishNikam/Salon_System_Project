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
body{
    background:#0b0b0b;
    color:#fff;
    font-family:Segoe UI;
}

/* ===== SIDEBAR ===== */
.sidebar{
    width:260px;
    height:100vh;
    position:fixed;
    top:0;
    left:0;
    background:linear-gradient(180deg,#0b0b0b,#111);
    border-right:1px solid #1a1a1a;
    padding-top:20px;
}

.sidebar h2{
    color:#F5A927;
    text-align:center;
    margin-bottom:30px;
}

.sidebar a{
    display:block;
    padding:15px 25px;
    color:#fff;
    text-decoration:none;
    transition:0.3s;
}

.sidebar a i{
    margin-right:10px;
    color:#F5A927;
}

.sidebar a:hover{
    background:#1a1a1a;
    color:#F5A927;
}

.sidebar a.active{
    background:#1a1a1a;
    color:#ffd700;
    border-left:3px solid #F5A927;
}

/* ===== MAIN ===== */
.main{
    margin-left:260px;
    padding:40px;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.feedback-card{
    width:500px;
    background:#111;
    padding:30px;
    border-radius:16px;
    border:1px solid #d4af37;
    box-shadow:0 0 25px rgba(212,175,55,0.3);
}

.page-title{
    text-align:center;
    color:#ffd700;
    margin-bottom:25px;
}

.form-control{
    background:#000;
    border:1px solid #d4af37;
    color:#fff;
}

.btn-feedback{
    background:#ffd700;
    border:none;
    color:#000;
    font-weight:bold;
}

.rating-stars i{
    font-size:26px;
    margin-right:8px;
    cursor:pointer;
    color:#555;
}
</style>

<script>
function setRating(r){
    document.getElementById("rating").value = r;
    const stars = document.querySelectorAll(".rating-stars i");
    stars.forEach((s,i)=>{
        if(i<r){
            s.classList.remove("fa-regular");
            s.classList.add("fa-solid");
            s.style.color="#ffd700";
        }else{
            s.classList.add("fa-regular");
            s.classList.remove("fa-solid");
            s.style.color="#555";
        }
    });
}
</script>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a class="active" href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- ===== MAIN CONTENT ===== -->
<div class="main">

<div class="feedback-card">

<h3 class="page-title">
<i class="fa fa-star"></i> Admin Feedback
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
<i class="fa-regular fa-star" onclick="setRating(1)"></i>
<i class="fa-regular fa-star" onclick="setRating(2)"></i>
<i class="fa-regular fa-star" onclick="setRating(3)"></i>
<i class="fa-regular fa-star" onclick="setRating(4)"></i>
<i class="fa-regular fa-star" onclick="setRating(5)"></i>
</div>
<input type="hidden" name="rating" id="rating" value="0">
</div>

<button class="btn btn-feedback w-100">Submit</button>

</form>

</div>
</div>

</body>
</html>
