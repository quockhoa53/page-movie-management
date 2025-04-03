package org.example.ejb.entity;

import java.io.Serializable;
import java.util.Objects;

public class PriceChangeDetailId implements Serializable {
    private Integer showtimeId;
    private Integer priceChangeId;

    public PriceChangeDetailId() {}
    public PriceChangeDetailId(Integer showtimeId, Integer priceChangeId) {
        this.showtimeId = showtimeId;
        this.priceChangeId = priceChangeId;
    }

    public Integer getShowtimeId() { return showtimeId; }
    public void setShowtimeId(Integer showtimeId) { this.showtimeId = showtimeId; }
    public Integer getPriceChangeId() { return priceChangeId; }
    public void setPriceChangeId(Integer priceChangeId) { this.priceChangeId = priceChangeId; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PriceChangeDetailId that = (PriceChangeDetailId) o;
        return Objects.equals(showtimeId, that.showtimeId) && Objects.equals(priceChangeId, that.priceChangeId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(showtimeId, priceChangeId);
    }
}