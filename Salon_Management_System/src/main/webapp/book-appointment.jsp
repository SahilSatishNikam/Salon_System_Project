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
</head>
<body>

<h2>Booking for: <%= salon.getName() %></h2>
<p>Address: <%= salon.getAddress() %></p>
<p>Contact: <%= salon.getPhone() %></p>

<% if(error != null){ %>
    <div style="color:red;"><%= error %></div>
<% } %>

<form action="BookAppointmentServlet" method="post">
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
    <select name="therapistId" required>
        <% for(Therapist t : therapists){ %>
            <option value="<%= t.getId() %>">
                <%= t.getName() %> - <%= t.getSpecialty() %>
            </option>
        <% } %>
    </select>
    <br><br>

    <!-- DATE -->
    <label>Date:</label>
    <input type="date" name="date" required min="<%= java.time.LocalDate.now() %>">
    <br><br>

    <!-- TIME -->
    <label>Time:</label>
    <input type="time" name="time" required>
    <br><br>

    <button type="submit">Confirm Booking</button>
</form>

<br>
<a href="search-salons.jsp">← Back</a>

</body>
</html>
