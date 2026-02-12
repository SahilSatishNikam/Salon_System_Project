<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Therapist, model.Salon" %>

<%
    // Get data from servlet
    List<Therapist> therapists = (List<Therapist>) request.getAttribute("therapists");
    List<Salon> salons = (List<Salon>) request.getAttribute("salons");
    Therapist editTherapist = (Therapist) request.getAttribute("editTherapist");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Therapists</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { background:#111; color:#FFD700; font-family:Poppins; }
        .card { background:#000; border:1px solid #FFD700; color:#FFD700; }
        .btn-gold { background:#FFD700; color:#000; font-weight:600; }
        .table { background:#fff; color:#000; }
        .table th { background:#FFD700; color:#000; }
        .sidebar { width:260px; height:100vh; position:fixed; top:0; left:0; background:#111; padding-top:20px; }
        .sidebar a { display:block; color:#fff; padding:12px; text-decoration:none; margin:5px; border-radius:8px; }
        .sidebar a:hover, .sidebar a.active { background:#FFD700; color:#000; }
        .main { margin-left:270px; padding:30px; }
        .btn-approve { background:#28a745; color:#fff; }
        .btn-reject { background:#dc3545; color:#fff; }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3 class="text-center">Golden Admin</h3>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="manage-salons.jsp">Manage Salons</a>
    <a href="visitedClients">Clients</a>
    <a href="AdminTherapistServlet" class="active">Manage Therapists</a>
    <a href="AdminAppointmentServlet">Appointments</a>
    <a href="feedback.jsp">Feedback</a>
    <a href="reports.jsp">Reports</a>
    <a href="logout.jsp">Logout</a>
</div>

<!-- Main -->
<div class="main">
<h3 class="mb-4"><i class="bi bi-people-fill"></i> Manage Therapists</h3>

<!-- Add / Edit Form -->
<div class="card p-4 mb-4">
<form action="AdminTherapistServlet" method="post" class="row g-3">
    <input type="hidden" name="action" value="<%= (editTherapist != null) ? "update" : "add" %>">
    <% if(editTherapist != null) { %>
        <input type="hidden" name="id" value="<%= editTherapist.getId() %>">
    <% } %>

    <div class="col-md-2">
        <input class="form-control" name="name" placeholder="Name" required
               value="<%= (editTherapist != null) ? editTherapist.getName() : "" %>">
    </div>
    <div class="col-md-2">
        <input class="form-control" name="phone" placeholder="Phone" required
               value="<%= (editTherapist != null) ? editTherapist.getPhone() : "" %>">
    </div>
    <div class="col-md-2">
        <input class="form-control" name="email" placeholder="Email" required
               value="<%= (editTherapist != null) ? editTherapist.getEmail() : "" %>">
    </div>
    <div class="col-md-2">
        <input class="form-control" name="specialty" placeholder="Specialty"
               value="<%= (editTherapist != null) ? editTherapist.getSpecialty() : "" %>">
    </div>
    <div class="col-md-2">
        <select name="salonId" class="form-select" required>
            <option value="">Assign Salon</option>
            <% for(Salon s : salons) { %>
                <option value="<%=s.getId()%>" 
                    <%= (editTherapist != null && editTherapist.getSalonId() == s.getId()) ? "selected" : "" %>>
                    <%=s.getName()%>
                </option>
            <% } %>
        </select>
    </div>
    <div class="col-md-2">
        <input type="password" class="form-control" name="password" placeholder="Password"
               value="<%= (editTherapist != null) ? editTherapist.getPassword() : "" %>" required>
    </div>

    <div class="col-12 mt-2">
        <button class="btn btn-gold">
            <%= (editTherapist != null) ? "Update Therapist" : "Add Therapist" %>
        </button>
    </div>
</form>
</div>

<!-- Therapists Table -->
<div class="card p-3">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Specialty</th>
                <th>Salon</th>
                <th>Status</th>
                <th>Approved</th>
                <th>Decision</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% if(therapists != null && !therapists.isEmpty()) {
                   for(Therapist t : therapists) { %>
                <tr>
                    <td><%= t.getId() %></td>
                    <td><%= t.getName() %></td>
                    <td><%= t.getPhone() %></td>
                    <td><%= t.getEmail() %></td>
                    <td><%= t.getSpecialty() %></td>
                    <td>
                        <% for(Salon s : salons) {
                            if(s.getId() == t.getSalonId()) { out.print(s.getName()); break; }
                        } %>
                    </td>
                    <td><%= t.getStatus() != null ? t.getStatus() : "Inactive" %></td>
                    <td><%= t.getApproved() == 1 ? "Yes" : "No" %></td>
                    <td><%= t.getTherapistDecision() != null ? t.getTherapistDecision() : "PENDING" %></td>
                    <td>
                        <!-- Edit / Delete -->
                        <a href="AdminTherapistServlet?action=edit&id=<%=t.getId()%>" class="btn btn-sm btn-primary mb-1">
                            <i class="fa fa-edit"></i> Edit
                        </a>
                        <a href="AdminTherapistServlet?action=delete&id=<%=t.getId()%>" class="btn btn-sm btn-danger mb-1" onclick="return confirm('Are you sure?');">
                            <i class="fa fa-trash"></i> Delete
                        </a>

                        <!-- Approve / Reject -->
                        <% if(t.getApproved() != 1) { %>
                            <a href="AdminTherapistServlet?action=approve&id=<%=t.getId()%>" class="btn btn-sm btn-approve mb-1">
                                <i class="fa fa-check"></i> Approve
                            </a>
                            <a href="AdminTherapistServlet?action=reject&id=<%=t.getId()%>" class="btn btn-sm btn-reject mb-1">
                                <i class="fa fa-times"></i> Reject
                            </a>
                        <% } %>
                    </td>
                </tr>
            <%   }
               } else { %>
                <tr>
                    <td colspan="10" class="text-center">No therapists found</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

</div>
</body>
</html>
