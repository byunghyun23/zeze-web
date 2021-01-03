<!-- boardRead -->

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="duka.BoardBean"%>
<%@page import="duka.CommentBean"%>
<%@page import="duka.CharBean"%>
<%@page import="duka.LiveChatBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="duka.BoardMgr" />
<jsp:useBean id="lMgr" class="duka.LoginMgr" />
<jsp:useBean id="cMgr" class="duka.CommentMgr" />
<%
      request.setCharacterEncoding("UTF-8");

      // 로그인 여부 
      String charName = null;
      Object accountId = session.getAttribute("accountId");
      if(accountId != null) {
          charName = lMgr.getChar((int) accountId);
      }

      // 게시판 선택
      String boardName = request.getParameter("boardName");
      bMgr.setBoardName(boardName);
      Vector<CommentBean> vlist = null;
      int listSize;

      int id = Integer.parseInt(request.getParameter("id"));
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");
	  String keyWord = request.getParameter("keyWord");
	  bMgr.upCount(id);//조회수 증가
	  BoardBean bean = bMgr.getBoard(id);//게시물 가져오기
	  String name = bean.getName();
	  String subject = bean.getSubject();
      String regdate = bean.getRegdate();
	  String content = bean.getContent();
	  String filename = bean.getFilename();
	  int filesize = bean.getFilesize();
	  String ip = bean.getIp();
	  int count = bean.getCount();
      session.setAttribute("bean", bean);//게시물을 세션에 저장
%>

