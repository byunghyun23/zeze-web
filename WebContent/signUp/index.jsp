<!-- signUp -->

<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="duka.CharBean"%>
<%@page import="duka.LiveChatBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="lMgr" class="duka.LoginMgr" />
<%

    String charName = null;
    Object accountId = session.getAttribute("accountId");
    if(accountId != null) {
        charName = lMgr.getChar((int) accountId);
    }
    String keyWord = "", keyField = "";
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
            
            function onSubmit() {
            	document.logFrm.email.value = document.logFrm2.email.value;
                $.get("/sendMail", 
                {
                	email : document.logFrm2.email.value,
                	aut : document.logFrm2.aut.value
                });
                alert('인증 코드 전송완료\r\n메일이 오지 않을 경우 오픈톡 문의');
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
                <h2 style = "padding: 10px;">회원가입</h2>
                <br/>
                <hr/ style = "color: 1px solid rgb(219, 217, 245);">
                <br/>
                <script>
                    function frmCheck() {
                      if(logFrm.name.value == "") {
                        alert("아이디를 입력해주세요.");
                        logFrm.name.focus();
                      }
                      else if(logFrm.pwd.value == "") {
                        alert("비밀번호를 입력해주세요.");
                        logFrm.pwd.focus();
                      }
                      else if(logFrm.pwd2.value == "") {
                          alert("비밀번호 확인을 입력해주세요.");
                          logFrm.pwd2.focus();
                        }
                      else if(logFrm.email.value == "") {
                        alert("이메일 입력후 엔터를 눌러주세요.");
                        logFrm.email.focus();
                      }
                      else if(logFrm.code.value == "") {
                        alert("식별번호를 입력해주세요.");
                        logFrm.code.focus();
                      }
                      else if(logFrm.doco.value == "") {
                          alert("접속경로를 입력해주세요.");
                          logFrm.doco.focus();
                        }
                      else if(logFrm.aut.value == "") {
                          alert("인증코드를 입력해주세요.");
                          logFrm.aut.focus();
                        }
                      else 
                        document.logFrm.submit();
                    }
                </script>
                <form id = "logFrm2" name = "logFrm2" action = "javascript:onSubmit();">
                    <table align="center" width="100%" >
                    <tr>
                   		<td width = "10%" style = "padding: 1%;">이메일</td>
	                    <td width = "15%" style = "padding: 1%;"><input name = "email" type = "email" maxlength = "40" autocomplete=off style = "width: 100%;">
	                    <td width = "40%" style = "padding: 1%;">이메일 입력후 엔터를 눌러주세요. (코드 전송)</td>
	                    <input type = "hidden" name = "aut" value = "<%=session.getId()%>">
                    </tr>
	                </table>
                </form>
                <form id = "logFrm" name = "logFrm" action = "/s_join" method = "POST">
                    <table align="center" width="100%" >
                    	<input type = "hidden" name = "email">
                    	<tr>
	                        <td width = "10%" style = "padding: 1%;">인증 코드</td>
	                        <td width = "15%" style = "padding: 1%;"><input name = "aut" type = "text" minlength = "1" maxlength = "70" autocomplete=off style = "width: 100%;">
	                        <td width = "40%" style = "padding: 1%;">이메일 인증 코드를 입력해주세요.</td>
	                    </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">아이디</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "name" type = "text"minlength = "4" maxlength = "20" autocomplete=off style = "width: 100%;"></td>
                            <td width = "40%" style = "padding: 1%;">아이디는 4자리 이상이어야 하며 특수문자 및 한글을 포함할 수 없습니다.</td>
                        </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">비밀번호</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "pwd" type = "password" minlength = "5" maxlength = "12" autocomplete=off style = "width: 100%;"></td>
                            <td width = "40%" style = "padding: 1%;">비밀번호는 5자리 이상이어야 합니다.</td>
                        </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">비밀번호 확인</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "pwd2" type = "password" minlength = "5" maxlength = "12" autocomplete=off style = "width: 100%;">
                            <td width = "40%" style = "padding: 1%;"></td>
                        </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">식별번호</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "code" type = "password" minlength = "6" maxlength = "6" autocomplete=off style = "width: 100%;">
                            <td width = "40%" style = "padding: 1%;">식별번호는 6자리 이어야하며 알기 쉬운 번호(생년월일)로 입력해주세요.</td>
                        </tr>
                        <tr>
                            <td width = "10%" style = "padding: 1%;">접속경로</td>
                            <td width = "15%" style = "padding: 1%;"><input name = "doco" type = "text" minlength = "1" maxlength = "20" autocomplete=off style = "width: 100%;">
                            <td width = "40%" style = "padding: 1%;">게임존, 유튜브, 블로그 등을입력해주세요.</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <div class = "right">
                                    <div style = "display: inline;"><a href = "javascript:" onclick = "frmCheck();" style = "letter-spacing: 3px; ">확인</a></div> | 
                                    <div style = "display: inline;"><a href = "javascript:" onclick = "history.back();" style = "letter-spacing: 3px; ">취소</a></div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div id = "footer">

            </div>
        </div>
    </body>
</html>