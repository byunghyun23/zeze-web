package duka;
 
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
 
public class SMTPAuthenticator extends Authenticator{
 
    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("zeze-_-","ghkdlxm1");
    }
}