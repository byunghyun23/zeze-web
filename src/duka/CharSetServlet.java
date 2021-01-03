package duka;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/s_charSet")
public class CharSetServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();

            boolean bool = false;
            Object accountId = null;
            int charId;
            String charName = null;
            HttpSession session = request.getSession();

            accountId = session.getAttribute("accountId"); 
            if(accountId != null) {
                charId = Integer.parseInt(request.getParameter("charid"));
                charName = request.getParameter("charname");
                LoginMgr lMgr = new LoginMgr();
			    bool = lMgr.setChar((int) accountId, charId);
            }

            if(bool) {
                out.println("<script>alert('대표 캐릭터가 \"" + charName + "\"으로 설정되었습니다.'); location.href='/';</script>");
            }
            else {
                out.println("<script>alert('대표 캐릭터 설정에 실패했습니다.'); location.href='/setChar';</script>");
            }

	}
}