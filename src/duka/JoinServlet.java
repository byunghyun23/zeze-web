package duka;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.request.SendMessage;

@WebServlet("/s_join")
public class JoinServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        String name = null;
        String pwd = null;
        String pwd2 = null;
        String email = null;
        String code = null;
        String doco = null;
        String aut = null;
        
        name = request.getParameter("name");
        pwd = request.getParameter("pwd");
        pwd2 = request.getParameter("pwd2");
        email = request.getParameter("email");
        code = request.getParameter("code");
        doco = request.getParameter("doco");
        aut = request.getParameter("aut");
        
        HttpSession session = request.getSession();
        String autcode = session.getId();
        session.invalidate();
        
        if(!pwd.equals(pwd2)) {
            out.println("<script>alert('비밀번호를 다시 확인해주세요.'); location.href='/signUp';</script>");
            return;
        }
        
		LoginMgr lMgr = new LoginMgr();
		int isCreate = lMgr.createAccount(name, pwd, email, code, request.getRemoteAddr(), doco);
		
//        int isCreate = lMgr.createAccount(name, pwd, email, code, request.getRemoteAddr());
        
        
        if(!autcode.equals(aut)) {
        	out.println("<script>alert('인증 코드가 올바르지 않습니다.'); location.href='/signUp';</script>");
        	return;
        }
        
        if(isCreate == -1) 
            out.println("<script>alert('계정이 올바르지 않습니다.'); location.href='/signUp';</script>");
        else if(isCreate == -2) 
            out.println("<script>alert('중복된 계정입니다.'); location.href='/signUp';</script>");
        else if(isCreate == -3)
            out.println("<script>alert('중복된 이메일입니다.'); location.href='/signUp';</script>");
        else if(isCreate == -4)
            out.println("<script>alert('계정 등록에 실패했습니다. 오픈톡에서 운영자에게 문의 해주세요.'); location.href='/signUp';</script>");
        else if(isCreate == -5)
        	out.println("<script>alert('아이피당 하나의 계정만 생성가능 합니다.'); location.href='/signUp';</script>");
        else {
		    	TelegramBot bot = new TelegramBot("863536501:AAFGCjFvFUpkpjhBwmPCGqoubrqDtbIAGAs");
		    	bot.execute(new SendMessage(469118517, "[ZEZE WEB] \"" + name + "\" 회원가입 완료\r\n" + aut));
		    	out.println("<script>alert('성공적으로 생성되었습니다.'); location.href='/';</script>");
		    	// \r\n오픈톡 참여 후 운영자에게\r\n인증 코드를 알려주세요.
        }
            
        out.flush();
//			response.sendRedirect("../boardList.jsp?boardName=" + bMgr.getBoardName());
	}
}
