

package model;

public class Feedback {

 private String user;
 private String message;
 private int rating;

 public String getUser(){ return user; }
 public void setUser(String u){ user=u; }

 public String getMessage(){ return message; }
 public void setMessage(String m){ message=m; }

 public int getRating(){ return rating; }
 public void setRating(int r){ rating=r; }
}
