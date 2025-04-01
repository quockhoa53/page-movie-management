package org.example.ejb.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "price_change_detail")
public class PriceChangeDetail {
    @Id
    @ManyToOne
    @JoinColumn(name = "showtime_id", referencedColumnName = "showtime_id")
    private Showtime showtime;

    @Id
    @ManyToOne
    @JoinColumn(name = "change_id", referencedColumnName = "price_change_id")
    private PriceChange priceChange;

    @Column(name = "change_percentage")
    private Float changePercentage;

    // Getters and Setters
    public Showtime getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime showtime) {
        this.showtime = showtime;
    }

    public PriceChange getPriceChange() {
        return priceChange;
    }

    public void setPriceChange(PriceChange priceChange) {
        this.priceChange = priceChange;
    }

    public Float getChangePercentage() {
        return changePercentage;
    }

    public void setChangePercentage(Float changePercentage) {
        this.changePercentage = changePercentage;
    }
}

