package org.example.ejb.entity;

import jakarta.persistence.*;

import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "showtime")
public class Showtime {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "showtime_id")
    private Integer showtimeId;

    @Column(name = "show_date")
    private Date showDate;

    @Column(name = "show_time")
    private String showTime;

    @Column(name = "ticket_sale_start")
    private Date ticketSaleStart;

    @ManyToOne
    @JoinColumn(name = "room_code", referencedColumnName = "room_code")
    private Room room;

    @ManyToOne
    @JoinColumn(name = "movie_id", referencedColumnName = "movie_id")
    private Movie movie;

    @OneToMany(mappedBy = "showtime", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Ticket> tickets;

    @OneToMany(mappedBy = "showtime", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<PriceChangeDetail> priceChangeDetails;

    // Getters and Setters
    public Integer getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(Integer showtimeId) {
        this.showtimeId = showtimeId;
    }

    public Date getShowDate() {
        return showDate;
    }

    public void setShowDate(Date showDate) {
        this.showDate = showDate;
    }

    public String getShowTime() {
        return showTime;
    }

    public void setShowTime(String showTime) {
        this.showTime = showTime;
    }

    public Date getTicketSaleStart() {
        return ticketSaleStart;
    }

    public void setTicketSaleStart(Date ticketSaleStart) {
        this.ticketSaleStart = ticketSaleStart;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public Set<Ticket> getTickets() {
        return tickets;
    }

    public void setTickets(Set<Ticket> tickets) {
        this.tickets = tickets;
    }

    public Set<PriceChangeDetail> getPriceChangeDetails() {
        return priceChangeDetails;
    }

    public void setPriceChangeDetails(Set<PriceChangeDetail> priceChangeDetails) {
        this.priceChangeDetails = priceChangeDetails;
    }
}

