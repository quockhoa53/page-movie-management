package org.example.ejb.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.util.Set;

@Entity
@Table(name = "seat_type")
public class SeatType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "seat_type_id")
    private Integer seatTypeId;

    @Column(name = "type_name")
    private String typeName;

    @Column(name = "price")
    private BigDecimal price;

    @OneToMany(mappedBy = "seatType", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<SeatRoomDetail> seatRoomDetails;

    // Getters and Setters
    public Integer getSeatTypeId() {
        return seatTypeId;
    }

    public void setSeatTypeId(Integer seatTypeId) {
        this.seatTypeId = seatTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Set<SeatRoomDetail> getSeatRoomDetails() {
        return seatRoomDetails;
    }

    public void setSeatRoomDetails(Set<SeatRoomDetail> seatRoomDetails) {
        this.seatRoomDetails = seatRoomDetails;
    }
}

