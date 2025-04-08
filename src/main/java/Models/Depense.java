package Models;

import java.util.Date;

public class Depense {
    public int id;
    public double montant;
    public String date;

    public Depense(int id, double montant, String date) {
        this.id = id;
        this.montant = montant;
        this.date = date;
    }
}
