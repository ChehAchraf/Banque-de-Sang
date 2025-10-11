package org.medical.banquedesang.dao;

import jakarta.persistence.EntityManager;
import org.medical.banquedesang.entities.Donation;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.EtatReceveur;
import org.medical.banquedesang.service.BloodCompatibilityService;
import org.medical.banquedesang.util.JPAUtil;

import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DonationDAO {
    private static final Logger logger = Logger.getLogger(DonationDAO.class.getName());

    public Donation findById(Long id) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(Donation.class, id);
        } finally {
            em.close();
        }
    }

    public List<Donation> findAll() {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("select d from Donation d", Donation.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Donation> findByReceveurId(Long receveurId) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("select d from Donation d where d.receveur.id = :rid", Donation.class)
                    .setParameter("rid", receveurId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Donation> findByDonneurId(Long donneurId) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("select d from Donation d where d.donneur.id = :did", Donation.class)
                    .setParameter("did", donneurId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void performDonationTransaction(Donneur donneur, Receveur receveur, LocalDate date) {
        EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();

            Donneur managedDonneur = em.find(Donneur.class, donneur.getId());
            Receveur managedReceveur = em.find(Receveur.class, receveur.getId());

            Donation donation = new Donation();
            donation.setDateDonation(date != null ? date : LocalDate.now());
            donation.setDonneur(managedDonneur);
            donation.setReceveur(managedReceveur);

            em.persist(donation);

            managedDonneur.setReceveur(managedReceveur);
            managedDonneur.setDisponibilite(Disponibilite.NON_DISPONIBLE);
            managedReceveur.addDonneur(managedDonneur);

            BloodCompatibilityService compatibilityService = new BloodCompatibilityService();
            managedReceveur.setEtatReceveur(compatibilityService.calculateEtatReceveur(managedReceveur));

            em.merge(managedDonneur);
            em.merge(managedReceveur);

            em.getTransaction().commit();
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erreur lors de la transaction de donation", e);
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}