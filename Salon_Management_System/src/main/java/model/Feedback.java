package model;

public class Feedback {

    private int feedbackId;
    private int userId;
    private int salonId;
    private int therapistId;
    private int salonRating;
    private int therapistRating;
    private String comments;

    // Getters & Setters
    public int getFeedbackId() { return feedbackId; }
    public void setFeedbackId(int feedbackId) { this.feedbackId = feedbackId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getSalonId() { return salonId; }
    public void setSalonId(int salonId) { this.salonId = salonId; }

    public int getTherapistId() { return therapistId; }
    public void setTherapistId(int therapistId) { this.therapistId = therapistId; }

    public int getSalonRating() { return salonRating; }
    public void setSalonRating(int salonRating) { this.salonRating = salonRating; }

    public int getTherapistRating() { return therapistRating; }
    public void setTherapistRating(int therapistRating) { this.therapistRating = therapistRating; }

    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }
}
