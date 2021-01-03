<!-- rank -->

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="duka.CharBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="bMgr" class="duka.BoardMgr" />
<jsp:useBean id="lMgr" class="duka.LoginMgr" />
<%@page import="duka.CharBean"%>
<jsp:useBean id="uMgr" class="duka.UtilMgr" />
<%	
    request.setCharacterEncoding("utf-8");
    
    // test
    String charName = null;
    Object accountId = session.getAttribute("accountId");
    if(accountId != null) {
        charName = lMgr.getChar((int) accountId);
    }
    
    int listSize=0; //현재 읽어온 게시물의 수
	Vector<CharBean> vlist = null;

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

            function read(id){
                document.readFrm.id.value=id;
                document.readFrm.action="readBoard.jsp";
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
        <!-- <div>
            <div style="position: absolute;">
        
                <div style="position: relative; top: 80px; left: 100px;"><img src="image/h.png"></img></div>
        
            </div>
        
            <div style="position: relative;">
        
                <div style="position: relative; top: 95px; left: 103px;"><img src="image/f.png"></img></div>
        
            </div>
        
        </div> -->

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
                <h2 style = "padding: 10px;">랭킹</h2>
                <br/>
                <hr/ style = "color: 1px solid rgb(219, 217, 245);">
                <table align="center" width="100%">
                        <tr>
							<td>
								최대 20개까지 보여줍니다.&nbsp
								<!-- 찾기 -->
				                <% 
				                    boolean bool = false;
				                	Vector<CharBean> __vlist = lMgr.getRank("", "");
	                                int __listSize = __vlist.size();//브라우저 화면에 보여질 랭킹개수
				                    if(keyWord != "") {
				                        bool = true;
				                        out.print(" \"" +  keyWord + "\"" + "으로 검색한 결과입니다.");
				                    }
				                %>
							</td>
                        </tr>
                </table>
                <table align="center" width="100%" cellpadding="3">
                    <tr>
                        <td align="center" colspan="2">
                            <%
                                vlist = lMgr.getRank(keyField, keyWord);
                                listSize = vlist.size();//브라우저 화면에 보여질 랭킹개수
                                if (vlist.isEmpty()) {
                                out.println("검색 결과가 없습니다.<br>");
                                } else {
                                	if(keyWord.equals("ZEZE") || keyWord.equals("zeze")) {
                                		out.println("검색 결과가 없습니다.<br>");
                                	}
                                	else if (keyWord.equals("제제")) {
                                		out.println("검색 결과가 없습니다.<br>");
                                	}
                                	else {
                            %>
                            <table width="100%" cellpadding="2" cellspacing="0">
                                <tr bgcolor="#D0D0D0">
                                    <td width = "10%" align = "center">순 위</td>
                                    <td width = "40%">이 름</td>
                                    <td width = "20%">직 업</td>
                                    <td width = "20%">레 벨 / 경 험 치</td>
                                    <td width = "10%" align = "center">인 기 도</td>
                                </tr>

                            <%
                                int limit = 20;
                            	int rank = 0;
                                for (int i = 0;i<limit; i++) {
                                    if(i == listSize) break;
                                    
                                    CharBean bean = vlist.get(i);
                                    // int rank = bean.getRank();
                                    String name = bean.getName();
                                    int level = bean.getLevel();
                                    int job = bean.getJob();
                                    String jobName = uMgr.getJobName(job);
                                    if(jobName == null) jobName = "";
                                    int exp = bean.getExp();
                                    int fame = bean.getFame();
                                    
                                    if(name.equals("ZEZE") || name.equals("zeze")) {
                                    	limit++;
                                    	continue;
                                    }
                                    
                                    for(int j = 0; j < __listSize; j++) {
                                    	CharBean __bean = __vlist.get(j);
                                    	String __name = __bean.getName();
                                    	if(__name.equals(name)) {
                                    		rank = j;
                                    		break;
                                    	}

                                    }
                            %>
                                <tr class = "tr">
                                    <%
                                        if(bool) {
                                    %>
                                    <td align = "center"><%=++rank%></td>
                                    <%
                                        } else {
                                    %>
                                    <td align = "center"><%=++rank%></td>
                                    <% } %>        
                                    <td><%=name%></td>
                                    <td><%=jobName%></td>
                                    <td><%=level%> / <%=exp%></td>
                                    <td align = "center"><%=fame%></td>
                                </tr>
                                <%}//for%>
                            </table> 
                        </td>
                    </tr>
                </table>
                <%
                    	} // else
                    } // else
                %>
                <form  name="searchFrm"  method="get" action = "/rank">
                    <table width="600" cellpadding="4" cellspacing="0">
                        <tr>
                            <td align="center" valign="bottom">
                                <select name="keyField" style = "font-size: 1.2rem; height: 25px;">
                                <option value="name"> 이 름</option>
                                <option value="job"> 직 업</option>
                                </select>
                                <input name="keyWord" style = "font-size: 1.2rem; height: 25px;">
                                <input type="button" value="찾기" onClick="javascript:check()" style = "font-size: 1.2rem; height: 25px;">
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