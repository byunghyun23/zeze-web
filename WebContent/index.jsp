<!-- main -->

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="duka.BoardBean"%>
<%@page import="duka.CharBean"%>
<%@page import="duka.LiveChatBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="duka.BoardMgr" />
<jsp:useBean id="lMgr" class="duka.LoginMgr" />
<%	
    request.setCharacterEncoding("utf-8");

    // Object con_num = null;
    // con_num = application.getAttribute("con_num");
    
    String charName = null;
    Object accountId = session.getAttribute("accountId");
    if(accountId != null) {
        charName = lMgr.getChar((int) accountId);
    }

    int totalRecord=0; //전체레코드수
    int numPerPage=10; // 페이지당 레코드 수 
    int pagePerBlock=15; //블럭당 페이지수 
    
    int totalPage=0; //전체 페이지 수
    int totalBlock=0;  //전체 블럭수 

    int nowPage=1; // 현재페이지
    int nowBlock=1;  //현재블럭
    
    int start=0; //디비의 select 시작번호
    int end=10; //시작번호로 부터 가져올 select 갯수F
    
    int listSize=0; //현재 읽어온 게시물의 수

	String keyWord = "", keyField = "";
	Vector<BoardBean> vlist = null;
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if (request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	 start = (nowPage * numPerPage)-numPerPage;
	 end = numPerPage;
	 
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	  
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
%>

<html>
    <head>
        <title>제제 - ZEZE</title>
        <link rel="shortcut icon" type = "image/x-icon" href = "zeze.ico">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link type = "text/css" rel = "stylesheet" href = "main.css"></link>
        <!-- <script src="//code.jquery.com/jquery-3.4.1.min.js"></script> -->
        <script src="script/jquery-3.4.1.min.js?v=<%=System.currentTimeMillis()%>"></script>
        <script src="script/js.js?v=<%=System.currentTimeMillis()%>"></script>
        <script type="text/javascript">
        	
			// $(window).bind("beforeunload", function() {
			// 	$.get("/sessionDestroy");
      	    // });

    	
            var accountId = "<%= accountId%>";
            var charName = '<%=charName%>';
			
            $(document).ready(function() {
            	// $('a').on("click", function() {
    			// 	$(window).unbind("beforeunload");
            	// });
            	// $('form').on("submit", function() {
    			// 	$(window).unbind("beforeunload");
            	// });
            	
                if(accountId == "null") {
                    $(".login").css("display", "block");
                    $(".loginok").css("display", "none");
                }
                else {
                    $(".login").css("display", "none");
                    $(".loginok").css("display", "block");
                }

                setInterval(function() {
                    $('#liveResult').load('/liveChat');
                    $('#connectNum').load('/connectNum');
                }, 1000);

            });

            function onSubmit() {
            	if(document.liveChatFrm.ip.value == "") {
            		alert('채팅이 차단된 아이피입니다.');
            	}
            	else {
                    accountId = "<%= accountId %>";
                    if(accountId == "null" || charName == "null") {
                        $.get("/chatPost", 
                        {
                        	name : "익명",
                            content : document.liveChatFrm.content.value
                        });
                    }
                    else {
                        $.get("/chatPost", 
                        {
                            content : document.liveChatFrm.content.value
                        });
                    }
            	}
                document.liveChatFrm.reset();
            }

            function read(id){
                document.readFrm.id.value=id;
                document.readFrm.action="/boardRead";
                document.readFrm.submit();
            }

        </script>
        <style>
            table {
                border-collapse: collapse;
            }
            .tr {
                border-bottom: 1px solid rgb(219, 217, 245);
            }
            td {
                padding: 10px;
                font-size: 1.2rem;
            }
        </style>
    </head>
    <body>
        <div id = "main">
            <div id = "header">
                <!-- <a href = "duka.jsp" style = "color:white;">DUKA</a> -->
                <!-- <p>방문자님, 환영합니다!<p> -->
            </div>
            <div id = "nav">
                <!-- <a href = "duka2.html"><img src = "image/logo.png" alt = "error">< </a> -->
                <div class = "nav_list">
                    <ul class = nav_ul>
                        <li class = "nav_list1" onmouseover = "onMouseIn(1)" onmouseout = "onMouseOut(1)">
                            <a class = "nav_link1" href = "/">홈</a></li>
                        <li class = "nav_list1" onmouseover = "onMouseIn(2)" onmouseout = "onMouseOut(2)">
                            <a class = "nav_link2" href = "javascript:"> 월드소식 </a>
                            <ul class = "news" class = nav_ul style = "display: none;">
                                <li>
                                    <form action = "/boardList" method = "get" class = "nav_link2_1">
                                        <input type="hidden" name = "boardName" value = "newsBoard">
                                        <a href = "javascript:" onclick = "$('.nav_link2_1').submit();">공지사항</a> 
                                    </form>
                                </li>
                                <li>
                                    <form action = "/boardList" method = "get" class = "nav_link2_2">
                                        <input type="hidden" name = "boardName" value = "updateBoard">
                                        <a href = "javascript:" onclick = "$('.nav_link2_2').submit();">업데이트</a> 
                                    </form>
                                </li>
                                <li>
                                    <form action = "/boardList" method = "get" class = "nav_link2_3">
                                        <input type="hidden" name = "boardName" value = "eventBoard">
                                        <a href = "javascript:" onclick = "$('.nav_link2_3').submit();">이벤트</a> 
                                    </form>
                                </li>
                            </ul>
                        </li>
                        <li class = "nav_list1" onmouseover = "onMouseIn(3)" onmouseout = "onMouseOut(3)">
                            <a class = "nav_link3" href = "javascript:"> 커뮤니티 </a>
                            <ul class = "commu" class = nav_ul style = "display: none;">
                                <li>
                                    <form action = "/boardList" method = "get" class = "nav_link3_1">
                                        <input type="hidden" name = "boardName" value = "freeBoard">
                                        <a href = "javascript:" onclick = "$('.nav_link3_1').submit();">자유게시판</a> 
                                    </form>              
                                </li>
                                <li>
                                    <form action = "/boardList" method = "get" class = "nav_link3_2">
                                        <input type="hidden" name = "boardName" value = "questionBoard">
                                        <a href = "javascript:" onclick = "$('.nav_link3_2').submit();">지식게시판</a> 
                                    </form>       
                                </li>
                                <li>
                                    <!-- <form action = "boardList.jsp" method = "POST" class = "nav_link3_3">
                                        <input type="hidden" name = "boardName" value = "questionboard">
                                        <a href = "#" onclick = "$('.nav_link3_3').submit();">스크린샷</a> 
                                    </form>       -->
                                    <!-- <a class = "nav_link3_3" href = "screenshot.jsp">스크린샷</a>  -->
                                </li>
                            </ul>
                        </li>
                        <li class = "nav_list1" onmouseover = "onMouseIn(4)" onmouseout = "onMouseOut(4)"><a href = "/rank"> 랭킹 </a></li>
                        <li class = "nav_list1" onmouseover = "onMouseIn(5)" onmouseout = "onMouseOut(5)">
                            <form action = "/boardList" method = "get" class = "nav_link5">
                                <input type="hidden" name = "boardName" value = "inquireBoard">
                                <a href = "javascript:" onclick = "$('.nav_link5').submit();">문의</a> 
                            </form>  
                        </li>
                        <li class = "nav_list1" onmouseover = "onMouseIn(6)" onmouseout = "onMouseOut(6)">
                            <a class = "nav_link6" href = "javascript:"> 홍보실 </a>
                            <ul class = "promotion" class = nav_ul style = "display: none;">
                                <li>
                                    <form action = "/boardList" method = "get" class = "nav_link6_1">
                                        <input type="hidden" name = "boardName" value = "gamezoneBoard">
                                        <a href = "javascript:" onclick = "$('.nav_link6_1').submit();">게임존</a> 
                                    </form>              
                                </li>
                                <li>
                                    <form action = "/boardList" method = "get" class = "nav_link6_2">
                                        <input type="hidden" name = "boardName" value = "youtubeBoard">
                                        <a href = "javascript:" onclick = "$('.nav_link6_2').submit();">유튜브</a> 
                                    </form>              
                                </li>
                                <li>
                                    <form action = "/boardList" method = "get" class = "nav_link6_3">
                                        <input type="hidden" name = "boardName" value = "blogBoard">
                                        <a href = "javascript:" onclick = "$('.nav_link6_3').submit();">블로그</a> 
                                    </form>              
                                </li>
                            </ul>
                        </li>
                        <li class = "nav_list1" onmouseover = "onMouseIn(7)" onmouseout = "onMouseOut(7)"><a href = "https://drive.google.com/open?id=1mSpjIHWZKak-DmhJrTHG_VV8iGxI-8rK"> 다운로드 </a></li>
                    </ul>  
                </div>
            </div>
            <div id = "aside">
                <div class = "login">
                    <form action = "s_login" method="POST">
                        <div class = "login_area">
                            <input id = "id" name = "id" type = "text" placeholder = "아이디" minlength = "4" maxlength = "20" autocomplete=off>
                            <input id = "pw" name = "pwd" type = "password" placeholder = "비밀번호" minlength = "5" maxlength = "12">
                        </div>
                        <div class = "btn_log">
                            <input id = "btnLogin" type = "submit" value = "로그인">
                        </div>
                    </form>
                    <ul class = "menu">
                        <li><a href = "/signUp"> 회원가입 </a></li>
                        <div class = "border"> | </div>
                        <li><a href = "/find"> 아이디 / 비밀번호 찾기 </a></li>
                    </ul>
                </div>
                <div class = "loginok" style = "display: none;">
                    <div style = "float: left;" ><img src = "/image/no_char.png" alt = "error" style = "padding: 50px 0px 50px 30px;"></div>
                    <div style = "float: right; padding: 50px 30px 50px 0px;">
                        <%
                            if(charName == null) {
                        %>
                            대표 캐릭터를 <br> 선택해주세요. <br><br>
                        <%
                            }
                            else {
                        %>
                            안녕하세요. <br> <%=charName%>님, 환영합니다! <br><br>
                        <%
                            }
                        %>
                        <a href = "/myPage"> 마이페이지 </a>
                        <div class = "border" >&nbsp|&nbsp</div>
                        <form name = "logout" action = "/s_logout" method="POST" style = "display: inline;">
                            <a href = "javascript:" onclick = document.logout.submit();> 로그아웃 </a>
                        </form>
                    </div>
                </div>
                <div class = "guide"><a href = "/guide"><img src = "/image/ㅋㅋ.png" alter = "error" style = "border-radius: 10px;"></a></div>
                <div class = "download">
                    <a href = "https://open.kakao.com/o/gQW5uWCb"><img src = "/image/openkakao.JPG" alt = "error" width = 100%></a>
                </div>
                <div class = "downrank">
                    <div class = "left">랭킹</div>
                    <div class = "right"><a href = "/rank" style = "float: right">더보기</a></div>
                    <table align="center" width="100%" cellpadding="3">
                        <tr>
                            <td align="center" colspan="2">
                                <%
                                    Vector<CharBean> _vlist = lMgr.getRank(keyField, keyWord);
                                    int _listSize = _vlist.size();//브라우저 화면에 보여질 랭킹개수
                                    if (_vlist.isEmpty()) {
                                    // out.println("검색 결과가 없습니다.<br>");
                                    } else {
                                %>
                                <table width="100%" cellpadding="2" cellspacing="0">
                                    <tr bgcolor="#D0D0D0">
                                        <td width = "20%" align = "center">순위</td>
                                        <td width = "45%">이름</td>
                                        <td width = "20%">레벨</td>
                                    </tr>
    
                                <%
                                    int limit = 10;
                                    for (int i = 0;i<limit; i++) {
                                        if(i == _listSize) break;
                                        CharBean bean = _vlist.get(i);
                                        int rank = bean.getRank();
                                        String name = bean.getName();
                                        int level = bean.getLevel();
                                %>
                                    <tr class = "tr">
                                        <!-- <td align = "center"><%=rank%></td> -->
                                        <td align = "center"><%=i+1%></td>
                                        <td><%=name%></td>
                                        <td><%=level%></td>
                                    </tr>
                                    <%} }%>
                                </table> 
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id = "content">
                <div id = "banner">
                    <ul>
                        <li class = "banner_first" style = "display: block">
                            <a href = "javascript:alert('준비중입니다.');"><img src = "/image/배너각3.png" alt = "error"></a>
                        </li>
                        <li class = "banner_second" style = "display: none">
                            <a href = "/boardList/?boardName=eventBoard"><img src = "/image/배너각2.png" alt = "error"></a>
                        </li>
                        <li class = "banner_third" style = "display: none">
                            <a href = "boardRead/?boardName=newsBoard&id=4&nowPage=1&keyField=&keyWord="><img src = "/image/배너각.jpg" alt = "error"></a>
                        </li>
                    </ul>
                    <div class = "btn_box" style = "text-align: center;">
                        <div class = "index" >1</div>/3
                    </div>
                </div>
                <div class = "livechat">
                    <div class = "left">실시간 채팅 (도배 적발 시 아이피 채팅 차단)</div>
                    <div id = "connectNum" class = "right"></div>
                    <div id = "liveResult" style = "height: 72%; clear: both;">
                    
                    </div>
                    <hr style = "border:1px solid rgb(218, 235, 245);">
                    <form id = "liveChatFrm" name = "liveChatFrm" action = "javascript:onSubmit();">
                        <input id = "liveInput" name = "content" type = "text" placeholder = "내용" autofocus autocomplete=off
                        style = "width: 97%; height: 8%; border: none; padding: 1%; margin: 1%;">
                        <input type = "hidden" name = "ip" value = "<%=request.getRemoteAddr()%>">
                    </form>

                </div>
                <div id = "bulletin">
                    <div id = "bull_main">
                        <div class = "newsArt">
                            <div class = "left">월드소식</div>
                            <div class = "right"> 
                                <a class = "news_top_first" href = "javascript:" style = "color: red;" onclick = "changeWorldNews(1)">공지사항</a><div class = "border"> | </div>
                                <a class = "news_top_second" href = "javascript:" onclick = "changeWorldNews(2)">업데이트</a><div class = "border"> | </div>
                                <a class = "news_top_third" href = "javascript:" onclick = "changeWorldNews(3)">이벤트</a>
                            </div>
                            <div id = "newsFirst" class = "boardForm">
                                <%
                                    bMgr.setBoardName("newsBoard");
                                    vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                                    listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
                                    if (vlist.isEmpty()) {
                                %>  <ul style = "list-style-type: none;">
                                        <li>게시물이 존재하지 않습니다.</li>
                                    </ul>
                                <%
                                    } else {
                                %>
                            
                                <ul>
                                    <%
                                        for (int i = 0;i<numPerPage; i++) {
                                            if (i == listSize) break;
                                            BoardBean bean = vlist.get(i);
                                            int id = bean.getId();
                                            String name = bean.getName();
                                            String subject = bean.getSubject();
                                            String regdate = bean.getRegdate();
                                            int depth = bean.getDepth();
                                            int count = bean.getCount();
                                    %>
                                    <li>
                                        <form style = "display: inline;" action = "/boardRead" method = "get" class = "linkBoard">
                                            <a href = "javascript:" onclick = "$('#newsFirst .id').attr('value', '<%=id%>'); $('#newsFirst .linkBoard').submit();"><%=subject%></a>
                                            <input type="hidden" name = "boardName" value = "newsBoard">
                                            <input class = "id" type="hidden" name="id"> 
                                            <input type="hidden" name="nowPage" value = "<%=nowPage%>"> 
                                            <input type="hidden" name="keyField" value = "<%=keyField%>"> 
                                            <input type="hidden" name="keyWord" value = "<%=keyWord%>">
                                        </form>
                                    </li>
                                    <%} }%>
                                </ul>
                                <form action = "/boardList" method = "get" class = "plus">
                                    <input type="hidden" name = "boardName" value = "newsBoard">
                                    <a href = "javascript:" onclick = "$('#newsFirst .plus').submit();">더보기</a> 
                                </form>
                            </div>
                            <div id = "newsSecond" class = "boardForm" style = "display: none">
                                <%
                                    bMgr.setBoardName("updateBoard");
                                    vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                                    listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
                                    if (vlist.isEmpty()) {
                                %>  <ul style = "list-style-type: none;">
                                        <li>게시물이 존재하지 않습니다.</li>
                                    </ul>
                                <%
                                    } else {
                                %>
                            
                                <ul>
                                    <%
                                        for (int i = 0;i<numPerPage; i++) {
                                            if (i == listSize) break;
                                            BoardBean bean = vlist.get(i);
                                            int id = bean.getId();
                                            String name = bean.getName();
                                            String subject = bean.getSubject();
                                            String regdate = bean.getRegdate();
                                            int depth = bean.getDepth();
                                            int count = bean.getCount();
                                    %>
                                    <li>
                                        <form style = "display: inline;" action = "/boardRead" method = "get" class = "linkBoard">
                                            <a href = "javascript:" onclick = "$('#newsSecond .id').attr('value', '<%=id%>'); $('#newsSecond .linkBoard').submit();"><%=subject%></a>
                                            <input type="hidden" name = "boardName" value = "updateBoard">
                                            <input class = "id" type="hidden" name="id"> 
                                            <input type="hidden" name="nowPage" value = "<%=nowPage%>"> 
                                            <input type="hidden" name="keyField" value = "<%=keyField%>"> 
                                            <input type="hidden" name="keyWord" value = "<%=keyWord%>">
                                        </form>
                                    </li>
                                    <%} }%>
                                </ul>   
                                <form action = "/boardList" method = "get" class = "plus">
                                    <input type="hidden" name = "boardName" value = "updateBoard">
                                    <a href = "javascript:" onclick = "$('#newsSecond .plus').submit();">더보기</a> 
                                </form> 
                            </div>
                            <div id = "newsThird" class = "boardForm" style = "display: none">
                                <%
                                    bMgr.setBoardName("eventBoard");
                                    vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                                    listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
                                    if (vlist.isEmpty()) {
                                %>  <ul style = "list-style-type: none;">
                                        <li>게시물이 존재하지 않습니다.</li>
                                    </ul>
                                <%
                                    } else {
                                %>
                            
                                <ul>
                                    <%
                                        for (int i = 0;i<numPerPage; i++) {
                                            if (i == listSize) break;
                                            BoardBean bean = vlist.get(i);
                                            int id = bean.getId();
                                            String name = bean.getName();
                                            String subject = bean.getSubject();
                                            String regdate = bean.getRegdate();
                                            int depth = bean.getDepth();
                                            int count = bean.getCount();
                                    %>
                                    <li>
                                        <form style = "display: inline;" action = "/boardRead" method = "get" class = "linkBoard">
                                            <a href = "javascript:" onclick = "$('#newsThird .id').attr('value', '<%=id%>'); $('#newsThird .linkBoard').submit();"><%=subject%></a>
                                            <input type="hidden" name = "boardName" value = "eventBoard">
                                            <input class = "id" type="hidden" name="id"> 
                                            <input type="hidden" name="nowPage" value = "<%=nowPage%>"> 
                                            <input type="hidden" name="keyField" value = "<%=keyField%>"> 
                                            <input type="hidden" name="keyWord" value = "<%=keyWord%>">
                                        </form>
                                    </li>
                                    <%} }%>
                                </ul>
                                <form action = "/boardList" method = "get" class = "plus">
                                    <input type="hidden" name = "boardName" value = "eventBoard">
                                    <a href = "javascript:" onclick = "$('#newsThird .plus').submit();">더보기</a> 
                                </form> 
                            </div>
                        </div>
                        <div class = "freeBoardArt">
                            <div class = "left">자유게시판</div>                             
                            <div id = "free" class = "boardForm">
                                <%
                                    bMgr.setBoardName("freeBoard");
                                    vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                                    listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
                                    if (vlist.isEmpty()) {
                                %>  <ul style = "list-style-type: none;">
                                        <li>게시물이 존재하지 않습니다.</li>
                                    </ul>
                                <%
                                    } else {
                                %>
                            
                                <ul>
                                    <%
                                        for (int i = 0;i<numPerPage; i++) {
                                            if (i == listSize) break;
                                            BoardBean bean = vlist.get(i);
                                            int id = bean.getId();
                                            String name = bean.getName();
                                            String subject = bean.getSubject();
                                            String regdate = bean.getRegdate();
                                            int depth = bean.getDepth();
                                            int count = bean.getCount();
                                    %>
                                    <li>
                                        <form style = "display: inline;" action = "/boardRead" method = "get" class = "linkBoard">
                                            <a href = "javascript:" onclick = "$('#free .id').attr('value', '<%=id%>'); $('#free .linkBoard').submit();"><%=subject%></a>
                                            <input type="hidden" name = "boardName" value = "freeBoard">
                                            <input class = "id" type="hidden" name="id"> 
                                            <input type="hidden" name="nowPage" value = "<%=nowPage%>"> 
                                            <input type="hidden" name="keyField" value = "<%=keyField%>"> 
                                            <input type="hidden" name="keyWord" value = "<%=keyWord%>">
                                        </form>
                                    </li>
                                    <%} }%>
                                </ul>
                                <form action = "/boardList" method = "get" class = "plus">
                                    <input type="hidden" name = "boardName" value = "freeBoard">
                                    <a href = "javascript:" onclick = "$('#free .plus').submit();">더보기</a> 
                                </form> 
                            </div>
                        </div>
                        <div class = "promotionArt">
                            <div class = "left">홍보실</div>
                            <div class = "right">
                                <a class = "prom_top_first" href = "javascript:" style = "color: red;" onclick = "changePromotion(1)">게임존</a><div class = "border"> | </div>
                                <a class = "prom_top_second" href = "javascript:" onclick = "changePromotion(2)">유튜브</a><div class = "border"> | </div>
                                <a class = "prom_top_third" href = "javascript:" onclick = "changePromotion(3)">블로그</a>
                            </div>                                
                            <div id = "promotionFirst" class = "boardForm">
                                <%
                                    bMgr.setBoardName("gamezoneBoard");
                                    vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                                    listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
                                    if (vlist.isEmpty()) {
                                %>  <ul style = "list-style-type: none;">
                                        <li>게시물이 존재하지 않습니다.</li>
                                    </ul>
                                <%
                                    } else {
                                %>
                            
                                <ul>
                                    <%
                                        for (int i = 0;i<numPerPage; i++) {
                                            if (i == listSize) break;
                                            BoardBean bean = vlist.get(i);
                                            int id = bean.getId();
                                            String name = bean.getName();
                                            String subject = bean.getSubject();
                                            String regdate = bean.getRegdate();
                                            int depth = bean.getDepth();
                                            int count = bean.getCount();
                                    %>
                                    <li>
                                        <form style = "display: inline;" action = "/boardRead" method = "get" class = "linkBoard">
                                            <a href = "javascript:" onclick = "$('#promotionFirst .id').attr('value', '<%=id%>'); $('#promotionFirst .linkBoard').submit();"><%=subject%></a>
                                            <input type="hidden" name = "boardName" value = "gamezoneBoard">
                                            <input class = "id" type="hidden" name="id"> 
                                            <input type="hidden" name="nowPage" value = "<%=nowPage%>"> 
                                            <input type="hidden" name="keyField" value = "<%=keyField%>"> 
                                            <input type="hidden" name="keyWord" value = "<%=keyWord%>">
                                        </form>
                                    </li>
                                    <%} }%>
                                </ul>
                                <form action = "/boardList" method = "get" class = "plus">
                                    <input type="hidden" name = "boardName" value = "gamezoneBoard">
                                    <a href = "javascript:" onclick = "$('#promotionFirst .plus').submit();">더보기</a> 
                                </form> 
                            </div>
                            <div id = "promotionSecond" class = "boardForm" style = "display: none">
                                <%
                                    bMgr.setBoardName("youtubeBoard");
                                    vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                                    listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
                                    if (vlist.isEmpty()) {
                                %>  <ul style = "list-style-type: none;">
                                        <li>게시물이 존재하지 않습니다.</li>
                                    </ul>
                                <%
                                    } else {
                                %>
                            
                                <ul>
                                    <%
                                        for (int i = 0;i<numPerPage; i++) {
                                            if (i == listSize) break;
                                            BoardBean bean = vlist.get(i);
                                            int id = bean.getId();
                                            String name = bean.getName();
                                            String subject = bean.getSubject();
                                            String regdate = bean.getRegdate();
                                            int depth = bean.getDepth();
                                            int count = bean.getCount();
                                    %>
                                    <li>
                                        <form style = "display: inline;" action = "/boardRead" method = "get" class = "linkBoard">
                                            <a href = "javascript:" onclick = "$('#promotionSecond .id').attr('value', '<%=id%>'); $('#promotionSecond .linkBoard').submit();"><%=subject%></a>
                                            <input type="hidden" name = "boardName" value = "youtubeBoard">
                                            <input class = "id" type="hidden" name="id"> 
                                            <input type="hidden" name="nowPage" value = "<%=nowPage%>"> 
                                            <input type="hidden" name="keyField" value = "<%=keyField%>"> 
                                            <input type="hidden" name="keyWord" value = "<%=keyWord%>">
                                        </form>
                                    </li>
                                    <%} }%>
                                </ul>   
                                <form action = "/boardList" method = "get" class = "plus">
                                    <input type="hidden" name = "boardName" value = "youtubeBoard">
                                    <a href = "javascript:" onclick = "$('#promotionSecond .plus').submit();">더보기</a> 
                                </form> 
                            </div>
                            <div id = "promotionThird" class = "boardForm" style = "display: none">
                                <%
                                    bMgr.setBoardName("blogBoard");
                                    vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                                    listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
                                    if (vlist.isEmpty()) {
                                %>  <ul style = "list-style-type: none;">
                                        <li>게시물이 존재하지 않습니다.</li>
                                    </ul>
                                <%
                                    } else {
                                %>
                            
                                <ul>
                                    <%
                                        for (int i = 0;i<numPerPage; i++) {
                                            if (i == listSize) break;
                                            BoardBean bean = vlist.get(i);
                                            int id = bean.getId();
                                            String name = bean.getName();
                                            String subject = bean.getSubject();
                                            String regdate = bean.getRegdate();
                                            int depth = bean.getDepth();
                                            int count = bean.getCount();
                                    %>
                                    <li>
                                        <form style = "display: inline;" action = "/boardRead" method = "get" class = "linkBoard">
                                            <a href = "javascript:" onclick = "$('#promotionThird .id').attr('value', '<%=id%>'); $('#promotionThird .linkBoard').submit();"><%=subject%></a>
                                            <input type="hidden" name = "boardName" value = "blogBoard">
                                            <input class = "id" type="hidden" name="id"> 
                                            <input type="hidden" name="nowPage" value = "<%=nowPage%>"> 
                                            <input type="hidden" name="keyField" value = "<%=keyField%>"> 
                                            <input type="hidden" name="keyWord" value = "<%=keyWord%>">
                                        </form>
                                    </li>
                                    <%} }%>
                                </ul>
                                <form action = "/boardList" method = "get" class = "plus">
                                    <input type="hidden" name = "boardName" value = "blogBoard">
                                    <a href = "javascript:" onclick = "$('#promotionThird .plus').submit();">더보기</a> 
                                </form> 
                            </div>
                        </div>
                        <div class = "questionBoardArt">
                            <div class = "left">지식게시판</div>                            
                            <div id = "question" class = "boardForm">
                                <%
                                    bMgr.setBoardName("questionBoard");
                                    vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                                    listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
                                    if (vlist.isEmpty()) {
                                %>  <ul style = "list-style-type: none;">
                                        <li>게시물이 존재하지 않습니다.</li>
                                    </ul>
                                <%
                                    } else {
                                %>
                            
                                <ul>
                                    <%
                                        for (int i = 0;i<numPerPage; i++) {
                                            if (i == listSize) break;
                                            BoardBean bean = vlist.get(i);
                                            int id = bean.getId();
                                            String name = bean.getName();
                                            String subject = bean.getSubject();
                                            String regdate = bean.getRegdate();
                                            int depth = bean.getDepth();
                                            int count = bean.getCount();
                                    %>
                                    <li>
                                        <form style = "display: inline;" action = "/boardRead" method = "get" class = "linkBoard">
                                            <a href = "javascript:" onclick = "$('#question .id').attr('value', '<%=id%>'); $('#question .linkBoard').submit();"><%=subject%></a>
                                            <input type="hidden" name = "boardName" value = "questionBoard">
                                            <input class = "id" type="hidden" name="id"> 
                                            <input type="hidden" name="nowPage" value = "<%=nowPage%>"> 
                                            <input type="hidden" name="keyField" value = "<%=keyField%>"> 
                                            <input type="hidden" name="keyWord" value = "<%=keyWord%>">
                                        </form>
                                    </li>
                                    <%} }%>
                                </ul>
                                <form action = "/boardList" method = "get" class = "plus">
                                    <input type="hidden" name = "boardName" value = "questionBoard">
                                    <a href = "javascript:" onclick = "$('#question .plus').submit();">더보기</a> 
                                </form> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id = "footer">
            
        </div>
    </body>
</html>