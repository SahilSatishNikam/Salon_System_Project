<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Therapist, model.Salon" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Therapists</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #111;
            color: #f5c518;
        }

        .main {
            margin-left: 250px;
            padding: 30px;
        }

        .card {
            background: #000;
            border: 1px solid #f5c518;
            color: #f5c518;
        }

        .table {
            background: white;
            color: black;
        }

        .table th {
            background: #f5c518;
            color: black;
        }

        .btn-gold {
            background: #f5c518;
            color: black;
            font-weight: 600;
        }

        .btn-gold:hover {
            background: #d4a90f;
            color: black;
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<%@ include file="sidebar.jsp" %>

<!-- MAIN CONTENT -->
<div class="main">

    <h3 class="mb-4">
        <i class="bi bi-people-fill"></i> Manage Therapists
    </h3>

    <!-- ADD THERAPIST -->
    <form action="AdminTherapistServlet" method="post" class="card p-4 mb-4 shadow">
        <input type="hidden" name="action" value="add">

        <h5 class="mb-3">
            <i class="bi bi-person-plus"></i> Add New Therapist
        </h5>

        <div class="row g-3">
            <div class="col-md-2">
                <input class="form-control" name="name" placeholder="Name" required>
            </div>

            <div class="col-md-2">
                <input class="form-control" name="phone" placeholder="Phone" required>
            </div>

            <div class="col-md-2">
                <input class="form-control" name="email" placeholder="Email" required>
            </div>

            <div class="col-md-2">
                <input class="form-control" name="specialty" placeholder="Specialty">
            </div>

            <div class="col-md-2">
                <select name="salonId" class="form-select" required>
                    <option value="">Assign Salon</option>
                    <%
                        if(request.getAttribute("salons") != null){
                            List<Salon> salons = (List<Salon>) request.getAttribute("salons");
                            for(Salon s : salons){
                    %>
                        <option value="<%= s.getId() %>"><%= s.getName() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <div class="col-md-2">
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>
        </div>

        <button class="btn btn-gold mt-3">
            <i class="bi bi-plus-circle"></i> Add Therapist
        </button>
    </form>

    <!-- THERAPIST TABLE -->
    <div class="card p-3 shadow">
        <h5 class="mb-3">
            <i class="bi bi-table"></i> Therapist List
        </h5>

        <table class="table table-bordered table-striped text-center align-middle">
            <tr>
                <th><i class="bi bi-person"></i> Name</th>
                <th><i class="bi bi-telephone"></i> Phone</th>
                <th><i class="bi bi-envelope"></i> Email</th>
                <th><i class="bi bi-award"></i> Specialty</th>
                <th><i class="bi bi-shop"></i> Salon</th>
                <th><i class="bi bi-toggle-on"></i> Status</th>
                <th><i class="bi bi-patch-check"></i> Approved</th>
                <th><i class="bi bi-gear"></i> Actions</th>
            </tr>

            <%
                if(request.getAttribute("therapists") != null){
                    List<Therapist> therapists = (List<Therapist>) request.getAttribute("therapists");
                    for(Therapist t : therapists){
                        String statusClass = "Active".equals(t.getStatus()) ? "bg-success" : "bg-danger";
                        String approvedClass = t.getApproved() == 1 ? "bg-success" : "bg-warning";
                        String approvedText = t.getApproved() == 1 ? "Approved" : "Pending";
                        String toggleStatus = "Active".equals(t.getStatus()) ? "Inactive" : "Active";
            %>
                <tr>
                    <td><%= t.getName() %></td>
                    <td><%= t.getPhone() %></td>
                    <td><%= t.getEmail() %></td>
                    <td><%= t.getSpecialty() %></td>
                    <td><%= t.getSalonId() %></td>

                    <td><span class="badge <%= statusClass %>"><%= t.getStatus() %></span></td>
                    <td><span class="badge <%= approvedClass %>"><%= approvedText %></span></td>

                    <td>
                        <!-- Activate / Deactivate -->
                        <form action="AdminTherapistServlet" method="post" class="d-inline">
                            <input type="hidden" name="action" value="status">
                            <input type="hidden" name="therapistId" value="<%= t.getId() %>">
                            <input type="hidden" name="status" value="<%= toggleStatus %>">
                            <button class="btn btn-sm btn-warning">
                                <i class="bi bi-power"></i> <%= "Active".equals(t.getStatus()) ? "Deactivate" : "Activate" %>
                            </button>
                        </form>

                        <!-- Approve -->
                        <%
                            if(t.getApproved() != 1){
                        %>
                        <form action="ApproveTherapistServlet" method="post" class="d-inline">
                            <input type="hidden" name="therapistId" value="<%= t.getId() %>">
                            <button class="btn btn-sm btn-success">
                                <i class="bi bi-check-circle"></i> Approve
                            </button>
                        </form>
                        <% } %>
                    </td>
                </tr>
            <% 
                    }
                }
            %>
        </table>
    </div>

</div>

</body>
</html>
