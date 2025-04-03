package org.example.ejb.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "price_change_detail")
@IdClass(PriceChangeDetailId.class)
public class PriceChangeDetail {
    @Id
    @Column(name = "showtime_id")
    private Integer showtimeId;

    @Id
    @Column(name = "change_id")
    private Integer priceChangeId;

    @ManyToOne
    @JoinColumn(name = "showtime_id", referencedColumnName = "showtime_id", insertable = false, updatable = false)
    private Showtime showtime;

    @ManyToOne
    @JoinColumn(name = "change_id", referencedColumnName = "price_change_id", insertable = false, updatable = false)
    private PriceChange priceChange;

    @Column(name = "change_percentage")
    private Float changePercentage;

    public Integer getShowtimeId() { return showtimeId; }
    public void setShowtimeId(Integer showtimeId) { this.showtimeId = showtimeId; }
    public Integer getPriceChangeId() { return priceChangeId; }
    public void setPriceChangeId(Integer priceChangeId) { this.priceChangeId = priceChangeId; }
    public Showtime getShowtime() { return showtime; }
    public void setShowtime(Showtime showtime) { this.showtime = showtime; }
    public PriceChange getPriceChange() { return priceChange; }
    public void setPriceChange(PriceChange priceChange) { this.priceChange = priceChange; }
    public Float getChangePercentage() { return changePercentage; }
    public void setChangePercentage(Float changePercentage) { this.changePercentage = changePercentage; }
}