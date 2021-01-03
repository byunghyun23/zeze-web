package duka;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/s_login")
public class LoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			String id = null;
            String pwd = null;
			HttpSession session = request.getSession();
			id = request.getParameter("id");
            pwd = request.getParameter("pwd");

			LoginMgr lMgr = new LoginMgr();
			int accountId = lMgr.login(id, pwd);
			if(accountId == -1) { 
				session.setAttribute("accountId", null);
				out.println("<script>alert('아이디 또는 패스워드가 일치하지 않습니다.'); history.back();</script>");
				out.flush();
			}
			else { 
				session.setAttribute("accountId", accountId);
				response.sendRedirect(request.getHeader("referer"));
			}
				
//			response.sendRedirect("../boardList.jsp?boardName=" + bMgr.getBoardName());
	}
}

