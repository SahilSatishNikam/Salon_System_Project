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
body{
    background:linear-gradient(135deg,#000,#111);
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    font-family:'Segoe UI',sans-serif;
}

/* main card */
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

/* avatar section */
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
    box-shadow:0 0 20px rgba(255,215,0,.9);
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
    transition:0.3s;
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
    background:linear-gradient(135deg,#d4af37,#ffd700);
    font-weight:600;
    transition:0.3s;
}

.save-photo:hover{
    box-shadow:0 0 15px rgba(255,215,0,.9);
    transform:scale(1.05);
}

/* info section */
.info-box{
    flex:2;
    color:#fff;
}

.info-box h2{
    color:#ffd700;
    text-shadow:0 0 10px rgba(255,215,0,.8);
}

.email{
    color:#d4af37;
    margin-bottom:15px;
}

.success{
    background:#0c3321;
    color:#3cffb1;
    padding:10px;
    border-radius:10px;
    margin-bottom:15px;
    border-left:4px solid #3cffb1;
}

.profile-form label{
    margin-top:10px;
    color:#ffd700;
    font-weight:600;
}

.profile-form input{
    width:100%;
    padding:10px;
    border-radius:12px;
    border:1px solid #d4af37;
    background:#000;
    color:#fff;
}

.profile-form input:focus{
    outline:none;
    border-color:#ffd700;
    box-shadow:0 0 10px rgba(255,215,0,.7);
}

.update-btn{
    margin-top:20px;
    width:100%;
    padding:12px;
    border:none;
    border-radius:40px;
    background:linear-gradient(135deg,#d4af37,#ffd700);
    color:#000;
    font-weight:700;
    letter-spacing:1px;
    transition:0.3s;
}

.update-btn:hover{
    transform:scale(1.05);
    box-shadow:0 0 25px rgba(255,215,0,.9);
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

<div class="profile-card">

    <!-- LEFT -->
    <div class="avatar-box">
        <img src="ImageServlet?entity=user&id=<%= user.getId() %>"
             onerror="this.src='images/user-avatar.png'"
             class="avatar">

        <form action="UploadProfileImageServlet" method="post" enctype="multipart/form-data">
            <label class="upload-btn">
                <i class="fa-solid fa-camera"></i> Change Photo
                <input type="file" name="photo" hidden required>
            </label>
            <br>
            <button type="submit" class="save-photo">Upload</button>
        </form>
    </div>

    <!-- RIGHT -->
    <div class="info-box">
        <h2><%= user.getName() %></h2>
        <p class="email"><i class="fa-solid fa-envelope"></i> <%= user.getEmail() %></p>

        <% if(request.getParameter("success") != null){ %>
            <div class="success"><%= request.getParameter("success") %></div>
        <% } %>

        <form action="UserServlet" method="post" class="profile-form">
            <input type="hidden" name="action" value="update">

            <label>Full Name</label>
            <input type="text" name="name" value="<%= user.getName() %>" required>

            <label>Email (cannot change)</label>
            <input type="email" value="<%= user.getEmail() %>" disabled>

            <label>Password</label>
            <input type="password" name="password" value="<%= user.getPassword() %>" required>

            <label>Phone</label>
            <input type="text" name="phone" value="<%= user.getPhone() %>">

            <button class="update-btn">Update Profile</button>
        </form>
    </div>

</div>

</body>
</html>
