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
<<<<<<< Updated upstream
/* ================= GLOBAL ================= */
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

/* ================= SIDEBAR ================= */
.sidebar{
    width:260px;
    min-height:100vh;
    background:linear-gradient(180deg,#0f0f0f,#1a1a1a);
    border-right:2px solid #ffd700;
    padding:25px 20px;
}

.sidebar-profile{
    text-align:center;
    border-bottom:1px solid #444;
    padding-bottom:15px;
    margin-bottom:20px;
}

.sidebar-profile img{
    width:70px;
    height:70px;
    border-radius:50%;
    border:2px solid #ffd700;
}

.sidebar-profile h5{
    color:#ffd700;
    margin-top:10px;
}

.sidebar-menu a{
    display:flex;
    align-items:center;
    padding:12px 15px;
    margin:6px 0;
    color:#fff;
    text-decoration:none;
    border-radius:12px;
    transition:.3s;
}

.sidebar-menu a i{
    margin-right:12px;
}

.sidebar-menu a:hover,
.sidebar-menu a.active{
    background:#ffd700;
    color:#000;
}

/* ================= MAIN ================= */
.main{
    flex:1;
    padding:40px;
    display:flex;
    justify-content:center;
    align-items:center;
}

<<<<<<< Updated upstream

/* ================= PROFILE CARD ================= */

=======
>>>>>>> Stashed changes
.profile-card{
    background:#0c0c0c;
    border-radius:22px;
    width:900px;
    max-width:95%;
    display:flex;
    padding:30px;
    gap:30px;
    box-shadow:0 0 40px rgba(212,175,55,.5);
    border:1px solid #d4af37;
}

<<<<<<< Updated upstream

/* avatar */
.avatar-box{
    flex:1;
    text-align:center;
}
.avatar-box{ flex:1; text-align:center; }

.avatar-box{ flex:1; text-align:center; }

=======
.avatar-box{ flex:1; text-align:center; }
>>>>>>> Stashed changes

.avatar{
    width:180px;
    height:180px;
    border-radius:50%;
    border:4px solid #d4af37;
    object-fit:cover;
    background:#000;
}

.upload-btn{
    display:inline-block;
    margin-top:15px;
    padding:8px 18px;
    border-radius:30px;
    border:1px solid #ffd700;
    color:#ffd700;
    cursor:pointer;
}

.upload-btn:hover{
    background:#ffd700;
    color:#000;
}

.save-photo{
    margin-top:10px;
    padding:8px 22px;
    border:none;
    border-radius:30px;
    background:#ffd700;
    font-weight:600;
}

<<<<<<< Updated upstream

/* info */
.info-box{
    flex:2;
}
=======
.info-box{ flex:2; color:#fff; }
>>>>>>> Stashed changes

.info-box{ flex:2; color:#fff; }

.info-box{ flex:2; color:#fff; }


.info-box h2{
    color:#ffd700;
}

.email{ color:#d4af37; margin-bottom:15px; }
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes

.success{
    background:#0c3321;
    color:#3cffb1;
    padding:10px;
    border-radius:10px;
    margin-bottom:15px;
}


.profile-form label{
    margin-top:10px;
    color:#ffd700;
}

.profile-form input{
    width:100%;
    padding:10px;
    border-radius:12px;
    border:1px solid #d4af37;
    background:#000;
    color:#fff;
}

.update-btn{
    margin-top:20px;
    width:100%;
    padding:12px;
    border:none;
    border-radius:40px;
    background:#ffd700;
    font-weight:700;
}

@media(max-width:768px){
<<<<<<< Updated upstream

    .container-fluid{ flex-direction:column; }
    .sidebar{ width:100%; min-height:auto; }
    .profile-card{ flex-direction:column; }
    .profile-card{ flex-direction:column; text-align:center; }
    .profile-card{ flex-direction:column; text-align:center; }

=======
    .profile-card{ flex-direction:column; text-align:center; }
>>>>>>> Stashed changes
}
=======
/* ===== GLOBAL ===== */
body {
    margin: 0;
    font-family: "Times New Roman", serif;
    color: #fff;
    height: 100vh;
    overflow: hidden;

    /* Dark image + overlay */
    background:
        
        url("https://png.pngtree.com/thumb_back/fh260/background/20230516/pngtree-small-black-hair-salon-in-an-empty-space-image_2566444.jpg");
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
}

/* layout */
.container-fluid {
    display: flex;
    height: 100vh;
    padding: 0;
}

/* ===== SIDEBAR ===== */
.sidebar {
    width: 250px;
    background: #111;
    min-height: 100vh;
    position: fixed;
    border-right: 2px solid #F5A927;
    padding-top: 10px;
}

.sidebar h2 {
    text-align: center;
    color: #F5A927;
    font-weight: 700;
    border-bottom: 1px solid #333;
    font-size: 1.3rem;
    padding-bottom: 10px;
    margin-bottom: 15px;
    text-shadow: 0 0 6px #F5A927;
      padding:20px 0px;
}

.sidebar a {
    display: flex;
    align-items: center;
    color: #fff;
    padding: 14px 22px;
    text-decoration: none;
    border-bottom: 1px solid #222;
    font-weight: 500;
    font-size: 18px;
    transition: all 0.3s ease;
}

.sidebar a i {
    margin-right: 12px;
    font-size: 1.1rem;
}

.sidebar a:hover {
    background: #F5A927;
    color: #000;
    padding-left: 28px;
    box-shadow: 0 0 12px #F5A927;
}

.sidebar a.active {
    background: #F5A927;
    color: #000;
    box-shadow: 0 0 10px #F5A927;
}

/* ===== MAIN CENTER ===== */
.main{
    flex:1;
    display:flex;
    justify-content:center;
    align-items:center;
    min-height:100vh;
    font-family:"Times New Roman", serif;
    margin-left:30px;
}

/* ===== PROFILE CARD ===== */
.profile-card{
    width:560px;
    max-width:92%;
    background:linear-gradient(145deg,#000,#111);
    border:2px solid #F5A927;
    border-radius:22px;
    padding:30px 34px;
    box-shadow:0 0 30px rgba(255,215,0,.35);

    animation:cardEnter .6s ease;
    transition:.35s;
    margin-left:30px;
}

/* hover glow */
.profile-card:hover{
    transform:translateY(-6px) scale(1.02);
    box-shadow:0 0 55px rgba(255,215,0,.75);
}

/* ===== INFO BOX ===== */
.info-box h2{
    font-size:26px;
    text-align:center;
    color:#F5A927;
    margin-bottom:5px;
    letter-spacing:.5px;
}

.email{
    text-align:center;
    font-size:17px;
    color:#F5A927;
    margin-bottom:18px;
}

/* ===== FORM LABEL ===== */
.profile-form label{
    font-size:17px;
    margin-top:10px;
    color:#F5A927;
    letter-spacing:.3px;
}

/* ===== INPUT FIELD ===== */
.profile-form input{
    width:100%;
    padding:11px 14px;
    border-radius:12px;
    border:1px solid #FFD700;
    background:#0b0b0b;
    color:#fff;
    font-size:17px;
    margin-top:4px;
    transition:.3s;
}

/* input hover */
.profile-form input:hover{
    border-color:#F5A927;
    box-shadow:0 0 6px rgba(255,215,0,.4);
}

/* input focus animation */
.profile-form input:focus{
    outline:none;
    box-shadow:0 0 12px #FFD700;
    transform:scale(1.02);
}

/* ===== UPDATE BUTTON ===== */
.update-btn{
    margin-top:20px;
    width:100%;
    padding:13px;
    font-size:18px;
    border-radius:30px;
    background:linear-gradient(135deg,#F5A927,#ffcc00);
    color:#000;
    font-weight:bold;
    border:none;
    letter-spacing:.5px;
    transition:.35s;
}

/* button hover */
.update-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 0 18px #FFD700;
}

/* button click */
.update-btn:active{
    transform:scale(.97);
}

/* ===== ENTRY ANIMATION ===== */
@keyframes cardEnter{
    from{
        opacity:0;
        transform:translateY(40px) scale(.95);
    }
    to{
        opacity:1;
        transform:translateY(0) scale(1);
    }
}

/* ===== SMALL SCREEN FIT ===== */
@media(max-height:700px){
    .profile-card{
        padding:22px 26px;
    }

    .profile-form input{
        padding:9px 12px;
    }
}

>>>>>>> Stashed changes
</style>
</head>

<body>

<div class="container-fluid">

<<<<<<< Updated upstream
<<<<<<< Updated upstream
    <!-- SIDEBAR -->
    <div class="sidebar">
       
 <div class="sidebar-menu">
            <a href="dashboard.jsp"><i class="fa fa-chart-line"></i> Dashboard</a>
            <a href="search-salons.jsp"><i class="fa fa-magnifying-glass"></i> Search Salons</a>
            <a href="myAppointments.jsp"><i class="fa fa-calendar"></i> My Appointments</a>
            <a href="user-feedback.jsp"><i class="fa fa-star"></i> Feedback</a>
            <a href="profile.jsp" class="active"><i class="fa fa-user"></i> Profile</a>
            <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
            
        </div>
    </div>

    <!-- MAIN -->
    <div class="main">

        <div class="profile-card">

            <!-- LEFT -->
            <div class="avatar-box">
                <img src="ImageServlet?entity=user&id=<%= user.getId() %>"
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

            <!-- RIGHT -->
            <div class="info-box">
                <h2><%= user.getName() %></h2>
                <p class="email"><i class="fa fa-envelope"></i> <%= user.getEmail() %></p>

                <form action="UserServlet" method="post" class="profile-form">
                    <input type="hidden" name="action" value="update">

                    <label>Full Name</label>
                    <input type="text" name="name" value="<%= user.getName() %>" required>

                    <label>Email</label>
                    <input type="email" value="<%= user.getEmail() %>" disabled>

                    <label>Password</label>
                    <input type="password" name="password" value="<%= user.getPassword() %>" required>

                    <label>Phone</label>
                    <input type="text" name="phone" value="<%= user.getPhone() %>">

                    <button class="update-btn">Update Profile</button>
                </form>
            </div>

        </div>

    </div>


=======
<!-- LEFT -->
<div class="avatar-box">

<img src="ImageServlet?id=<%= user.getId() %>&v=<%= System.currentTimeMillis() %>"
     onerror="this.src='images/user-avatar.png'"
     class="avatar">

<form action="UploadProfileImageServlet"
      method="post"
      enctype="multipart/form-data">

<label class="upload-btn">
<i class="fa-solid fa-camera"></i> Change Photo
<input type="file" name="photo" accept="image/*" hidden required>
</label>

<br>
<button type="submit" class="save-photo">Upload</button>
</form>

</div>

<!-- RIGHT -->
=======
<!-- ===== SIDEBAR (MATCHED) ===== -->
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

<div class="profile-card">

<!-- LEFT AVATAR -->

<!-- RIGHT INFO -->
>>>>>>> Stashed changes
<div class="info-box">

<h2><%= user.getName() %></h2>
<p class="email">
<<<<<<< Updated upstream
<i class="fa-solid fa-envelope"></i>
<%= user.getEmail() %>
</p>

<%
String msg = request.getParameter("success");
if(msg != null){
%>
<div class="success"><%= msg %></div>
<% } %>

<form action="UserServlet" method="post" class="profile-form">
=======
<i class="fa fa-envelope"></i> <%= user.getEmail() %>
</p>

<form action="UserServlet" method="post" class="profile-form">

>>>>>>> Stashed changes
<input type="hidden" name="action" value="update">

<label>Full Name</label>
<input type="text" name="name" value="<%= user.getName() %>" required>

<label>Email</label>
<input type="email" value="<%= user.getEmail() %>" disabled>

<<<<<<< Updated upstream
<label>New Password</label>
<input type="password" name="password" placeholder="Enter new password">
=======
<label>Password</label>
<input type="password" name="password" value="<%= user.getPassword() %>" required>
>>>>>>> Stashed changes

<label>Phone</label>
<input type="text" name="phone" value="<%= user.getPhone() %>">

<<<<<<< Updated upstream
<button class="update-btn">Update Profile</button>
</form>

</div>
>>>>>>> Stashed changes
</div>


=======
<button class="update-btn">
<i class="fa fa-save"></i> Update Profile
</button>

</form>

</div>

</div>
</div>
</div>

>>>>>>> Stashed changes
</body>
</html>
