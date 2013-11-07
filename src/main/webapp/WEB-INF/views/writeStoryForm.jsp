<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!-- 로그인 안했으면 메인페이지로 보내버림  -->
<% 
if(null == (String)session.getAttribute("userId")) {
	response.sendRedirect("/");
} 

// Mode
String mode = (String)request.getAttribute("mode");
if(null == mode) {
	mode = "new";
}

// For followed
String parentStoryId = null;
String parentTreeLevel = null;
String parentStoryBaseId = null;

// For modify
String meStoryId = null;

/*
 * < writeStoryForm 페이지의 모드 >  
 * 1. new(새글) - 임시저장, 등록
 * 2. modify(수정) - 삭제, 수정
 * 3. followed(이어쓰기) - 임시저장, 등록
 */
 if(mode.equals("followed")) {
	 parentStoryId = (String)request.getAttribute("parentStoryId");
	 parentTreeLevel = (String)request.getAttribute("parentTreeLevel");
	 parentStoryBaseId = (String)request.getAttribute("parentStoryBaseId");
 } else if(mode.equals("modify")) {
	 meStoryId = (String)request.getAttribute("meStoryId");
 } else {
	 
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
var mode = "<%=mode%>";
var pStoryId = null;
var pTreeLevel = null;
var pStoryBaseId = null;
var mStoryId = null;

$(function(){
	//alert("jquery loaded!");
		
	if("followed" == mode) {
		pStoryId = <%=parentStoryId%>;
		pTreeLevel = <%=parentTreeLevel%>;
		pStoryBaseId = <%=parentStoryBaseId%>;
		alert("Mode:" + mode + ", pStoryId:" + pStoryId + ", pTreeLevel:" + pTreeLevel + ", pStoryBaseId:" + pStoryBaseId);
		
		$("#baseInfo").remove();
		$("#actorsInfo").remove();
		$("#writeBtnForNew").remove();
		$("#writeBtnForModify").remove();
		
		// 스토리 기본정보와 이전 스토리를 가져온다.
		getStoryBase(pStoryBaseId);
		getParentStory(pStoryId);
	} else if("modify" == mode) {
		mStoryId = <%=meStoryId%>;
		alert("Mode:" + mode + ", mStoryId:" + mStoryId);
		
		$("#writeBtnForNew").remove();
		$("#writeBtnForFollowed").remove();
	} else {
		alert("Mode:" + mode);
		
		$("#writeBtnForModify").remove();
		$("#writeBtnForFollowed").remove();
		$("#story_base_div").remove();
		$("#parent_story_div").remove();
	}
	
});

function getStoryBase(pStoryBaseIdVal){
	var url = "getStoryBase.ajax";
    var param = "storyBaseId=" + pStoryBaseIdVal;

    $.ajax({
        type: "POST",
        url: url,
        data: param,
        dataType: "json",
        success: response_json
    });
    
    function response_json(json) {
    	var jsonObj = json;
    	
    	// storybase
    	var storyBaseInfo = "<p>배경:" + jsonObj.m_StoryBase.m_background + 
    	                    "&nbsp; 시점:" + jsonObj.m_StoryBase.m_view + 
    	                    "&nbsp; 장르:" + jsonObj.m_StoryBase.m_genre + "</p>";
    	                    
    	$('#me_storyBase').text("");
    	$(storyBaseInfo).appendTo('#me_storyBase');
    	
    	// storyactors
    	var meActorsList = jsonObj.m_StoryActors;
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
    }
}

function getParentStory(pStoryIdVal){
	var url = "getParentStory.ajax";
    var param = "storyId=" + pStoryIdVal;

    $.ajax({
        type: "POST",
        url: url,
        data: param,
        dataType: "json",
        success: response_json
    });
    
    function response_json(json) {
    	var jsonObj = json;
    	
    	$('#parentP').text("<<이전 스토리>>" + jsonObj.p_storyId);
    	$('#parent_story').text(jsonObj.p_story);
    }
}

var actorCount = 1;

// 등장인물 폼 추가
function addActorForm(){
	actorCount = actorCount + 1;
	
	var newActorForm = "<p id='p_story_actor" + actorCount + "'>등장인물" + actorCount + "&nbsp; <button type=button onclick='delActorForm(" + actorCount + ")'>삭제</button>";
	newActorForm += "<label>이름<input id='actor" + actorCount + "Name' required></label>"; 
	newActorForm += "<label> <input type=radio name='actor" + actorCount + "Sex' id='actor" + actorCount + "Sex1' checked> 남 </label>";
	newActorForm += "<label> <input type=radio name='actor" + actorCount + "Sex' id='actor" + actorCount + "Sex0'> 여 </label>"; 	 	
	newActorForm += "<label>나이<input id='actor" + actorCount + "Age' pattern='[0-9]{1,4}' title='숫자(최대4자리)' required></label>";
	newActorForm += "<label>소개<input id='actor" + actorCount + "Desc' required></label>";
	newActorForm += "</p>";
	
	$(newActorForm).appendTo("#actors");
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

// 스토리 수정
function modifyStory() {
	alert("현재 스토리를 수정하시겠습니까?");
}

// 스토리 임시저장
function saveTempStory() {
	var url = "writeStory.ajax";
    var param = "storyBg=" + $('#story_background').val();
    param += "&storyView=" + $('#story_view').val();
    param += "&storyGenre=" + $('#story_genre').val();
    
    // !!!!!!!!!!!!!!!등장인물의 수가 동적이므로 추후에 json 배열에 담아 전송하게끔 수정!!!!!!!!!!!!!!!!!!!!!!
    // 등장인물 데이터 시작
    param += "&actorCount=" + actorCount;
    for(var i=0; i<actorCount; i++) {
    	var idx = i + 1;
    	param += "&storyActor"+ idx + "Name=" + $('#actor' + idx + 'Name').val();
        if($("input:radio[id='actor' + idx + 'Sex1']").is(":checked") == true) {
        	param += "&storyActor" + idx + "Sex=1";
        } else {
        	param += "&storyActor" + idx + "Sex=0";
        }
        param += "&storyActor" + idx + "Age=" + $('#actor' + idx + 'Age').val();
        param += "&storyActor" + idx + "Desc=" + $('#actor' + idx + 'Desc').val();
    }
 	// 등장인물 데이터 끝
    
    param += "&story=" + $('#story').val();
    param += "&saveTemp=1"; 
    param += "&mode=" + mode;
    param += "&parentRef=" + pStoryId;
    param += "&parentTreeLevel=" + pTreeLevel;
    param += "&storyBaseId=" + pStoryBaseId;

    $.ajax({
        type: "POST",
        url: url,
        data: param,
        success: function(msg) {
			var parsed = $.parseJSON(msg);
			
			if(parsed.result) {
				alert("스토리 임시저장 성공! - story_id:" + parsed.newStoryId);
        	} else {
        		alert("스토리 임시저장 에러:(");
        		$('#story_background').focus();
        	}
       }
    });
}

// 스토리 등록
function registerStory() {
	var url = "writeStory.ajax";
	
    var param = "storyBg=" + $('#story_background').val();
    param += "&storyView=" + $('#story_view').val();
    param += "&storyGenre=" + $('#story_genre').val();
    
    // !!!!!!!!!!!!!!!등장인물의 수가 동적이므로 추후에 json 배열에 담아 전송하게끔 수정!!!!!!!!!!!!!!!!!!!!!!
    // 등장인물 데이터 시작
    param += "&actorCount=" + actorCount;
    for(var i=0; i<actorCount; i++) {
    	var idx = i + 1;
    	param += "&storyActor"+ idx + "Name=" + $('#actor' + idx + 'Name').val();
        if($("input:radio[id='actor" + idx + "Sex1']").is(":checked") == true) {
        	param += "&storyActor" + idx + "Sex=1";
        } else {
        	param += "&storyActor" + idx + "Sex=0";
        }
        param += "&storyActor" + idx + "Age=" + $('#actor' + idx + 'Age').val();
        param += "&storyActor" + idx + "Desc=" + $('#actor' + idx + 'Desc').val();
    }
 	// 등장인물 데이터 끝
    
    param += "&story=" + $('#story').val();
    param += "&mode=" + mode;
    param += "&parentRef=" + pStoryId;
    param += "&parentTreeLevel=" + pTreeLevel;
    param += "&storyBaseId=" + pStoryBaseId;
    
    alert(param);
    
    $.ajax({
        type: "POST",
        url: url,
        data: param,
        success: function(msg) {
			var parsed = $.parseJSON(msg);
			
			if(parsed.result) {
				alert("스토리 등록 성공! - story_id:" + parsed.newStoryId);
        		
        		// "스토리 보기" 페이지로 이동 (POST)
				var form = document.createElement('form');
				var objs;
				objs = document.createElement('input');
				objs.setAttribute('type', 'hidden');
				objs.setAttribute('name', 'storyId');
				objs.setAttribute('value', parsed.newStoryId);
				form.appendChild(objs);
				form.setAttribute('method', 'post');
				form.setAttribute('action', "viewStory.do");
				document.body.appendChild(form);
				form.submit();
        	} else {
        		alert("스토리 등록 에러:(");
        		$('#story_background').focus();
        	}
       }
    });
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
	
		<!-- 스토리 기본정보 -->
		<div class="container" id='story_base_div'>
			<main class="content">
				<p><strong><<스토리 기본정보>></strong></p>
				<div id='me_storyBase'>스토리 기본정보가 없습니다.</div>
				<div id='me_storyActors'>스토리 등장인물정보가 없습니다.</div>
			</main><!-- .content -->
		</div><!-- .container-->
		
		<!-- 이전 스토리 -->
		<div class="current_story_content" id='parent_story_div'>
			<p><strong id='parentP'><<이전 글>></strong></p>
			<div id='parent_story'>이전 스토리가 없습니다.</div>
		</div>

		<!-- 글쓰기 폼 시작 -->
		<div class="write_content">
			<p><strong><<글쓰기 폼>></strong></p>
			
				<form method="post" enctype="application/x-www-form-urlencoded" action="javascript:registerStory()">
					
					<div id="baseInfo">
						<p><label>배경: <input id="story_background" required></label></p>
						<p><label>시점: <input id="story_view" required></label></p>
						<p><label>장르: <input id="story_genre" required></label></p>
					</div>
					
					<div id="actorsInfo">
						<div id="actors">
							<p>등장인물1
								<label>이름<input id="actor1Name" required></label> 
								<label> <input type=radio name="actor1Sex" id="actor1Sex1" checked> 남 </label>
								<label> <input type=radio name="actor1Sex" id="actor1Sex0"> 여 </label>
								<label>나이<input id="actor1Age" pattern="[0-9]{1,4}" title="숫자(최대4자리)" required></label>
								<label>소개<input id="actor1Desc" required></label>
							</p>
						</div>
							 &nbsp; <button type=button onclick="addActorForm()">등장인물 추가</button>
					</div>

					<p><label>스토리:<textarea rows="30" cols="100" id="story" required></textarea></label></p>
					
					<div id="writeBtnForNew">
						<p> 
							<button type=button onclick="saveTempStory()">임시저장</button> &nbsp; 
							<button>등록</button>
						</p>
					</div>
					<div id="writeBtnForModify">
						<p>
							<button type=button onclick="deleteStory()">삭제</button> &nbsp; 
							<button type=button onclick="modifyStory()">수정</button>
						</p>
					</div>
					<div id="writeBtnForFollowed">
						<p> 
							<button type=button onclick="saveTempStory()">임시저장</button> &nbsp; 
							<button>등록</button>
						</p>
					</div>
					
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