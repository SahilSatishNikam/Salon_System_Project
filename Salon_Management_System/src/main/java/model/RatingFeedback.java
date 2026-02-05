package model;

public class RatingFeedback {
    private int id;
    private int userId;
    private int therapistId;
    private int serviceId;
    private int rating;        // 1 to 5
    private String feedback;

    public RatingFeedback() {}

    public RatingFeedback(int id, int userId, int therapistId, int serviceId, int rating, String feedback) {
        this.id = id;
        this.userId = userId;
        this.therapistId = therapistId;
        this.serviceId = serviceId;
        this.rating = rating;
        this.feedback = feedback;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getTherapistId() { return therapistId; }
    public void setTherapistId(int therapistId) { this.therapistId = therapistId; }

    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getFeedback() { return feedback; }
    public void setFeedback(String feedback) { this.feedback = feedback; }
}