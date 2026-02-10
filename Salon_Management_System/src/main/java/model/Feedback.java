package model;

import java.sql.Timestamp;

public class Feedback {

    private int id;           // unique ID for feedback
    private String user;      // name of the user
    private String message;   // feedback message
    private int rating;       // 1-5
    private Timestamp createdAt; // submission timestamp

    public Feedback() {}

    public Feedback(int id, String user, String message, int rating, Timestamp createdAt) {
        this.id = id;
        this.user = user;
        this.message = message;
        this.rating = rating;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUser() { return user; }
    public void setUser(String user) { this.user = user; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
