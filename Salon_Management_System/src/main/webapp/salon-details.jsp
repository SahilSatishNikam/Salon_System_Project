<%@ page import="java.util.*, dao.SalonDAO, dao.ServiceDAO, model.Salon, model.Service" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Salon Details | SalonEase</title>

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
            padding: 20px;
        }

        h2, h3 {
            color: #ffd700;
        }

        .salon-info {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 30px;
            align-items: center;
            background: #0b0b0b;
            padding: 20px;
            border-radius: 20px;
            border: 1px solid #d4af37;
            box-shadow: 0 0 25px rgba(212,175,55,0.3);
        }

        .salon-info img {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: 15px;
            border: 2px solid #ffd700;
        }

        .salon-info div p {
            margin: 5px 0;
            font-size: 1.1rem;
        }

        .services-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .service-card {
            background: #0b0b0b;
            border: 1px solid #d4af37;
            border-radius: 20px;
            padding: 20px;
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 30px rgba(212,175,55,0.5);
        }

        .service-card h4 {
            color: #ffd700;
            margin-bottom: 10px;
        }

        .service-card p {
            font-size: 0.95rem;
            color: #ddd;
            margin-bottom: 8px;
        }

        .service-card .price-duration {
            font-weight: 500;
            margin-bottom: 10px;
            color: #ffd700;
        }

        .service-card a.book-btn {
            align-self: start;
            padding: 10px 20px;
            border-radius: 25px;
            background: linear-gradient(135deg,#d4af37,#ffd700);
            color: #000;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
        }

        .service-card a.book-btn:hover {
            background: linear-gradient(135deg,#ffd700,#e6b800);
        }

        @media(max-width:768px){
            .salon-info {
                flex-direction: column;
                text-align: center;
            }

            .salon-info img {
                margin-bottom: 15px;
            }
        }
    </style>
</head>
<body>

<%
String salonIdParam = request.getParameter("salonId");
if(salonIdParam == null) {
    out.println("<p>No salon selected.</p>");
    return;
}

int salonId = Integer.parseInt(salonIdParam);
SalonDAO salonDAO = new SalonDAO();
ServiceDAO serviceDAO = new ServiceDAO();

Salon salon = salonDAO.getSalonById(salonId);
if(salon == null) {
    out.println("<p>Salon not found.</p>");
    return;
}

// Load services
List<Service> services = serviceDAO.getServicesBySalon(salonId);
%>

<h2><i class="fa-solid fa-shop"></i> <%= salon.getName() %></h2>

<div class="salon-info">
    <img src="<%= salon.getImage() != null ? "SalonImageServlet?id="+salon.getId() : "../images/no-image.png" %>" alt="<%=salon.getName()%>">
    <div>
        <p><i class="fa-solid fa-envelope"></i> <strong>Email:</strong> <%= salon.getEmail() %></p>
        <p><i class="fa-solid fa-phone"></i> <strong>Phone:</strong> <%= salon.getPhone() %></p>
        <p><i class="fa-solid fa-location-dot"></i> <strong>Address:</strong> <%= salon.getAddress() %></p>
    </div>
</div>

<h3>Services Offered</h3>

<% if(services != null && !services.isEmpty()) { %>
<div class="services-container">
    <% for(Service s : services) { %>
    <div class="service-card">
        <h4><i class="fa-solid fa-scissors"></i> <%= s.getName() %></h4>
        <p><%= s.getDescription() != null ? s.getDescription() : "No description available." %></p>
        <div class="price-duration">
            <span>Price: ₹<%= s.getPrice() %></span><br>
            <span>Duration: <%= s.getDurationMinutes() %> min</span>
        </div>
        <a class="book-btn" href="book-appointment.jsp?salonId=<%=salon.getId()%>&serviceId=<%=s.getId()%>">
            <i class="fa-solid fa-calendar-check"></i> Book Now
        </a>
    </div>
    <% } %>
</div>
<% } else { %>
<p style="text-align:center; margin-top:20px;">No services available for this salon yet.</p>
<% } %>
<div style="text-align:center; margin: 20px 0;">
    <a href="search-salons.jsp" 
       style="display:inline-block; padding:10px 20px; border-radius:25px; background: linear-gradient(135deg,#d4af37,#ffd700); 
              color:#000; font-weight:600; text-decoration:none; transition:0.3s;">
         Back to Search
    </a>
</div>

</body>
</html>
