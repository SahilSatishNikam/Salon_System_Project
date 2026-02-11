<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Salon, model.Service, model.Therapist, java.util.List" %>

<%
    Salon salon = (Salon) request.getAttribute("salon");
    List<Service> services = (List<Service>) request.getAttribute("services");
    String error = (String) request.getAttribute("error");

    if(salon == null){
        response.sendRedirect("search-salons.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<<<<<<< Updated upstream
    <title>Book Appointment</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
=======
    <meta charset="UTF-8">
    <title>Book Appointment | SalonEase</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top,#111,#000);
            color: #fff;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
        }

        /* Page Header */
        h2 {
            text-align: center;
            color: #ffd700;
            margin-bottom: 30px;
            font-weight: 600;
        }

        /* Error Message */
        .error-msg {
            background-color: #ff4d4d;
            color: #fff;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 500;
        }

        /* Card Styles */
        .card {
            background: #0b0b0b;
            border: 1px solid #d4af37;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 0 20px rgba(212,175,55,.3);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 35px rgba(212,175,55,0.5);
        }

        .salon-info{
          display:flex;
          flex-direction:row;
          column-gap:90px;
        }
        .salon-info p {
            font-size: 1.1rem;
            margin: 5px 0;
        }

        .salon-info i {
            color: #ffd700;
            margin-right: 8px;
        }

        form label {
            display: block;
            margin-top: 15px;
            font-weight: 500;
            color: #ffd700;
        }

        form select, form input[type="date"], form button {
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            border: 1px solid #d4af37;
            margin-bottom: 15px;
            font-size: 1rem;
            background: #111;
            color: #fff;
        }

        form select:focus, form input[type="date"]:focus {
            outline: none;
            border-color: #ffd700;
            box-shadow: 0 0 10px #ffd700;
        }

        button {
            background: linear-gradient(135deg,#d4af37,#ffd700);
            color: #000;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: linear-gradient(135deg,#ffd700,#e6b800);
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            font-weight: 500;
            color: #ffd700;
        }

        .back-link i {
            margin-right: 5px;
        }

        /* Responsive */
        @media(max-width:768px){
            .card {
                padding: 20px;
            }
        }
    </style>

    <script>
        function loadAvailableSlots() {
            var therapistId = document.getElementById("therapistSelect").value;
            var date = document.getElementById("dateInput").value;
            var timeSelect = document.getElementById("timeSelect");

            timeSelect.innerHTML = "<option value=''>Loading...</option>";

            if(therapistId && date){
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "GetTherapistSlotsServlet?therapistId=" + therapistId + "&date=" + date, true);
                xhr.onreadystatechange = function() {
                    if(xhr.readyState === 4 && xhr.status === 200){
                        var slots = JSON.parse(xhr.responseText);
                        timeSelect.innerHTML = "";
                        if(slots.length > 0){
                            for(var i=0;i<slots.length;i++){
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
>>>>>>> Stashed changes
</head>
<body>
<h2>Book Appointment at <%= salon.getName() %></h2>

<% if(error != null){ %>
    <div style="color:red;"><%= error %></div>
<% } %>

<form action="BookAppointmentServlet" method="post">
    <input type="hidden" name="salonId" value="<%= salon.getId() %>">

<<<<<<< Updated upstream
    <!-- Service -->
    <label>Service:</label>
    <select name="serviceId" id="serviceSelect" required>
        <option value="">-- Select Service --</option>
        <% for(Service s : services){ %>
            <option value="<%= s.getId() %>"><%= s.getName() %> (₹<%= s.getPrice() %>)</option>
        <% } %>
    </select>

    <!-- Therapist -->
    <label>Therapist:</label>
    <select name="therapistId" id="therapistSelect" onchange="loadAvailableSlots()" required>
        <option value="">-- Select Therapist --</option>
        <!-- Populated dynamically based on service -->
    </select>

    <!-- Date -->
    <label>Date:</label>
    <input type="date" name="date" id="dateInput" onchange="loadAvailableSlots()" required min="<%= java.time.LocalDate.now() %>">

    <!-- Time -->
    <label>Time:</label>
    <select name="time" id="timeSelect" required>
        <option value="">Select therapist and date</option>
    </select>

    <button type="submit">Confirm Booking</button>
</form>

<script>
    // Load therapists based on selected service
    $('#serviceSelect').change(function(){
        var serviceId = $(this).val();
        $('#timeSelect').html("<option value=''>Select therapist and date</option>");
        if(serviceId){
            $.get('GetTherapistsByServiceServlet', { serviceId: serviceId }, function(data){
                $('#therapistSelect').html(data);
            });
        } else {
            $('#therapistSelect').html("<option value=''>-- Select Therapist --</option>");
        }
    });

    // Load available slots when therapist or date changes
    function loadAvailableSlots(){
        var therapistId = $('#therapistSelect').val();
        var date = $('#dateInput').val();
        if(therapistId && date){
            $.get('GetTherapistSlotsServlet', { therapistId: therapistId, date: date }, function(response){
                var slots = JSON.parse(response);
                var html = "";
                if(slots.length > 0){
                    for(var i=0; i<slots.length; i++){
                        html += "<option value='"+slots[i]+"'>"+slots[i]+"</option>";
                    }
                } else {
                    html = "<option value=''>No slots available</option>";
                }
                $('#timeSelect').html(html);
            });
        } else {
            $('#timeSelect').html("<option value=''>Select therapist and date</option>");
        }
    }
</script>
=======
    <% if(error != null){ %>
        <div class="error-msg"><i class="fa-solid fa-triangle-exclamation"></i> <%= error %></div>
    <% } %>

    <div class="card">
        <!-- Salon Info -->
        <div class="salon-info mb-3">
            <p><i class="fa-solid fa-shop"></i> <strong><%= salon.getName() %></strong></p>
            <p><i class="fa-solid fa-location-dot"></i> <%= salon.getAddress() %></p>
            <p><i class="fa-solid fa-phone"></i> <%= salon.getPhone() %></p>
        </div>

        <!-- Appointment Form -->
        <form action="<%= request.getContextPath() %>/book-appointment" method="post">
            <input type="hidden" name="salonId" value="<%= salon.getId() %>">

            <label><i class="fa-solid fa-scissors"></i> Select Service</label>
            <select name="serviceId" required>
                <% for(Service s : services){ %>
                    <option value="<%= s.getId() %>"><%= s.getName() %> (₹<%= s.getPrice() %>)</option>
                <% } %>
            </select>

            <label><i class="fa-solid fa-user"></i> Select Therapist</label>
            <select name="therapistId" id="therapistSelect" onchange="loadAvailableSlots()" required>
                <option value="">-- Select Therapist --</option>
                <% for(Therapist t : therapists){ %>
                    <option value="<%= t.getId() %>"><%= t.getName() %> - <%= t.getSpecialty() %></option>
                <% } %>
            </select>

            <label><i class="fa-solid fa-calendar-days"></i> Date</label>
            <input type="date" name="date" id="dateInput" onchange="loadAvailableSlots()" required min="<%= java.time.LocalDate.now() %>">

            <label><i class="fa-solid fa-clock"></i> Time</label>
            <select name="time" id="timeSelect" required>
                <option value="">Select therapist and date</option>
            </select>

            <button type="submit"><i class="fa-solid fa-check"></i> Confirm Booking</button>
        </form>

        <a href="search-salons.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Search</a>
    </div>

</div>
>>>>>>> Stashed changes

</body>
</html>
