<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Movie Management</title>
    <link rel="stylesheet" href="css/customer.css">
    <link rel="stylesheet" href="css/showtime.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="page-wrapper">
    <!-- Sidebar Include -->
    <%@ include file="index.jsp" %>
</div>
<div class="main-content">
    <div class="container">
        <header class="d-flex justify-content-between align-items-center mb-4">
            <h1>Movie Management</h1>
            <button class="btn btn-primary add-btn" data-bs-toggle="modal" data-bs-target="#addModal">
                <i class="fas fa-plus me-2"></i>Add New Showtime
            </button>
        </header>

        <div class="d-flex justify-content-between mb-4">
            <div class="search-container">
                <input type="text" placeholder="Search movies..." id="searchInput" onkeyup="searchShowtimes()">
            </div>
        </div>

        <table class="customer-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Movie Name</th>
                <th>Country</th>
                <th>Production Year</th>
                <th>Duration (minutes)</th>
                <th>Release Date</th>
                <th>Rating</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="showtimeTableBody">
            <c:forEach var="movie" items="${movies}">
                <tr>
                    <td>${movie.movieId}</td>
                    <td>${movie.movieName}</td>
                    <td>${movie.country}</td>
                    <td>${movie.productionYear}</td>
                    <td>${movie.duration}</td>
                    <td><fmt:formatDate value="${movie.releaseDate}" pattern="yyyy-MM-dd"/></td>
                    <td>${movie.score}</td>
                    <td>
                        <c:choose>
                            <c:when test="${movie.statusId == 0}">Not Released</c:when>
                            <c:when test="${movie.statusId == 1}">Now Showing</c:when>
                            <c:when test="${movie.statusId == 2}">No Longer Showing</c:when>
                            <c:otherwise>Undefined</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#info-${movie.movieId}"><i class="fas fa-eye"></i> View </button>
                        <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#edit-${movie.movieId}"><i class="fas fa-edit"></i> Edit</button>
                        <a href="${pageContext.request.contextPath}/movies?action=delete&id=${movie.movieId}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this movie?')"><i class="fas fa-trash"></i> Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- View Movie Modal -->
<c:forEach var="p" items="${movies}">
    <div class="modal fade" id="info-${p.movieId}" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title">Movie Details</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <!-- Modal Body -->
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <!-- Image and Status -->
                            <div class="col-md-4 text-center">
                                <img src="${p.imageUrl}" alt="movie-poster" class="img-fluid rounded mb-3" width="200" height="250"/>
                                <p><strong>Movie ID:</strong> ${p.movieId}</p>
                                <p class="btn-f btn-solid-f">
                                    <c:choose>
                                        <c:when test="${p.statusId == 0}">Not Released</c:when>
                                        <c:when test="${p.statusId == 1}">Now Showing</c:when>
                                        <c:when test="${p.statusId == 2}">No Longer Showing</c:when>
                                    </c:choose>
                                </p>
                            </div>
                            <!-- Detailed Information -->
                            <div class="col-md-8">
                                <p><strong>Movie Name:</strong> ${p.movieName}</p>
                                <p><strong>Description:</strong> ${p.description}</p>
                                <p><strong>Country:</strong> ${p.country}</p>
                                <p><strong>Production Year:</strong> ${p.productionYear}</p>
                                <p><strong>Duration:</strong> ${p.duration} minutes</p>
                                <p><strong>Release Date:</strong> <fmt:formatDate value="${p.releaseDate}" pattern="dd-MM-yyyy" /></p>
                                <p><strong>Rating:</strong> ${p.score}</p>
                                <p><strong>Director:</strong> ${p.director.directorName}</p>
                                <p><strong>Trailer:</strong>
                                    <c:if test="${not empty p.trailerUrl}">
                                        <a href="${p.trailerUrl}" target="_blank">Watch Trailer</a>
                                    </c:if>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<!-- Add Movie Modal -->
