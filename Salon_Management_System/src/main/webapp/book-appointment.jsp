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
<html>
<head>
    <title>Book Appointment</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>Book Appointment at <%= salon.getName() %></h2>

<% if(error != null){ %>
    <div style="color:red;"><%= error %></div>
<% } %>

<form action="BookAppointmentServlet" method="post">
    <input type="hidden" name="salonId" value="<%= salon.getId() %>">

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

</body>
</html>
