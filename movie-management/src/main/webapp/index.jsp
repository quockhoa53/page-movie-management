<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.HttpURLConnection, java.net.URL, java.io.BufferedReader, java.io.InputStreamReader, java.util.ArrayList, java.util.List" %>
<%@ page import="jakarta.json.Json, jakarta.json.JsonReader, jakarta.json.JsonArray, jakarta.json.JsonObject" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý phim</title>
    <script>
        function editMovie(id) {
            const name = prompt("Nhập tên phim mới:");
            if (name) {
                fetch(`http://localhost:8080/movie-management/api/movies/${id}`, {
                    method: "PUT",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ movieName: name })
                })
                    .then(response => response.ok ? location.reload() : alert("Cập nhật thất bại"));
            }
        }

        function deleteMovie(id) {
            if (confirm("Bạn có chắc muốn xóa phim này?")) {
                fetch(`http://localhost:8080/movie-management/api/movies/${id}`, { method: "DELETE" })
                    .then(response => response.ok ? location.reload() : alert("Xóa thất bại"));
            }
        }

        function addMovie() {
            const name = document.getElementById("newMovieName").value;
            if (name) {
                fetch("http://localhost:8080/movie-management/api/movies", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ movieName: name, status: 1 })
                })
                    .then(response => response.ok ? location.reload() : alert("Thêm phim thất bại"));
            }
        }
    </script>
</head>
<body>
<h2>Danh sách phim</h2>

<%
    List<JsonObject> movies = new ArrayList<>();
    try {
        URL url = new URL("http://localhost:8080/movie-management/api/movies");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        if (conn.getResponseCode() == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            JsonReader jsonReader = Json.createReader(br);
            JsonArray jsonArray = jsonReader.readArray();
            jsonReader.close();
            conn.disconnect();

            for (JsonObject jsonObject : jsonArray.getValuesAs(JsonObject.class)) {
                movies.add(jsonObject);
            }
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Lỗi khi tải danh sách phim: " + e.getMessage() + "</p>");
    }
%>

<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên phim</th>
        <th>Quốc gia</th>
        <th>Thời lượng</th>
        <th>Ngày phát hành</th>
        <th>Trạng thái</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (!movies.isEmpty()) {
            for (JsonObject movie : movies) {
    %>
    <tr>
        <td><%= movie.getInt("movieId") %></td>
        <td><%= movie.getString("movieName") %></td>
        <td><%= movie.containsKey("countryOfProduction") ? movie.getString("countryOfProduction") : "N/A" %></td>
        <td><%= movie.containsKey("duration") ? movie.getInt("duration") : 0 %> phút</td>
        <td><%= movie.containsKey("releaseDate") ? movie.getString("releaseDate") : "Không xác định" %></td>
        <td><%= movie.getInt("status") == 1 ? "Đang chiếu" : "Chưa chiếu" %></td>
        <td>
            <button onclick="editMovie(<%= movie.getInt("movieId") %>)">Sửa</button>
            <button onclick="deleteMovie(<%= movie.getInt("movieId") %>)">Xóa</button>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="7">Không có phim nào</td></tr>
    <%
        }
    %>
    </tbody>
</table>

</body>
</html>
