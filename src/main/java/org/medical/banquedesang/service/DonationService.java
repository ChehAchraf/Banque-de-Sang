package org.medical.banquedesang.service;

import org.medical.banquedesang.dao.DonationDAO;
import org.medical.banquedesang.dao.DonneurDAO;
import org.medical.banquedesang.dao.ReceveurDAO;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.EtatReceveur;
import org.medical.banquedesang.validation.DonationValidation;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class DonationService {
    private final DonationDAO donationDAO;
    private final DonneurDAO donneurDAO;
    private final ReceveurDAO receveurDAO;
    private final BloodCompatibilityService compatibilityService;

    public DonationService(DonationDAO donationDAO, DonneurDAO donneurDAO, ReceveurDAO receveurDAO) {
        this.donationDAO = donationDAO;
        this.donneurDAO = donneurDAO;
        this.receveurDAO = receveurDAO;
        this.compatibilityService = new BloodCompatibilityService();
    }

    public void registerDonation(Long donneurId, Long receveurId) throws Exception {
        if (donneurId == null || receveurId == null) {
            throw new IllegalArgumentException("Donneur et receveur sont obligatoires");
        }
        Donneur donneur = donneurDAO.findById(donneurId);
        Receveur receveur = receveurDAO.findById(receveurId);

        DonationValidation.validate(donneur, receveur);

        // Business validations
        if (!compatibilityService.isDonneurEligible(donneur)) {
            throw new IllegalStateException("Le donneur n'est pas éligible au don");
        }
        if (donneur.getDisponibilite() != Disponibilite.DISPONIBLE) {
            throw new IllegalStateException("Le donneur n'est pas disponible");
        }
        if (donneur.getReceveur() != null) {
            throw new IllegalStateException("Le donneur est déjà associé à un receveur");
        }
        if (!compatibilityService.isBloodTypeCompatible(donneur, receveur)) {
            throw new IllegalStateException("Groupes sanguins incompatibles");
        }
        if (receveur.getEtatReceveur() == EtatReceveur.SATISFAIT) {
            throw new IllegalStateException("Ce receveur est déjà satisfait");
        }
        if (!compatibilityService.canReceiveMoreDonors(receveur)) {
            throw new IllegalStateException("Ce receveur ne peut pas recevoir plus de donneurs");
        }

        donationDAO.performDonationTransaction(donneur, receveur, LocalDate.now());
    }

    public List<Donneur> getCompatibleAvailableDonneursForReceveur(Long receveurId) {
        Receveur receveur = receveurDAO.findById(receveurId);
        return new DonneurService(donneurDAO)
                .findAll()
                .stream()
                .filter(d -> d.getDisponibilite() == Disponibilite.DISPONIBLE)
                .filter(d -> d.getReceveur() == null)
                .filter(d -> compatibilityService.isBloodTypeCompatible(d, receveur))
                .collect(Collectors.toList());
    }

    public List<Receveur> getCompatibleReceveursForDonneur(Long donneurId) {
        Donneur donneur = donneurDAO.findById(donneurId);
        return new ReceveurService(receveurDAO)
                .findAllSortedByPriority()
                .stream()
                .filter(r -> r.getEtatReceveur() != EtatReceveur.SATISFAIT)
                .filter(r -> compatibilityService.isBloodTypeCompatible(donneur, r))
                .filter(compatibilityService::canReceiveMoreDonors)
                .collect(Collectors.toList());
    }
}