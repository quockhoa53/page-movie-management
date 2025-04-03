<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Ticket Management</title>
  <link rel="stylesheet" href="css/customer.css">
  <link rel="stylesheet" href="css/ticket.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="page-wrapper">
  <%@ include file="index.jsp" %>
</div>
<div class="main-content">
  <div class="container">
    <header>
      <h1>Ticket Management</h1>
    </header>
    <div class="search-container">
      <input type="text" placeholder="Search tickets..." id="searchInput" onkeyup="searchTickets()">
    </div>
    <table class="customer-table">
      <thead>
      <tr>
        <th>Ticket ID</th>
        <th>Showtime</th>
        <th>Customer</th>
        <th>Sale Date</th>
        <th>Payment Time</th>
        <th>Seat Name</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody id="ticketTableBody">
      <c:forEach var="ticket" items="${tickets}">
        <tr>
          <td>${ticket.ticketId}</td>
          <td>${ticket.showtime.showTime}</td>
          <td>${ticket.customer.customerName}</td>
          <td>
            <fmt:formatDate value="${ticket.saleDate}" pattern="yyyy-MM-dd" />
          </td>
          <td>
            <fmt:formatDate value="${ticket.paymentTime}" pattern="yyyy-MM-dd HH:mm:ss" />
          </td>
          <td>${ticket.seatRoomDetail.seat.seatName}</td>
          <td>
            <button class="btn btn-info view-ticket-btn" data-bs-toggle="modal" data-bs-target="#i-${ticket.ticketId}">
              <i class="fas fa-eye"></i> Xem
            </button>
            <button class="btn btn-danger" onclick="deleteTicket(${ticket.ticketId})">
              <i class="fas fa-trash"></i> Delete
            </button>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<!-- Modal for viewing ticket -->
<c:forEach var="ticket" items="${tickets}">
  <div class="modal fade" id="i-${ticket.ticketId}" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header green-bg-color">
          <h4 class="modal-title text-white">Ticket Details</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="row py-5 p-4 bg-white rounded shadow-sm">
            <div class="col-lg-12">
              <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold green-bg-color">
                Booking
              </div>
              <div class="p-4">
                <ul class="list-unstyled mb-4">
                  <li class="d-flex justify-content-between py-3 border-bottom">
                    <strong class="text-muted">Ticket ID</strong><b><strong>${ticket.ticketId}</strong></b>
                  </li>
                  <li class="d-flex justify-content-between py-3 border-bottom">
                    <strong class="text-muted">Customer Name</strong><b><strong>${ticket.customer.customerName}</strong></b>
                  </li>
                  <li class="d-flex justify-content-between py-3 border-bottom">
                    <strong class="text-muted">Movie Name</strong><b><strong>${ticket.showtime.movie.movieName}</strong></b>
                  </li>
                  <li class="d-flex justify-content-between py-3 border-bottom">
                    <strong class="text-muted">Total Price</strong>
                    <b><strong>${ticket.seatRoomDetail.seatType.price}</strong></b>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <div class="px-4 px-lg-0">
            <div class="pb-5">
              <div class="container">
                <div class="row">
                  <div class="col-lg-12 p-5 mt-5 bg-white rounded shadow-sm mb-5">
                    <div class="table-responsive">
                      <table class="table">
                        <thead>
                        <tr>
                          <th scope="col" class="border-0 bg-light">Sale Date</th>
                          <th scope="col" class="border-0 bg-light">Room ID</th>
                          <th scope="col" class="border-0 bg-light">Seat Name</th>
                          <th scope="col" class="border-0 bg-light">Seat Type</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                          <th scope="row" class="border-0">
                            <div class="p-2">
                              <img src="/DoAnWebCinema/uploads/${ticket.showtime.movie.imageUrl}" alt="" width="70" class="img-fluid rounded shadow-sm">
                              <div class="ml-3 d-inline-block align-middle">
                                <h5 class="mb-0">
                                  <a href="#" class="text-dark d-inline-block align-middle">
                                    <fmt:formatDate value="${ticket.saleDate}" pattern="yyyy-MM-dd" />
                                  </a>
                                </h5>
                              </div>
                            </div>
                          </th>
                          <td class="align-middle text-center"><strong>${ticket.showtime.room.roomCode}</strong></td>
                          <td class="align-middle text-center"><strong>${ticket.seatRoomDetail.seat.seatName}</strong></td>
                          <td class="align-middle text-center"><strong>${ticket.seatRoomDetail.seatType.typeName}</strong></td>
                        </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</c:forEach>

<script>
  // Function to delete a ticket
  function deleteTicket(ticketId) {
    if (confirm("Are you sure you want to delete this ticket?")) {
      fetch('http://localhost:8080/myapp/tickets?ticketId=' + ticketId, {
        method: 'POST'
      })
              .then(response => {
                if (response.ok) {
                  alert("Ticket deleted successfully!");
                  location.reload();
                } else {
                  alert("Error deleting ticket.");
                }
              })
              .catch(error => {
                console.error("Error deleting ticket:", error);
                alert("An error occurred while deleting the ticket.");
              });
    }
  }

  // Function to search tickets dynamically
  function searchTickets() {
    const query = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.getElementById('ticketTableBody').getElementsByTagName('tr');
    Array.from(rows).forEach(row => {
      const cells = row.getElementsByTagName('td');
      let matchFound = Array.from(cells).some(cell => cell.textContent.toLowerCase().includes(query));
      row.style.display = matchFound ? "" : "none";
    });
  }
</script>
</body>
</html>