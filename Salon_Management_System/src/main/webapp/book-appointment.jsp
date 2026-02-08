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

<html>
<head>
    <title>Book Appointment</title>
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

<h2>Booking for: <%= salon.getName() %></h2>
<p>Address: <%= salon.getAddress() %></p>
<p>Contact: <%= salon.getPhone() %></p>

<% if(error != null){ %>
    <div style="color:red;"><%= error %></div>
<% } %>

<form action="<%= request.getContextPath() %>/book-appointment" method="post">

    <input type="hidden" name="salonId" value="<%= salon.getId() %>">

    <!-- SERVICE -->
    <label>Select Service:</label>
    <select name="serviceId" required>
        <% for(Service s : services){ %>
            <option value="<%= s.getId() %>">
                <%= s.getName() %> (₹<%= s.getPrice() %>)
            </option>
        <% } %>
    </select>
    <br><br>

    <!-- THERAPIST -->
    <label>Select Therapist:</label>
    <select name="therapistId" id="therapistSelect" onchange="loadAvailableSlots()" required>
        <option value="">-- Select Therapist --</option>
        <% for(Therapist t : therapists){ %>
            <option value="<%= t.getId() %>">
                <%= t.getName() %> - <%= t.getSpecialty() %>
            </option>
        <% } %>
    </select>
    <br><br>

    <!-- DATE -->
    <label>Date:</label>
    <input type="date" name="date" id="dateInput" onchange="loadAvailableSlots()" required min="<%= java.time.LocalDate.now() %>">
    <br><br>

    <!-- TIME -->
    <label>Time:</label>
    <select name="time" id="timeSelect" required>
        <option value="">Select therapist and date</option>
    </select>
    <br><br>

    <button type="submit">Confirm Booking</button>
</form>

<br>
<a href="search-salons.jsp">← Back</a>

</body>
</html>
