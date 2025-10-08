package org.medical.banquedesang.service;

import java.util.List;

import org.medical.banquedesang.dao.DonneurDAO;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.validation.DonneurValidation;

public class DonneurService {
    private final DonneurDAO donneurDAO;
    private final BloodCompatibilityService compatibilityService;

    public DonneurService(DonneurDAO donneurDAO) {
        this.donneurDAO = donneurDAO;
        this.compatibilityService = new BloodCompatibilityService();
    }

    public void createDonneur(Donneur donneur) throws Exception {
        DonneurValidation.Validate(donneur);
        // Automatically calculate disponibilite based on business rules
        donneur.setDisponibilite(compatibilityService.calculateDonneurDisponibilite(donneur));
        donneurDAO.addDonneur(donneur);
    }

    public List<Donneur> findAll() {
        return donneurDAO.findAll();
    }

    public Donneur findById(Long id) {
        return donneurDAO.findById(id);
    }

    public void update(Donneur donneur) throws Exception {
        DonneurValidation.Validate(donneur);
        // Recalculate disponibilite when updating
        donneur.setDisponibilite(compatibilityService.calculateDonneurDisponibilite(donneur));
        donneurDAO.update(donneur);
    }

    public void delete(Donneur donneur) {
        donneurDAO.delete(donneur);
    }
    
    /**
     * Get all compatible receivers for a specific donor
     */
    public List<Receveur> getCompatibleReceveurs(Donneur donneur, List<Receveur> allReceveurs) {
        return compatibilityService.getCompatibleReceveurs(donneur, allReceveurs);
    }
    
    /**
     * Check if a donor is eligible for donation
     */
    public boolean isDonneurEligible(Donneur donneur) {
        return compatibilityService.isDonneurEligible(donneur);
    }
    
    /**
     * Check blood type compatibility between donor and receiver
     */
    public boolean isCompatible(Donneur donneur, Receveur receveur) {
        return compatibilityService.isBloodTypeCompatible(donneur, receveur);
    }
    
    /**
     * Get all available donors (DISPONIBLE status)
     */
    public List<Donneur> getAvailableDonneurs() {
        return findAll().stream()
                .filter(d -> d.getDisponibilite() == Disponibilite.DISPONIBLE)
                .toList();
    }
}
