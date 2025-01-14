<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags/MainMapTags"%>
<%@ taglib prefix="hel" tagdir="/WEB-INF/tags/help"%>
<%@ taglib prefix="bot" tagdir="/WEB-INF/tags/botnav"%>
<%@ taglib prefix="main" tagdir="/WEB-INF/tags/main"%>
<%@ taglib prefix="map" tagdir="/WEB-INF/tags/MainMapTags" %>
<%@ taglib prefix="ga" tagdir="/WEB-INF/tags" %>


<!DOCTYPE html>  
<html>
<head>

<link href="${appRoot }/resources/favicon/brand_logo.png" rel="shortcut icon" type="image/x-icon">

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-204320906-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-204320906-1');
</script>

<%@ include file = "/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Main</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bangers&family=Nanum+Brush+Script&display=swap" rel="stylesheet">

<style type="text/css">
@font-face {
	font-family: 'GongGothicMedium';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

@font-face {
    font-family: 'BinggraeSamanco-Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/BinggraeSamanco-Bold.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

body {
	font-family: 'GongGothicMedium';
}

.button1 {
	background-color: #169EF2;
	border: none;
	color: white;
	padding: 16px 32px;
	text-align: center;
	font-size: 18px;
	margin: 4px 2px;
	opacity: 1;
	transition: 0.3s;
	display: inline-block;
	text-decoration: none;
	cursor: pointer;
	-webkit-border-radius: 40px;
	-moz-border-radius: 40px;
	border-radius: 40px;
	width: 200px;
	font-family: 'GongGothicMedium';
}

.button1:hover {
	background: #0583F2;
}
/*사용자 리뷰 관련 박스 */
#reviewbox {
	box-shadow: 5px 3px 30px gray;
	border: 3px solid white;
	-webkit-border-radius: 40px;
	-moz-border-radius: 40px;
	border-radius: 60px;
	height: 600px;
	width: 1110px;
}
#review_card1 {
	margin-top: 30px;
}

/*구독 관련 정보 박스 */
#subsinfo_box {
	box-shadow: 5px 3px 30px gray;
	border: 3px solid white;
	border-radius: 10%;
	margin-top: 3%;
	height: 1200px;
	width: 1110px;
}
/* 서비스 관련 정보 박스 */
#service_box {
	box-shadow: 5px 3px 30px gray;
	border: 3px solid white;
	border-radius: 10%;
	margin-top: 3%;
	height: 1700px;
	width: 1110px;
}
/* 세탁방 위치 관련 정보 박스 */
#location {
	box-shadow: 5px 3px 30px gray;
	border: 3px solid white;
	-webkit-border-radius: 40px;
	-moz-border-radius: 40px;
	border-radius: 60px;
	margin-top: 3%;
	height: 500px;
	width: 1110px;
}

#go-review, #subscribe-btn1, #subscribe-btn2 {
	padding: 5px;
	background-color: transparent;
	border: none;
	outline: none;
}

.connection {
	width: 20px;
	padding: 5px;
}

</style>


<!-- Tawk.to 실시간 채팅 -->
<script type="text/javascript">
var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
(function(){
var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
s1.async=true;
s1.src='https://embed.tawk.to/6034acd39c4f165d47c618a9/1ev6sa12g';
s1.charset='UTF-8';
s1.setAttribute('crossorigin','*');
s0.parentNode.insertBefore(s1,s0);
})(); 
</script>



<!-- 구독 신청 버튼 권한 부여 -->
<script type="text/javascript">
$(function(){
	let loginID = "${pinfo.member.userid}";
	$.ajax({
		type: "POST",
		url: "${appRoot}/member/getLoginInfo",
		data: {
			userid : loginID
		},
		success: function(data) {
			
			let confirmID = data;
			console.log(confirmID);
			if(confirmID == "") {
				$("#main-subscribe").show();
				$("#main-subscribe").click(function() {
				location.href = "${appRoot}/subscribe/subsregister";
				})
			} 		
		},
		error : function() {
			console.log("실패")
		}
	})
})
</script>
<!-- 블랙리스트 회원에게 뜨는 안내창 -->
<script type="text/javascript">
	$(function() {
		let loginid = "${pinfo.member.userid}";
		$.ajax({
			type: "GET",
			url: "${appRoot}/member/getMemberAuth",
			data: {
				userid : loginid
			},
			success: function(data) {
				
				let blackAuth = data;
				console.log(blackAuth);
				if(blackAuth == "ROLE_BLACK") {
					$("#alert1").text("당신은 블랙리스트로 지정되었습니다. 이의가 있을 경우 1:1 문의를 통해 접수해주세요.").addClass("show");
				} else {
					console.log("일반유저")
				}
			}
		});
	});
</script>


