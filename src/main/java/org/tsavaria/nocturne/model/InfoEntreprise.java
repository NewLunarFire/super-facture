package org.tsavaria.nocturne.model;

import jakarta.xml.bind.annotation.XmlElement;

public class InfoEntreprise {
    @XmlElement
    private String nom;
    @XmlElement
    private String adresse;
    @XmlElement
    private String codePostal;

    public InfoEntreprise() {
    }

    public InfoEntreprise(String nom, String adresse, String codePostal) {
        this.nom = nom;
        this.adresse = adresse;
        this.codePostal = codePostal;
    }

    public String getNom() {
        return nom;
    }

    public String getAdresse() {
        return adresse;
    }

    public String getCodePostal() {
        return codePostal;
    }
}
