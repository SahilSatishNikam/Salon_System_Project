

package model;

public class Service {

 private int id;
 private int salon_id;
 private String name;
 private int price;

 public int getId(){ return id; }
 public void setId(int id){ this.id=id; }

 public int getSalon_id(){ return salon_id; }
 public void setSalon_id(int s){ salon_id=s; }

 public String getName(){ return name; }
 public void setName(String n){ name=n; }

 public int getPrice(){ return price; }
 public void setPrice(int p){ price=p; }
}
