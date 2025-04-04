package org.example.web;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ejb.DirectorEJB;
import org.example.ejb.MovieEJB;
import org.example.ejb.entity.Director;
import org.example.ejb.entity.Movie;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {

    @EJB
    private MovieEJB movieEJB;

    @EJB
    private DirectorEJB directorEJB;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String searchQuery = req.getParameter("search");

        // Xử lý xóa phim
        if ("delete".equals(action)) {
            try {
                int movieId = Integer.parseInt(req.getParameter("id"));
                movieEJB.deleteMovie(movieId);
                req.setAttribute("message", "Phim đã được xóa thành công.");
            } catch (NumberFormatException e) {
                req.setAttribute("errorMessage", "ID phim không hợp lệ.");
            }
        }

        // Tìm kiếm phim theo tên
        List<Movie> movies;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            movies = movieEJB.searchMoviesByName(searchQuery);
        } else {
            movies = movieEJB.getAllMovies();
        }

        req.setAttribute("movies", movies);
        req.setAttribute("searchQuery", searchQuery);

        // Chuyển hướng đến trang phim
        req.getRequestDispatcher("/movie.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            // Lấy dữ liệu từ form
            String movieName = req.getParameter("movieName");
            String country = req.getParameter("country");
            String description = req.getParameter("description");
            String durationStr = req.getParameter("duration");
            String releaseDateStr = req.getParameter("releaseDate");
            String productionYearStr = req.getParameter("productionYear");
            String scoreStr = req.getParameter("score");
            String directorIdStr = req.getParameter("directorId");
            String imageUrl = req.getParameter("imageUrl");
            String trailerUrl = req.getParameter("trailerUrl");
            String statusIdStr = req.getParameter("statusId");

            // Kiểm tra các trường dữ liệu bắt buộc
            if (movieName == null || movieName.trim().isEmpty() ||
                    country == null || country.trim().isEmpty() ||
                    description == null || description.trim().isEmpty() ||
                    durationStr == null || durationStr.trim().isEmpty() ||
                    releaseDateStr == null || releaseDateStr.trim().isEmpty() ||
                    productionYearStr == null || productionYearStr.trim().isEmpty() ||
                    scoreStr == null || scoreStr.trim().isEmpty() ||
                    directorIdStr == null || directorIdStr.trim().isEmpty()) {
                req.setAttribute("errorMessage", "Tất cả các trường bắt buộc phải được điền.");
                doGet(req, resp); // Quay lại trang với thông báo lỗi
                return;
            }

            // Chuyển đổi dữ liệu đầu vào
            int duration = Integer.parseInt(durationStr);
            Date releaseDate = Date.valueOf(releaseDateStr);
            int productionYear = Integer.parseInt(productionYearStr);
            float score = Float.parseFloat(scoreStr);
            int directorId = Integer.parseInt(directorIdStr);
            int statusId = Integer.parseInt(statusIdStr);

            // Tìm kiếm đối tượng Director từ directorId
            Director director = directorEJB.getDirectorById(directorId);
            if (director == null) {
                req.setAttribute("errorMessage", "Không tìm thấy đạo diễn với ID: " + directorId);
                doGet(req, resp); // Quay lại trang với thông báo lỗi
                return;
            }

            // Tạo đối tượng Movie mới
            Movie movie = new Movie();
            movie.setMovieName(movieName);
            movie.setCountry(country);
            movie.setDescription(description);
            movie.setDuration(duration);
            movie.setReleaseDate(releaseDate);
            movie.setProductionYear(productionYear);
            movie.setScore(score);
            movie.setImageUrl(imageUrl != null ? imageUrl : "");
            movie.setTrailerUrl(trailerUrl != null ? trailerUrl : "");
            movie.setDirector(director);
            movie.setStatusId(statusId);

            // Thực hiện thêm hoặc cập nhật phim
            if ("add".equals(action)) {
                // Thêm phim mới
                movieEJB.addMovie(movie);
                req.setAttribute("message", "Phim đã được thêm thành công.");
            } else if ("update".equals(action)) {
                // Cập nhật phim
                int movieId = Integer.parseInt(req.getParameter("movieId"));
                movie.setMovieId(movieId);  // Đặt ID của phim cần cập nhật
                movieEJB.updateMovie(movie);
                req.setAttribute("message", "Phim đã được cập nhật thành công.");
            }

            // Sau khi thực hiện thêm hoặc cập nhật, chuyển lại về danh sách phim
            doGet(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Dữ liệu không hợp lệ.");
            doGet(req, resp); // Quay lại trang với thông báo lỗi
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            doGet(req, resp); // Quay lại trang với thông báo lỗi
        }
    }
}
