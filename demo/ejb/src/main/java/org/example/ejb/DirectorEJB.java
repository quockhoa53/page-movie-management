package org.example.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.ejb.entity.Director;

import java.util.List;

@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
public class DirectorEJB {
    @PersistenceContext(unitName = "cinema")
    private EntityManager em;

    // Lấy tất cả các đạo diễn
    public List<Director> getAllDirectors() {
        List<Director> directors = em.createQuery("SELECT t FROM Director t", Director.class).getResultList();
        System.out.println("Directors found: " + directors.size());
        return directors;
    }

    // Xóa đạo diễn theo ID
    public boolean deleteDirector(int directorId) {
        Director director = em.find(Director.class, directorId);
        if (director != null) {
            em.remove(director);
            return true;
        }
        return false;
    }

    // Lấy đạo diễn theo ID
    public Director getDirectorById(Integer directorId) {
        return em.find(Director.class, directorId);
    }
    // Thêm đạo diễn mới
    public void addDirector(Director director) {
        em.persist(director);
    }

}
