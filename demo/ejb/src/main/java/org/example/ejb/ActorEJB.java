package org.example.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.ejb.entity.Actor;

import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class ActorEJB {
    @PersistenceContext(unitName = "cinema")
    private EntityManager em;

    // Lấy tất cả diễn viên
    public List<Actor> getAllActors() {
        return em.createQuery("SELECT a FROM Actor a", Actor.class).getResultList();
    }

    // Xóa diễn viên theo ID
    public boolean deleteActor(int actorId) {
        Actor actor = em.find(Actor.class, actorId);
        if (actor != null) {
            em.remove(actor);
            return true;
        }
        return false;
    }

    // Lấy diễn viên theo ID
    public Actor getActorById(Integer actorId) {
        return em.find(Actor.class, actorId);
    }

    // Thêm diễn viên mới
    public void addActor(Actor actor) {
        em.persist(actor);
    }
}