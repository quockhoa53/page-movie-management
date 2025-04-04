package org.example.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.example.ejb.entity.Movie;
import org.example.ejb.entity.Room;
import org.example.ejb.entity.Showtime;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class ShowtimeEJB {

    @PersistenceContext(unitName = "cinema")
    private EntityManager entityManager;

    public List<Showtime> getUpcomingShowtimes() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        Date currentDate = calendar.getTime(); // 2025-04-04 00:00:00
        calendar.add(Calendar.DAY_OF_YEAR, 7);

        String query = "SELECT s FROM Showtime s WHERE s.showDate = :currentDate";
        TypedQuery<Showtime> typedQuery = entityManager.createQuery(query, Showtime.class);
        typedQuery.setParameter("currentDate", currentDate);
        List<Showtime> result = typedQuery.getResultList();
        System.out.println("Upcoming showtimes found: " + result.size());
        return result;
    }

    public List<Showtime> getAllShowtimes() {
        String query = "SELECT s FROM Showtime s";
        TypedQuery<Showtime> typedQuery = entityManager.createQuery(query, Showtime.class);
        List<Showtime> result = typedQuery.getResultList();
        System.out.println("All showtimes found: " + result.size());
        return result;
    }

    public List<Movie> getAllMovies() {
        String query = "SELECT m FROM Movie m";
        TypedQuery<Movie> typedQuery = entityManager.createQuery(query, Movie.class);
        List<Movie> result = typedQuery.getResultList();
        System.out.println("All movies found: " + result.size());
        return result;
    }

    public List<Room> getAllRooms() {
        String query = "SELECT r FROM Room r";
        TypedQuery<Room> typedQuery = entityManager.createQuery(query, Room.class);
        List<Room> result = typedQuery.getResultList();
        System.out.println("All rooms found: " + result.size());
        return result;
    }

    public List<Showtime> getShowtimesByDate(String dateStr) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(dateStr);
            System.out.println("Parsed date: " + sdf.format(date));

            String query = "SELECT s FROM Showtime s WHERE s.showDate = :date";
            TypedQuery<Showtime> typedQuery = entityManager.createQuery(query, Showtime.class);
            typedQuery.setParameter("date", date);
            List<Showtime> result = typedQuery.getResultList();
            System.out.println("Showtimes for " + dateStr + ": " + result.size());
            return result;
        } catch (ParseException e) {
            System.err.println("Invalid date format: " + dateStr);
            e.printStackTrace();
            return List.of();
        }
    }

    // Get showtime by ID
    public Showtime getShowtimeById(int showtimeId) {
        try {
            Showtime showtime = entityManager.find(Showtime.class, showtimeId);
            if (showtime != null) {
                System.out.println("Found showtime with ID: " + showtimeId);
            } else {
                System.out.println("No showtime found with ID: " + showtimeId);
            }
            return showtime;
        } catch (Exception e) {
            System.err.println("Error finding showtime by ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Get movie by ID
    public Movie getMovieById(int movieId) {
        try {
            Movie movie = entityManager.find(Movie.class, movieId);
            if (movie != null) {
                System.out.println("Found movie with ID: " + movieId);
            } else {
                System.out.println("No movie found with ID: " + movieId);
            }
            return movie;
        } catch (Exception e) {
            System.err.println("Error finding movie by ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Get room by ID
    public Room getRoomById(String roomId) {
        try {
            Room room = entityManager.find(Room.class, roomId);
            if (room != null) {
                System.out.println("Found room with ID: " + roomId);
            } else {
                System.out.println("No room found with ID: " + roomId);
            }
            return room;
        } catch (Exception e) {
            System.err.println("Error finding room by ID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Update showtime
    public Showtime updateShowtime(Showtime showtime) {
        try {
            if (showtime == null) {
                System.err.println("Cannot update null showtime");
                return null;
            }

            Showtime existing = getShowtimeById(showtime.getShowtimeId());
            if (existing == null) {
                System.err.println("No existing showtime found with ID: " + showtime.getShowtimeId());
                return null;
            }

            // Merge the changes
            Showtime updated = entityManager.merge(showtime);
            entityManager.flush();

            System.out.println("Successfully updated showtime with ID: " + showtime.getShowtimeId());
            return updated;
        } catch (Exception e) {
            System.err.println("Error updating showtime: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public Showtime addShowtime(Showtime showtime) {
        try {
            if (showtime == null) {
                System.err.println("Cannot add null showtime");
                return null;
            }

            entityManager.persist(showtime);
            entityManager.flush();
            System.out.println("Created new showtime with ID: " + showtime.getShowtimeId());
            return showtime;
        } catch (Exception e) {
            System.err.println("Error creating showtime: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Create new showtime
    public Showtime createShowtime(Showtime showtime) {
        try {
            entityManager.persist(showtime);
            entityManager.flush();
            System.out.println("Created new showtime with ID: " + showtime.getShowtimeId());
            return showtime;
        } catch (Exception e) {
            System.err.println("Error creating showtime: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Delete showtime
    public boolean deleteShowtime(int showtimeId) {
        try {
            Showtime showtime = getShowtimeById(showtimeId);
            if (showtime != null) {
                entityManager.remove(showtime);
                System.out.println("Deleted showtime with ID: " + showtimeId);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error deleting showtime: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    public List<Showtime> getShowtimesByRoomAndDate(String roomId, String dateStr) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(dateStr);
            System.out.println("Parsed date for room " + roomId + ": " + sdf.format(date));

            String query = "SELECT s FROM Showtime s WHERE s.room.roomCode = :roomId AND s.showDate = :date";
            TypedQuery<Showtime> typedQuery = entityManager.createQuery(query, Showtime.class);
            typedQuery.setParameter("roomId", roomId);
            typedQuery.setParameter("date", date);

            List<Showtime> result = typedQuery.getResultList();
            System.out.println("Showtimes found for room " + roomId + " on " + dateStr + ": " + result.size());
            return result;
        } catch (ParseException e) {
            System.err.println("Invalid date format for room " + roomId + ": " + dateStr);
            e.printStackTrace();
            return List.of();
        } catch (Exception e) {
            System.err.println("Error fetching showtimes for room " + roomId + " on " + dateStr + ": " + e.getMessage());
            e.printStackTrace();
            return List.of();
        }
    }
}