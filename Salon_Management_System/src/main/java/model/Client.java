package model;

public class Client {

    private int id;
    private String name;
    private String phone;
    private int userId;

    // Default constructor
    public Client() {}

    // Full constructor
    public Client(int id, String name, String phone, int userId) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.userId = userId;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    @Override
    public String toString() {
        return "Client{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", userId=" + userId +
                '}';
    }
}
