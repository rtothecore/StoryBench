<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

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
$(function(){
	//alert("jquery loaded!");
	
	//현재 스토리 Readed 설정
});

// 책갈피 추가
function addBookmark() {
	alert("책갈피 추가");
}

// 이어쓰기
function writeFollowed() {
	alert("이어쓰기");
	
	//writeStoryForm.html으로 이동(부모 story_id등을 파라미터로 넘김)
}

// 추천
function addRecomm() {
	alert("추천!!");
}

</script>

<body>

<div class="wrapper">

	<header class="header">
		<p><strong><<로그인명>></strong></p> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras tortor. Praesent dictum, libero ut tempus dictum, neque eros elementum mauris, quis mollis arcu velit ac diam. Etiam neque. Quisque nec turpis. Aliquam arcu nulla, dictum et, lacinia a, mollis in, ante. Sed eu felis in elit tempor venenatis.
	</header><!-- .header-->

	<div class="middle">

		<div class="container">
			<main class="content">
				<p><strong><<스토리 기본정보>></strong></p> Sed placerat accumsan ligula. Aliquam felis magna, congue quis, tempus eu, aliquam vitae, ante. Cras neque justo, ultrices at, rhoncus a, facilisis eget, nisl. Quisque vitae pede. Nam et augue. Sed a elit. Ut vel massa. Suspendisse nibh pede, ultrices vitae, ultrices nec, mollis non, nibh. In sit amet pede quis leo vulputate hendrerit. Cras laoreet leo et justo auctor condimentum. Integer id enim. Suspendisse egestas, dui ac egestas mollis, libero orci hendrerit lacus, et malesuada lorem neque ac libero. Morbi tempor pulvinar pede. Donec vel elit.
			</main><!-- .content -->
		</div><!-- .container-->
		
		<!-- 스토리 보기 시작 -->
		<div class="current_story_content">
			<p><strong><<이전 글>></strong></p>
			<p>차라투스트라는 이렇게 말했다. 위키백과, 우리 모두의 백과사전.이동: 둘러보기, 찾기 이 문서는 니체가 쓴....</p> 
		</div>
		
		<div class="current_story_content">
			<p><strong><<현재 글>></strong></p>
			<p>메밀꽃 필 무렵. 1936년 《조광(朝光)》지에 발표. 한국 현대 단편소설의 대표작의 하나로 평가되는 작품이다. 왼손잡이요 곰보인 허생원은 재산마저 날려 장터를 돌아다니는 장돌뱅이가 된다. 그 허생원이 봉평장이 서던 날 같은 장돌뱅이인 조선달을 따라 충주집으로 간다. 그는 동이라는 애송이 장돌뱅이가 충주댁과 농탕치는 것에 화가 나서 뺨을 때려 쫓아버린다. 그러나 그날 밤 그들 셋은 달빛을 받으며 메밀꽃이 하얗게 핀 산길을 걷게 된다. 허생원은 젊었을 때 메밀꽃이 하얗게 핀 달밤에 개울가 물레방앗간에서 어떤 처녀와 밤을 새운 이야기를 한다. 동이도 그의 어머니 얘기를 한다. 자기는 아버지가 누구인지도 모르고 의붓아버지 밑에서 고생을 하다가 집을 뛰쳐나왔다는 것이다.늙은 허생원은 냇물을 건너다 발을 헛디뎌 빠지는 바람에 동이에게 업히게 되는데, 허생원은 동이 모친의 친정이 봉평이라는 사실과 동이가 자기와 똑같이 왼손잡이인 것을 알고는 착잡한 감회에 사로잡힌다. 그들은 동이 어머니가 현재 살고 있다는 제천으로 가기로 작정하고 발길을 옮긴다. 전편에 시적(詩的) 정서가 흐르는 산뜻하고도 애틋한 명작소설이다. 작가 자신은 이 작품에서 애욕(愛慾)의 신비성을 다루려 했다고 그의 〈현대적 단편소설의 상모(相貌)〉에서 밝히고 있다.</p> 
			<p>
			   <button type=button onclick="addBookmark()">책갈피</button> 
			   <button type=button onclick="writeFollowed()">이어쓰기</button> 
			   <button type=button onclick="addRecomm()">추천</button> 
			   <!--<button type=button onclick="deleteStory()">구조보기</button>-->
			</p>
		</div>
		
		<div class="current_story_content">
			<p><strong><<다음 글>></strong></p>
			<p>파우스트. 파우스트(Faust) 또는 파우스투스(Faustus;"경사로운", "행운의" 의미의 라틴어)는 고전 독일 소설의....</p> 
		</div>
		<!-- 스토리 보기 끝 -->

	</div><!-- .middle-->

</div><!-- .wrapper -->

<footer class="footer">
	<strong>Footer:</strong> Mus elit Morbi mus enim lacus at quis Nam eget morbi. Et semper urna urna non at cursus dolor vestibulum neque enim. Tellus interdum at laoreet laoreet lacinia lacinia sed Quisque justo quis. Hendrerit scelerisque lorem elit orci tempor tincidunt enim Phasellus dignissim tincidunt. Nunc vel et Sed nisl Vestibulum odio montes Aliquam volutpat pellentesque. Ut pede sagittis et quis nunc gravida porttitor ligula.
</footer><!-- .footer -->

</body>
</html>