package model;

import java.sql.Date;
import java.sql.Time;

public class Appointment {

    private int id;
    private int userId;
    private int therapistId;
    private int salonId;
    private String serviceName;   // NEW: for displaying in JSP
    private Date appointmentDate;
    private Time appointmentTime;
    private String status;        // e.g., Pending, Completed, Cancelled
    private boolean feedbackGiven; // NEW: for feedback status

    // Default constructor
    public Appointment() {}

    // Parameterized constructor
    public Appointment(int id, int userId, int therapistId, int serviceId, String serviceName,
                       Date appointmentDate, Time appointmentTime, String status, boolean feedbackGiven) {
        this.id = id;
        this.userId = userId;
        this.therapistId = therapistId;
        this.salonId = salonId;
        this.serviceName = serviceName;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.feedbackGiven = feedbackGiven;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getTherapistId() { return therapistId; }
    public void setTherapistId(int therapistId) { this.therapistId = therapistId; }

    public int getSalonId() { return salonId; }
    public void setSalonId(int salon) { this.salonId = salonId; }

    public String getServiceName() { return serviceName; }       // NEW
    public void setServiceName(String serviceName) { this.serviceName = serviceName; } // NEW

    public Date getAppointmentDate() { return appointmentDate; }
    public void setAppointmentDate(Date appointmentDate) { this.appointmentDate = appointmentDate; }

    public Time getAppointmentTime() { return appointmentTime; }
    public void setAppointmentTime(Time appointmentTime) { this.appointmentTime = appointmentTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isFeedbackGiven() { return feedbackGiven; }   // NEW
    public void setFeedbackGiven(boolean feedbackGiven) { this.feedbackGiven = feedbackGiven; } // NEW

    @Override
    public String toString() {
        return "Appointment [id=" + id + ", userId=" + userId + ", therapistId=" + therapistId +
                ", serviceId=" + salonId + ", serviceName=" + serviceName +
                ", appointmentDate=" + appointmentDate + ", appointmentTime=" + appointmentTime +
                ", status=" + status + ", feedbackGiven=" + feedbackGiven + "]";
    }
}


