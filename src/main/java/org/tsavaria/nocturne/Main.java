package org.tsavaria.nocturne;

import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.tsavaria.nocturne.model.Facture;
import org.tsavaria.nocturne.model.InfoEntreprise;
import org.tsavaria.nocturne.model.ItemFacture;
import org.xml.sax.SAXException;

import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.time.Instant;
import java.util.Date;
import java.util.List;
import java.util.Objects;

public class Main {

    public static void main(String[] args) throws SAXException, IOException, TransformerException, URISyntaxException, JAXBException {
        var xsltFile = new File(getResource("facture.xsl"));
        var fopFactory = FopFactory.newInstance(new File(getResource("fop.xconf")));

        var xml = creerXmlDeFacture(creerFacture());
        var src = new StreamSource(new StringReader(xml));
        var factory = TransformerFactory.newInstance();
        var transformer = factory.newTransformer(new StreamSource(xsltFile));

        try (var out = new BufferedOutputStream(new FileOutputStream("facture.pdf"))) {
            var fop = fopFactory.newFop(MimeConstants.MIME_PDF, out);
            var res = new SAXResult(fop.getDefaultHandler());
            transformer.transform(src, res);
        }
    }

    private static URI getResource(String name) throws URISyntaxException {
        return Objects.requireNonNull(Main.class.getResource(name)).toURI();
    }

    private static String creerXmlDeFacture(Facture facture) throws JAXBException {
        var jaxbContext = JAXBContext.newInstance(Facture.class);
        var jaxbMarshaller = jaxbContext.createMarshaller();
        var stringWriter = new StringWriter();

        jaxbMarshaller.marshal(facture, stringWriter);
        return stringWriter.toString();
    }

    private static Facture creerFacture() {
        var entreprise = new InfoEntreprise("Chat Illimités Inc.", "123 rue Félin, Chatmonix, Québec", "J1M E0W");
        var items = List.of(
                new ItemFacture("Patente à gosse #10", 2, 4.44),
                new ItemFacture("Machin chouette à tête carrée", 1, 4.97));


        return new Facture(42, entreprise, new Date(), items);
    }
}