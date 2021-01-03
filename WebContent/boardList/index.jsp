<!-- boardList -->

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="duka.BoardBean"%>
<%@page import="duka.CommentBean"%>
<%@page import="duka.CharBean"%>
<%@page import="duka.LiveChatBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="duka.BoardMgr" />
<jsp:useBean id="lMgr" class="duka.LoginMgr" />
<jsp:useBean id="cMgr" class="duka.CommentMgr" />

<%	
	  request.setCharacterEncoding("utf-8");
      
      // 로그인 여부 
      String charName = null;
      Object accountId = session.getAttribute("accountId");
      if(accountId != null) {
          charName = lMgr.getChar((int) accountId);
      }

      // 게시판 선택
      String boardName = request.getParameter("boardName");
      bMgr.setBoardName(boardName);

      int totalRecord=0; //전체레코드수
	  int numPerPage=20; // 페이지당 레코드 수 
	  int pagePerBlock=15; //블럭당 페이지수 
	  
	  int totalPage=0; //전체 페이지 수
	  int totalBlock=0;  //전체 블럭수 

	  int nowPage=1; // 현재페이지
	  int nowBlock=1;  //현재블럭
	  
	  int start=0; //디비의 select 시작번호
	  int end=10; //시작번호로 부터 가져올 select 갯수
	  
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
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" type = "image/x-icon" href = "zeze.ico">
        <link type = "text/css" rel = "stylesheet" href = "/main.css"></link>
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
        <!-- <script src="//code.jquery.com/jquery-3.4.1.min.js"></script> -->
        <script src="/script/jquery-3.4.1.min.js?v=<%=System.currentTimeMillis()%>"></script>
        <script src="/script/js.js?v=<%=System.currentTimeMillis()%>"></script>
        <script type="text/javascript">
            // My Code
            var post = '<%=boardName%>';
            var accountId = '<%=accountId%>'; 
            var charName = '<%=charName%>';
            
            $(document).ready(function() {
                if(accountId == "null") {
                    $(".login").css("display", "block");
                    $(".loginok").css("display", "none");
                    if(post == 'newsBoard' || post == 'updateBoard' || post == 'eventBoard') {
                        $('.post').css('display', 'none');
                        $('.commentCount').css('display', 'none');
                    }    
                }
                else {
                    $(".login").css("display", "none");
                    $(".loginok").css("display", "block");
                    if(accountId == '0') {
                        $('.post').css('display', 'inline');
                    }
                    else {
                        if(post == 'newsBoard' || post == 'updateBoard' || post == 'eventBoard') {
                            $('.post').css('display', 'none');
                            $('.commentCount').css('display', 'none');
                        }                     
                    }
                }
            });
			
            function postCheck() {
                if(accountId == "0") {
                    $('.post').submit();
                    return;
                }
                
                if(accountId == "null")
                    alert('로그인 해주세요');
                else {
                    if(charName == "null")
                        alert('대표캐릭터를 선택해주세요');
                    else
                        $('.post').submit();
                }

            }

            function list() {
                document.listFrm.action = "/boardList";
                document.listFrm.submit();
            }
            
            function pageing(page) {
                document.readFrm.nowPage.value = page;
                document.readFrm.submit();
            }
            
            function block(value){
                 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
                 document.readFrm.submit();
            } 
            
            function read(id){
                document.readFrm.id.value=id;
                document.readFrm.action="/boardRead";
                document.readFrm.submit();
            }
            
            function check() {
                if (document.searchFrm.keyWord.value == "") {
                    alert("검색어를 입력하세요.");
                    document.searchFrm.keyWord.focus();
                    return;
                }
              document.searchFrm.submit();
            }
        </script>
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
                            <a class = "nav_link1" href = "/"> 홈 </a></li>
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
                    <form action = "/s_login" method="POST">
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
                                    Vector<CharBean> _vlist = lMgr.getRank("", "");
                                    int _listSize = _vlist.size();//브라우저 화면에 보여질 랭킹개수
                                    if (_vlist.isEmpty()) {
                                     out.println("검색 결과가 없습니다.<br>");
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
                                    <%}//for%>
                                </table> 
                            </td>
                        </tr>
                    </table>
                    <%
                        } // else
                        %>
                </div>
            </div>
            <div id = "content" style = "background-color: white; font-size: 1.2rem;">
                <br/>
                <%
                    if(bMgr.getBoardName().equals("newsBoard")) out.print("<h2 style = 'padding: 10px;'>공지사항</h2>");
                    else if(bMgr.getBoardName().equals("updateBoard")) out.print("<h2 style = 'padding: 10px;'>업데이트</h2>");
                    else if(bMgr.getBoardName().equals("eventBoard")) out.print("<h2 style = 'padding: 10px;'>이벤트</h2>");
                    else if(bMgr.getBoardName().equals("gamezoneBoard")) out.print("<h2 style = 'padding: 10px;'>게임존</h2>");
                    else if(bMgr.getBoardName().equals("youtubeBoard")) out.print("<h2 style = 'padding: 10px;'>유튜브</h2>");
                    else if(bMgr.getBoardName().equals("blogBoard")) out.print("<h2 style = 'padding: 10px;'>블로그</h2>");
                    else if(bMgr.getBoardName().equals("freeBoard")) out.print("<h2 style = 'padding: 10px;'>자유게시판</h2>");
                    else if(bMgr.getBoardName().equals("questionBoard")) out.print("<h2 style = 'padding: 10px;'>지식게시판</h2>");
                    else if(bMgr.getBoardName().equals("inquireBoard")) out.print("<h2 style = 'padding: 10px;'>문의</h2>");
                %>
                <!-- 찾기 -->
                <% 
                    if(keyWord != "") {
                        out.print("\"" + keyWord + "\"" + "으로 검색한 결과입니다.");
                    }
                %>
                <br/>
                <hr/ style = "color: 1px solid rgb(219, 217, 245);">
                <table align="center" width="100%">
                        <tr>
                        	<%
                        		if(!boardName.equals("inquireBoard")) {
                        	%>
                            <td>종합 : <%=totalRecord%>게시글(<font color="red">
                            <%=nowPage%>/<%=totalPage%>페이지</font>)</td>
                            <%
                        		} else {
                            %>
                            <td>대표캐릭터로 작성한 게시글만 볼 수 있습니다.  글쓰기 완료 후 운영자에게 바로 텔레그램 메시지가 전달됩니다.</td>
                            <%
                        		}
                            %>
                        </tr>
                </table>
                <table align="center" width="100%" cellpadding="3">
                    <tr>
                        <td align="center" colspan="2">
                        <%
                                vlist = bMgr.getBoardList(keyField, keyWord, start, end);
                                listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수
                                if (vlist.isEmpty()) {
                                  out.println("등록된 게시물이 없습니다.");
                                } else {
                        %>
                                <table width="100%" cellpadding="2" cellspacing="0">
                                <tr bgcolor="#D0D0D0" height="120%">
                                    <td align="center" width = "10%">번 호</td>
                                    <td width = "50%">제 목</td>
                                    <td align="center" width = "15%">이 름</td>
                                    <td align="center" width = "15%">날 짜</td>
                                    <td align="center" width = "10%">조 회 수</td>
                                </tr>
                                <%
                                		// fix
                                		int fixCount = 0;
                                		if(boardName.equals("newsBoard")) {
                                		for (int i = 0; i< listSize; i++) {
                                			BoardBean bean = vlist.get(i);
                                			int fix = bean.getFix();
                                			if(fix != 0) {
                                				fixCount++;
                                				int id = bean.getId();
                                				String name = bean.getName();
                                				String regdate = bean.getRegdate();
                                				String subject = bean.getSubject();
                                				int count = bean.getCount();
                                %>
                                <tr bgcolor = #E8E3FF class = "tr">
                                    <td align="center">
                                       	공지
                                    </td>
                                    <td>
                                    <a href="javascript:read('<%=id%>')"><%=subject%></a>
                                    </td>
                                    <td align="center"><%=name%></td>
                                    <td align="center"><%=regdate%></td>
                                    <td align="center"><%=count%></td>
                                    </tr>
                                <% 
                                			} // if fix != 0
                                		} // for fix
                                	} // if newsBoard
                                		
                                		if(nowPage == 1)
                                			numPerPage = numPerPage - fixCount;
                                        for (int i = 0;i<numPerPage; i++) {
                                        if (i == listSize) break;
                                        BoardBean bean = vlist.get(i);
                                        int id = bean.getId();
                                        String name = bean.getName();
                                        String subject = bean.getSubject();
                                        String regdate = bean.getRegdate();
                                        int depth = bean.getDepth();
                                        int count = bean.getCount();
                                        Vector<CommentBean> cvlist = cMgr.getCommentList(boardName, id);
                                        int clistSize = cvlist.size();//브라우저 화면에 보여질 댓글개수
                                        
                                        if(accountId == null) {
    	                                    if(boardName.equals("inquireBoard")){
    	                                    	if(charName == null)
    	                                    		continue;
    	                                    	else if(!charName.equals(name))
    	                                    		continue;
    	                                    }
                                        }
                                        else {
                                        	if(boardName.equals("inquireBoard") && !accountId.equals(0)) {
		                                    	if(charName == null)
		                                    		continue;
		                                    	else if(!charName.equals(name))
		                                    		continue;
		                                    }
                                        }
                                %>
                                <tr class = "tr">
                                    <td align="center">
                                        <%=totalRecord-((nowPage-1)*numPerPage)-i%>
                                    </td>
                                    <td>
                                    <%		                                       
                                            if(depth>0){
                                            for(int j=0;j<depth;j++){
                                                out.println("&nbsp;&nbsp;");
                                                }
                                            }
                                    %>
                                    <a href="javascript:read('<%=id%>')"><%=subject%> <div style = "color: blue; display: inline;">
                                        <div class = "commentCount" style = "display: inline;">[<%=clistSize%>]</div></div></a>
                                    </td>
                                    <td align="center"><%=name%></td>
                                    <td align="center"><%=regdate%></td>
                                    <td align="center"><%=count%></td>
                                    </tr>
                                <% }//for%>
                            </table> 
                        <%
                            }//else
                        %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><br /><br /></td>
                    </tr>
                    <tr>
                        <td>
                        <!-- 페이징 및 블럭 처리 Start--> 
                        <%
                                int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
                                int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
                                //하단 페이지 끝번호
                                if(totalPage !=0){
                                if (nowBlock > 1) {%>
                                    <a href="javascript:block('<%=nowBlock-1%>')">prev...</a><%}%>&nbsp; 
                                    <%for ( ; pageStart < pageEnd; pageStart++){%>
                                    <a href="javascript:pageing('<%=pageStart %>')"> 
                                    <%if(pageStart==nowPage) {%><font color="blue"> <%}%>
                                    [<%=pageStart %>] 
                                    <%if(pageStart==nowPage) {%></font> <%}%></a> 
                                <%}//for%>&nbsp; 
                                <%if (totalBlock > nowBlock ) {%>
                                <a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
                            <%}%>&nbsp;  
                            <%}%>
                            <!-- 페이징 및 블럭 처리 End-->
                        </td>
                        <td align="right">
                            <form action = "/boardPost" method = "get" class = "post">
                                <input type="hidden" name = "boardName" value = "<%=boardName%>">
                                <a href = "#" onclick = "postCheck();">글쓰기</a> 
                            </form>
                            <!-- <a href="post.jsp">글쓰기</a> -->
                        </td>
                    </tr>
                </table>
                <!-- <hr width="600"/> -->
                <form  name="searchFrm"  method="get" action="/boardList">
                <table width="600" cellpadding="4" cellspacing="0">
                        <tr>
                            <td align="center" valign="bottom">
                                <select name="keyField" style = "font-size: 1.2rem; height: 25px;">
                                <option value="name"> 이 름</option>
                                <option value="subject"> 제 목</option>
                                <option value="content"> 내 용</option>
                                </select>
                                <input name="keyWord" style = "font-size: 1.2rem; height: 25px;">
                                <input type="button" value="찾기" onClick="javascript:check()" style = "font-size: 1.2rem; height: 25px;">
                                <input type="hidden" name="nowPage" value="1">
                            </td>
                        </tr>
                        <input type="hidden" name = "boardName" value = "<%=boardName%>">
                </table>
                </form>
                <form name="listFrm" method="get">
                    <input type="hidden" name="reload" value="true"> 
                    <input type="hidden" name="nowPage" value="1">
                </form>
                <form name="readFrm" method="get">
                    <input type="hidden" name = "boardName" value = "<%=boardName%>">
                    <input type="hidden" name="id"> 
                    <input type="hidden" name="nowPage" value="<%=nowPage%>"> 
                    <input type="hidden" name="keyField" value="<%=keyField%>"> 
                    <input type="hidden" name="keyWord" value="<%=keyWord%>">
                </form>     
            </div>
            <div id = "footer">
            
            </div>
        </div>
    </body>
</html>