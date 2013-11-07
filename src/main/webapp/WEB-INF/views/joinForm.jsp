<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<title>회원가입</title>
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

// 아이디 중복체크
function checkDuplId() {
	//alert("Check Duplicated ID:" + $("#join_id").val());
	
    var url = "checkDuplUserId.do";
    var postString = "join_id=" + $('#join_id').val();

    $.ajax({
        type: "POST",
        url: url,
        data: postString,
        success: function(msg) {
        	if(1 == msg) {
        		alert("사용할 수 없는 아이디입니다.");
        		$('#join_id').val("");
        		$('#join_id').focus();
        	} else {
        		alert("사용가능한 아이디입니다.");
        		$('#join_pw').focus();
        	}
       }
    });
}

// 필명 중복체크
function checkDuplAuthorName() {
	//alert("Check Duplicated Authorname:" + $("#join_authorname").val());
	
	var url = "checkDuplAuthor.do";
    var postString = "join_authorname=" + $('#join_authorname').val();

    $.ajax({
        type: "POST",
        url: url,
        data: postString,
        success: function(msg) {
        	if(1 == msg) {
        		alert("사용할 수 없는 필명입니다.");
        		$('#join_authorname').val("");
        		$('#join_authorname').focus();
        	} else {
        		alert("사용가능한 필명입니다.");
        	}
       }
    });
}

// 회원가입
function join() {
	//alert("Id:" + $("#join_id").val() + "\nPw:" + $('#join_pw').val() + "\nAuthorname:" + $('#join_authorname').val());
	
	var url = "join.do";
    var param = "join_id=" + $('#join_id').val();
    param += "&join_pw=" + $('#join_pw').val();
    param += "&join_author=" + $('#join_authorname').val();

    $.ajax({
        type: "POST",
        url: url,
        data: param,
        success: function(msg) {
        	if(1 == msg) {
        		alert("스토리벤치에 오신걸 환영합니다:)");
        		$(location).attr('href',"/");
        	} else {
        		alert("가입에러:(");
        	}
       }
    });
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
				<p><strong><<배너>></strong></p> Sed placerat accumsan ligula. Aliquam felis magna, congue quis, tempus eu, aliquam vitae, ante. Cras neque justo, ultrices at, rhoncus a, facilisis eget, nisl. Quisque vitae pede. Nam et augue. Sed a elit. Ut vel massa. Suspendisse nibh pede, ultrices vitae, ultrices nec, mollis non, nibh. In sit amet pede quis leo vulputate hendrerit. Cras laoreet leo et justo auctor condimentum. Integer id enim. Suspendisse egestas, dui ac egestas mollis, libero orci hendrerit lacus, et malesuada lorem neque ac libero. Morbi tempor pulvinar pede. Donec vel elit.
			</main><!-- .content -->
		</div><!-- .container-->
		
		<!-- 회원가입 폼 시작 -->
		<div class="join_content">
			<p><strong><<회원가입 폼>></strong></p>
				<form method="post" enctype="application/x-www-form-urlencoded" action="javascript:join()">
				 <p><label>아이디: <input id="join_id" pattern="^[A-Za-z]+[A-Za-z0-9]{4,19}" title="영문으로 시작하는 영문+숫자조합 아이디(5~20자리)" required></label> &nbsp <button type=button onclick="checkDuplId()">중복체크</button></p>
				 <p><label>암호: <input type=password id="join_pw" pattern="[A-Za-z0-9]{5,20}" title="영문으로 시작하는 영문+숫자조합 암호(5~20자리)" required></label></p>
				 <p><label>필명: <input id="join_authorname" pattern="{1,20}" title="필명(1~20자리)" required></label> &nbsp <button type=button onclick="checkDuplAuthorName()">중복체크</button></p>
				 <p><button>가입하기</button><p>
				</form>
			
		</div>
		<!-- 회원가입 폼 끝 -->

	</div><!-- .middle-->

</div><!-- .wrapper -->

<footer class="footer">
	<strong>Footer:</strong> Mus elit Morbi mus enim lacus at quis Nam eget morbi. Et semper urna urna non at cursus dolor vestibulum neque enim. Tellus interdum at laoreet laoreet lacinia lacinia sed Quisque justo quis. Hendrerit scelerisque lorem elit orci tempor tincidunt enim Phasellus dignissim tincidunt. Nunc vel et Sed nisl Vestibulum odio montes Aliquam volutpat pellentesque. Ut pede sagittis et quis nunc gravida porttitor ligula.
</footer><!-- .footer -->

</body>
</html>