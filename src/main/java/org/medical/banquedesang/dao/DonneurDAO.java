package org.medical.banquedesang.dao;

import jakarta.persistence.EntityManager;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.util.JPAUtil;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DonneurDAO {
    private static final Logger logger = Logger.getLogger(DonneurDAO.class.getName());

    public DonneurDAO() {
    }

    // add donneur
    public void addDonneur(Donneur d) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(d);
            em.getTransaction().commit();
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // find donneur by id
    public Donneur findById(Long id) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Donneur.class, id);
        } finally {
            em.close();
        }
    }

    // find all donneurs
    public List<Donneur> findAll() {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("select d from Donneur d", Donneur.class).getResultList();
        } finally {
            em.close();
        }
    }

    // update donneur
    public void update(Donneur d) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(d);
            em.getTransaction().commit();
        } catch (Exception e) {
            logger.log(Level.SEVERE, e.getMessage(), e);
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // delete donneur
    public void delete(Donneur d) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.remove(em.contains(d) ? d : em.merge(d));
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

