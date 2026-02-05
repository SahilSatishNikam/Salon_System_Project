package model;

public class User {
    private int id;
    private String name, email, password, phone;
    private int loyaltyPoints;
    public User() {}
    public User(int id, String name, String email, String password, String phone) {
        this.id = id; this.name = name; this.email = email; this.password = password; this.phone = phone;
    }

    // getters & setters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getPhone() { return phone; }
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public int getLoyaltyPoints() { return loyaltyPoints; } // ✅ getter
    public void setLoyaltyPoints(int loyaltyPoints) { this.loyaltyPoints = loyaltyPoints; } // ✅ setter
}