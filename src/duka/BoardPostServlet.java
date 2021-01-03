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

import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.request.SendMessage;

@WebServlet("/s_boardPost")
public class BoardPostServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
            PrintWriter out = response.getWriter();
			MultipartRequest multi = null; //
			String  SAVEFOLDER = "C:/Jsp/myapp/WebContent/ch15/fileupload"; //
			String ENCTYPE = "utf-8"; //
			int MAXSIZE = 5*1024*1024; //
			String boardName = null;
			String name = null;

			try {
				multi = new MultipartRequest(request, SAVEFOLDER,MAXSIZE, ENCTYPE,
				new DefaultFileRenamePolicy());
				boardName = multi.getParameter("boardName");
				name = multi.getParameter("name");
				System.out.println("boardName = " + boardName);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			BoardMgr bMgr = new BoardMgr();
			boolean bool = bMgr.insertBoard(multi);
			if(bool) {
				if(boardName.equals("inquireBoard")) {
			    	TelegramBot bot = new TelegramBot("863536501:AAFGCjFvFUpkpjhBwmPCGqoubrqDtbIAGAs");
			    	bot.execute(new SendMessage(469118517, "[ZEZE WEB] \"" + name + "\"님이 문의 게시판 작성. 확인해라 병현아."));
				}
				else if(boardName.equals("gamezoneBoard") || boardName.equals("youtubeBoard") || boardName.equals("blogBoard")) {
			    	TelegramBot bot = new TelegramBot("863536501:AAFGCjFvFUpkpjhBwmPCGqoubrqDtbIAGAs");
			    	bot.execute(new SendMessage(469118517, "[ZEZE WEB] \"" + name + "\"님이 홍보 게시판 작성. 확인해라 병현아."));
				}
		    	response.sendRedirect("/boardList?boardName=" + boardName);
			}	
	}
}