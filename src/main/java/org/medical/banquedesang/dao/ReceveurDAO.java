package org.medical.banquedesang.dao;

import jakarta.persistence.EntityManager;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.util.JPAUtil;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ReceveurDAO {
    private static final Logger logger =  Logger.getLogger(ReceveurDAO.class.getName());

    public ReceveurDAO() { }

    // add receveur
    public void addReceveur(Receveur r) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(r);
            em.getTransaction().commit();
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // find receveur by id
    public Receveur findById(Long id) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Receveur.class, id);
        } finally {
            em.close();
        }
    }

    // find all receveur
    public List<Receveur> findAll() {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("select r from Receveur r", Receveur.class).getResultList();
        } finally {
            em.close();
        }
    }

    // update receveur
    public void update(Receveur r) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(r);
            em.getTransaction().commit();
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // delete Receveur
    public void delete(Receveur r) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.remove(em.contains(r) ? r : em.merge(r));
            em.getTransaction().commit();
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

}
