package Models;

import java.util.Date;

public class Credit {
    public int id;
    public String name;
    public double montant;
    public String date;

    public Credit(int id, String name, double montant, String date) {
        this.id = id;
        this.name = name;
        this.montant = montant;
        this.date = date;
    }
}
