<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="duka.LiveChatBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="lMgr" class="duka.LoginMgr" />
<jsp:useBean id="bMgr" class="duka.BoardMgr" />
<%	
    request.setCharacterEncoding("utf-8");
	
    String charName = null;
    Object accountId = session.getAttribute("accountId");
    if(accountId != null) {
        charName = lMgr.getChar((int) accountId);
    }

    String content = request.getParameter("content");
	String name = request.getParameter("name");
	String ip = request.getRemoteAddr();
	String id = session.getId();
	id = id.substring(0, 3);
	if(name != null) {
		charName = name + id;
	}
    boolean bool = bMgr.setLive(charName, content, ip);

    if(!bool)
        out.print("<script>alert('채팅 등록에 실패했습니다.');</script>");

%>

        