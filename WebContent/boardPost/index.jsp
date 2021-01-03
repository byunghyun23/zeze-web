<!-- boardPost -->

<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="duka.CharBean"%>
<%@page import="duka.LiveChatBean"%>
<%@page import="java.util.Vector"%>

<jsp:useBean id="lMgr" class="duka.LoginMgr" />
<%	
    request.setCharacterEncoding("utf-8");
    
    // test
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
    String boardName = request.getParameter("boardName");
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
        <script>
            var accountId = '<%=accountId%>'; 
            var charName = '<%=charName%>';

            $(document).ready(function() {
                if(accountId == "null") {
                    $(".login").css("display", "block");
                    $(".loginok").css("display", "none");
                    alert('로그인 해주세요');
                }
                else if(charName == "null")
                    alert('대표캐릭터를 선택해주세요');
                else {
                    $(".login").css("display", "none");
                    $(".loginok").css("display", "block");
                }
            });
            
            function postFrmCheck() {
                if(postFrm.subject.value == "") {
                    alert("제목을 입력해 주세요.");
                    postFrm.subject.focus();
                }
                else if(postFrm.content.value == "<br>") {
                    alert("내용을 입력해 주세요.");
                    postFrm.content.focus();
                }
                else 
                    document.postFrm.submit();
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
                <h2 style = "padding: 10px;">글쓰기</h2>
                <br/>
                <hr/ style = "color: 1px solid rgb(219, 217, 245);">
                <br/>
                <form name="postFrm" method="POST" action="/s_boardPost"   enctype="multipart/form-data" >
                    <table cellpadding="3" style = "width: 100%; padding: 10px;"> 
                        <tr>
                            <td>제 목</td>
                            <td>
                            <input name="subject" size="100" maxlength="50" placeholder = "제목을 입력해주세요." style = "border:none;"></td>
                        </tr>
                        <tr>
                            <td>내 용</td>
                            <td>
                                <textarea id = "editContent" name="content" rows="10" cols="50" style = "width: 90%; height: 500px;"></textarea>
                                <script type="text/javascript">
                                    var oEditors = [];
                                    nhn.husky.EZCreator.createInIFrame({
                                        oAppRef: oEditors,
                                        elPlaceHolder: "editContent",
                                        sSkinURI: "<%=request.getContextPath()%>/./se2/SmartEditor2Skin.html",
                                        fCreator: "createSEditor2"
                                    });
                                    function submitContents(elClickedObj) {
                                        // 에디터의 내용이 textarea에 적용됩니다.
                                        oEditors.getById["editContent"].exec("UPDATE_CONTENTS_FIELD", []);
                                        // 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("editContent").value를 이용해서 처리하면 됩니다.
                                        try {
                                            elClickedObj.form.submit();
                                        } catch(e) {}
                                    }
                                    function pasteHTML(filepath){
                                        var sHTML = '<img src="/image/upload/' + filepath+ '" alt = "error!">';
                                        // var sHTML = "<img src=" + "\'C:/Program Files/Apache Software Foundation/Tomcat 8.5/webapps/duka/image/upload/" + filepath +"\'>";
                                        oEditors.getById["editContent"].exec("PASTE_HTML", [sHTML]);
                                    }
                                    function showHTML(){
                                        alert(oEditors.getById["editContent"].getIR());
                                    }
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><hr/></td>
                        </tr>
                    </table>
                    <div style="float: right; padding: 10px;">
                        <a href = "javascript:" onclick="submitContents(this); postFrmCheck();">등 록</a>
                        <div class = "border"> | </div>
                    	<a href = "javascript:" onclick="history.back();">목 록</a>
                    </div>
                    <input type = "hidden" name = "name" value = "<%=charName%>">
                    <input type = "hidden" name = "boardName" value = "<%=boardName%>">
                    <input type = "hidden" name = "ip" value="<%=request.getRemoteAddr()%>">
                </form>
            </div>
            <div id = "footer">
            
            </div>
        </div>
    </body>
</html>