<div class="modal" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/movies" method="post">
                <input type="hidden" name="action" value="add">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Add New Movie</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" onclick="closeModal('addModal')" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addMovieName">Movie Name:</label>
                        <input type="text" id="addMovieName" name="movieName" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addDescription">Description:</label>
                        <textarea id="addDescription" name="description" required class="form-control"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="addCountry">Country:</label>
                        <input type="text" id="addCountry" name="country" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addProductionYear">Production Year:</label>
                        <input type="number" id="addProductionYear" name="productionYear" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addDuration">Duration (minutes):</label>
                        <input type="number" id="addDuration" name="duration" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addReleaseDate">Release Date:</label>
                        <input type="date" id="addReleaseDate" name="releaseDate" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addScore">Rating:</label>
                        <input type="number" step="0.1" id="addScore" name="score" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addDirectorId">Director:</label>
                        <input type="number" id="addDirectorId" name="directorId" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addImageUrl">Image URL:</label>
                        <input type="text" id="addImageUrl" name="imageUrl" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addTrailerUrl">Trailer URL:</label>
                        <input type="text" id="addTrailerUrl" name="trailerUrl" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="addStatusId">Status:</label>
                        <select id="addStatusId" name="statusId" class="form-control">
                            <option value="0">Not Released</option>
                            <option value="1">Now Showing</option>
                            <option value="2">No Longer Showing</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Add</button>
                    <button type="button" class="btn btn-secondary" onclick="closeModal('addModal')">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Movie Modal -->
<c:forEach var="p" items="${movies}">
    <div class="modal fade" id="edit-${p.movieId}" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/movies" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="movieId" value="${p.movieId}">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Movie</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="movieName-${p.movieId}">Movie Name:</label>
                            <input type="text" id="movieName-${p.movieId}" name="movieName" class="form-control" value="${p.movieName}">
                        </div>
                        <div class="form-group">
                            <label for="description-${p.movieId}">Description:</label>
                            <textarea id="description-${p.movieId}" name="description" class="form-control">${p.description}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="country-${p.movieId}">Country:</label>
                            <input type="text" id="country-${p.movieId}" name="country" class="form-control" value="${p.country}">
                        </div>
                        <div class="form-group">
                            <label for="productionYear-${p.movieId}">Production Year:</label>
                            <input type="number" id="productionYear-${p.movieId}" name="productionYear" class="form-control" value="${p.productionYear}">
                        </div>
                        <div class="form-group">
                            <label for="duration-${p.movieId}">Duration (minutes):</label>
                            <input type="number" id="duration-${p.movieId}" name="duration" class="form-control" value="${p.duration}">
                        </div>
                        <div class="form-group">
                            <label for="releaseDate-${p.movieId}">Release Date:</label>
                            <input type="date" id="releaseDate-${p.movieId}" name="releaseDate" class="form-control" value="${p.releaseDate}">
                        </div>
                        <div class="form-group">
                            <label for="score-${p.movieId}">Rating:</label>
                            <input type="number" step="0.1" id="score-${p.movieId}" name="score" class="form-control" value="${p.score}">
                        </div>
                        <div class="form-group">
                            <label for="directorId-${p.movieId}">Director:</label>
                            <input type="number" id="directorId-${p.movieId}" name="directorId" class="form-control" value="${p.director.directorId}">
                        </div>
                        <div class="form-group">
                            <label for="imageUrl-${p.movieId}">Image URL:</label>
                            <input type="text" id="imageUrl-${p.movieId}" name="imageUrl" class="form-control" value="${p.imageUrl}">
                        </div>
                        <div class="form-group">
                            <label for="trailerUrl-${p.movieId}">Trailer URL:</label>
                            <input type="text" id="trailerUrl-${p.movieId}" name="trailerUrl" class="form-control" value="${p.trailerUrl}">
                        </div>
                        <div class="form-group">
                            <label for="statusId-${p.movieId}">Status:</label>
                            <select id="statusId-${p.movieId}" name="statusId" class="form-control">
                                <option value="0" <c:if test="${p.statusId == 0}">selected</c:if>>Not Released</option>
                                <option value="1" <c:if test="${p.statusId == 1}">selected</c:if>>Now Showing</option>
                                <option value="2" <c:if test="${p.statusId == 2}">selected</c:if>>No Longer Showing</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Save</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:forEach>

<script>
    // Mở và đóng modal
    function openModal(modalId) {
        document.getElementById(modalId).style.display = "block";
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }
    function searchShowtimes() {
        const query = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.getElementById('showtimeTableBody').getElementsByTagName('tr');
        Array.from(rows).forEach(row => {
            const cells = row.getElementsByTagName('td');
            let matchFound = Array.from(cells).some(cell => cell.textContent.toLowerCase().includes(query));
            row.style.display = matchFound ? '' : 'none';
        });
    }
</script>
</body>
</html>
