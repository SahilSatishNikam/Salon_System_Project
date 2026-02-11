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

/* ===== GLOBAL ===== */
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

/* ===== MAIN CENTER ===== */
.main{
    flex:1;
    display:flex;
    justify-content:center;
    align-items:center;
    min-height:100vh;
    padding:30px;
}

/* ===== PROFILE CARD ===== */
.profile-card{
    width:850px;
    max-width:95%;
    background:#0c0c0c;
    border-radius:20px;
    display:flex;
    gap:30px;
    padding:30px;
    border:1px solid #F5A927;
    box-shadow:0 0 40px rgba(255,215,0,.4);
}

/* LEFT */
.avatar-box{
    flex:1;
    text-align:center;
}

.avatar{
    width:170px;
    height:170px;
    border-radius:50%;
    border:4px solid #F5A927;
    object-fit:cover;
}

.upload-btn{
    margin-top:15px;
    display:inline-block;
    padding:8px 18px;
    border:1px solid #F5A927;
    border-radius:30px;
    color:#F5A927;
    cursor:pointer;
}

.upload-btn:hover{
    background:#F5A927;
    color:#000;
}

.save-photo{
    margin-top:10px;
    padding:8px 22px;
    border:none;
    border-radius:30px;
    background:#F5A927;
    font-weight:600;
}

/* RIGHT */
.info-box{
    flex:2;
}

.info-box h2{
    color:#F5A927;
}

.email{
    color:#d4af37;
    margin-bottom:15px;
}

.profile-form label{
    margin-top:10px;
    color:#F5A927;
}

.profile-form input{
    width:100%;
    padding:10px;
    border-radius:10px;
    border:1px solid #F5A927;
    background:#000;
    color:#fff;
}

.update-btn{
    margin-top:20px;
    width:100%;
    padding:12px;
    border:none;
    border-radius:30px;
    background:#F5A927;
    font-weight:700;
}

@media(max-width:768px){
    .profile-card{
        flex-direction:column;
        text-align:center;
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

<div class="profile-card">

    <!-- LEFT IMAGE -->
    <div class="avatar-box">
        <img src="ImageServlet?id=<%= user.getId() %>"
             onerror="this.src='images/user-avatar.png'"
             class="avatar">

        <form action="UploadProfileImageServlet" method="post" enctype="multipart/form-data">
            <label class="upload-btn">
                <i class="fa fa-camera"></i> Change Photo
                <input type="file" name="photo" hidden required>
            </label><br>
            <button class="save-photo">Upload</button>
        </form>
    </div>

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
