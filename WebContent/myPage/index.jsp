<!-- myPage -->

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="duka.BoardBean"%>
<%@page import="duka.CharBean"%>
<%@page import="duka.LiveChatBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="duka.BoardMgr" />
<jsp:useBean id="lMgr" class="duka.LoginMgr" />
<%	
      request.setCharacterEncoding("utf-8");
      
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
        <link type = "text/css" rel = "stylesheet" href = "/main.css"></link>
        <link rel="shortcut icon" type = "image/x-icon" href = "zeze.ico">
        <!-- <script src="//code.jquery.com/jquery-3.4.1.min.js"></script> -->
        <script src="/script/jquery-3.4.1.min.js?v=<%=System.currentTimeMillis()%>"></script>
        <script src="/script/js.js?v=<%=System.currentTimeMillis()%>"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                accountId = "<%= accountId %>";
                if(accountId == "null") {
                    $(".login").css("display", "block");
                    $(".loginok").css("display", "none");
                  
                }
                else {
                    $(".login").css("display", "none");
                    $(".loginok").css("display", "block");
                }
            });

            function changePwdFrmCheck() {
                if(changePwdFrm.prepwd.value == "") {
                    alert("현재 비밀번호를 입력해 주세요.");
                    changePwdFrm.prepwd.focus();
                }
                else if(changePwdFrm.newpwd.value == "") {
                    alert("새 비밀번호를 입력해 주세요.");
                    changePwdFrm.newpwd.focus();
                }
                else if(changePwdFrm.newpwd2.value == "") {
                    alert("새 비밀번호를 한번 더 입력해 주세요.");
                    changePwdFrm.newpwd2.focus();
                }
                else 
                    document.changePwdFrm.submit();
            }

            function changeMailFrmCheck() {
                if(changeMailFrm.prepwd.value == "") {
                    alert("현재 비밀번호를 입력해 주세요.");
                    changeMailFrm.prepwd.focus();
                }
                else if(changeMailFrm.email.value == "") {
                    alert("이메일을 입력해 주세요.");
                    changeMailFrm.email.focus();
                }
                else 
                    document.changeMailFrm.submit();
            }
        </script>
    </head>
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
                                    Vector<CharBean> _vlist = lMgr.getRank(keyField, keyWord);
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
                <h2 style = 'padding: 10px;'>마이페이지</h2>
                <br/>
                <hr/ style = "color: 1px solid rgb(219, 217, 245);">
                <br>
                <table width="100%">
                    <tr>
                        <td bgcolor="#F5F5F5" style = "padding: 1%; font-weight: bold;">대표 캐릭터 설정</td>
                    </tr>
                    <tr>
                        <td style = "padding: 1%;">계정의 대표 캐릭터를 설정합니다.</td>
                    </tr>
                    <tr>
                        <td style = "padding: 1%;">Lv. 10 이상의 캐릭터만 설정할 수 있습니다.</td>
                    </tr>
                </table>
                <div class = "right">
                    <div style = "display: inline;"><a href = "/setChar" style = "letter-spacing: 3px; ">대표캐릭터 설정</a></div>
                </div>

                <form name = "changePwdFrm" action="/s_changePwd" method="POST">
                    <table width="100%">
                        <tr>
                            <td bgcolor="#F5F5F5" colspan="3" style = "padding: 1%; font-weight: bold;">계정 비밀번호 변경</td>
                        </tr>
                        <tr>
                            <td colspan="3" style = "padding: 1%;">보안을 위해 주기적으로 계정 비밀번호를 변경하는것을 권장합니다.</td>
                        </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">현재 비밀번호</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "prepwd" type = "password"  minlength = "5" maxlength = "12" autocomplete=off style = "width: 100%;" /></td>
                            <td width = "40%" style = "padding: 1%;">정확하게 입력해주세요.</td>
                        </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">새 비밀번호</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "newpwd" type = "password"  minlength = "5" maxlength = "12" autocomplete=off style = "width: 100%;" /></td>
                            <td width = "40%" style = "padding: 1%;">정확하게 입력해주세요.</td>
                        </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">비밀번호 확인</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "newpwd2" type = "password"  minlength = "5" maxlength = "12" autocomplete=off style = "width: 100%;" /></td>
                            <td width = "40%" style = "padding: 1%;">정확하게 입력해주세요.</td>
                        </tr>
                    </table>
                    <div class = "right">
                            <div style = "display: inline;"><a href = "javascript:" onclick = "changePwdFrmCheck();" style = "letter-spacing: 3px; ">비밀번호 변경</a></div>
                    </div>
                </form>

                
                <form name = "changeMailFrm" action="/s_changeMail" method="POST">
                    <table width="100%">
                        <tr>
                            <td bgcolor="#F5F5F5" colspan="3" style = "padding: 1%; font-weight: bold;">이메일 변경</td>
                        </tr>
                        <tr>
                        	<td width = "10%" style = "padding: 1%;">현재 이메일</td>
                        	<td width = "25%" style = "padding: 1%;"><%=lMgr.getEmail((int)accountId)%></td>
                        </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">현재 비밀번호</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "prepwd" type = "password"  minlength = "5" maxlength = "12" autocomplete=off style = "width: 100%;" /></td>
                            <td width = "40%" style = "padding: 1%;">정확하게 입력해주세요.</td>
                        </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">이메일 주소</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "email" type = "email"  maxlength = "40" autocomplete=off style = "width: 100%;" /></td>
                            <td width = "40%" style = "padding: 1%;">정확하게 입력해주세요.</td>
                        </tr>
                    </table>
                    <div class = "right">
                            <div style = "display: inline;"><a href = "javascript:" onclick = "changeMailFrmCheck();" style = "letter-spacing: 3px; ">이메일 변경</a></div>
                    </div>
                </form>
            </div>
            <div id = "footer">

            </div>
        </div>
    </body>
</html>