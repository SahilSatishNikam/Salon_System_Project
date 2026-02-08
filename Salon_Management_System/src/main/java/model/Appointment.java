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

    // dashboard display fields
    private String customerName;
    private String phone;
    private String date;
    private String time;
    private String service;

    private String therapistDecision; // PENDING / COMPLETED / CANCELLED
    
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

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    public String getService() { return service; }
    public void setService(String service) { this.service = service; }
    
    public String getTherapistDecision() { return therapistDecision; }
    public void setTherapistDecision(String therapistDecision) {
        this.therapistDecision = therapistDecision;
    }

}
