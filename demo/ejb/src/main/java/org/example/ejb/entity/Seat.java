package org.example.ejb.entity;

import jakarta.persistence.*;

import java.util.Set;

@Entity
@Table(name = "seat")
public class Seat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "seat_id")
    private Integer seatId;

    @Column(name = "seat_name")
    private String seatName;

    @OneToMany(mappedBy = "seat", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<SeatRoomDetail> seatRoomDetails;

    // Getters and Setters
    public Integer getSeatId() {
        return seatId;
    }

    public void setSeatId(Integer seatId) {
        this.seatId = seatId;
    }

    public String getSeatName() {
        return seatName;
    }

    public void setSeatName(String seatName) {
        this.seatName = seatName;
    }

    public Set<SeatRoomDetail> getSeatRoomDetails() {
        return seatRoomDetails;
    }

    public void setSeatRoomDetails(Set<SeatRoomDetail> seatRoomDetails) {
        this.seatRoomDetails = seatRoomDetails;
    }
}

