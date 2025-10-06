package org.medical.banquedesang.entities;

import jakarta.persistence.*;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.GroupeSanguin;

import java.time.LocalDate;

@MappedSuperclass

public abstract class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nom;
    private String prenom;
    private String cin;
    private String telephone;
    private LocalDate dateNaissance;
    private double poids;
    private String sexe;
    private GroupeSanguin groupesanguin;
    private Disponibilite disponibilite;
    private String maladie;


    public Account (){
    }

    public Account(Long id,String nom, String prenom, String cin, String telephone, LocalDate dateNaissance, double poids, String sexe, GroupeSanguin groupesanguin, Disponibilite disponibilite, String maladie) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.cin = cin;
        this.telephone = telephone;
        this.dateNaissance = dateNaissance;
        this.poids = poids;
        this.sexe = sexe;
        this.groupesanguin = groupesanguin;
        this.disponibilite = disponibilite;
        this.maladie = maladie;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public double getPoids() {
        return poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public GroupeSanguin getGroupesanguin() {
        return groupesanguin;
    }

    public void setGroupesanguin(GroupeSanguin groupesanguin) {
        this.groupesanguin = groupesanguin;
    }

    public Disponibilite getDisponibilite() {
        return disponibilite;
    }

    public void setDisponibilite(Disponibilite disponibilite) {
        this.disponibilite = disponibilite;
    }

    public String getMaladie() {
        return maladie;
    }

    public void setMaladie(String maladie) {
        this.maladie = maladie;
    }
}
