<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Salon, model.User" %>

<%
    User owner = (User) session.getAttribute("user");
    Salon salon = (Salon) session.getAttribute("salon");

    if (owner == null || salon == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Therapist</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card p-4 shadow col-md-6 mx-auto">
        <h3 class="text-center mb-3">Add Therapist</h3>

        <form action="AddTherapistServlet" method="post">
            <input class="form-control mb-2" name="name" placeholder="Name" required>
            <input class="form-control mb-2" name="email" placeholder="Email" required>
            <input class="form-control mb-2" name="phone" placeholder="Phone" required>
            <input class="form-control mb-2" name="specialty" placeholder="Specialty" required>
            <input class="form-control mb-3" name="password" type="password" placeholder="Create Password" required>
            <button class="btn btn-success w-100">Add Therapist</button>
        </form>
    </div>
</div>

</body>
</html>
