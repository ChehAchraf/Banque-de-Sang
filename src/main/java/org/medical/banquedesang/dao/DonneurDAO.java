package org.medical.banquedesang.dao;

import jakarta.persistence.EntityManager;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.util.JPAUtil;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DonneurDAO {
    private static final Logger logger =  Logger.getLogger(DonneurDAO.class.getName());
    private EntityManager em;

    public DonneurDAO(EntityManager em) {
        this.em = em;
    }
    //    add Donneur
    public void addDonneur(Donneur donneur) {
        try {
            em.getTransaction().begin();
            em.persist(donneur);
            em.getTransaction().commit();
        } catch (Exception ex) {
            logger.log(Level.SEVERE, ex.getMessage(), ex);
        }
    }
    // find by id
    public Donneur findById(Long id){
            return em.find(Donneur.class, id);
    }

    // get all Donneur
    public List<Donneur> findAll(){
        return em.createQuery("SELECT d FROM Donneur d", Donneur.class).getResultList();
    }

    // update donneur
    public void update(Donneur donneur){
        em.getTransaction().begin();
        em.merge(donneur);
        em.getTransaction().commit();
    }

    // delete donneur
    public void delete(Donneur donneur){
        em.getTransaction().begin();
        em.remove(em.contains(donneur) ? donneur : em.merge(donneur));
        em.getTransaction().commit();
    }



}

