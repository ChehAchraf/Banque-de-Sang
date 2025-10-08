package org.medical.banquedesang.service;

import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.EtatReceveur;
import org.medical.banquedesang.enums.GroupeSanguin;
import java.time.LocalDate;
import java.time.Period;
import java.util.*;
import java.util.logging.Logger;
import java.util.stream.Collectors;


public class BloodCompatibilityService {
    
    private static final Logger logger = Logger.getLogger(BloodCompatibilityService.class.getName());
    
    private static final Map<GroupeSanguin, Set<GroupeSanguin>> COMPATIBILITY_MATRIX = initializeCompatibilityMatrix();


    private static Map<GroupeSanguin, Set<GroupeSanguin>> initializeCompatibilityMatrix() {
        Map<GroupeSanguin, Set<GroupeSanguin>> matrix = new EnumMap<>(GroupeSanguin.class);
        
        matrix.put(GroupeSanguin.AB_POS, EnumSet.allOf(GroupeSanguin.class));
        
        matrix.put(GroupeSanguin.AB_NEG, EnumSet.of(
            GroupeSanguin.O_NEG, GroupeSanguin.B_NEG, GroupeSanguin.A_NEG, GroupeSanguin.AB_NEG
        ));
        
        matrix.put(GroupeSanguin.A_POS, EnumSet.of(
            GroupeSanguin.O_NEG, GroupeSanguin.O_POS, GroupeSanguin.A_NEG, GroupeSanguin.A_POS
        ));
        

        matrix.put(GroupeSanguin.A_NEG, EnumSet.of(
            GroupeSanguin.O_NEG, GroupeSanguin.A_NEG
        ));
        
        matrix.put(GroupeSanguin.B_POS, EnumSet.of(
            GroupeSanguin.O_NEG, GroupeSanguin.O_POS, GroupeSanguin.B_NEG, GroupeSanguin.B_POS
        ));
        

        matrix.put(GroupeSanguin.B_NEG, EnumSet.of(
            GroupeSanguin.O_NEG, GroupeSanguin.B_NEG
        ));
        

        matrix.put(GroupeSanguin.O_POS, EnumSet.of(
            GroupeSanguin.O_NEG, GroupeSanguin.O_POS
        ));
        
        matrix.put(GroupeSanguin.O_NEG, EnumSet.of(
            GroupeSanguin.O_NEG
        ));
        
        return Collections.unmodifiableMap(matrix);
    }


    public boolean isBloodTypeCompatible(Donneur donneur, Receveur receveur) {
        if (donneur == null || receveur == null) {
            return false;
        }
        
        if (donneur.getGroupesanguin() == null || receveur.getGroupesanguin() == null) {
            return false;
        }

        Set<GroupeSanguin> compatibleDonorTypes = COMPATIBILITY_MATRIX.get(receveur.getGroupesanguin());
        return compatibleDonorTypes != null && compatibleDonorTypes.contains(donneur.getGroupesanguin());
    }


    public boolean isDonneurEligible(Donneur donneur) {
        if (donneur == null) {
            return false;
        }


        if (donneur.getDateNaissance() != null) {
            int age = Period.between(donneur.getDateNaissance(), LocalDate.now()).getYears();
            if (age < 18 || age > 65) {
                return false;
            }
        } else {
            return false; // No date of birth provided
        }


        if (donneur.getPoids() < 50.0) {
            return false;
        }

        // Check medical contraindications
        if (donneur.getMaladie() != null) {
            String maladie = donneur.getMaladie().toLowerCase();
            if (maladie.contains("hépatite") || 
                maladie.contains("vih") || 
                maladie.contains("diabète insulino-dépendant") ||
                maladie.contains("grossesse") ||
                maladie.contains("allaitement")) {
                return false;
            }
        }

        return true;
    }


    public Disponibilite calculateDonneurDisponibilite(Donneur donneur) {
        if (!isDonneurEligible(donneur)) {
            return Disponibilite.NON_ELIGIBLE;
        }


        if (donneur.getReceveur() != null) {
            return Disponibilite.NON_DISPONIBLE;
        }

        return Disponibilite.DISPONIBLE;
    }


    public EtatReceveur calculateEtatReceveur(Receveur receveur) {
        if (receveur == null || receveur.getUrgence() == null) {
            return EtatReceveur.EN_ATTENTE;
        }

        int donneursAssocies = receveur.getDonneurs() != null ? receveur.getDonneurs().size() : 0;
        int pochesRequises = receveur.getUrgence().getPochesRequises();

        return donneursAssocies >= pochesRequises ? EtatReceveur.SATISFAIT : EtatReceveur.EN_ATTENTE;
    }


    public List<Donneur> getCompatibleDonneurs(Receveur receveur, List<Donneur> allDonneurs) {
        if (receveur == null || allDonneurs == null) {
            return new ArrayList<>();
        }

        return allDonneurs.stream()
                .filter(donneur -> isBloodTypeCompatible(donneur, receveur))
                .filter(donneur -> donneur.getDisponibilite() == Disponibilite.DISPONIBLE)
                .filter(donneur -> donneur.getReceveur() == null) // Not already associated
                .toList();
    }


    public List<Receveur> getCompatibleReceveurs(Donneur donneur, List<Receveur> allReceveurs) {
        if (donneur == null || allReceveurs == null) {
            return new ArrayList<>();
        }

        return allReceveurs.stream()
                .filter(receveur -> isBloodTypeCompatible(donneur, receveur))
                .filter(receveur -> receveur.getEtatReceveur() == EtatReceveur.EN_ATTENTE)
                .filter(receveur -> canReceiveMoreDonors(receveur))
                .sorted((r1, r2) -> Integer.compare(r2.getUrgence().getPriorite(), r1.getUrgence().getPriorite()))
                .toList();
    }


    public boolean canReceiveMoreDonors(Receveur receveur) {
        if (receveur == null || receveur.getUrgence() == null) {
            return false;
        }

        int currentDonors = receveur.getDonneurs() != null ? receveur.getDonneurs().size() : 0;
        return currentDonors < receveur.getUrgence().getPochesRequises();
    }


    public Set<GroupeSanguin> getCompatibleDonorBloodTypes(GroupeSanguin receiverBloodType) {
        return COMPATIBILITY_MATRIX.getOrDefault(receiverBloodType, Collections.emptySet());
    }


    public Set<GroupeSanguin> getCompatibleReceiverBloodTypes(GroupeSanguin donorBloodType) {
        return COMPATIBILITY_MATRIX.entrySet().stream()
                .filter(entry -> entry.getValue().contains(donorBloodType))
                .map(Map.Entry::getKey)
                .collect(Collectors.toCollection(() -> EnumSet.noneOf(GroupeSanguin.class)));
    }
}