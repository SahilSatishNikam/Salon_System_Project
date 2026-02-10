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
</head>

<body>

<!-- SIDEBAR -->
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

</body>
</html>
