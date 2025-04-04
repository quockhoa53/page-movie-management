package org.example.ejb.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "seat_room_detail")
public class SeatRoomDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "seat_booking_id")
    private Integer seatBookingId;

    @ManyToOne
    @JoinColumn(name = "seat_id", referencedColumnName = "seat_id")
    private Seat seat;

    @ManyToOne
    @JoinColumn(name = "room_code", referencedColumnName = "room_code")
    private Room room;

    @ManyToOne
    @JoinColumn(name = "seat_type_id", referencedColumnName = "seat_type_id", nullable = true)
    private SeatType seatType;

    // Getters and Setters
    public Integer getSeatBookingId() {
        return seatBookingId;
    }

    public void setSeatBookingId(Integer seatBookingId) {
        this.seatBookingId = seatBookingId;
    }

    public Seat getSeat() {
        return seat;
    }

    public void setSeat(Seat seat) {
        this.seat = seat;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public SeatType getSeatType() {
        return seatType;
    }

    public void setSeatType(SeatType seatType) {
        this.seatType = seatType;
    }
}
