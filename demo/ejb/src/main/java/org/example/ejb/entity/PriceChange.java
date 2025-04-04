package org.example.ejb.entity;

import jakarta.persistence.*;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "price_change")
public class PriceChange {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "price_change_id")
    private Integer priceChangeId;

    @Column(name = "change_reason")
    private String changeReason;

    @Column(name = "change_date")
    private Date changeDate;

    @OneToMany(mappedBy = "priceChange", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<PriceChangeDetail> priceChangeDetails;

    // Getters and Setters
    public Integer getPriceChangeId() {
        return priceChangeId;
    }

    public void setPriceChangeId(Integer priceChangeId) {
        this.priceChangeId = priceChangeId;
    }

    public String getChangeReason() {
        return changeReason;
    }

    public void setChangeReason(String changeReason) {
        this.changeReason = changeReason;
    }

    public Date getChangeDate() {
        return changeDate;
    }

    public void setChangeDate(Date changeDate) {
        this.changeDate = changeDate;
    }

    public Set<PriceChangeDetail> getPriceChangeDetails() {
        return priceChangeDetails;
    }

    public void setPriceChangeDetails(Set<PriceChangeDetail> priceChangeDetails) {
        this.priceChangeDetails = priceChangeDetails;
    }
}

