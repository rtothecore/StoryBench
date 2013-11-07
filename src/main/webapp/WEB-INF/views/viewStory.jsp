<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page import="org.json.simple.*" %>

<% 
   String storyId = (String)request.getAttribute("storyId");
%>

<!DOCTYPE html>
<html>
<title>스토리 보기</title>
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

var storyId = <%=storyId%>;
var jsonObj = null;

$(function(){
	//alert("jquery loaded!");
	
	getStories(storyId);	// 스토리 데이터 얻기
	createDivClickFunc()	// div 클릭 함수 생성
	
	//현재 스토리 Readed 설정
});

// 서버에서 스토리 데이터 얻기
function getStories(storyIdVal) {
	
	//storyId로 viewStory.ajax 호출
	var url = "viewStory.ajax";
    var param = "storyId=" + storyIdVal;

    $.ajax({
        type: "POST",
        url: url,
        data: param,
        dataType: "json",
        success: response_json
    });
    
    function response_json(json) {
    	
    	jsonObj = json;
    	
    	// parent
    	var parentObj = json.parent;
    	//$('#parentP').text("<<이전 스토리>>" + parentObj.p_storyId);
    	$('#parentP').text(parentObj.p_storyId);
    	$('#parent_story').text(parentObj.p_story);
    	
    	// me
    	var meObj = json.me;
    	//$('#meP').text("<<현재 스토리>>" + meObj.m_Story.m_storyId);
    	$('#meP').text(meObj.m_Story.m_storyId);
    	$('#me_story').text(meObj.m_Story.m_story);
    	
    	// me - storybase
    	var storyBaseInfo = "<p>배경:" + meObj.m_StoryBase.m_background + 
    	                    "&nbsp; 시점:" + meObj.m_StoryBase.m_view + 
    	                    "&nbsp; 장르:" + meObj.m_StoryBase.m_genre + "</p>";
    	                    
    	$('#me_storyBase').text("");
    	$(storyBaseInfo).appendTo('#me_storyBase');
    	
    	// me - storyactors
    	var meActorsList = meObj.m_StoryActors;
    	var meActorsCount = meActorsList.length;
    	if( 0 < meActorsCount)
    		$('#me_storyActors').text("");
    	
    	$.each(meActorsList, function(idx){
    		var actorDiv = "<div id='actor" + idx + "'><strong>등장인물" + idx + "(" + meActorsList[idx].m_storyActorsId + ")</strong>:&nbsp;" 
    						+ meActorsList[idx].m_actorName + " "
    						+ meActorsList[idx].m_actorSex + " "
    						+ meActorsList[idx].m_actorAge + "세 "
    						+ meActorsList[idx].m_actorDesc + " "
    						+ "</div>";
    		$(actorDiv).appendTo("#me_storyActors");
    	});
    	
    	// children
    	var childrenList = json.children; 	
    	var childrenCount = childrenList.length;
    	$.each(childrenList, function(idx){
    		//var childDiv = "<div id='child_story" + idx + "'><strong id='childP" + idx +"'>" + childrenList[idx].c_storyId + "</strong>:&nbsp;" + childrenList[idx].c_story + "</div>"
    		var childDiv = "<div id='child_story" + idx + "'><strong id='childP" + idx +"' onclick='viewStory(" + childrenList[idx].c_storyId + ")'>" + childrenList[idx].c_storyId + "</strong>:&nbsp;" + childrenList[idx].c_story + "</div>"
    		$(childDiv).appendTo("#children_story");
    	});
    }
    
    /*
    $.ajax({
        type: "POST",
        url: url,
        data: param,
        success: function(msg) {
        	alert(msg);
       }
    });
    */
}

// 책갈피 추가
function addBookmark() {
	alert("책갈피 추가");
}

// 이어쓰기
function writeFollowed() {
	//alert("이어쓰기");
	
	//writeFollowedForm.do로 이동(부모 story_id, 부모 TreeLevel을 파라미터로 넘김)
	var form = document.createElement('form');
	var objs;
	objs = document.createElement('input');
	objs.setAttribute('type', 'hidden');
	objs.setAttribute('name', 'parentStoryId');
	objs.setAttribute('value', jsonObj.me.m_Story.m_storyId);
	form.appendChild(objs);
	var objs2;
	objs2 = document.createElement('input');
	objs2.setAttribute('type', 'hidden');
	objs2.setAttribute('name', 'parentTreeLevel');
	objs2.setAttribute('value', jsonObj.me.m_Story.m_treeLevel);
	form.appendChild(objs2);
	var objs3;
	objs3 = document.createElement('input');
	objs3.setAttribute('type', 'hidden');
	objs3.setAttribute('name', 'parentStoryBaseId');
	objs3.setAttribute('value', jsonObj.me.m_Story.m_storyBaseId);
	form.appendChild(objs3);
	form.setAttribute('method', 'post');
	form.setAttribute('action', "writeFollowedForm.do");
	document.body.appendChild(form);
	form.submit();
}

