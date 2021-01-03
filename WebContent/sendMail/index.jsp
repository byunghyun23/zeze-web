<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="duka.SMTPAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<jsp:useBean id="lMgr" class="duka.LoginMgr" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
 
String name = request.getParameter("name");
String from = "zeze-_-@naver.com";
String email = request.getParameter("email");
String subject = request.getParameter("subject");
String content = null;
// String content = request.getParameter("content");
// 입력값 받음


Properties p = new Properties(); // 정보를 담을 객체
 
p.put("mail.smtp.host","smtp.naver.com"); // naver SMTP
 
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");
// SMTP 서버에 접속하기 위한 정보들

content = request.getParameter("aut");
if(content == null) { // 아이디 비번 찾기
	try{
	    Authenticator auth = new SMTPAuthenticator();
	    Session ses = Session.getInstance(p, auth);
	    
	    ses.setDebug(true);
	     
	    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
	    msg.setSubject(subject); // 제목
	     
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr); // 보내는 사람
	     
	    Address toAddr = new InternetAddress(email);
	    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
	    
	    if(name == null) {
	        content = "ID : ";
	        String id = lMgr.getIdName(email);
	        if(id == null) {
	            out.println("<script>alert('정보가 올바르지 않습니다.');history.back();</script>");
	        }
	        else {
	            content += id;
	            msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
	            Transport.send(msg); // 전송
	            out.println("<script>alert('메일을 성공적으로 보냈습니다.');location.href='/';</script>");
	        }
	            
	    }
	    else {
	        content = "PW : ";
	        String pwd = lMgr.getPwd(name, email);
	        if(pwd == null) {
	            out.println("<script>alert('정보가 올바르지 않습니다.');history.back();</script>");
	        }
	        else {
	            content += pwd;
	            msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
	            Transport.send(msg); // 전송
	            out.println("<script>alert('메일을 성공적으로 보냈습니다.');location.href='/';</script>");
	        }
	    }

	} catch(Exception e){
	    e.printStackTrace();
	    out.println("<script>alert('메일 전송에 실패했습니다.');history.back();</script>");
	    // 오류 발생시 뒤로 돌아가도록
	    return;
	}
}
else { // 회원가입 인증
	try {
	    Authenticator auth = new SMTPAuthenticator();
	    Session ses = Session.getInstance(p, auth);
	    
	    ses.setDebug(true);
	     
	    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
	    msg.setSubject("인증 코드"); // 제목
	     
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr); // 보내는 사람
	     
	    Address toAddr = new InternetAddress(email);
	    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
	    
        msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
        Transport.send(msg); // 전송
        //out.println("<script>alert('메일을 성공적으로 보냈습니다.');location.href='/';</script>");
        
	} catch(Exception e){
	    e.printStackTrace();
	    //out.println("<script>alert('메일 전송에 실패했습니다.');history.back();</script>");
	    // 오류 발생시 뒤로 돌아가도록
	    return;
	}
}

 
%>
