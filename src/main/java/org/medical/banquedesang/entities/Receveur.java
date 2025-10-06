package org.medical.banquedesang.entities;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="receveur")

public class Receveur extends Account{
    @OneToMany(mappedBy = "receveur",cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Donneur> donneurs =  new ArrayList<Donneur>();

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
    }

    @Override
    public String toString() {
        return "Receveur{" +
                "id=" + getId() +
                ", nom=" + getNom() +
                ", prenom=" + getPrenom() +
                ", donneurs=" + donneurs.size() +
                '}';
    }
}
