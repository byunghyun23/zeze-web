package duka;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/s_changePwd")
public class ChangePwdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            boolean bool = false;
            String newpwd = null;
            String newpwd2 = null;
            String prepwd = null;
            Object accountId = null;
            HttpSession session = request.getSession();
            LoginMgr lMgr = new LoginMgr();

            newpwd = request.getParameter("newpwd");
            newpwd2 = request.getParameter("newpwd2");
            prepwd = request.getParameter("prepwd");
            
            if(!newpwd.equals(newpwd2)) {
                out.println("<script>alert('변경할 비밀번호를 다시 확인해주세요.'); location.href='/myPage';</script>");
                return;
            }
                
            accountId = session.getAttribute("accountId");
            if(accountId != null)
                bool = lMgr.changePwd((int) accountId, prepwd, newpwd);

            if(bool) {
                session.setAttribute("accountId", null);
                out.println("<script>alert('비밀번호가 변경되었습니다. 다시 로그인 해주세요.'); location.href='/';</script>");
            }
            else {
                out.println("<script>alert('현재 비밀번호가 올바르지 않습니다.'); location.href='/myPage';</script>");
            }
        }
}