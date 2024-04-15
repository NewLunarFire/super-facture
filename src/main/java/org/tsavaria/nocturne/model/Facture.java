package org.tsavaria.nocturne.model;

import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;

import java.util.List;

@XmlRootElement(name = "facture")
public class Facture {
    @XmlElement(name = "item")
    private List<ItemFacture> items;

    public Facture() {

    }

    public Facture(List<ItemFacture> items) {
        this.items = items;
    }

    public List<ItemFacture> getItems() {
        return items;
    }
}
