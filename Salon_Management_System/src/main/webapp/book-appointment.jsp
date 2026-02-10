<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Salon, model.Service, model.Therapist, java.util.List" %>

<%
    Salon salon = (Salon) request.getAttribute("salon");
    List<Service> services = (List<Service>) request.getAttribute("services");
    List<Therapist> therapists = (List<Therapist>) request.getAttribute("therapists");
    String error = (String) request.getAttribute("error");

    if(salon == null){
        response.sendRedirect("search-salons.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        /* ===== GLOBAL STYLES ===== */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #1a1a1a;
            color: #fff;
            margin: 0;
            padding: 0;
        }

        a {
            color: #ffc107;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }

        h2 {
            color: #ffc107;
            text-align: center;
        }

        .container {
            max-width: 700px;
            margin: 40px auto;
            background-color: #111;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(255, 193, 7, 0.5);
        }

        .salon-info p {
            margin: 5px 0;
            font-size: 1.1em;
        }

        .error-msg {
            background-color: #ff4d4d;
            color: #fff;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
        }

        form label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: 500;
        }

        form select, form input[type="date"], form button {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: none;
            font-size: 1em;
            margin-bottom: 10px;
        }

        select, input[type="date"] {
            background-color: #222;
            color: #fff;
        }

        button {
            background-color: #ffc107;
            color: #111;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background-color: #e6b800;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            font-weight: 500;
        }

        .back-link i {
            margin-right: 5px;
        }

        /* Icon inside select */
        select option::before {
            content: "\f007"; /* user icon example */
            font-family: "Font Awesome 6 Free";
            padding-right: 5px;
        }

    </style>

    <script>
        function loadAvailableSlots() {
            var therapistId = document.getElementById("therapistSelect").value;
            var date = document.getElementById("dateInput").value;
            var timeSelect = document.getElementById("timeSelect");

            // Clear previous options
            timeSelect.innerHTML = "<option value=''>Loading...</option>";

            if(therapistId && date){
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "GetTherapistSlotsServlet?therapistId=" + therapistId + "&date=" + date, true);
                xhr.onreadystatechange = function() {
                    if(xhr.readyState === 4 && xhr.status === 200){
                        var slots = JSON.parse(xhr.responseText);
                        timeSelect.innerHTML = "";
                        if(slots.length > 0){
                            for(var i=0; i<slots.length; i++){
                                timeSelect.innerHTML += "<option value='"+slots[i]+"'>"+slots[i]+"</option>";
                            }
                        } else {
                            timeSelect.innerHTML = "<option value=''>No slots available</option>";
                        }
                    }
                };
                xhr.send();
            } else {
                timeSelect.innerHTML = "<option value=''>Select therapist and date</option>";
            }
        }
    </script>
</head>
<body>

<div class="container">

    <h2><i class="fa-solid fa-calendar-check"></i> Book Appointment</h2>

    <div class="salon-info">
        <p><i class="fa-solid fa-shop"></i> <strong><%= salon.getName() %></strong></p>
        <p><i class="fa-solid fa-location-dot"></i> <%= salon.getAddress() %></p>
        <p><i class="fa-solid fa-phone"></i> <%= salon.getPhone() %></p>
    </div>

    <% if(error != null){ %>
        <div class="error-msg"><i class="fa-solid fa-triangle-exclamation"></i> <%= error %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/book-appointment" method="post">

        <input type="hidden" name="salonId" value="<%= salon.getId() %>">

        <!-- SERVICE -->
        <label><i class="fa-solid fa-scissors"></i> Select Service:</label>
        <select name="serviceId" required>
            <% for(Service s : services){ %>
                <option value="<%= s.getId() %>">
                    <%= s.getName() %> (₹<%= s.getPrice() %>)
                </option>
            <% } %>
        </select>

        <!-- THERAPIST -->
        <label><i class="fa-solid fa-user"></i> Select Therapist:</label>
        <select name="therapistId" id="therapistSelect" onchange="loadAvailableSlots()" required>
            <option value="">-- Select Therapist --</option>
            <% for(Therapist t : therapists){ %>
                <option value="<%= t.getId() %>">
                    <%= t.getName() %> - <%= t.getSpecialty() %>
                </option>
            <% } %>
        </select>

        <!-- DATE -->
        <label><i class="fa-solid fa-calendar-days"></i> Date:</label>
        <input type="date" name="date" id="dateInput" onchange="loadAvailableSlots()" required min="<%= java.time.LocalDate.now() %>">

        <!-- TIME -->
        <label><i class="fa-solid fa-clock"></i> Time:</label>
        <select name="time" id="timeSelect" required>
            <option value="">Select therapist and date</option>
        </select>

        <button type="submit"><i class="fa-solid fa-check"></i> Confirm Booking</button>
    </form>

    <a href="search-salons.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back</a>

</div>

</body>
</html>
