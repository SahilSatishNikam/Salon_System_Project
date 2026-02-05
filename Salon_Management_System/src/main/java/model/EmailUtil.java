package model;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {

    /**
     * Send an email via Gmail SMTP
     *
     * @param to      Recipient email
     * @param subject Email subject
     * @param body    Email body (text)
     */
    public static void sendMail(String to, String subject, String body) {

        // Sender email credentials
        final String fromEmail = "gaurithokal2004@gmail.com";
        final String appPassword = "xdqppivigfuhbzdt"; // Use Gmail App Password

        // SMTP properties
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS

        // Create session with authenticator
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        try {
            // Compose the email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);

            // Send the message
            Transport.send(message);
            System.out.println("Email sent successfully to " + to);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}