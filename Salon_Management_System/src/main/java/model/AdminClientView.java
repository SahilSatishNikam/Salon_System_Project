package model;

import java.sql.Date;

public class AdminClientView {

    private int id;
    private String name;
    private String phone;
    private int totalVisits;
    private Date lastVisit;
    private String salonName;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getTotalVisits() { return totalVisits; }
    public void setTotalVisits(int totalVisits) { this.totalVisits = totalVisits; }

    public Date getLastVisit() { return lastVisit; }
    public void setLastVisit(Date lastVisit) { this.lastVisit = lastVisit; }

    public String getSalonName() { return salonName; }
    public void setSalonName(String salonName) { this.salonName = salonName; }
}
