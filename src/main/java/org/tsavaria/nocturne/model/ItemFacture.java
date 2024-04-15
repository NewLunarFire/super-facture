package org.tsavaria.nocturne.model;

import jakarta.xml.bind.annotation.XmlElement;

public class ItemFacture {
    @XmlElement
    private String nom;
    @XmlElement
    private long quantite;
    @XmlElement
    private double prix;

    public ItemFacture() {

    }

    public ItemFacture(String nom, long quantite, double prix) {
        this.nom = nom;
        this.quantite = quantite;
        this.prix = prix;
    }

    public String getNom() {
        return nom;
    }

    public long getQuantite() {
        return quantite;
    }

    public double getPrix() {
        return prix;
    }
}
