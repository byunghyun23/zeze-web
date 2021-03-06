package duka;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/s_guidePost")
public class GuidePostServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
            String content = null;
			MultipartRequest multi = null; //
			String  SAVEFOLDER = "C:/Jsp/myapp/WebContent/ch15/fileupload"; //
			String ENCTYPE = "utf-8"; //
			int MAXSIZE = 5*1024*1024; //
			
			try {
				multi = new MultipartRequest(request, SAVEFOLDER,MAXSIZE, ENCTYPE,
				new DefaultFileRenamePolicy());
				content = multi.getParameter("content");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			BoardMgr bMgr = new BoardMgr();
			bMgr.setGuide(content);
			response.sendRedirect("/guide");
	}
}