</head>
<body>
	<main:navbar></main:navbar>
<div class = "container">


		<div class="row justify-content-center  mt-5 mb-5">


			<!-- 브랜드 로고 이미지 -->
			<div class="row justify-content-center">
				<a href="${appRoot }/member/main"> 
					<img src="${appRoot }/resources/image/others/brand_logo_500px.png" alt="...">
				</a>
			</div>

		</div>



	
	<div id="alert1" class="alert alert-danger fade" role="alert"> </div>
	</div>
	
	<hr style="border: 5px solid #E3F6FF">
	
	<div class="container">
	
	<br>
	
	<script type="text/javascript">
	$(function() {
		$.ajax({
			type : "get",
			url : "${appRoot}/review/getgetget1",
			success : function(data) {
				if (data != "") {
					$("#1-1").text(data.payCount +'개월 연속 구독중인 "' + data.reWriterName + '" 님의 리뷰');
					$("#1-2").text(data.reContent);
					$("#1-3").attr("href", "${appRoot }/review/get?reBno=" + data.reBno + "&pageNum=1&amount=10&type=&keyword=&sort=100");

				} else if (data == "") {
					$("#1-1").text("이상합니다!");
					$("#1-2").text("이상합니다!");
					$("#1-3").attr("href", "${appRoot }/member/main");
					
				}

			},
			error : function() {
				console.log("Hot Review 불러오기 실패");
			}

		});
		
	});
	$(function() {
		$.ajax({
			type : "get",
			url : "${appRoot}/review/getgetget2",
			success : function(data) {
				if (data != "") {
					$("#2-1").text('가장 많은 추천을 받은 "' + data.reWriterName +'" 님의 리뷰');
					$("#2-2").text(data.reContent);
					$("#2-3").attr("href", "${appRoot }/review/get?reBno=" + data.reBno + "&pageNum=1&amount=10&type=&keyword=&sort=100");

				} else if (data == "") {
					$("#2-1").text("이상합니다!");
					$("#2-2").text("이상합니다!");
					$("#2-3").attr("href", "${appRoot }/member/main");
					
				}

			},
			error : function() {
				console.log("Hot Review 불러오기 실패");
			}

		});
		
	});
	</script>
	
	<!-- 메인 - HOT REVIEW -->
	<div id="reviewbox1">
		
		<h1 class="text-center mt-4" style="color:#0583F2; padding-bottom: 10px; font-size: 80px; font-family: 'Bangers', cursive;">HOT REVIEW</h1>
		
		<div id="" class="card-group mt-4">
 			<div class="card ml-3 mr-3" style="box-shadow: 5px 3px 30px gray;
											   border: 3px solid white; -webkit-border-radius: 40px; -moz-border-radius: 40px;">
    			<div class="card-body">
      				<h5 id="1-1" class="card-title"></h5>
      				<p id="1-2" class="card-text"></p>
      				<p class="card-text"><small class="text-muted"><a id="1-3" href="">더보기 >>></a></small></p>
    			</div>
  			</div>
		</div>
		
		<div id="review_card2" class="card-group mt-4">
 			<div class="card ml-3 mr-3" style="box-shadow: 5px 3px 30px gray;
											   border: 3px solid white; -webkit-border-radius: 40px; -moz-border-radius: 40px;">
    			<div class="card-body">
      				<h5 id="2-1" class="card-title"></h5>
      				<p id="2-2" class="card-text"></p>
      				<p class="card-text"><small class="text-muted"><a id="2-3" href="">더보기 >>></a></small></p>
    			</div>
  			</div>
		</div>
		
		<br> 
		
		<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_EMPUSER', 'ROLE_ADMIN') or isAnonymous()">
			<div class="row justify-content-center mt-3 mb-3">
	 		<a href="${appRoot }/review/list?sort=200">
	 			<button id="go-review" type="button" class="btn btn-primary"
				data-toggle="modal" data-target="#staticBackdrop2">
				<img alt="goreview" src="${appRoot }/resources/image/main/goreview.png">
				</button>
			 </a>
			</div>
		</sec:authorize>
	</div>
	
	<br>
	<!-- 구독시스템 정보 박스 -->
	<div id="subsinfo_box">
		
		<h1 class="text-center mt-4" style="color:#0583F2; padding-bottom: 10px; font-size: 80px; font-family: 'Bangers', cursive;">How To Subscribe?</h1>
		
		<div class="container">
 		        
 		        <div class="row justify-content-center mt-3 mb-3">
 					<img alt="" src="${appRoot }/resources/image/main/signup.png">			
 				</div>
    			<div class="text-center mg-4">
      				첫번째, 빨래널자의 서비스를 구독합니다. 
    			</div>
    			
    			<div class="row justify-content-center">
	    			<img class="connection" alt="" src="${appRoot }/resources/image/main/화살표2.png">
    			</div>
    			
    			<div class="row justify-content-center mt-3 mb-3">
 					<img alt="" src="${appRoot }/resources/image/main/put.png">			
 				</div>
    			<div class="text-center mg-4">
      				두번째, 구독이 완료되면 회원님의 구독 스케줄에 따라 지정된 장소에 세탁물을 보관합니다.
    			</div>
    			
    			<div class="row justify-content-center">
	    			<img class="connection" alt="" src="${appRoot }/resources/image/main/화살표2.png">
    			</div>
    			
 				<div class="row justify-content-center mt-3 mb-3">
 					<img alt="" src="${appRoot }/resources/image/main/shipping2.jpg">			
 				</div>
    			<div class="text-center mg-4">
    				세번째, 구독 스케줄에 따라서 세탁물의 수거 및 반납이 반복됩니다. 
    			</div>
    		
 				
 				<div class="row justify-content-center">
	    			<img class="connection" alt="" src="${appRoot }/resources/image/main/화살표2.png">
    			</div>
 				
 				<div class="row justify-content-center mt-3 mb-3">
 					<img alt="" src="${appRoot }/resources/image/main/laundry.png">			
 				</div>
    			<div class="text-center mg-4">
      				매일 매일 새 옷을 입는 것 같은 행복한 일상이 시작됩니다. <br> 세탁으로 인한 피로함이 없는 새로운 일상을 시작해보시겠습니까?
    			</div>
  			
		</div>
		
	</div>
	
	<!-- 구독 혜택 안내 박스 -->
	<div id="service_box">
		<div class="text-center mt-4" style="color:#0583F2; padding-bottom: 10px; font-size: 80px; font-family: 'Bangers', cursive;">Why Special?</div>
		<small class="row justify-content-center mt-4">빨래로부터의 해방감을 느껴보세요!</small>
		
				<div class="container">
 		        
    			<h4 class="text-center mt-5">
      				1. AI를 활용한 맞춤형 세탁! 보기 싫은 때, 지지 않는 얼룩? 걱정마세요!
    			</h4>
 		        <div class="row justify-content-center mt-5">
 					<img alt="" src="${appRoot }/resources/image/main/AI.jpg">			
 				</div>
    			
    			
    			
    			<h4 class="text-center mt-5">
      				2. 빨래널자 만의 위생관리 시스템으로 소중한 내 옷을 더욱 깨끗하게!
    			</h4>
    			<div class="row justify-content-center mt-5">
 					<img alt="" src="${appRoot }/resources/image/main/위생.jpg">			
 				</div>
    			
    			
    			
    			<h4 class="text-center mt-4">
    				3. 빨래 접기에 드는 시간이 아까우신가요? 빨래는 모두 이쁘게 그리고 각지게 접어서 보내드립니다! 
    			</h4>
 				<div class="row justify-content-center mt-5">
 					<img alt="" src="${appRoot }/resources/image/main/빨래 접기.jpg">			
 				</div>
    		
  			
		</div>
		
	</div>
	
	<!-- 로그인한 계정이 잇을 경우에만 자신의 위치정보를 기반으로 세탁방 정보가 나오도록 설정 -->
	<sec:authorize access="hasRole('ROLE_USER')">
		<div id="location">
			<h1 class="text-center mt-4">지금 내 주변에 있는 빨래널자의 세탁방은?</h1>
		  <div class="row justify-content-center">
			<map:MainMapTags></map:MainMapTags>
		  </div>
		
		</div>
	</sec:authorize>
	
	<br>
	
	<!-- 구독하기 버튼이 구독하지 않은 일반유저와 블랙 유저에게만 보이도록 함. -->
		<div class="row justify-content-center fixed-bottom ">
			<sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_BLACK')">
						<a id="main-subscribe" style="display:none; background-color: ##0583F2;">
							<button id="subscribe-btn1" class="btn btn-primary btn-lg btn-block">
								<img alt="goreview" src="${appRoot }/resources/image/main/subscribebtn.png">
							</button>
						</a>
			</sec:authorize>
	<!-- 구독하기 버튼이 방문자에게도 보이지만 이를 누르면 로그인창으로 이동되도록 함. -->	
			<sec:authorize access="isAnonymous()">
				<a class="mb-3 mt-5" id="main-subscribe2" style="background-color: ##0583F2; " href="${appRoot}/member/login">
				<button id="subscribe-btn2" class="btn btn-primary btn-lg btn-block">
					<img alt="goreview" src="${appRoot }/resources/image/main/subscribebtn.png">
				</button>
				</a>
			</sec:authorize>
		</div>
		
		

	<bot:botnav></bot:botnav>

</div>
</body>
</html>