package org.medical.banquedesang.service;

import java.util.Comparator;
import java.util.List;

import org.medical.banquedesang.dao.ReceveurDAO;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.enums.EtatReceveur;
import org.medical.banquedesang.validation.ReceveurValidation;

public class ReceveurService {
    private final ReceveurDAO receveurDAO;
    private final BloodCompatibilityService compatibilityService;

    public ReceveurService(ReceveurDAO receveurDAO) {
        this.receveurDAO = receveurDAO;
        this.compatibilityService = new BloodCompatibilityService();
    }

    public void createReceveur(Receveur receveur) throws Exception {
        ReceveurValidation.validate(receveur);
        // Automatically calculate etatReceveur based on business rules
        receveur.setEtatReceveur(compatibilityService.calculateEtatReceveur(receveur));
        receveurDAO.addReceveur(receveur);
    }

    public List<Receveur> findAll() {
        return receveurDAO.findAll();
    }
    
    /**
     * Get all receivers sorted by priority (CRITIQUE > URGENT > NORMAL)
     */
    public List<Receveur> findAllSortedByPriority() {
        return receveurDAO.findAll().stream()
                .sorted(Comparator.comparing(
                    receveur -> receveur.getUrgence().getPriorite(),
                    Comparator.reverseOrder()
                ))
                .toList();
    }

    public Receveur findById(Long id) {
        return receveurDAO.findById(id);
    }

    public void update(Receveur receveur) throws Exception {
        ReceveurValidation.validate(receveur);
        // Recalculate etatReceveur when updating
        receveur.setEtatReceveur(compatibilityService.calculateEtatReceveur(receveur));
        receveurDAO.update(receveur);
    }

    public void delete(Receveur receveur) {
        receveurDAO.delete(receveur);
    }
    
    /**
     * Get all compatible donors for a specific receiver
     */
    public List<Donneur> getCompatibleDonneurs(Receveur receveur, List<Donneur> allDonneurs) {
        return compatibilityService.getCompatibleDonneurs(receveur, allDonneurs);
    }
    
    /**
     * Check blood type compatibility between donor and receiver
     */
    public boolean isCompatible(Donneur donneur, Receveur receveur) {
        return compatibilityService.isBloodTypeCompatible(donneur, receveur);
    }
    
    /**
     * Check if a receiver can receive more donors
     */
    public boolean canReceiveMoreDonors(Receveur receveur) {
        return compatibilityService.canReceiveMoreDonors(receveur);
    }
    
    /**
     * Get all receivers that are still waiting (EN_ATTENTE)
     */
    public List<Receveur> getWaitingReceveurs() {
        return findAllSortedByPriority().stream()
                .filter(r -> r.getEtatReceveur() == EtatReceveur.EN_ATTENTE)
                .toList();
    }
}


