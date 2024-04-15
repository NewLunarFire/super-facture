package org.tsavaria.nocturne;

import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

public class Util {
    private final static DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd").withZone(ZoneId.systemDefault());

    public static String formatterDate(String date) {
        return formatter.format(Instant.parse(date));
    }

    public static String formatterMontant(double montant) {
        return String.format("%.2f", montant);
    }
}
