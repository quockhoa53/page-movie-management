package org.example.web;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.ejb.RoomEJB;
import org.example.ejb.entity.Room;
import org.example.ejb.entity.Seat;

import java.io.IOException;
import java.util.List;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {
    @EJB
    private RoomEJB roomEJB;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tất cả các phòng
        List<Room> rooms = roomEJB.getAllRooms();

        // Tính tổng số ghế cho mỗi phòng
        for (Room room : rooms) {
            List<Seat> seats = roomEJB.getSeatsByRoom(room.getRoomCode());
            int totalSeats = seats.size();  // Đếm số ghế trong phòng
            room.setTotalSeats(totalSeats); // Gán tổng số ghế cho phòng
        }

        // Gửi danh sách phòng tới trang JSP
        request.setAttribute("rooms", rooms);
        RequestDispatcher dispatcher = request.getRequestDispatcher("room.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            Room room = new Room();
            String seatCountPerRow = request.getParameter("seatCountPerRow");
            String[] seatCounts = seatCountPerRow != null ? seatCountPerRow.split(",") : new String[0];
            roomEJB.addRoom(room, seatCounts);
        } else if ("edit".equals(action)) {
            Room room = new Room();
            String originalRoomCode = request.getParameter("originalRoomCode");
            room.setRoomCode(request.getParameter("roomCode"));
            room.setStatus(Integer.parseInt(request.getParameter("status")));
            Room existingRoom = roomEJB.getRoomById(originalRoomCode);
            if (existingRoom != null) {
                existingRoom.setRoomCode(room.getRoomCode());
                existingRoom.setStatus(room.getStatus());
                roomEJB.updateRoom(existingRoom);
            }
        } else if ("delete".equals(action)) {
            String roomCode = request.getParameter("roomCode");
            boolean deleted = roomEJB.deleteRoom(roomCode);
            if (!deleted) {
                // Phòng không xóa được, có thể do có ghế hoặc không tồn tại
                request.setAttribute("errorMessage", "Cannot delete room " + roomCode + " because it has associated seats or does not exist.");
                doGet(request, response); // Tải lại danh sách phòng với thông báo lỗi
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/rooms");
    }
}
