<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Salon, model.Service, model.Therapist, java.util.List" %>

<%
    Salon salon = (Salon) request.getAttribute("salon");
    List<Service> services = (List<Service>) request.getAttribute("services");
    List<Therapist> therapists = (List<Therapist>) request.getAttribute("therapists"); // Make sure servlet provides this
    String error = (String) request.getAttribute("error");

    if(salon == null){
        response.sendRedirect("search-salons.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Book Appointment | SalonEase</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
/* ================= GLOBAL RESET ================= */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'times new roman', sans-serif;
    background:#000;
    color:#fff;
    height:100vh;
}

/* ================= MAIN LAYOUT ================= */
.lux-wrapper{
    display:flex;
    height:100vh;
    width:100%;
}

/* ================= LEFT SIDE ================= */
.lux-left{
    width:50%;
    background:#000;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:60px;
}

.left-content{
    max-width:500px;
}

.brand{
    color:#d4af37;
    font-size:22px;
    letter-spacing:4px;
    margin-bottom:80px;
}

.left-content h1{
    font-family:"Times New Roman", serif;
    font-size:80px;
    font-weight:300;
    line-height:1.1;
}

.left-content h1 span{
    display:block;
    color:#d4af37;
}

.left-content p{
    margin-top:30px;
    color:#d0d0d0;
    font-size:17px;
    line-height:1.7;
}

/* ================= RIGHT SIDE ================= */
.lux-right{
    width:50%;
    background:#0b0b0b;
    display:flex;
    justify-content:center;
    align-items:center;
    padding:40px;
}

.booking-box{
height:200px;
    width:450px;
    margin-top:0px;
    margin-bottom:340px   /* was 620px */
}


/* ================= CARD ================= */
.card{

    background:#0f0f0f;
    border:1px solid rgba(212,175,55,.35);
    border-radius:18px;
    padding:22px;          /* reduced from 30px */
    box-shadow:0 0 25px rgba(212,175,55,.12);
}


/* SALON INFO */
.salon-info{
    margin-bottom:25px;
}

.salon-info p{
    color:#cfcfcf;
    font-size:14px;
    margin-bottom:6px;
}

.salon-info i{
    color:#d4af37;
    margin-right:8px;
}

/* ================= FORM ================= */
form label{
    display:block;
    color:#d4af37;
    font-size:12px;
    margin-top:4px;   /* smaller spacing */
    letter-spacing:1px;
}

form select,
form input{
    width:100%;
    background:transparent;
    border:none;
    border-bottom:1px solid rgba(212,175,55,.35);
    padding:8px 0;     /* reduced from 12px */
    color:#fff;
    font-size:14px;
}


form select:focus,
form input:focus{
    outline:none;
    border-bottom:1px solid #d4af37;
    box-shadow:0 8px 20px rgba(212,175,55,.2);
}

/* Button */
button{
    width:100%;
    margin-top:20px;
    padding:12px;   /* smaller */
    border:none;
    border-radius:40px;
    background:linear-gradient(135deg,#d4af37,#f3d37a);
    color:#000;
    font-weight:500;
    letter-spacing:1px;
}


button:hover{
    transform:translateY(-3px);
    box-shadow:0 0 25px rgba(212,175,55,.6);
}

/* ================= RESPONSIVE ================= */

/* Tablet */
@media(max-width:1100px){
    .left-content h1{
        font-size:60px;
    }
}

/* Mobile */
@media(max-width:900px){

    body{
        overflow:auto;
        height:auto;
    }

    .lux-wrapper{
        flex-direction:column;
        height:auto;
    }

    .lux-left{
        width:100%;
        padding:40px 20px;
        text-align:center;
    }

    .brand{
        margin-bottom:40px;
    }

    .left-content h1{
        font-size:50px;
    }

    .lux-right{
        width:100%;
        padding:30px 20px;
    }

    .booking-box{
        width:100%;
        max-width:450px;
    }
}

/* ===== BACK LINK LUXURY STYLE ===== */
.back-link{
    display:inline-flex;
    align-items:center;
    gap:8px;
    margin-top:18px;
    font-size:13px;
    text-decoration:none;
    color:#d4af37;
    letter-spacing:1px;
    padding:10px 18px;
    border-radius:40px;
    border:1px solid rgba(212,175,55,.35);
    transition:all .35s ease;
    position:relative;
    overflow:hidden;
}

/* Arrow animation */
.back-link i{
    transition:transform .35s ease;
}

/* Hover */
.back-link:hover{
    color:#000;
    background:linear-gradient(135deg,#d4af37,#f3d37a);
    box-shadow:0 0 18px rgba(212,175,55,.55);
}

/* Slide arrow left */
.back-link:hover i{
    transform:translateX(-4px);
}


</style>

<script>
function loadAvailableSlots() {
    const therapistId = document.getElementById("therapistSelect").value;
    const date = document.getElementById("dateInput").value;
    const timeSelect = document.getElementById("timeSelect");

    if (!therapistId || !date) {
        timeSelect.innerHTML = "<option value=''>Select therapist and date</option>";
        return;
    }

    const xhr = new XMLHttpRequest();
    xhr.open("GET", "GetAvailableSlotsServlet?therapistId=" + therapistId + "&date=" + date, true);

    xhr.onload = function () {
        if (xhr.status === 200) {
            timeSelect.innerHTML = xhr.responseText;
        } else {
            timeSelect.innerHTML = "<option value=''>Error loading slots</option>";
        }
    };

    xhr.send();
}
</script>


</head>
<body>

<body>

<div class="lux-wrapper">

    <!-- LEFT SIDE -->
    <div class="lux-left">
        <div class="left-content">
            <div class="brand">GOLDENGLOW SALON</div>

            <h1>Refine Your <span>Radiance</span></h1>

            <p>
                Experience a sanctuary of elegance where every detail is curated
                for your ultimate rejuvenation. Your journey to beauty starts here.
            </p>
        </div>
    </div>


    <!-- RIGHT SIDE -->
    <div class="lux-right">
        <div class="booking-box">

            <div class="card">

                <h2>Book Appointment at <%= salon.getName() %></h2>

                <% if(error != null){ %>
                    <div class="error-msg">
                        <i class="fa-solid fa-triangle-exclamation"></i> <%= error %>
                    </div>
                <% } %>

                <!-- SALON INFO -->
                <div class="salon-info">
                    <p><i class="fa-solid fa-shop"></i> <strong><%= salon.getName() %></strong></p>
                    <p><i class="fa-solid fa-location-dot"></i> <%= salon.getAddress() %></p>
                    <p><i class="fa-solid fa-phone"></i> <%= salon.getPhone() %></p>
                </div>

                <!-- FORM -->
                <form action="BookAppointmentServlet" method="post">

                    <input type="hidden" name="salonId" value="<%= salon.getId() %>">

                    <label><i class="fa-solid fa-scissors"></i> Select Service</label>
                    <select name="serviceId" id="serviceSelect" required>
                        <option value="">-- Select Service --</option>
                        <% for(Service s : services){ %>
                            <option value="<%= s.getId() %>">
                                <%= s.getName() %> (₹<%= s.getPrice() %>)
                            </option>
                        <% } %>
                    </select>

                    <label><i class="fa-solid fa-user"></i> Select Therapist</label>
                    <select name="therapistId" id="therapistSelect" onchange="loadAvailableSlots()" required>
                        <option value="">-- Select Therapist --</option>
                        <% for(Therapist t : therapists){ %>
                            <option value="<%= t.getId() %>">
                                <%= t.getName() %> - <%= t.getSpecialty() %>
                            </option>
                        <% } %>
                    </select>

                    <label><i class="fa-solid fa-calendar-days"></i> Date</label>
                    <input type="date"
                           id="dateInput"
                           name="date"
                           onchange="loadAvailableSlots()"
                           required
                           min="<%= java.time.LocalDate.now() %>">

                    <label><i class="fa-solid fa-clock"></i> Time</label>
                    <select name="time" id="timeSelect" required>
                        <option value="">Select therapist and date</option>
                    </select>

                    <button type="submit">
                        <i class="fa-solid fa-check"></i> Confirm Booking
                    </button>

                </form>

                <a href="search-salons.jsp" class="back-link">
                    <i class="fa-solid fa-arrow-left"></i> Back to Search
                </a>

            </div>
        </div>
    </div>

</div>

</body>

</html>
