package model;

import java.sql.Date;
import java.sql.Time;

public class Slot {

    private int id;
    private int therapistId;
    private Date availableDate;
    private Time startTime;
    private Time endTime;
    private int slotDuration;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTherapistId() {
		return therapistId;
	}
	public void setTherapistId(int therapistId) {
		this.therapistId = therapistId;
	}
	public Date getAvailableDate() {
		return availableDate;
	}
	public void setAvailableDate(Date availableDate) {
		this.availableDate = availableDate;
	}
	public Time getStartTime() {
		return startTime;
	}
	public void setStartTime(Time startTime) {
		this.startTime = startTime;
	}
	public Time getEndTime() {
		return endTime;
	}
	public void setEndTime(Time endTime) {
		this.endTime = endTime;
	}
	public int getSlotDuration() {
		return slotDuration;
	}
	public void setSlotDuration(int slotDuration) {
		this.slotDuration = slotDuration;
	}

    // getters setters
}
