<%@ page import="java.util.*, model.AdminClientView" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Salon Clients</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4">All Clients</h2>

    <form method="get" class="mb-3">
        <input type="text" name="search" class="form-control w-25 d-inline" placeholder="Search by name or phone">
        <button class="btn btn-primary">Search</button>
    </form>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Total Visits</th>
                <th>Last Visit</th>
                <th>Salon</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<AdminClientView> clients = (List<AdminClientView>) request.getAttribute("clients");
                int i = 1;
                if(clients != null){
                    for(AdminClientView c : clients){
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= c.getName() %></td>
                <td><%= c.getPhone() %></td>
                <td><%= c.getTotalVisits() %></td>
                <td><%= c.getLastVisit() != null ? c.getLastVisit() : "-" %></td>
                <td><%= c.getSalonName() != null ? c.getSalonName() : "-" %></td>
            </tr>
            <% 
                    }
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>
