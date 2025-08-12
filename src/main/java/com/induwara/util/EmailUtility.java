package com.induwara.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtility {

    public static void sendEmail(String toEmail, String subject, String content) throws Exception {
        final String fromEmail = "pahanaedu@gmail.com"; // 🔐 use your Gmail
        final String password = "rcphemkznnqweisw";     // 🔐 paste app password here

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "587");              
        props.put("mail.smtp.auth", "true");             
        props.put("mail.smtp.starttls.enable", "true");  

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(fromEmail, "Pahana Edu"));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        msg.setSubject(subject);
        msg.setContent(content, "text/html");

        Transport.send(msg);
    }
}
