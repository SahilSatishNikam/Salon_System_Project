package model;

import java.util.List;

public class Salon {
    private int id;
    private String name;
    private String email;
    private String phone;
    private String address;
    private byte[] image;

    // ✅ Add list of services
    private List<Service> services;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public byte[] getImage() { return image; }
    public void setImage(byte[] image) { this.image = image; }

    public List<Service> getServices() { return services; }
    public void setServices(List<Service> services) { this.services = services; }
}
