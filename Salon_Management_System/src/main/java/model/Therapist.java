package model;

public class Therapist {


private int id;
private int salonId;
private String name;
private String phone;
private String email;
private String specialty;
private String password;
private String status;          // Active / Inactive
private int approved;           // 0 or 1
private String therapistDecision;   // NEW COLUMN

public Therapist() {}

// Full constructor
public Therapist(int id, int salonId, String name, String phone,
                 String email, String specialty, String password,
                 String status, int approved, String therapistDecision) {
    this.id = id;
    this.salonId = salonId;
    this.name = name;
    this.phone = phone;
    this.email = email;
    this.specialty = specialty;
    this.password = password;
    this.status = status;
    this.approved = approved;
    this.therapistDecision = therapistDecision;
}

public int getId() { return id; }
public void setId(int id) { this.id = id; }

public int getSalonId() { return salonId; }
public void setSalonId(int salonId) { this.salonId = salonId; }

public String getName() { return name; }
public void setName(String name) { this.name = name; }

public String getPhone() { return phone; }
public void setPhone(String phone) { this.phone = phone; }

public String getEmail() { return email; }
public void setEmail(String email) { this.email = email; }

public String getSpecialty() { return specialty; }
public void setSpecialty(String specialty) { this.specialty = specialty; }

public String getPassword() { return password; }
public void setPassword(String password) { this.password = password; }

public String getStatus() { return status; }
public void setStatus(String status) { this.status = status; }

public int getApproved() { return approved; }
public void setApproved(int approved) { this.approved = approved; }

public String getTherapistDecision() { return therapistDecision; }
public void setTherapistDecision(String therapistDecision) { 
    this.therapistDecision = therapistDecision; 
}


}
