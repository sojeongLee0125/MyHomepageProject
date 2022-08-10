package mail;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSend {

	public void ContactMailSend(mailBean mb) {

		Properties prop = System.getProperties();
		
        	// 로그인시 TLS를 사용할 것인지 설정
		prop.put("mail.smtp.starttls.enable", "true");
        
		// 이메일 발송을 처리해줄 SMTP서버
		prop.put("mail.smtp.host", "smtp.gmail.com");
        
		// SMTP 서버의 인증을 사용한다는 의미
		prop.put("mail.smtp.auth", "true");
        
		// TLS의 포트번호는 587이며 SSL의 포트번호는 465이다.
		prop.put("mail.smtp.port", "587");

		Authenticator auth = new MailAuth();

		Session session = Session.getDefaultInstance(prop, auth);

		MimeMessage msg = new MimeMessage(session);

		try {
			// 보내는 날짜 지정
			msg.setSentDate(new Date());

			// 발송자를 지정한다. 발송자의 메일, 발송자명
			msg.setFrom(new InternetAddress("--@gmail.com", "문의사항알림이"));
			
            		// 수신자의 메일을 생성한다.
			InternetAddress to = new InternetAddress("--@naver.com");
			
        		// Message 클래스의 setRecipient() 메소드를 사용하여 수신자를 설정한다. setRecipient() 메소드로 수신자, 참조,
			// 숨은 참조 설정이 가능하다.
			// Message.RecipientType.TO : 받는 사람
			// Message.RecipientType.CC : 참조
			// Message.RecipientType.BCC : 숨은 참조
			msg.setRecipient(Message.RecipientType.TO, to);
			
            		// 메일의 제목 지정
			msg.setSubject("문의사항이 도착했습니다.", "UTF-8");
			
			// 메일의 내용 지정
			msg.setText("문의자 이름 : "+mb.getName()+
					    "\n\n 답변 받을 메일 : "+mb.getEmail()+
					    "\n\n문의 메세지 : "+mb.getmessage()+
					    "\n\n문의자 전화번호: "+mb.getPhone(),"UTF-8");
			
			// Transport는 메일을 최종적으로 보내는 클래스	
			Transport.send(msg);

		} catch (AddressException ae) {
			System.out.println("AddressException : " + ae.getMessage());
		} catch (MessagingException me) {
			System.out.println("MessagingException : " + me.getMessage());
		} catch (UnsupportedEncodingException e) {
			System.out.println("UnsupportedEncodingException : " + e.getMessage());
		}
	}
}
