<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

        .sidebar {
            height: 100vh;
            background: #000;
            padding: 20px;
            position: fixed;
            width: 230px;
        }

        .sidebar h4 {
            color: #f5c518;
            font-weight: bold;
        }

        .sidebar a {
            color: #f5c518;
            text-decoration: none;
            display: block;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 8px;
        }

        .sidebar a i {
            margin-right: 8px;
        }

        .sidebar a:hover {
            background: #f5c518;
            color: black;
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
<div class="sidebar">
    <h4><i class="bi bi-gem"></i> Admin Panel</h4>

    <a href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="manage-salons.jsp"><i class="bi bi-shop"></i> Salons</a>
    <a href="manageVerifyAdmins.jsp"><i class="bi bi-shield-check"></i> Admins</a>
    <a href="AdminTherapistServlet"><i class="bi bi-person-badge"></i> Therapists</a>
    <a href="AdminAppointmentServlet"><i class="bi bi-calendar-check"></i> Appointments</a>
    <a href="user-dashboard.jsp"><i class="bi bi-people"></i> Users</a>
    <a href="feedback.jsp"><i class="bi bi-chat-left-text"></i> Feedback</a>
    <a href="reports.jsp"><i class="bi bi-bar-chart"></i> Reports</a>
    <a href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>

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
                    <c:forEach var="s" items="${salons}">
                        <option value="${s.id}">
                            ${s.name}
                        </option>
                    </c:forEach>
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

            <c:forEach var="t" items="${therapists}">
                <tr>
                    <td>${t.name}</td>
                    <td>${t.phone}</td>
                    <td>${t.email}</td>
                    <td>${t.specialty}</td>
                    <td>${t.salonId}</td>

                    <td>
                        <span class="badge ${t.status=='Active'?'bg-success':'bg-danger'}">
                            ${t.status}
                        </span>
                    </td>

                    <td>
                        <span class="badge ${t.approved==1?'bg-success':'bg-warning'}">
                            ${t.approved==1?'Approved':'Pending'}
                        </span>
                    </td>

                    <td>

                        <!-- Activate / Deactivate -->
                        <form action="AdminTherapistServlet" method="post" class="d-inline">
                            <input type="hidden" name="action" value="status">
                            <input type="hidden" name="therapistId" value="${t.id}">
                            <input type="hidden" name="status" value="${t.status=='Active'?'Inactive':'Active'}">

                            <button class="btn btn-sm btn-warning">
                                <i class="bi bi-power"></i>
                                ${t.status=='Active'?'Deactivate':'Activate'}
                            </button>
                        </form>

                        <!-- Approve -->
                        <c:if test="${t.approved != 1}">
                            <form action="ApproveTherapistServlet" method="post" class="d-inline">
                                <input type="hidden" name="therapistId" value="${t.id}">
                                <button class="btn btn-sm btn-success">
                                    <i class="bi bi-check-circle"></i> Approve
                                </button>
                            </form>
                        </c:if>

                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

</div>

</body>
</html>
