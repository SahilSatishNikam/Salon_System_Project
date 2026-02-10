package model;

public class User {

    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private int loyaltyPoints;
    private String customerName;

    // ✅ LONGBLOB → byte[]
    private byte[] profilePhoto;

    // ===== Constructors =====

    public User() {}

    public User(int id, String name, String email, String password, String phone) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
    }

    // ===== Getters =====

    public int getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getPhone() { return phone; }
    public int getLoyaltyPoints() { return loyaltyPoints; }
    public String getCustomerName() { return customerName; }

    public byte[] getProfilePhoto() { return profilePhoto; }

    // ===== Setters =====

    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setLoyaltyPoints(int loyaltyPoints) { this.loyaltyPoints = loyaltyPoints; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public void setProfilePhoto(byte[] profilePhoto) {
        this.profilePhoto = profilePhoto;
    }
}
