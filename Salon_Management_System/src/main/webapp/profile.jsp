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

    <!-- CSS -->
    <link rel="stylesheet" href="css/profile.css">

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<div class="profile-container">

    <div class="profile-card">

        <!-- Profile Image -->
        <div class="avatar-box">
            <img src="ImageServlet?entity=user&id=<%= user.getId() %>" onerror="this.src='images/user-avatar.png'" class="avatar">
            <form action="UploadProfileImageServlet" method="post" enctype="multipart/form-data">
                <label class="upload-btn">
                    <i class="fa-solid fa-camera"></i> Change Photo
                    <input type="file" name="photo" hidden required>
                </label>
                <button type="submit" class="save-photo">Upload</button>
            </form>
        </div>

        <!-- User Info -->
        <div class="info-box">
            <h2><span class="gold"><%= user.getName() %></span></h2>
            <p class="email"><i class="fa-solid fa-envelope"></i> <%= user.getEmail() %></p>

            <% if(request.getParameter("success") != null){ %>
                <div class="success"><%= request.getParameter("success") %></div>
            <% } %>

            <form action="UserServlet" method="post" class="profile-form">
                <input type="hidden" name="action" value="update">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" value="<%= user.getName() %>" required>
                </div>

                <div class="form-group">
                    <label>Email (cannot change)</label>
                    <input type="email" value="<%= user.getEmail() %>" disabled>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" value="<%= user.getPassword() %>" required>
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" name="phone" value="<%= user.getPhone() %>">
                </div>

                <button class="update-btn">Update Profile</button>
            </form>
        </div>

    </div>

</div>

</body>
</html>