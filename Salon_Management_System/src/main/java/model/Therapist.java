package model;

public class Therapist {
    private int id;
    private String name;
    private int salonId;
    private String phone;
    private String email;
    private String specialty;

    // ✅ No-argument constructor
    public Therapist() {}

    // Optional: all-args constructor
    public Therapist(int id, int salonId, String name, String phone, String email, String specialty) {
        this.id = id;
        this.salonId = salonId;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.specialty = specialty;
    }

    // ✅ Getters and Setters
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
}
