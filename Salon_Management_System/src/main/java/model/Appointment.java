package model;

import java.sql.Date;
import java.sql.Time;

public class Appointment {

    private int id;
    private int userId;
    private int therapistId;
    private int salonId;
    private String serviceName;

    private Date appointmentDate;
    private Time appointmentTime;

    private String status;
    private boolean feedbackGiven;

    // -------- GETTERS & SETTERS --------

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getTherapistId() { return therapistId; }
    public void setTherapistId(int therapistId) { this.therapistId = therapistId; }

    public int getSalonId() { return salonId; }
    public void setSalonId(int salonId) { this.salonId = salonId; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public Date getAppointmentDate() { return appointmentDate; }
    public void setAppointmentDate(Date appointmentDate) { this.appointmentDate = appointmentDate; }

    public Time getAppointmentTime() { return appointmentTime; }
    public void setAppointmentTime(Time appointmentTime) { this.appointmentTime = appointmentTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isFeedbackGiven() { return feedbackGiven; }
    public void setFeedbackGiven(boolean feedbackGiven) { this.feedbackGiven = feedbackGiven; }
}
