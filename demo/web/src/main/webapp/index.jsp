<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/sidebar.css"> <!-- Make sure to include CSS -->
</head>
<body>

<!-- Sidebar Code -->
<aside class="left-sidebar" data-sidebarbg="skin6">
  <!-- Sidebar scroll-->
  <div class="scroll-sidebar">
    <!-- Sidebar navigation-->
    <nav class="sidebar-nav">
      <ul id="sidebarnav">
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="profile.jsp" aria-expanded="false">
            <i class="fa fa-user" aria-hidden="true"></i>
            <span class="hide-menu">Profile</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="changepassword.jsp" aria-expanded="false">
            <i class="fa-solid fa-arrows-rotate mr-10"></i>
            <span class="hide-menu">Change Password</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="customer.jsp" aria-expanded="false">
            <i class="fa-solid fa-users"></i>
            <span class="hide-menu">Customers</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="movie.jsp" aria-expanded="false">
            <i class="fa-solid fa-film"></i>
            <span class="hide-menu">Movies</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="director.jsp" aria-expanded="false">
            <i class="fa-solid fa-clapperboard"></i>
            <span class="hide-menu">Directors</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="actor.jsp" aria-expanded="false">
            <i class="fa-solid fa-theater-masks"></i>
            <span class="hide-menu">Actors</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="typeseat.jsp" aria-expanded="false">
            <i class="fa-solid fa-ticket-simple"></i>
            <span class="hide-menu">Seat Types</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="http://localhost:9999/DoAnWebCinema/admin/order.htm?filter=today" aria-expanded="false">
            <i class="fa-solid fa-bookmark"></i>
            <span class="hide-menu">Booked Tickets</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="http://localhost:9999/DoAnWebCinema/admin/room.htm" aria-expanded="false">
            <i class="fa-solid fa-house-chimney"></i>
            <span class="hide-menu">Rooms</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="http://localhost:9999/DoAnWebCinema/admin/showtimes.htm" aria-expanded="false">
            <i class="fa-solid fa-calendar-days"></i>
            <span class="hide-menu">Showtimes</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="http://localhost:9999/DoAnWebCinema/admin/type.htm" aria-expanded="false">
            <i class="fa-solid fa-align-center"></i>
            <span class="hide-menu">Genres</span>
          </a>
        </li>
        <li class="sidebar-item">
          <a class="sidebar-link waves-effect waves-dark sidebar-link" href="http://localhost:9999/DoAnWebCinema/login.htm" aria-expanded="false">
            <i class="fa-solid fa-arrow-right-from-bracket"></i>
            <span class="hide-menu">Logout</span>
          </a>
        </li>
      </ul>
    </nav>
    <!-- End Sidebar navigation -->
  </div>
  <!-- End Sidebar scroll-->
</aside>
</body>
</html>
