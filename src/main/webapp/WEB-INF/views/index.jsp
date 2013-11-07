<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<title>메인페이지</title>
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
	
<%
	if(null != (String)session.getAttribute("userId")) {	//로그인
%>
	$(".right_login_form").remove();
<%
	} else { //로그아웃
%>
	$(".right_readed_story").remove();
	$(".right_wrote_story").remove();	
<%	} 
%>	
		
});

// 회원가입
function joinMember() {
	$(location).attr('href',"joinForm.do");
}

// 로그인
function login() {
	//alert("Id:" + $("#login_id").val() + "\n" + "Pw:" + $('#login_pw').val());
	
	//login.do 호출하여 로그인
	var url = "login.do";
    var param = "id=" + $('#login_id').val();
    param += "&pw=" + $('#login_pw').val();

    $.ajax({
        type: "POST",
        url: url,
        data: param,
        success: function(msg) {
        	if(1 == msg) {
        		$(location).attr('href',"/");
        	} else {
        		alert("로그인 에러:(");
        		$('#login_id').focus();
        	}
       }
    });
}

// 로그아웃
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
				<p><strong><<배너>></strong></p> Sed placerat accumsan ligula. Aliquam felis magna, congue quis, tempus eu, aliquam vitae, ante. Cras neque justo, ultrices at, rhoncus a, facilisis eget, nisl. Quisque vitae pede. Nam et augue. Sed a elit. Ut vel massa. Suspendisse nibh pede, ultrices vitae, ultrices nec, mollis non, nibh. In sit amet pede quis leo vulputate hendrerit. Cras laoreet leo et justo auctor condimentum. Integer id enim. Suspendisse egestas, dui ac egestas mollis, libero orci hendrerit lacus, et malesuada lorem neque ac libero. Morbi tempor pulvinar pede. Donec vel elit.
			</main><!-- .content -->
			
			<!-- 하단 스토리 목록 시작 -->
			<div class="sub_content">
				<p><strong><<인기글 목록>></strong></p>차라투스트라는 이렇게 말했다. 위키백과, 우리 모두의 백과사전.이동: 둘러보기, 찾기 이 문서는 니체가 쓴 책에 대한 것입니다. 《차라투스트라는 이렇게 말했다》는 그 책을 원작으로 한 교향시의 제목이기도 합니다.1부의 초판 표지.《차라투스트라는 이렇게 말했다》(독일어: Also sprach Zarathustra)는 독일 철학자 프리드리히 니체가 1883~1885년의 기간동안 저술하였다. 니체의 사상이 무르익은 후기에 쓰인 것으로, 위버멘쉬(초인), 권력에의 의지, 영겁회귀 등 니체의 중심 사상을 문학적으로 풀어낸 작품이다. 문학적 비유와 상징등 언뜻 보기에는 니체의 이론적 저작들에 비해서 읽기 쉬워보이지만, 사실은 그동안의 사상들을 은유적으로 풀어놓았기 때문에 내용을 소화하기가 더 어렵다고 할 수 있다.본서의 제목에는 ‘차라투스트라’라는 말이 쓰였지만, 그 내용은 실존한 배화교 창시자 차라투스트라와는 전혀 무관하다.
			</div>
			<div class="sub_content">
				<p><strong><<에디터 선정>></strong></p>메밀꽃 필 무렵. 1936년 《조광(朝光)》지에 발표. 한국 현대 단편소설의 대표작의 하나로 평가되는 작품이다. 왼손잡이요 곰보인 허생원은 재산마저 날려 장터를 돌아다니는 장돌뱅이가 된다. 그 허생원이 봉평장이 서던 날 같은 장돌뱅이인 조선달을 따라 충주집으로 간다. 그는 동이라는 애송이 장돌뱅이가 충주댁과 농탕치는 것에 화가 나서 뺨을 때려 쫓아버린다. 그러나 그날 밤 그들 셋은 달빛을 받으며 메밀꽃이 하얗게 핀 산길을 걷게 된다. 허생원은 젊었을 때 메밀꽃이 하얗게 핀 달밤에 개울가 물레방앗간에서 어떤 처녀와 밤을 새운 이야기를 한다. 동이도 그의 어머니 얘기를 한다. 자기는 아버지가 누구인지도 모르고 의붓아버지 밑에서 고생을 하다가 집을 뛰쳐나왔다는 것이다.늙은 허생원은 냇물을 건너다 발을 헛디뎌 빠지는 바람에 동이에게 업히게 되는데, 허생원은 동이 모친의 친정이 봉평이라는 사실과 동이가 자기와 똑같이 왼손잡이인 것을 알고는 착잡한 감회에 사로잡힌다. 그들은 동이 어머니가 현재 살고 있다는 제천으로 가기로 작정하고 발길을 옮긴다. 전편에 시적(詩的) 정서가 흐르는 산뜻하고도 애틋한 명작소설이다. 작가 자신은 이 작품에서 애욕(愛慾)의 신비성을 다루려 했다고 그의 〈현대적 단편소설의 상모(相貌)〉에서 밝히고 있다. 
			</div>
			<div class="sub_content">
				<p><strong><<최신글 목록>></strong></p>파우스트. 파우스트(Faust) 또는 파우스투스(Faustus;"경사로운", "행운의" 의미의 라틴어)는 고전 독일 소설의 주인공이다. 대강의 내용은 다음과 같다. 박식한 학자 파우스트는 속세적인 지식에 만족하지 못하고, 자신의 영혼과 악마가 가진 인간의 한계를 넘어선 금지된 지식을 교환하는 계약을 하게 된다. 메피스토펠리스(Mephistopheles) 또는 메피스토로 불리는 이 악마는 계약 기간 동안 흑마술로서 파우스트의 욕심을 충족시켜주지만, 계약 기간이 끝난 후 파우스트의 영혼은 악마 메피스토의 소유가 되고, 영원히 저주받게 된다.악마 메피스토펠리우스와의 계약 기간동안 파우스트는 흑마술을 여러 방면으로 사용한다. 여러 형태의 이야기 중에는 파우스트가 아리따운 소녀 그레첸(Gretchen)을 유혹하는데. 그레첸은 수차례의 위기를 겪게 되지만 그녀의 순수함이 결국 그녀를 구하게 되고, 그녀의 영혼은 천국으로 가게된다.괴테의 파우스트[편집]이 부분의 본문은 파우스트 (괴테)입니다.독일의 시인·정치가·과학자·극작가인 요한 볼프강 폰 괴테 (Johann Wolfgang von Goethe)가 쓴 희곡 파우스트는 기존의 고전 독일 문학의 기독교적 도덕을 심화시킨다. 희곡과 장시(長詩)의 형태가 합작된 괴테의 파우스트는 서사적 서재극(書齋劇)이다.
			</div>
			<!-- 하단 스토리 목록 끝 -->
		</div><!-- .container-->

		
		<aside class="right-sidebar">
			<!-- 로그인 전 시작 -->
			<div class="right_login_form"><!-- 로그인 폼 -->
				<p><strong><<로그인폼>></strong></p> 
				<form method="post" enctype="application/x-www-form-urlencoded" action="javascript:login()">
				 <p><label>아이디: <input type=text id="login_id" pattern="^[A-Za-z]+[A-Za-z0-9]{4,19}" title="영문으로 시작하는 영문+숫자조합 아이디(5~20자리)" required></label></p>
				 <p><label>암호: <input type=password id="login_pw" pattern="[A-Za-z0-9]{5,20}" title="영문으로 시작하는 영문+숫자조합 암호(5~20자리)" required></label></p>
				 <p>
					<button type=button onclick="joinMember()">회원가입</button>
					<button>로그인</button>
				 </p>
				</form>
			</div>
			<!-- 로그인 전 끝 -->
				
			<!-- 로그인 후 시작 -->
			<div class="right_readed_story"><!-- 최근 본 글 -->
				<p><strong><<최근본글>></strong></p> 
				인간의 굴레에서. 교양소설과 대중소설을 아우르며 20세기에 가장 널리 읽힌 책!고뇌를 짊어진 한 젊은이가 인생과 사회에 눈떠 가는 과정삶을 구속하는 굴레로부터의 자유! 문학적 전통으로 볼 때 이 소설은.... 
			</div>
			<div class="right_wrote_story"><!-- 내가 쓴 글 -->
				<p><strong><<내가쓴글>></strong></p> 
				‘교양소설Bildungsroman’ 계열에 든다. 교양소설이란 젊은이가 인생과 사회에 눈떠 가는 과정을 그린 소설이다. 교양소설로서의 『인간의 굴레에서』가 가진 독특한 점은, 작가 스스로 밝혔듯이, 늘 특출한 사람보다 보통사람...
			</div>
			<!-- 로그인 후 시작 -->
		</aside><!-- .right-sidebar -->
	
	</div><!-- .middle-->

</div><!-- .wrapper -->

<footer class="footer">
	<strong>Footer:</strong> Mus elit Morbi mus enim lacus at quis Nam eget morbi. Et semper urna urna non at cursus dolor vestibulum neque enim. Tellus interdum at laoreet laoreet lacinia lacinia sed Quisque justo quis. Hendrerit scelerisque lorem elit orci tempor tincidunt enim Phasellus dignissim tincidunt. Nunc vel et Sed nisl Vestibulum odio montes Aliquam volutpat pellentesque. Ut pede sagittis et quis nunc gravida porttitor ligula.
</footer><!-- .footer -->

</body>
</html>