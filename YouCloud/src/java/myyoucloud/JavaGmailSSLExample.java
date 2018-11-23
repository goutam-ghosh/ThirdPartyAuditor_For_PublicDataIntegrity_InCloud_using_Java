package myyoucloud;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * Created by Ankush on 28/10/14.
 */
public class JavaGmailSSLExample {

    public static void main(String[] args) {

        final String username = "ankush.r.nistane@gmail.com";
        final String password = "9923458984";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        Session session = Session.getDefaultInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("ankush.r.nistane@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse("ankush.r.nistane@gmail.com"));
            message.setSubject("Test mail Example");
            message.setText("Hi,"
                    + "This is a Test mail Example!");

            Transport.send(message);

            System.out.println("Mail sent succesfully!");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
