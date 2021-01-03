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
%>

<table width="100%">
    <%
        Vector<LiveChatBean> __vlist = null;
        __vlist = bMgr.getLive();
        int __listSize = __vlist.size();//브라우저 화면에 보여질 게시물갯수
        if (__vlist.isEmpty()) {
            out.print("채팅이 존재하지 않습니다.");
        }
        else {
            for (int i = 0; i<__listSize; i++) {
                LiveChatBean __bean = __vlist.get(i);
                String name = __bean.getName();
                String content = __bean.getContent();
                String regTime = __bean.getRegTime();
                regTime = regTime.replace(".0", ""); 
    %>
        <tr style = "border-bottom: none; ">       
            <td id = "livename" style = "padding: 0px 0px 0px 10px;" width = "10%"><%=name%></td>
            <td id = "livecontent" style = "padding: 0px 0px 0px 10px;"  width = "70%"><%=content%></td>
            <td id = "livetime" style = "padding: 0px 0px 0px 10px;"  width = "20%"><%=regTime%></td>
        </tr>
    <%} }%>
</table>