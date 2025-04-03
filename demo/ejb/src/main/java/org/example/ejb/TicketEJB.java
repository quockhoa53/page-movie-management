package org.example.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.ejb.entity.Ticket;

import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class TicketEJB {
    @PersistenceContext(unitName = "cinema")
    private EntityManager em;

    public List<Ticket> getAllTickets() {
        List<Ticket> tickets = em.createQuery("SELECT t FROM Ticket t", Ticket.class).getResultList();
        System.out.println("Tickets found: " + tickets.size());
        return tickets;
    }

    public boolean deleteTicket(int ticketId) {
        Ticket ticket = em.find(Ticket.class, ticketId);
        if (ticket != null) {
            em.remove(ticket);
            return true;
        }
        return false;
    }

    public Ticket getTicketById(Integer ticketId) {
        return em.find(Ticket.class, ticketId);
    }
}
