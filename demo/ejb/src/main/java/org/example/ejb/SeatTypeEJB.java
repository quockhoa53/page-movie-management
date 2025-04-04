package org.example.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.ejb.entity.SeatType;

import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class SeatTypeEJB {

    @PersistenceContext(unitName = "cinema")
    private EntityManager entityManager;

    // Create a new SeatType
    public SeatType createSeatType(SeatType seatType) {
        entityManager.persist(seatType);
        return seatType;
    }

    // Find a SeatType by its ID
    public SeatType findSeatTypeById(Integer seatTypeId) {
        return entityManager.find(SeatType.class, seatTypeId);
    }

    // Update an existing SeatType
    public SeatType updateSeatType(SeatType seatType) {
        return entityManager.merge(seatType);
    }

    // Delete a SeatType by its ID
    public void deleteSeatType(Integer seatTypeId) {
        SeatType seatType = findSeatTypeById(seatTypeId);
        if (seatType != null) {
            entityManager.remove(seatType);
        }
    }

    // Get a list of all SeatTypes
    public List<SeatType> getAllSeatTypes() {
        return entityManager.createQuery("SELECT s FROM SeatType s", SeatType.class).getResultList();
    }
}

