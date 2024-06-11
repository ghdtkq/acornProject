<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- reset.css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/reset.css">
<!-- tourDetail.css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/tourDetail.css">
<title>관광세부정보</title>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var addr1Element = document.querySelector('.tour-addr');
    var addr1 = addr1Element.textContent.trim();
    var shortAddr1 = "";

    if (addr1.startsWith("전라") || addr1.startsWith("경상") || addr1.startsWith("충정")) {
        shortAddr1 = addr1.charAt(0) + addr1.charAt(2);
    } else {
        shortAddr1 = addr1.substring(0, 2); 
    }

    addr1Element.textContent = shortAddr1;
});
</script>
<style>
@charset "UTF-8";

.container {
    width: 1100px;
    margin: 0 auto;
    margin-top: 75px;
}

.tour-addr {
	color: #5c5c5c;
	font-weight: bold;
}


.tour-details-info {
    width: 80%;
    margin: 0 auto;
    padding-top: 30px;
    padding-bottom: 30px;
}

.tour-details-info ul {
    display: flex;
    flex-wrap: wrap;
    list-style: none;
    padding: 0;
    margin: 0;
}

.tour-details-info ul li {
    width: 50%;
    display: flex;
    margin-bottom: 10px;
}

.tour-details-info ul li strong {
    width: 80px;
    font-weight: bold;
}

.tour-details-info ul li span {
    flex: 1;
}
.tour-description {
	position: relative;
}
.tour-description-content {
	max-height: 297px;
	overflow-y: hidden;
}
.show-more-button {
	position: absolute;
	z-index: 99;
	bottom: 0;
	right: 0;
	cursor: pointer;
	font-weight: bold;
}

</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="../nav.jsp"%>
		<div class="container tour-detail">
			<div class="tour-info">
				<div class="tour-addr">${tourInfo[0].addr1}</div>
				<div class="tour-title">${tourInfo[0].title}</div>
				<!-- <div class="tour-date"></div>  -->
			</div>
			<div class="tour-details">
				<div class="tour-details-img">
					<img src="${tourInfo[0].firstimage}" alt="${tourInfo[0].title}">
				</div>
			</div>
			<div class="tour-description">
				<h3>상세정보</h3>
				<c:if test="${not empty tourInfo[0].overview}">
				    <div class="tour-description-content">
				        <p><!-- 내용:  -->${tourInfo[0].overview}</p>
				    </div>
				    <div class="show-more-button">더보기 +</div>
				</c:if>
				
  				<button id="toggle-button" style="display: none;">더보기</button>
			</div>
			<div class="tour-map-custom">
				<h3>지도</h3>
				<div class="tour-map" id="map"></div>
				<script type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5a8047e3c30bd5760407dbe6654a7338"></script>
				<script>
                var container = document.getElementById('map');
                var options = {
                    center: new kakao.maps.LatLng(${tourInfo[0].mapy}, ${tourInfo[0].mapx}),
                    level: 3
                };
                var map = new kakao.maps.Map(container, options);
                </script>
			</div>
			<div class="tour-details-info">
				<ul>
					<c:if test="${not empty tourInfo[0].title}">
						<li><strong>제목</strong> <span>${tourInfo[0].title}</span></li>
					</c:if>
					<c:if test="${not empty tourInfo[0].addr1}">
						<li><strong>주소</strong> <span>${tourInfo[0].addr1}${tourInfo[0].addr2}</span></li>
					</c:if>
					<c:if test="${not empty tourInfo[0].tel}">
						<li><strong>전화번호</strong> <span>${tourInfo[0].tel}</span></li>
					</c:if>
					<c:if test="${not empty tourInfo[0].homepage}">
						<li><strong>홈페이지</strong> <span>${tourInfo[0].homepage}</span></li>
					</c:if>
					<c:if test="${not empty tourInfo2[0].expguide}">
						<li><strong>체험안내</strong> <span>${tourInfo2[0].expguide}</span></li>
					</c:if>
					<c:if test="${not empty tourInfo2[0].infocenter}">
						<li><strong>문의 및 안내</strong> <span>${tourInfo2[0].infocenter}</span></li>
					</c:if>
					<c:if test="${not empty tourInfo2[0].restdate}">
						<li><strong>휴무일</strong> <span>${tourInfo2[0].restdate}</span></li>
					</c:if>
					<c:if test="${not empty tourInfo2[0].parking}">
						<li><strong>주차정보</strong> <span>${tourInfo2[0].parking}</span></li>
					</c:if>
				</ul>
			</div>
			<div class="tour-btn">
				<button onclick="history.back()">뒤로가기</button>
			</div>
		</div>
		<%@ include file="../footer-sub.jsp"%>
	</div>
	
	<script type="text/javascript">
    const content = document.querySelector('.tour-description-content');
    const button = document.querySelector('.show-more-button');
    
    
    function a() {    	
    	button.addEventListener('click', function() {
    		
    	    let contentH = content.clientHeight;
    	    
    	    if (contentH < 298) {
                content.style.maxHeight = '100%';
                button.textContent = "숨기기 -";
                
                //alert("T : " + contentH);
            } else {
                content.style.maxHeight = '297px';
                button.textContent = "더보기 +";

                //alert("F : " + contentH);
            }
    	});
    	
    	/*
        if (contentH >= 297) {
            alert("넘어요");

            button.addEventListener('click', function() {
                if (contentH < 298) {
                    content.style.maxHeight = '100%';
                    button.textContent = "숨기기";
                    
                    alert("T : " + contentH);
                } else {
                    content.style.maxHeight = '300px';
                    button.textContent = "더보기";

                    alert("F : " + contentH);
                }
            });
        } else {
            alert("안넘어요");
            button.style.display = 'none';
        }
    	*/
    }
    

    a();
    	
    	
    	

	</script>
</body>
</html>
