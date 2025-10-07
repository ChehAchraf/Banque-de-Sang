package org.medical.banquedesang.dao;

import jakarta.persistence.EntityManager;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.util.JPAUtil;

import java.util.List;
import java.util.logging.Logger;


public class DonneurDAO {
    private static final Logger logger =  Logger.getLogger(DonneurDAO.class.getName());
    private EntityManager em;

    public DonneurDAO() {
    }

    public void addDonneur(Donneur d) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(d);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Donneur findDonneurById(Long id) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Donneur.class, id);
        } finally {
            em.close();
        }
    }

    public List<Donneur> findAllDonneurs() {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT d FROM Donneur d", Donneur.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void updateDonneur(Donneur d) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(d);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void deleteDonneur(Donneur d) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            em.remove(em.contains(d) ? d : em.merge(d));
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}

