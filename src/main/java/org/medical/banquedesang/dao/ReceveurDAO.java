package org.medical.banquedesang.dao;
import jakarta.persistence.EntityManager;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.util.JPAUtil;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ReceveurDAO {
    private static final Logger logger =  Logger.getLogger(ReceveurDAO.class.getName());
    private EntityManager em;

    public ReceveurDAO() {
        em = JPAUtil.getEntityManagerFactory().createEntityManager();
    }

    // add receveur
    public void addReceveur(Receveur r) {
        try{
            em.getTransaction().begin();
            em.persist(r);
            em.getTransaction().commit();
        }catch(Exception e){
            logger.log(Level.SEVERE,e.getMessage(),e);
        }finally{
            em.getTransaction().rollback();
            em.close();
        }
    }

    // find receveur by id
    public Receveur findById(Long id) {
        try{
            return em.find(Receveur.class, id);
        }catch(Exception e){
            logger.log(Level.SEVERE,e.getMessage(),e);
        }finally{
            em.getTransaction().rollback();
            em.close();
        }
        return null;
    }

    // find all receveur
    public List<Receveur> findAll() {
        try{
            em.getTransaction().begin();
            return em.createQuery("select r from Receveur r", Receveur.class).getResultList();
        }catch(Exception e){
            logger.log(Level.SEVERE,e.getMessage(),e);
        }finally{
            em.getTransaction().rollback();
            em.close();
        }
        return null;
    }

    // update receveur
    public void update(Receveur r) {
        try{
            em.getTransaction().begin();
            em.merge(r);
            em.getTransaction().commit();
        }catch(Exception e){
            logger.log(Level.SEVERE,e.getMessage(),e);
        }finally{
            em.getTransaction().rollback();
            em.close();
        }
    }

    // delete Receveur
    public void delete(Receveur r) {
        try{
            em.getTransaction().begin();
            em.remove(r);
        }catch(Exception e){
            logger.log(Level.SEVERE,e.getMessage(),e);
        }finally{
            em.getTransaction().rollback();
            em.close();
        }
    }
}