<html>
    <head>
        <title>제제 - ZEZE</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link type = "text/css" rel = "stylesheet" href = "/main.css"></link>
        <link rel="shortcut icon" type = "image/x-icon" href = "zeze.ico">
        <!-- <script src="//code.jquery.com/jquery-3.4.1.min.js"></script> -->
        <script src="/script/jquery-3.4.1.min.js?v=<%=System.currentTimeMillis()%>"></script>
        <script src="/script/js.js?v=<%=System.currentTimeMillis()%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/./se2/js/HuskyEZCreator.js" charset="utf-8"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/./se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
        <script type="text/javascript">
            var post = '<%=boardName%>';
            var accountId = '<%=accountId%>'; 
            var charName = '<%=charName%>';

            $(document).ready(function() {
                if(accountId == "null") {
                    $(".login").css("display", "block");
                    $(".loginok").css("display", "none");
                    if(post == 'newsBoard' || post == 'updateBoard' || post == 'eventBoard') {
                        $('.update').css('display', 'none');
                        $('.delete').css('display', 'none');
                        $('.comment').css('display', 'none');
                    }  
                }
                else {
                    $(".login").css("display", "none");
                    $(".loginok").css("display", "block");
                    if(accountId == '0') {
                        $('.update').css('display', 'inline');
                        $('.delete').css('display', 'inline');
                        $('.comment').css('display', 'inline');
                    }
                    else {
                        if(post == 'newsBoard' || post == 'updateBoard' || post == 'eventBoard') {
                            $('.update').css('display', 'none');
                            $('.delete').css('display', 'none');
                            $('.comment').css('display', 'none');
                        }  
                    }
                }

                // $("#footer").css("display", "block");
            });

            function updateCheck() {
                var accountId = '<%=accountId%>'; 
                var charName = '<%=charName%>';
                var name = '<%=name%>';
                if(accountId == "null") 
                    alert('로그인 해주세요');
                else if(charName == "null")
                    alert('대표캐릭터를 선택해주세요');
                else if(charName != name)
                    alert('권한이 없습니다');
                else
                    document.updateFrm.submit();
            }

            function deleteCheck() {
                var accountId = '<%=accountId%>'; 
                var charName = '<%=charName%>';
                var name = '<%=name%>';
                if(accountId == "null") 
                    alert('로그인 해주세요');
                else if(charName == "null")
                    alert('대표캐릭터를 선택해주세요');
                else if(charName != name)
                    alert('권한이 없습니다');
                else {
                    if(confirm('삭제 ㄱ?') == true)
                        document.deleteFrm.confirm.value='1';
                        document.deleteFrm.submit();
                }   
            }

            function commentCheck() {
                var accountId = '<%=accountId%>'; 
                var charName = '<%=charName%>';
                var name = '<%=name%>';
                if(accountId == "null") 
                    alert('로그인 해주세요');
                else if(charName == "null")
                    alert('대표캐릭터를 선택해주세요');
                else
                    document.commentFrm.submit()
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
                                        CharBean _bean = _vlist.get(i);
                                        int rank = _bean.getRank();
                                        String _name = _bean.getName();
                                        int level = _bean.getLevel();
                                %>
                                    <tr class = "tr">
                                        <!-- <td align = "center"><%=rank%></td> -->
                                        <td align = "center"><%=i+1%></td>
                                        <td><%=_name%></td>
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
				<br/>
                <hr/ style = "color: 1px solid rgb(219, 217, 245);">
                <br/>
                <div class = "top">
                    <h4 style = "float: left; padding: 10px;"><%=subject%></h4>
                    <h4 style = "float: right; padding: 10px;">이름 : <%=name%> <div class = "border"> | </div>날짜 : <%=regdate%> <div class = "border"> | </div>조회수 : <%=count%>
                        <% if( filename !=null && !filename.equals("")) {%>
                        <div class = "border"> | </div>첨부파일 : 
                        <a href="javascript:down('<%=filename%>')"><%=filename%></a>
                        <font color="blue">(<%=filesize%>KBytes)</font>  
                        <%}%>
                    </h4>
                </div>
                <div style = "clear: both; font-size: 1.5rem; min-height: 50%; border: 2px solid rgb(221, 226, 230); padding: 10px;">
                    <!-- <% String s = "<p><img src='C:/Program Files/Apache Software Foundation/Tomcat 8.5/webapps/duka/image/upload/2019_07_28_175130.JPG'></p><p>ㄴㄹㄴㄹ</p>";
                        out.print(s);
                    %> -->
                    <%  
//                        content = content.replace("upload", "se2/upload"); 
//                        content = content.replace("\"", "\'"); 
//                        content = content.replace("lt;", ""); 
//                        content = content.replace("&", "<");
                        out.println(content);
                    %>

                </div><br/>
                <div class = "bottom_menu" style = "float: right; padding: 10px;"> 
                    <form name="listFrm" method="get" action="/boardList" style = "display: inline;">
                        <input type="hidden" name = "boardName" value = "<%=boardName%>">
                        <input type = "hidden" name = "nowPage" value = "<%=nowPage%>">
                        <%if(!(keyWord==null || keyWord.equals(""))){ %>
                        <input type="hidden" name="keyField" value="<%=keyField%>">
                        <input type="hidden" name="keyWord" value="<%=keyWord%>">                        
                        <%}%>
                        <a href = "#" onclick = "document.listFrm.submit();" >목 록</a>
                    </form>
                    <form name = "updateFrm" action = "/boardUpdate" method = "get" style = "display: inline;">
                        <input type = "hidden" name = "nowPage" value = "<%=nowPage%>">
                        <input type="hidden" name = "id" value = "<%=id%>">
                        <input type="hidden" name = "boardName" value = "<%=boardName%>">
                        <div class = "update" style = "display: inline;">| <a href = "#" onclick = "updateCheck();">수 정</a></div>
                    </form>
					<!-- <a href="update.jsp?nowPage=<%=nowPage%>&id=<%=id%>&boardName=<%=boardName%>">수 정</a> | -->
                    <!-- <a href="delete.jsp?nowPage=<%=nowPage%>&id=<%=id%>&boardName=<%=boardName%>" onclick="javascript:confirm('삭제 ㄱ?')">삭 제</a> -->
                    <!-- <a href="#" onclick="javascript:var bool = confirm('삭제 ㄱ?');">삭 제</a> -->
                    <form name = "deleteFrm" action = "/s_boardDelete" method="post" style = "display: inline">
                        <input type = "hidden" name = "nowPage" value = "<%=nowPage%>">
                        <input type = "hidden" name = "id" value = "<%=id%>">
                        <input type = "hidden" name = "boardName" value = "<%=boardName%>">
                        <input type = "hidden" name = "confirm" value = "0">
                        <div class = "delete" style = "display: inline;">| <a href = "#" onclick = "deleteCheck();">삭 제</a></div>
                    </form>
                    <!-- <a href="delete.jsp?nowPage=<%=nowPage%>&id=<%=id%>&boardName=<%=boardName%>" onclick="javascript:if(confirm('삭제 ㄱ?')) this.confirm.value='1';">삭 제</a> -->
				</div>
                <br><br>
                
                <div class = "comment">
                    <%
                        vlist = cMgr.getCommentList(boardName, id);
                        listSize = vlist.size();//브라우저 화면에 보여질 댓글개수
                        if (vlist.isEmpty()) {
                        out.println("등록된 댓글이 없습니다.<br>");
                        } else {
                            out.print("댓글 " + listSize + "개");
                            for (int i = 0;i<listSize; i++) {
                                CommentBean c_bean = vlist.get(i);
                                int c_id = c_bean.getId();
                                String c_name = c_bean.getName();
                                String c_content = c_bean.getContent();
                                String c_regdate = c_bean.getRegdate();
                    %>
                    <table width="100%" cellpadding="2" cellspacing="0">
                        <tr class = "tr">
                            <td width = "15%"><%=c_name%></td>
                            <td width = "73%"><%=c_content%></td>
                            <td width = "12%"><%=c_regdate%></td>
                        </tr>
                        <%}//for%>
                    </table> 
                    <%
                        } // else
                    %>
                    <br>
                    댓글 달기 <br>
                    <form name = "commentFrm" action = "/s_commentPost" method="POST">
                        <textarea name = "content" rows = "5" style="width: 99%; resize: none;"></textarea>
                        <a href = "#" onclick = "commentCheck();" style="float: right;">완 료</a>
                        <input type = "hidden" name = "nowPage" value = "<%=nowPage%>">
                        <input type="hidden" name = "boardName" value = "<%=boardName%>">
                        <input type="hidden" name = "id" value = "<%=id%>">
                        <input type="hidden" name = "name" value = "<%=charName%>">
                        <input type="hidden" name = "ip" value = "<%=request.getRemoteAddr()%>">
                    </form>
                    <br><br>
                </div>
            </div>
        </div>
        <div id = "footer">
        
        </div>
    </body>
</html>