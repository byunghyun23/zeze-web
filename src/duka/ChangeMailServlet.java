package duka;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/s_changeMail")
public class ChangeMailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            int result = 3;
            String email = null;
            Object accountId = null;
            String prepwd = null;
            HttpSession session = request.getSession();
            LoginMgr lMgr = new LoginMgr();

            email = request.getParameter("email");
            prepwd = request.getParameter("prepwd");
            accountId = session.getAttribute("accountId");

            if(accountId != null)
                result = lMgr.changeEmail((int) accountId, prepwd, email);

            if(result == 1)
                out.println("<script>alert('현재 비밀번호가 올바르지 않습니다.'); location.href='/myPage';</script>");
            else if(result == 2)
                out.println("<script>alert('중복된 이메일입니다.'); location.href='/myPage';</script>");
            else if(result == 3)
                out.println("<script>alert('이메일이 변경이 실패했습니다.'); location.href='/myPage';</script>");
            else
                out.println("<script>alert('이메일이 변경되었습니다.'); location.href='/myPage';</script>");
        }
}