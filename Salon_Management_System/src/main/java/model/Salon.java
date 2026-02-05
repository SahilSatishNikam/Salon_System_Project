package model;

public class Salon {

 private int id;
 private String salon_name;
 private String owner_name;
 private String description;
 private String image_name;
 private String status;
 private String location;

 public int getId(){ return id; }
 public void setId(int id){ this.id=id; }

 public String getSalon_name(){ return salon_name; }
 public void setSalon_name(String salon_name){ this.salon_name=salon_name; }

 public String getOwner_name(){ return owner_name; }
 public void setOwner_name(String owner_name){ this.owner_name=owner_name; }

 public String getDescription(){ return description; }
 public void setDescription(String description){ this.description=description; }

 public String getImage_name(){ return image_name; }
 public void setImage_name(String image_name){ this.image_name=image_name; }

 public String getStatus(){ return status; }
 public void setStatus(String status){ this.status=status; }

 public String getLocation(){ return location; }
 public void setLocation(String location){ this.location=location; }
}
