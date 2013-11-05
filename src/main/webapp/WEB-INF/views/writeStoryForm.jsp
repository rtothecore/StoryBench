<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!-- 로그인 안했으면 메인페이지로 보내버림  -->
<% 
if(null == (String)session.getAttribute("userId")) {
	response.sendRedirect("/");
}
%>

<!DOCTYPE html>
<html>
<title>스토리 쓰기</title>
<head>
	<meta charset="utf-8" />
	<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<link href="/resources/css/style.css" rel="stylesheet">
</head>

<script src="/resources/js/jquery-1.10.2.min.js"></script>
<script>
$(function(){
	//alert("jquery loaded!");	
});

var actorCount = 1;

// 등장인물 폼 추가
function addActorForm(){
	actorCount = actorCount + 1;
	$("<p id='p_story_actor" + actorCount + "'><input id='story_actor" + actorCount + "' required> &nbsp; <button type=button onclick='delActorForm(" + actorCount + ")'>삭제</button></p>").appendTo("#actors");
	$("#story_actor" + actorCount).val( "새로운 등장인물" );
	//$( "input[name='story_actor" + actorCount + "']" ).val( "새로운 등장인물" );
}

// 등장인물 폼 삭제
function delActorForm(actorIdx) {
	$("#p_story_actor" + actorIdx).remove();
	actorCount = actorCount - 1;
}

// 스토리 삭제
function deleteStory() {
	alert("현재 스토리를 삭제하시겠습니까?");
}

// 스토리 임시저장
function saveTempStory() {
	alert("스토리 임시저장!");
}

// 스토리 등록
function registerStory() {
	
	//writeStory.do 호출하여 스토리등록
	var url = "writeStory.do";
    var param = "storyBg=" + $('#story_background').val();
    param += "&storyView=" + $('#story_view').val();
    param += "&storyGenre=" + $('#story_genre').val();
    param += "&storyActor1=" + $('#story_actor1').val();
    param += "&story=" + $('#story').val();
    
//    alert(param);

    $.ajax({
        type: "POST",
        url: url,
        data: param,
        success: function(msg) {
        	if(1 == msg) {
        		alert("스토리 등록 성공!");
        		//$(location).attr('href',"/");
        	} else {
        		alert("스토리 등록 에러:(");
        		$('#story_background').focus();
        	}
       }
    });
}
</script>

<body>

<div class="wrapper">

	<header class="header">
		<p><strong><<로그인명>>
<%
	if(null != (String)session.getAttribute("userId")) {
%>
	<%=(String)session.getAttribute("userId")%>
	&nbsp;<button type=button onclick="logout()">로그아웃</button>
	&nbsp;반갑습니다 <%=(String)session.getAttribute("userAuthorName")%> 님
<%
	}
%>
		</strong></p> 
		Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras tortor. Praesent dictum, libero ut tempus dictum, neque eros elementum mauris, quis mollis arcu velit ac diam. Etiam neque. Quisque nec turpis. Aliquam arcu nulla, dictum et, lacinia a, mollis in, ante. Sed eu felis in elit tempor venenatis.
	</header><!-- .header-->

	<div class="middle">

		<!-- 글쓰기 폼 시작 -->
		<div class="write_content">
			<p><strong><<글쓰기 폼>></strong></p>
			
				<form method="post" enctype="application/x-www-form-urlencoded" action="javascript:registerStory()">
					
					<p><label>배경: <input id="story_background" required></label></p>
					<p><label>시점: <input id="story_view" required></label></p>
					<p><label>장르: <input id="story_genre" required></label></p>
					<div id="actors">
						<p><label>등장인물: <input id="story_actor1" required></label> &nbsp; <button type=button onclick="addActorForm()">추가</button> </p>
					</div>

					<p><label>스토리:<textarea rows="30" cols="100" id="story" required></textarea></label></p>
					<p>
						<button type=button onclick="deleteStory()">삭제</button> &nbsp; 
						<button type=button onclick="saveTempStory()">임시저장</button> &nbsp; 
						<button>등록</button>
					</p>
				</form>
				
		</div>
		<!-- 글쓰기 폼 끝 -->

	</div><!-- .middle-->

</div><!-- .wrapper -->

<footer class="footer">
	<strong>Footer:</strong> Mus elit Morbi mus enim lacus at quis Nam eget morbi. Et semper urna urna non at cursus dolor vestibulum neque enim. Tellus interdum at laoreet laoreet lacinia lacinia sed Quisque justo quis. Hendrerit scelerisque lorem elit orci tempor tincidunt enim Phasellus dignissim tincidunt. Nunc vel et Sed nisl Vestibulum odio montes Aliquam volutpat pellentesque. Ut pede sagittis et quis nunc gravida porttitor ligula.
</footer><!-- .footer -->

</body>
</html>