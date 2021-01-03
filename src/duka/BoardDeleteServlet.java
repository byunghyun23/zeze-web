package duka;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/s_boardDelete")
public class BoardDeleteServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
            int id = Integer.parseInt(request.getParameter("id"));
	        String confirm = request.getParameter("confirm");
            String boardName = request.getParameter("boardName");

			BoardMgr bMgr = new BoardMgr();
            bMgr.setBoardName(boardName);
            if(confirm.equals("1"))
			    bMgr.deleteBoard(id);
			response.sendRedirect("/boardList?boardName=" + boardName);
	}
}