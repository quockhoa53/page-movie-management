package org.example.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.example.ejb.entity.Room;
import org.example.ejb.entity.Seat;
import org.example.ejb.entity.SeatRoomDetail;
import org.example.ejb.entity.SeatType;

import java.text.DecimalFormat;
import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class RoomEJB {
    @PersistenceContext(unitName = "cinema")
    private EntityManager em;

    public List<Room> getAllRooms() {
        return em.createQuery("SELECT r FROM Room r", Room.class).getResultList();
    }

    public List<Seat> getSeatsByRoom(String roomCode) {
        Query query = em.createQuery("SELECT s FROM Seat s " +
                "JOIN s.seatRoomDetails srd " +
                "JOIN srd.room r WHERE r.roomCode = :roomCode");
        query.setParameter("roomCode", roomCode);
        return query.getResultList();
    }

    public boolean deleteRoom(String roomCode) {
        Room room = em.find(Room.class, roomCode);
        if (room == null) {
            return false; // Phòng không tồn tại
        }

        // Kiểm tra xem phòng có ghế nào liên quan không
        Query checkQuery = em.createQuery(
                "SELECT COUNT(srd) FROM SeatRoomDetail srd WHERE srd.room.roomCode = :roomCode"
        );
        checkQuery.setParameter("roomCode", roomCode);
        Long seatCount = (Long) checkQuery.getSingleResult();

        if (seatCount > 0) {
            // Phòng có ghế, không thể xóa
            return false;
        }

        // Nếu không có ghế, tiến hành xóa phòng
        em.remove(room);
        return true;
    }

    public Room getRoomById(String roomCode) {
        return em.find(Room.class, roomCode);
    }

    private String generatorId(String prefix, String table, String columnId) {
        Query query = em.createQuery("SELECT r FROM " + table + " r");
        int number = query.getResultList().size() + 1;
        boolean isInvalid = true;
        String id = prefix;
        DecimalFormat df = new DecimalFormat("000");
        while (isInvalid) {
            String pkTemp = id + df.format(number);
            Query checkQuery = em.createQuery("SELECT r FROM " + table + " r WHERE r." + columnId + " = :pkTemp");
            checkQuery.setParameter("pkTemp", pkTemp);
            if (checkQuery.getResultList().size() > 0) {
                number++;
            } else {
                id = pkTemp;
                isInvalid = false;
            }
        }
        return id;
    }

    public void addRoom(Room room, String[] seatCounts) {
        // Tự động sinh mã phòng
        room.setRoomCode(generatorId("P", "Room", "roomCode"));
        room.setStatus(0); // Trạng thái mặc định: 0 (Repairing, chưa kích hoạt)

        // Tính tổng số ghế
        int totalSeats = 0;
        for (String count : seatCounts) {
            totalSeats += Integer.parseInt(count);
        }
        room.setTotalSeats(totalSeats); // Gán tổng số ghế

        em.persist(room);

        // Lấy các loại ghế từ cơ sở dữ liệu
        SeatType seatType1 = em.find(SeatType.class, 1); // Loại ghế 1
        SeatType seatType2 = em.find(SeatType.class, 2); // Loại ghế 2
        SeatType seatType3 = em.find(SeatType.class, 3); // Loại ghế 3

        if (seatType1 == null || seatType2 == null || seatType3 == null) {
            throw new IllegalStateException("One or more SeatType (1, 2, 3) not found in database");
        }

        // Tạo ghế và chi tiết ghế cho phòng
        for (int row = 0; row < seatCounts.length; row++) {
            int seatCount = Integer.parseInt(seatCounts[row]);
            char rowLabel = (char) ('A' + row);

            for (int seatNum = 1; seatNum <= seatCount; seatNum++) {
                String seatName = rowLabel + String.format("%02d", seatNum);

                // Kiểm tra xem ghế đã tồn tại chưa
                Query seatQuery = em.createQuery("SELECT s FROM Seat s WHERE s.seatName = :seatName");
                seatQuery.setParameter("seatName", seatName);
                Seat existingSeat = (Seat) seatQuery.getResultList().stream().findFirst().orElse(null);

                if (existingSeat == null) {
                    // Nếu ghế chưa tồn tại, tạo mới
                    existingSeat = new Seat();
                    existingSeat.setSeatName(seatName);
                    em.persist(existingSeat);
                }

                // Xác định loại ghế
                SeatType seatType;
                if (row < 3) {
                    seatType = seatType1; // 3 hàng đầu
                } else if (row == seatCounts.length - 1) {
                    seatType = seatType3; // Hàng cuối
                } else {
                    if (seatNum == 1 || seatNum == 2 || seatNum == seatCount - 1 || seatNum == seatCount) {
                        seatType = seatType1; // 2 ghế đầu và 2 ghế cuối
                    } else {
                        seatType = seatType2; // Ghế giữa
                    }
                }

                // Kiểm tra SeatRoomDetail
                Query detailQuery = em.createQuery(
                        "SELECT srd FROM SeatRoomDetail srd WHERE srd.seat = :seat AND srd.room = :room"
                );
                detailQuery.setParameter("seat", existingSeat);
                detailQuery.setParameter("room", room);
                List<SeatRoomDetail> existingDetails = detailQuery.getResultList();

                if (existingDetails.isEmpty()) {
                    SeatRoomDetail seatDetail = new SeatRoomDetail();
                    seatDetail.setRoom(room);
                    seatDetail.setSeat(existingSeat);
                    seatDetail.setSeatType(seatType);
                    em.persist(seatDetail);
                }
            }
        }
    }

    public void updateRoom(Room room) {
        Room existingRoom = em.find(Room.class, room.getRoomCode());
        if (existingRoom != null) {
            existingRoom.setRoomCode(room.getRoomCode());
            existingRoom.setStatus(room.getStatus());
            // totalSeats không thay đổi khi chỉnh sửa
            em.merge(existingRoom);
        }
    }
}