
<%@ page import="java.util.*,model.*" %>

<%
List<Salon> list =
(List<Salon>)request.getAttribute("list");

if(list==null) list=new ArrayList<>();
%>

<!DOCTYPE html>
<html>
<head>

<title>Search Salons</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
 background:#0f0f0f;
 color:white;
}

.card{
 background:#1a1a1a;
 color:white;
 border-radius:15px;
}

.sidebar{
 background:#1e1100;
 height:100vh;
 color:white;
}

.btn-gold{
 background:gold;
}
</style>

</head>

<body>

<div class="container-fluid">
<div class="row">

<!-- SIDEBAR -->
<div class="col-2 sidebar p-3">

<h4 class="text-warning">Luxury Salon</h4>
<hr>

<a href="dashboard.jsp" class="text-white d-block">Dashboard</a>
<a href="search-salons.jsp" class="text-warning d-block">Search Salons</a>
<a href="logout.jsp" class="text-danger d-block">Logout</a>

</div>

<!-- MAIN -->
<div class="col-10 p-4">

<h2>Search Salons</h2>

<form action="SearchSalonServlet" method="get">

<div class="row mb-3">

<div class="col">
<input name="name"
class="form-control"
placeholder="Salon Name">
</div>

<div class="col">
<input name="location"
class="form-control"
placeholder="Location">
</div>

<div class="col">
<button class="btn btn-gold w-100">
Search
</button>
</div>

</div>
</form>

<div class="row">

<% for(Salon s : list){ %>

<div class="col-md-4 mb-3">

<div class="card p-3">

<h5 class="text-warning">
<%=s.getSalon_name()%>
</h5>

<p>Owner: <%=s.getOwner_name()%></p>

<p>Location: <%=s.getLocation()%></p>

<p><%=s.getDescription()%></p>

<a class="btn btn-gold w-100">
Explore Details
</a>

<a class="btn btn-gold w-100 mt-2">
Book Now
</a>

</div>
</div>

<% } %>

</div>

</div>
</div>
</div>

</body>
</html>
