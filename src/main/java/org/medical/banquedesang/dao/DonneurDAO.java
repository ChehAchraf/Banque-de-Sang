package org.medical.banquedesang.dao;

import jakarta.persistence.EntityManager;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.util.JPAUtil;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DonneurDAO {
    private static final Logger logger =  Logger.getLogger(DonneurDAO.class.getName());
    public void addDonneur(Donneur donneur) {
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            em.persist(donneur);
            em.getTransaction().commit();
        }catch(Exception ex) {
            logger.log(Level.SEVERE, ex.getMessage(), ex);
        }
    }
}