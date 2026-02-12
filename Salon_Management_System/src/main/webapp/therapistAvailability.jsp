<%@ page contentType="text/html;charset=UTF-8" %>
<%
model.Therapist t = (model.Therapist) session.getAttribute("therapist");
if(t == null){ response.sendRedirect("login.jsp"); return; }
%>

<!DOCTYPE html>
<html>
<head>
<title>Set Availability</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
/* =====================================
   GLOBAL SETTINGS
===================================== */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:"Times New Roman", Times, serif;
}

body{
    background:#000;
    color:#fff;
}

/* =========================================
   SIDEBAR CONTAINER
========================================= */
.sidebar{
    width:260px;
    height:100vh;
    position:fixed;
    top:0;
    left:0;
    background:linear-gradient(180deg,#0b0b0b,#111);
    border-right:1px solid #1a1a1a;
    backdrop-filter:blur(6px);
    padding-top:10px;
    overflow:hidden;

    display:flex;
    flex-direction:column;
    justify-content:space-between;

    animation:sidebarSlide 0.8s ease;
}

/* Golden vertical glow line */
.sidebar::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:3px;
    height:100%;
    background:linear-gradient(to bottom,#d4af37,#ffd700,#d4af37);
    box-shadow:0 0 15px #d4af37;
}

/* =========================================
   TOP SECTION (LOGO + MENU)
========================================= */
.sidebar-top{
    display:flex;
    flex-direction:column;
}

/* Logo */
.logo{
    padding:26px 22px;
    display:flex;
    align-items:center;
    gap:10px;
}

.logo-img{
    width:30px;
    filter:drop-shadow(0 0 6px #c9a227);
    transition:0.4s;
}

.logo:hover .logo-img{
    transform:rotate(10deg) scale(1.1);
}

.s1{
    color:#ffffff;
    font-weight:bold;
    font-size:19px;
}

.s2{
    color:#c9a227;
    font-size:19px;
}

/* =========================================
   MENU LINKS
========================================= */
.sidebar a{
    position:relative;
    display:flex;
    align-items:center;
    padding:16px 26px;
    margin:6px 10px;
    border-radius:14px;
    font-size:17px;
    color:#ffffff;
    text-decoration:none;
    transition:all 0.4s ease;
    overflow:hidden;
}

/* Hover golden background animation */
.sidebar a::before{
    content:"";
    position:absolute;
    left:0;
    top:0;
    height:100%;
    width:0;
    background:linear-gradient(to right,#c9a227,#ffd700);
    opacity:0.15;
    transition:0.4s ease;
}

.sidebar a:hover::before{
    width:100%;
}

/* Icon */
.sidebar a i{
    margin-right:14px;
    color:#ffffff;
    transition:0.4s ease;
}

/* Hover Effect */
.sidebar a:hover{
    color:#ffd700;
    transform:translateX(8px);
}

.sidebar a:hover i{
    color:#ffd700;
    transform:scale(1.2);
}

/* =========================================
   ACTIVE MENU ITEM
========================================= */
.sidebar a.active{
    color:#ffd700;
    background:rgba(201,162,39,0.15);
    border-right:4px solid #ffd700;

    box-shadow:
        0 0 12px rgba(201,162,39,0.4),
        inset 0 0 10px rgba(201,162,39,0.3);

    animation:activePulse 2s infinite;
}

/* =========================================
   LOGOUT BUTTON (BOTTOM)
========================================= */
.logout{
    margin:20px 10px;
    padding:16px;
    border-radius:14px;
    font-size:17px;
    font-weight:bold;

    display:flex;
    align-items:center;
    justify-content:center;

    background:linear-gradient(145deg,#2a0000,#110000);
    border:1px solid rgba(255,80,80,0.4);
    color:#ffdddd;

    transition:all 0.4s ease;
    text-decoration:none;
}

.logout i{
    margin-right:12px;
    color:#ff6b6b;
    transition:0.4s;
}

.logout:hover{
    background:linear-gradient(145deg,#5a0000,#2a0000);
    color:#ffffff;
    transform:translateY(-4px);

    box-shadow:
        0 0 20px rgba(255,80,80,0.6),
        inset 0 0 10px rgba(255,100,100,0.3);
}

.logout:hover i{
    color:#ffffff;
    transform:rotate(-10deg) scale(1.2);
}

/* =========================================
   ANIMATIONS
========================================= */

/* Sidebar Slide */
@keyframes sidebarSlide{
    from{
        transform:translateX(-100%);
        opacity:0;
    }
    to{
        transform:translateX(0);
        opacity:1;
    }
}

/* Active Glow Pulse */
@keyframes activePulse{
    0%,100%{
        box-shadow:
        0 0 10px rgba(201,162,39,0.3),
        inset 0 0 8px rgba(201,162,39,0.2);
    }
    50%{
        box-shadow:
        0 0 20px rgba(255,215,0,0.6),
        inset 0 0 12px rgba(255,215,0,0.4);
    }
}

/* =====================================
   MAIN CONTENT (CENTERED)
===================================== */
.main-content{
    margin-left:260px;
    min-height:100vh;
    display:flex;
    flex-direction:column;
    justify-content:center;   /* vertical center */
    align-items:center;       /* horizontal center */
    background:linear-gradient(135deg,#0f0f0f,#1a1a1a);
    padding:40px;
    text-align:center;
    animation:fadeIn 0.5s ease;
}

/* Limit content width */
.main-content > *{
    width:100%;
    max-width:700px;
}

/* Heading */
.main-content h1{
    color:#d4af37;
    margin-bottom:10px;
    font-weight:bold;
}

/* Paragraph */
.main-content p{
    color:#ccc;
    margin-bottom:30px;
}

/* =====================================
   FORM CARD
===================================== */
.form-card{
    background:#111;
    padding:35px;
    border-radius:15px;
    border:1px solid rgba(212,175,55,0.3);
    box-shadow:0 10px 30px rgba(0,0,0,0.5);
    text-align:left;
    transition:0.3s ease;
}

.form-card:hover{
    box-shadow:0 15px 40px rgba(212,175,55,0.25);
}

.form-card h2{
    color:#ffd700;
    margin-bottom:25px;
}

/* =====================================
   FORM ELEMENTS
===================================== */
form label{
    display:block;
    margin-top:15px;
    margin-bottom:6px;
    font-weight:bold;
    color:#d4af37;
}

form input{
    width:100%;
    padding:10px 12px;
    border-radius:6px;
    border:1px solid #333;
    background:#0f0f0f;
    color:#fff;
    font-size:15px;
    transition:0.3s ease;
}

form input:focus{
    outline:none;
    border:1px solid #d4af37;
    box-shadow:0 0 8px rgba(212,175,55,0.5);
}

/* =====================================
   TOGGLE SWITCH
===================================== */
.toggle-group{
    margin-top:20px;
    display:flex;
    align-items:center;
    gap:20px;
    flex-wrap:wrap;
}

.toggle-switch{
    position:relative;
    width:48px;
    height:24px;
}

.toggle-switch input{
    opacity:0;
    width:0;
    height:0;
}

.slider{
    position:absolute;
    top:0;
    left:0;
    right:0;
    bottom:0;
    background:#444;
    border-radius:34px;
    transition:0.3s;
}

.slider:before{
    position:absolute;
    content:"";
    height:18px;
    width:18px;
    left:3px;
    bottom:3px;
    background:white;
    border-radius:50%;
    transition:0.3s;
}

.toggle-switch input:checked + .slider{
    background:#d4af37;
}

.toggle-switch input:checked + .slider:before{
    transform:translateX(24px);
}

/* =====================================
   BUTTON
===================================== */
form button{
    margin-top:25px;
    width:100%;
    padding:12px;
    border:none;
    border-radius:8px;
    background:#d4af37;
    color:#000;
    font-weight:bold;
    font-size:16px;
    cursor:pointer;
    transition:0.3s ease;
}

form button:hover{
    background:#ffd700;
}

/* =====================================
   INFO BOX
===================================== */
.info-box{
    margin-top:20px;
    padding:15px;
    border-radius:8px;
    background:rgba(212,175,55,0.1);
    border-left:4px solid #d4af37;
    color:#ddd;
    font-size:14px;
}

/* =====================================
   ANIMATION
===================================== */
@keyframes fadeIn{
    from{opacity:0;}
    to{opacity:1;}
}

/* =====================================
   RESPONSIVE
===================================== */
@media(max-width:768px){

    .sidebar{
        position:relative;
        width:100%;
        height:auto;
    }

    .main-content{
        margin-left:0;
        min-height:auto;
        padding:30px;
    }
}


</style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
<h2>Therapist Panel</h2>

<a href="TherapistDashboardServlet" class="active">
<i class="fa fa-chart-line"></i> Dashboard
</a>

<a href="therapistAvailability.jsp" class="active">
<i class="fa fa-clock"></i> Set Availability
</a>

<!-- ✅ FIXED LINK -->
<a href="<%=request.getContextPath()%>/slots?therapistId=<%=t.getId()%>">
<i class="fa fa-calendar"></i> View Slots
</a>

<a href="therapist-services?salonId=<%=t.getSalonId()%>">
<i class="fa fa-spa"></i> Services
</a>

<a href="TherapistAppointmentServlet">
<i class="fa fa-calendar-check"></i> Appointments
</a>


<a href="LogoutServlet">
<i class="fa fa-sign-out-alt"></i> Logout
</a>
</div>


<!-- Main Content -->
<div class="main-content">
    <h1>Schedule Management</h1>
    <p>Configure your clinical hours and consultation slots for new and existing clients.</p>

    <div class="form-card">
        <h2><i class="fa-solid fa-clock"></i> Set Your Availability</h2>

        <form action="AddAvailabilityServlet" method="post">
            <input type="hidden" name="therapistId" value="<%= t.getId() %>">
            
            <label for="date">Select Date</label>
            <input type="date" id="date" name="date" required>
            
            <label for="start">Start Time</label>
            <input type="time" id="start" name="start" required>
            
            <label for="end">End Time</label>
            <input type="time" id="end" name="end" required>
            
            <label for="duration">Slot Duration</label>
            <input type="number" id="duration" name="duration" value="60" required>
            
            <!-- Example toggles for future features -->
            <div class="toggle-group">
                <label>Allow Waitlist</label>
                <label class="toggle-switch">
                    <input type="checkbox">
                    <span class="slider"></span>
                </label>

                <label>Virtual Only</label>
                <label class="toggle-switch">
                    <input type="checkbox">
                    <span class="slider"></span>
                </label>
            </div>

            <button type="submit"><i class="fa-solid fa-check"></i> Save Availability</button>
        </form>

        <div class="info-box">
            <strong>Pro Tip:</strong> You can set recurring availability patterns in the "Settings" tab to automate your weekly schedule.
        </div>
    </div>
</div>

</body>
</html>
