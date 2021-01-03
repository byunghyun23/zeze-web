package duka;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/s_boardUpdate")
public class BoardUpdateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		MultipartRequest multi = null; //
		String  SAVEFOLDER = "C:/Jsp/myapp/WebContent/ch15/fileupload"; //
		String ENCTYPE = "utf-8"; //
		int MAXSIZE = 5*1024*1024; //
		String id = null;
		String nowPage = null;
		String boardName = null;
		try {
			multi = new MultipartRequest(request, SAVEFOLDER,MAXSIZE, ENCTYPE,
			new DefaultFileRenamePolicy());
			nowPage = multi.getParameter("nowPage"); //
			id = multi.getParameter("id");
			boardName = multi.getParameter("boardName");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		BoardMgr bMgr = new BoardMgr();

		bMgr.updateBoard(multi);
		response.sendRedirect("/boardRead?boardName=" + boardName + "&id=" + id + "&nowPage=" + nowPage + "&keyField=&keyWord=");
	}
}