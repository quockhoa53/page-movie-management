package org.example.ejb.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "ticket")
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ticket_id")
    private Integer ticketId;

    @ManyToOne
    @JoinColumn(name = "showtime_id", referencedColumnName = "showtime_id")
    private Showtime showtime;

    @ManyToOne
    @JoinColumn(name = "customer_id", referencedColumnName = "customer_id", nullable = true)
    private Customer customer;

    @Column(name = "sale_date")
    private Date saleDate;

    @Column(name = "payment_time")
    private Date paymentTime;

    @Column(name = "booking_status")
    private Boolean bookingStatus;

    @ManyToOne
    @JoinColumn(name = "seat_booking_id", referencedColumnName = "seat_booking_id", nullable = true)
    private SeatRoomDetail seatRoomDetail;

    @ManyToOne
    @JoinColumn(name = "employee_id", referencedColumnName = "employee_id", nullable = true)
    private Employee employee;

    // Getters and Setters
    public Integer getTicketId() {
        return ticketId;
    }

    public void setTicketId(Integer ticketId) {
        this.ticketId = ticketId;
    }

    public Showtime getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime showtime) {
        this.showtime = showtime;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }

    public Date getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

    public Boolean getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(Boolean bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public SeatRoomDetail getSeatRoomDetail() {
        return seatRoomDetail;
    }

    public void setSeatRoomDetail(SeatRoomDetail seatRoomDetail) {
        this.seatRoomDetail = seatRoomDetail;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }
}

