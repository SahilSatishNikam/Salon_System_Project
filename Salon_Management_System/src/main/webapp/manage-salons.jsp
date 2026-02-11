<<<<<<< Updated upstream
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Salons</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: #0f0f0f;
            color: #fff;
        }

        /* SIDEBAR is included separately */
        .content {
            margin-left: 250px;
            padding: 30px;
            width: calc(100% - 250px);
        }

        h2 {
            color: #FFD700;
            margin-bottom: 15px;
        }

        form input, form select, form button {
            padding: 10px;
            margin: 6px 6px 6px 0;
            border: 1px solid #333;
            border-radius: 6px;
            background: #000;
            color: #fff;
        }

        button {
            background: linear-gradient(45deg, #FFD700, #ffb300);
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 18px;
            background: #111;
        }

        th {
            background: #FFD700;
            color: #000;
        }

        td, th {
            border: 1px solid #222;
            padding: 12px;
            vertical-align: middle;
        }

        .service-table {
            margin-left: 30px;
            width: 90%;
            background: #000;
        }

        img {
            border-radius: 8px;
            border: 2px solid #FFD700;
        }

        .toggle-btn {
            cursor: pointer;
            color: #FFD700;
            margin-left: 6px;
        }
    </style>

    <script>
        function toggleServiceForm(id) {
            const f = document.getElementById("serviceForm-" + id);
            f.style.display = (f.style.display === "none") ? "block" : "none";
        }
    </script>
=======
<%@ page import="java.util.*, dao.SalonDAO, model.Salon" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Manage Salons | Admin Panel</title>

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
    margin:0;
    font-family:'Poppins',sans-serif;
    background: linear-gradient(135deg, #0f0f0f, #1a1a1a);
    color:#fff;
    display:flex;
}

/* ===== SIDEBAR ===== */
.sidebar { width:250px; background:#000; min-height:100vh; position:fixed; border-right:2px solid #FFD700; padding-top:10px; }
.sidebar h2 { text-align:center; padding:20px; color:#FFD700; font-weight:600; border-bottom:1px solid #222; font-size:1.3rem; }
.sidebar a { display:flex; align-items:center; color:#fff; padding:14px 22px; text-decoration:none; border-bottom:1px solid #111; font-weight:500; font-size:19px; }
.sidebar a i { margin-right:12px; font-size:1.1rem; }
.sidebar a:hover, .sidebar a.active { background:#FFD700; color:#000; padding-left:28px; }

/* ===== MAIN CONTENT ===== */
.main-content { margin-left:250px; padding:40px; width:calc(100% - 250px); }

/* ===== ADD SALON FORM ===== */
.salon-form {
    background: rgba(30,30,30,0.8);
    padding:30px; border-radius:20px; max-width:900px; margin-bottom:50px;
    border:2px solid #FFD700; backdrop-filter: blur(10px);
}
.salon-form h3 { text-align:center; color:#FFD700; margin-bottom:25px; font-size:28px; }
.salon-form .form-row { display:flex; gap:20px; margin-bottom:15px; flex-wrap:wrap; }
.salon-form input[type="text"], .salon-form input[type="file"] {
    flex:1; padding:12px 15px; border-radius:12px; border:2px solid #FFD700; background:#111; color:#fff;
}
.salon-form input:focus { outline:none; border-color:#ffea00; box-shadow:0 0 15px rgba(255,215,0,.7); }
.salon-form input[type="file"]::file-selector-button {
    background:#FFD700; border:none; padding:8px 15px; border-radius:12px; font-weight:600; cursor:pointer; color:#000;
}
.salon-form button {
    width:100%; padding:14px; font-size:18px; font-weight:700; color:#000;
    background:linear-gradient(45deg,#FFD700,#ffea00); border:none; border-radius:12px; cursor:pointer;
}
.salon-form button:hover { box-shadow:0 8px 25px rgba(255,215,0,.8); }

/* ===== SALON CARD ===== */
.card.bg-dark {
    border-radius: 25px;
    background: rgba(20,20,20,0.6);
    backdrop-filter: blur(15px);
    border: 2px solid transparent;
    position: relative;
    overflow: hidden;
    box-shadow: 0 10px 20px rgba(255, 215, 0, 0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease, border 0.3s ease;
}

.card.bg-dark::before {
    content: "";
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    z-index: 0;
    opacity: 0.2;
    transform: rotate(0deg);
    transition: opacity 0.3s ease;
}

.card.bg-dark:hover::before {
    opacity: 0.6;
    animation: shimmer 4s linear infinite;
}

@keyframes shimmer {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.card.bg-dark .card-body {
    position: relative;
    z-index: 1;
    display: flex;
    flex-direction: column;
}

.card.bg-dark:hover {
    transform: scale(1.05);
    box-shadow: 0 20px 40px rgba(255, 215, 0, 0.5);
    border: 2px solid #FFD700;
}

.card-img-top {
    border-radius: 25px;
    height: 220px;
    object-fit: cover;
    margin-bottom: 15px;
    border: 2px solid #FFD700;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card-img-top:hover {
    transform: scale(1.1);
    box-shadow: 0 15px 30px rgba(255, 215, 0, 0.4);
}

.card-title {
    color: #FFD700;
    font-weight: 700;
    font-size: 1.5rem;
    margin-bottom: 10px;
}

.card-text i {
    margin-right: 8px;
    color: #FFD700;
}

.card-body .actions a {
    font-size: 1.5rem;
    transition: color 0.3s, transform 0.3s;
}

.card-body .actions a:hover {
    color: #ffea00;
    transform: scale(1.4);
}

/* ADD SUBTLE GRADIENT TO CARD BACKGROUND */
.card.bg-dark::after {
    content: "";
    position: absolute;
    inset: 0;
    background: linear-gradient(135deg, rgba(255, 215, 0, 0.1), rgba(255, 255, 255, 0.05));
    border-radius: 25px;
    pointer-events: none;
    z-index: 0;
}

/* RESPONSIVE GRID */
@media(max-width:1200px){ .col-lg-4{ margin-bottom:20px; } }

</style>
>>>>>>> Stashed changes
</head>
<body>

<!-- SIDEBAR -->
<<<<<<< Updated upstream
<%@ include file="sidebar.jsp" %>

<!-- MAIN CONTENT -->
<div class="content">

    <!-- ADD NEW SALON -->
    <h2><i class="fa-solid fa-circle-plus"></i> Add New Salon</h2>
    <form method="post" action="AddSalonServlet" enctype="multipart/form-data">
        <input type="text" name="name" placeholder="Salon Name" required>
        <input type="text" name="email" placeholder="Email">
        <input type="text" name="phone" placeholder="Phone">
        <input type="text" name="address" placeholder="Address">
        <input type="file" name="image" required>
        <button type="submit"><i class="fa-solid fa-floppy-disk"></i> Add</button>
    </form>

    <!-- LIST ALL SALONS -->
    <h2><i class="fa-solid fa-shop"></i> All Salons</h2>

    <%
        SalonDAO salonDAO = new SalonDAO();
        ServiceDAO serviceDAO = new ServiceDAO();
        List<Salon> salons = salonDAO.getAllSalons();

        for (Salon s : salons) {
            s.setServices(serviceDAO.getServicesBySalon(s.getId()));
    %>

    <table>
        <tr>
            <td rowspan="2" style="width:100px;">
                <% if (s.getImage() != null) { %>
                    <img src="SalonImageServlet?id=<%= s.getId() %>" width="80" height="80">
                <% } %>
            </td>
            <td><b style="color:#FFD700;"><%= s.getName() %></b></td>
            <td><%= s.getEmail() %></td>
            <td><%= s.getPhone() %></td>
            <td><%= s.getAddress() %></td>
            <td>
                <a href="EditSalonServlet?id=<%= s.getId() %>"><i class="fa-solid fa-pen-to-square"></i></a>
                <a href="DeleteSalonServlet?id=<%= s.getId() %>" onclick="return confirm('Delete this salon?')"><i class="fa-solid fa-trash"></i></a>
                <span class="toggle-btn" onclick="toggleServiceForm(<%= s.getId() %>)">
                    <i class="fa-solid fa-scissors"></i> Services
                </span>
            </td>
        </tr>

        <tr>
            <td colspan="5">
                <div id="serviceForm-<%= s.getId() %>" style="display:none; margin-top:10px;">

                    <!-- ADD SERVICE FORM -->
                    <h4 style="color:#FFD700;"><i class="fa-solid fa-cut"></i> Add Service</h4>
                    <form method="post" action="AddServiceServlet">
                        <input type="hidden" name="salonId" value="<%= s.getId() %>">
                        <input type="text" name="name" placeholder="Service Name" required>
                        <input type="text" name="description" placeholder="Description">
                        <input type="number" name="price" placeholder="Price" step="0.01" required>
                        <input type="number" name="durationMinutes" placeholder="Duration (min)" required>
                        <button type="submit"><i class="fa-solid fa-plus"></i> Add</button>
                    </form>

                    <!-- LIST SERVICES -->
                    <table class="service-table">
                        <tr>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Duration</th>
                            <th>Action</th>
                        </tr>
                        <% if (s.getServices() != null) {
                            for (Service srv : s.getServices()) { %>
                                <tr>
                                    <td><%= srv.getName() %></td>
                                    <td>₹<%= srv.getPrice() %></td>
                                    <td><%= srv.getDurationMinutes() %> min</td>
                                    <td>
                                        <a href="EditServiceServlet?id=<%= srv.getId() %>"><i class="fa-solid fa-pen-to-square"></i></a>
                                        <a href="DeleteServiceServlet?id=<%= srv.getId() %>&salonId=<%= s.getId() %>" onclick="return confirm('Delete this service?')"><i class="fa-solid fa-trash"></i></a>
                                    </td>
                                </tr>
                        <%  } } %>
                    </table>

                </div>
            </td>
        </tr>
    </table>

    <% } %>

</div>

=======
<div class="sidebar">
    <h2><i class="fa fa-gem"></i> SalonEase Admin</h2>
    <a href="dashboard.jsp"><i class="fa fa-tachometer-alt"></i> Dashboard</a>
    <a href="manage-salons.jsp" class="active"><i class="fa fa-store"></i> Manage Salons</a>
    <a href="visitedClients"><i class="fa fa-users"></i> Clients</a>
    <a href="AdminTherapistServlet"><i class="fa fa-user-tie"></i> Manage Therapists</a>
    <a href="AdminAppointmentServlet"><i class="fa fa-calendar-check"></i> Appointments</a>
    <a href="feedback.jsp"><i class="fa fa-comment-alt"></i> Feedback</a>
    <a href="reports.jsp"><i class="fa fa-chart-bar"></i> Reports</a>
    <a href="logout.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">

    <!-- ADD SALON FORM -->
    <form method="post" action="AddSalonServlet" enctype="multipart/form-data" class="salon-form">
        <h3><i class="fa-solid fa-circle-plus"></i> Add New Salon</h3>
        <div class="form-row">
            <input type="text" name="name" placeholder="Salon Name" required>
            <input type="text" name="email" placeholder="Email">
        </div>
        <div class="form-row">
            <input type="text" name="phone" placeholder="Phone">
            <input type="text" name="address" placeholder="Address">
        </div>
        <div class="form-row">
            <input type="file" name="image" required>
        </div>
        <button type="submit"><i class="fa-solid fa-floppy-disk"></i> Add Salon</button>
    </form>

    <!-- SALON LIST -->
    <h2 style="margin-top:50px; margin-bottom:40px;"><i class="fa-solid fa-shop"></i> All Salons</h2>
    <div class="row g-4">
        <%
            SalonDAO salonDAO = new SalonDAO();
            List<Salon> salons = salonDAO.getAllSalons();
            for(Salon s : salons){
        %>
        <div class="col-lg-4 col-md-6 col-sm-12">
            <div class="card bg-dark text-white h-100 shadow-sm">
                <% if(s.getImage() != null){ %>
                <img src="SalonImageServlet?id=<%=s.getId()%>" class="card-img-top" alt="Salon Image">
                <% } %>
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><i class="fa-solid fa-store"></i> <%=s.getName()%></h5>
                    <p class="card-text mb-1"><i class="fa-solid fa-envelope"></i> <%=s.getEmail()%></p>
                    <p class="card-text mb-1"><i class="fa-solid fa-phone"></i> <%=s.getPhone()%></p>
                    <p class="card-text"><i class="fa-solid fa-location-dot"></i> <%=s.getAddress()%></p>

                    <div class="mt-auto d-flex justify-content-between actions">
                        <a href="EditSalonServlet?id=<%=s.getId()%>" class="text-warning" title="Edit Salon"><i class="fa-solid fa-pen-to-square"></i></a>
                        <a href="DeleteSalonServlet?id=<%=s.getId()%>" class="text-warning" onclick="return confirm('Delete?')" title="Delete Salon"><i class="fa-solid fa-trash"></i></a>
                        <a href="#" class="text-warning" data-bs-toggle="modal" data-bs-target="#serviceModal-<%=s.getId()%>" title="Add Service"><i class="fa-solid fa-scissors"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- ADD SERVICE MODAL -->
        <div class="modal fade" id="serviceModal-<%=s.getId()%>" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="background:#111; color:#fff; border:2px solid #FFD700;">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Service for <%=s.getName()%></h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="AddServiceServlet">
                            <input type="hidden" name="salonId" value="<%=s.getId()%>">
                            <div class="mb-3">
                                <input type="text" name="name" placeholder="Service Name" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <input type="text" name="description" placeholder="Description" class="form-control">
                            </div>
                            <div class="mb-3">
                                <input type="number" name="price" placeholder="Price" step="0.01" class="form-control">
                            </div>
                            <div class="mb-3">
                                <input type="number" name="durationMinutes" placeholder="Duration (min)" class="form-control">
                            </div>
                            <button type="submit" class="btn btn-warning w-100"><i class="fa-solid fa-plus"></i> Add Service</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <% } %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
>>>>>>> Stashed changes
</body>
</html>
