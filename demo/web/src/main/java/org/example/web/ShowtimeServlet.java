package org.example.web;

import com.google.gson.*;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ejb.MovieEJB;
import org.example.ejb.ShowtimeEJB;
import org.example.ejb.entity.Movie;
import org.example.ejb.entity.Room;
import org.example.ejb.entity.Showtime;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.List;

@WebServlet("/showtimes")
public class ShowtimeServlet extends HttpServlet {

    @EJB
    private ShowtimeEJB showtimeEJB;

    // Custom TypeAdapter for LocalDateTime
    public static class LocalDateTimeAdapter extends TypeAdapter<LocalDateTime> {
        private final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

        @Override
        public void write(JsonWriter out, LocalDateTime value) throws IOException {
            if (value == null) {
                out.nullValue();
            } else {
                out.value(formatter.format(value));
            }
        }

        @Override
        public LocalDateTime read(JsonReader in) throws IOException {
            if (in.peek() == JsonToken.NULL) {
                in.nextNull();
                return null;
            } else {
                return LocalDateTime.parse(in.nextString(), formatter);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Action received: " + action);

        // Create Gson instance with custom adapter
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();

        if ("search".equals(action)) {
            String date = request.getParameter("date");
            System.out.println("Received date parameter: " + date);

            if (date == null || date.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("application/json");
                response.getWriter().write("{\"error\": \"Date parameter is required\"}");
                return;
            }

            try {
                List<Showtime> showtimes = showtimeEJB.getShowtimesByDate(date);
                System.out.println("Showtimes found: " + showtimes.size());
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String json = gson.toJson(showtimes); // Use custom Gson instance
                response.getWriter().write(json);
            } catch (Exception e) {
                System.err.println("Error fetching showtimes: " + e.getMessage());
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\": \"Failed to fetch showtimes\"}");
            }
        } else {
            List<Showtime> showtimes = showtimeEJB.getUpcomingShowtimes();
            List<Movie> movies = showtimeEJB.getAllMovies();
            List<Room> rooms = showtimeEJB.getAllRooms();
            request.setAttribute("showtimes", showtimes);
            request.setAttribute("movies", movies);
            request.setAttribute("rooms", rooms);
            RequestDispatcher dispatcher = request.getRequestDispatcher("showtime.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Read JSON from request body
            StringBuilder sb = new StringBuilder();
            try (BufferedReader reader = request.getReader()) {
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            JsonObject jsonObject = JsonParser.parseString(sb.toString()).getAsJsonObject();
            String action = jsonObject.get("action").getAsString();

            if ("update".equals(action)) {
                // Existing update logic remains unchanged
                try {
                    int showtimeId = jsonObject.get("showtimeId").getAsInt();
                    int movieId = jsonObject.get("movieId").getAsInt();
                    String roomId = jsonObject.get("roomId").getAsString();
                    String showDateStr = jsonObject.get("showDate").getAsString();
                    String showHour = jsonObject.get("showHour").getAsString();
                    String showMinute = jsonObject.get("showMinute").getAsString();
                    String ticketSaleStartStr = jsonObject.get("ticketSaleStart").getAsString();

                    LocalDate showDate = LocalDate.parse(showDateStr);
                    LocalDateTime ticketSaleStart = LocalDateTime.parse(ticketSaleStartStr);
                    String showTime = String.format("%s:%s:00", showHour, showMinute);

                    Showtime showtime = showtimeEJB.getShowtimeById(showtimeId);
                    if (showtime != null) {
                        Movie movie = showtimeEJB.getMovieById(movieId);
                        Room room = showtimeEJB.getRoomById(roomId);

                        if (movie == null || room == null) {
                            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                            response.getWriter().write("{\"status\": \"error\", \"error\": \"Invalid movie or room\"}");
                            return;
                        }

                        showtime.setMovie(movie);
                        showtime.setRoom(room);
                        showtime.setShowDate(Date.from(showDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
                        showtime.setShowTime(showTime);
                        showtime.setTicketSaleStart(Date.from(ticketSaleStart.atZone(ZoneId.systemDefault()).toInstant()));

                        showtimeEJB.updateShowtime(showtime);

                        response.getWriter().write("{\"status\": \"success\", \"message\": \"Showtime updated successfully\"}");
                    } else {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        response.getWriter().write("{\"status\": \"error\", \"error\": \"Showtime not found\"}");
                    }
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"status\": \"error\", \"error\": \"Failed to update showtime: " + e.getMessage() + "\"}");
                    e.printStackTrace();
                }
            } else if ("add".equals(action)) {
                try {
                    int movieId = jsonObject.get("movieId").getAsInt();
                    String roomId = jsonObject.get("roomId").getAsString();
                    String showDateStr = jsonObject.get("showDate").getAsString();
                    String showHour = jsonObject.get("showHour").getAsString();
                    String showMinute = jsonObject.get("showMinute").getAsString();
                    String ticketSaleStartStr = jsonObject.get("ticketSaleStart").getAsString();

                    // Convert dates
                    LocalDate showDate = LocalDate.parse(showDateStr);
                    LocalDateTime ticketSaleStart = LocalDateTime.parse(ticketSaleStartStr);
                    String showTime = String.format("%s:%s:00", showHour, showMinute);

                    // Validate data
                    Movie movie = showtimeEJB.getMovieById(movieId);
                    Room room = showtimeEJB.getRoomById(roomId);

                    if (movie == null || room == null) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write("{\"status\": \"error\", \"error\": \"Invalid movie or room\"}");
                        return;
                    }

                    // Check if showtime conflicts with existing ones
                    List<Showtime> existingShowtimes = showtimeEJB.getShowtimesByRoomAndDate(roomId, showDateStr);
                    Date newShowDateTime = Date.from(showDate.atTime(Integer.parseInt(showHour), Integer.parseInt(showMinute)).atZone(ZoneId.systemDefault()).toInstant());
                    boolean hasConflict = existingShowtimes.stream().anyMatch(existing -> {
                        Date existingDateTime = existing.getShowDate();
                        long diffInMinutes = Math.abs((newShowDateTime.getTime() - existingDateTime.getTime()) / (1000 * 60));
                        return diffInMinutes < 150; // Assume 2.5 hours minimum gap between showtimes
                    });

                    if (hasConflict) {
                        response.setStatus(HttpServletResponse.SC_CONFLICT);
                        response.getWriter().write("{\"status\": \"error\", \"error\": \"Showtime conflicts with existing schedule\"}");
                        return;
                    }

                    // Create new showtime
                    Showtime newShowtime = new Showtime();
                    newShowtime.setMovie(movie);
                    newShowtime.setRoom(room);
                    newShowtime.setShowDate(Date.from(showDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
                    newShowtime.setShowTime(showTime);
                    newShowtime.setTicketSaleStart(Date.from(ticketSaleStart.atZone(ZoneId.systemDefault()).toInstant()));

                    showtimeEJB.createShowtime(newShowtime);

                    response.getWriter().write("{\"status\": \"success\", \"message\": \"Showtime added successfully\"}");
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"status\": \"error\", \"error\": \"Failed to add showtime: " + e.getMessage() + "\"}");
                    e.printStackTrace();
                }
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"status\": \"error\", \"error\": \"Invalid action\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\": \"error\", \"error\": \"Invalid request format: " + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }
}