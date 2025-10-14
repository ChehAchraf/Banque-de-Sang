package org.medical.banquedesang.entities;

import jakarta.persistence.*;
import org.medical.banquedesang.enums.EtatReceveur;
import org.medical.banquedesang.enums.Urgence;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="receveur")
public class Receveur extends Account {
    
    @OneToMany(mappedBy = "receveur", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<Donneur> donneurs = new ArrayList<>();
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Urgence urgence = Urgence.NORMAL; // Default to NORMAL
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private EtatReceveur etatReceveur = EtatReceveur.EN_ATTENTE; // Default to EN_ATTENTE

    public Receveur(){

    }

    public List<Donneur> getDonneurs() {
        return donneurs;
    }

    public void setDonneurs(List<Donneur> donneurs) {
        this.donneurs = donneurs;
    }

    public void addDonneur(Donneur donneur){
        donneurs.add(donneur);
    }

    public void removeDonneur(Donneur donneur){
        donneurs.remove(donneur);
        donneur.setReceveur(null);
    }
    
    // Getter and setter for urgence
    public Urgence getUrgence() {
        return urgence;
    }
    
    public void setUrgence(Urgence urgence) {
        this.urgence = urgence;
    }
    
    // Getter and setter for etatReceveur
    public EtatReceveur getEtatReceveur() {
        return etatReceveur;
    }
    
    public void setEtatReceveur(EtatReceveur etatReceveur) {
        this.etatReceveur = etatReceveur;
    }
    

    public int getPochesRequises() {
        return urgence != null ? urgence.getPochesRequises() : 1;
    }
    

    public int getNombreDonneursAssocies() {
        return donneurs != null ? donneurs.size() : 0;
    }
    

    public boolean peutRecevoirPlusDonneurs() {
        return getNombreDonneursAssocies() < getPochesRequises();
    }

    @Override
    public String toString() {
        return "Receveur{" +
                "id=" + getId() +
                ", nom=" + getNom() +
                ", prenom=" + getPrenom() +
                ", urgence=" + urgence +
                ", etatReceveur=" + etatReceveur +
                ", donneurs=" + donneurs.size() + "/" + getPochesRequises() +
                '}';
    }
}
