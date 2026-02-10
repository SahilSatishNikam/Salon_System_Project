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

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
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

/* ================= PROFILE CARD ================= */
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

/* avatar */
.avatar-box{
    flex:1;
    text-align:center;
}

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

/* info */
.info-box{
    flex:2;
}

.info-box h2{
    color:#ffd700;
}

.email{
    color:#d4af37;
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
    .container-fluid{ flex-direction:column; }
    .sidebar{ width:100%; min-height:auto; }
    .profile-card{ flex-direction:column; }
}
</style>
</head>

<body>

<div class="container-fluid">

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
</div>

</body>
</html>