// 추천
function addRecomm() {
	alert("추천!!");
}

//로그아웃
function logout() {
	//logout.do 호출하여 로그아웃
	var url = "logout.do";

    $.ajax({
        type: "POST",
        url: url,
        success: function(msg) {
        	if(1 == msg) {
        		alert("로그아웃 되었습니다:)");
        		$(location).attr('href',"/");
        	} else {
        		alert("로그아웃 에러:(");
        	}
       }
    });
}

// 글쓰기
function writeStory() {
	$(location).attr('href',"writeStoryForm.do");
}

// 스토리보기
function viewStory(storyIdVal) {
	// "스토리 보기" 페이지로 이동 (POST)
	var form = document.createElement('form');
	var objs;
	objs = document.createElement('input');
	objs.setAttribute('type', 'hidden');
	objs.setAttribute('name', 'storyId');
	objs.setAttribute('value', storyIdVal);
	form.appendChild(objs);
	form.setAttribute('method', 'post');
	form.setAttribute('action', "viewStory.do");
	document.body.appendChild(form);
	form.submit();
}

//div 클릭 이벤트 생성
function createDivClickFunc() {
	$('#parentP').click(function() {
		viewStory($('#parentP').text());
	});

	$('#meP').click(function() {
		viewStory($('#meP').text());
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
	&nbsp;&nbsp;<button type=button onclick="writeStory()">이야기 쓰기</button>
<%
	}
%>
		</strong></p> 
		Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras tortor. Praesent dictum, libero ut tempus dictum, neque eros elementum mauris, quis mollis arcu velit ac diam. Etiam neque. Quisque nec turpis. Aliquam arcu nulla, dictum et, lacinia a, mollis in, ante. Sed eu felis in elit tempor venenatis.
	</header><!-- .header-->

	<div class="middle">

		<div class="container">
			<main class="content">
				<p><strong><<스토리 기본정보>></strong></p>
				<div id='me_storyBase'>스토리 기본정보가 없습니다.</div>
				<div id='me_storyActors'>스토리 등장인물정보가 없습니다.</div>
			</main><!-- .content -->
		</div><!-- .container-->
		
		<!-- 스토리 보기 시작 -->
		<div id='div_pStory' class="current_story_content">
			<p><strong id='parentP'><<이전 글>></strong></p>
			<div id='parent_story'>이전 스토리가 없습니다.</div>
		</div>
		
		<div id='div_mStory' class="current_story_content">
			<p><strong id='meP'><<현재 글>></strong></p>
			<div id='me_story'>현재 스토리가 없습니다.</div>

<%
	if(null != (String)session.getAttribute("userId")) {
%>			 
			<p>
			   <button type=button onclick="addBookmark()">책갈피</button> 
			   <button type=button onclick="writeFollowed()">이어쓰기</button> 
			   <button type=button onclick="addRecomm()">추천</button> 
			   <!--<button type=button onclick="deleteStory()">구조보기</button>-->
			</p>
<%
	}
%>		
			
		</div>
		
		<div class="current_story_content">
			<p><strong><<다음 스토리>></strong></p>
			<div id='children_story'>
				<!-- <div id='child_story1'>다음 스토리가 없습니다.</div> -->
			</div> 
		</div>
		<!-- 스토리 보기 끝 -->

	</div><!-- .middle-->

</div><!-- .wrapper -->

<footer class="footer">
	<strong>Footer:</strong> Mus elit Morbi mus enim lacus at quis Nam eget morbi. Et semper urna urna non at cursus dolor vestibulum neque enim. Tellus interdum at laoreet laoreet lacinia lacinia sed Quisque justo quis. Hendrerit scelerisque lorem elit orci tempor tincidunt enim Phasellus dignissim tincidunt. Nunc vel et Sed nisl Vestibulum odio montes Aliquam volutpat pellentesque. Ut pede sagittis et quis nunc gravida porttitor ligula.
</footer><!-- .footer -->

</body>
</html>