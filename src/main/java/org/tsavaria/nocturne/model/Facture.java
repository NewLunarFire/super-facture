package org.tsavaria.nocturne.model;

import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;

import java.time.Instant;
import java.util.Date;
import java.util.List;

@XmlRootElement(name = "facture")
public class Facture {
    private final static double TAUX_TPS = 0.05;
    private final static double TAUX_TVQ = 0.09975;

    @XmlElement
    private int id;
    @XmlElement(name = "item")
    private List<ItemFacture> items;
    @XmlElement
    private InfoEntreprise entreprise;
    @XmlElement
    private Date emission;

    public Facture() {
    }

    public Facture(int id, InfoEntreprise entreprise, Date emission, List<ItemFacture> items) {
        this.id = id;
        this.items = items;
        this.entreprise = entreprise;
        this.emission = emission;
    }

    public int getId() {
        return id;
    }

    public InfoEntreprise getEntreprise() {
        return entreprise;
    }
    
    public Date getEmission() {
        return emission;
    }

    public List<ItemFacture> getItems() {
        return items;
    }

    @XmlElement
    public double getSousTotal() {
        return items.stream().mapToDouble(ItemFacture::getPrix).sum();
    }

    @XmlElement
    public double getTaxes() {
        return getTaxes(getSousTotal());
    }

    @XmlElement
    public double getGrandTotal() {
        var sousTotal = getSousTotal();
        return sousTotal + getTaxes(sousTotal);
    }

    private static double getTaxes(double sousTotal) {
        var tps = sousTotal * TAUX_TPS;
        var tvq = sousTotal * TAUX_TVQ;

        return tps + tvq;
    }
}
