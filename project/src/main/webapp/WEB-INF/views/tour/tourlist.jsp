<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관광</title>
<link rel="stylesheet" type="text/css"

    href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css"
    href="${pageContext.request.contextPath}/resources/css/tourlist.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.filter-keep-btn:hover,
.filter-keep-btn.hovered {
    color: white;
    background-color: #E78181;
}
.filter-keep-btn.clicked {
    color: white;
    background-color: #E78181;
</style>
</head>
<body>
    <div class="wrap">
        <%@ include file="../nav.jsp"%>
        <div class="container">
            <div class="side-container">
                <div class="side">
                    <div class="side-name">지역</div>
                    <div class="local-box">
                        <div class="area filter-keep-btn" data-area="1">서울</div>
                        <div class="area filter-keep-btn" data-area="2">인천</div>
                        <div class="area filter-keep-btn" data-area="3">대전</div>
                        <div class="area filter-keep-btn" data-area="4">대구</div>
                        <div class="area filter-keep-btn" data-area="31">경기</div>
                        <div class="area filter-keep-btn" data-area="6">부산</div>
                        <div class="area filter-keep-btn" data-area="7">울산</div>
                        <div class="area filter-keep-btn" data-area="5">광주</div>
                        <div class="area filter-keep-btn" data-area="32">강원</div>
                        <div class="area filter-keep-btn" data-area="33">충북</div>
                        <div class="area filter-keep-btn" data-area="34">충남</div>
                        <div class="area filter-keep-btn" data-area="35">경북</div>
                        <div class="area filter-keep-btn" data-area="36">경남</div>
                        <div class="area filter-keep-btn" data-area="37">전북</div>
                        <div class="area filter-keep-btn" data-area="38">전남</div>
                        <div class="area filter-keep-btn" data-area="39">제주</div>
                        <div class="area filter-keep-btn" data-area="8">세종</div>
                    </div>

                    <div class="filter-btn-box sort-options">
                       <div class="filter-reset-btn filter-keep-btn arrange-option" data-arrange="S">거리순</div>
                       <div class="filter-reset-btn filter-keep-btn arrange-option" data-arrange="Q">최신순</div>
                   </div>
                </div>
            </div>
            <div class="section">
                <div class="section-name">
                    # 관광지
                    <hr>
                </div>     

                <div class="content-box">
                    <c:forEach var="item" items="${tourList}">
                        <div class="content" data-contentid="${item.contentid}"
                            data-contenttypeid="${item.contenttypeid}">
                            <div class="content-img">
                                <img src="${item.firstimage}">
                            </div>
                            <div class="content-info">
                                <div class="info-name">${item.title}</div>
                                <div class="info-local">${item.addr1}</div>
                                <div class="info-dist">${item.dist}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="more-btn-box">
                    <c:if test="${currentPage > 1}">
                        <a
                            href="${pageContext.request.contextPath}/tourlist?pageNo=${currentPage - 1}&area=${selectedArea}&arrange=${selectedArrange}&mapX=${mapX}&mapY=${mapY}"
                            class="prev">이전</a>
                    </c:if>
                    <c:if test="${currentPage < totalPages}">
                        <a
                            href="${pageContext.request.contextPath}/tourlist?pageNo=${currentPage + 1}&area=${selectedArea}&arrange=${selectedArrange}&mapX=${mapX}&mapY=${mapY}"
                            class="next">다음</a>
                    </c:if>
                </div>

                <!-- 페이지 번호 표시 -->
                <div class="page-number-box">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="current-page">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a
                                    href="${pageContext.request.contextPath}/tourlist?pageNo=${i}&area=${selectedArea}&arrange=${selectedArrange}&mapX=${mapX}&mapY=${mapY}"
                                    class="page-number">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>

            </div>
        </div>

        
         <%@ include file="../footer-sub.jsp" %>
    </div>
    
<script>
$(document).ready(function() {
    // 페이지 로드 시 저장된 클릭 상태 복구
    var clickedButton = localStorage.getItem("clickedButton");
    var clickedArea = localStorage.getItem("clickedArea");
    
    if (clickedButton) {
        $(".filter-keep-btn").removeClass("clicked");
        $(".filter-keep-btn[data-arrange='" + clickedButton + "']").addClass("clicked");
    }

    if (clickedArea) {
        $(".filter-keep-btn").removeClass("clicked");
        $(".filter-keep-btn[data-area='" + clickedArea + "']").addClass("clicked");
    }

    // 거리 정보 표시 및 거리순 정렬 유지
    function displayDistanceAndSort() {
        $('.content').each(function() {
            var distElement = $(this).find('.info-dist');
            var distanceText = distElement.text().trim();
            
            // 거리가 NaN이면 숨기기
            if (isNaN(parseFloat(distanceText))) {
                distElement.addClass('hidden');
            } else {
                var distanceInKm = parseFloat(distanceText);
                var roundedDistance = Math.round(distanceInKm) / 1000; // km 단위로 변환
                
                // 거리가 0보다 크면 보이기
                if (roundedDistance > 0) {
                    distElement.removeClass('hidden');
                    distElement.text(roundedDistance.toFixed(1) + ' km');
                } else {
                    distElement.addClass('hidden');
                }
            }
        });
    }

    // 페이지 로드 시 거리 정보 표시
    displayDistanceAndSort();

    // 거리순 정렬 버튼 클릭 시 동작
    $(".arrange-option").click(function() {
        var arrange = $(this).data("arrange");
        if (arrange === "S") {
            navigator.geolocation.getCurrentPosition(function(position) {
                var mapX = position.coords.longitude;
                var mapY = position.coords.latitude;
                var url = "${pageContext.request.contextPath}/tourlist?pageNo=1&arrange=S&mapX=" + mapX + "&mapY=" + mapY;
                window.location.href = url;
            });
        } else if (arrange === "Q") {
            var area = "${selectedArea}";
            var url = "${pageContext.request.contextPath}/tourlist?pageNo=1&arrange=Q&area=" + area;
            window.location.href = url;
        }
    });

    // 초기화 버튼 클릭 이벤트 핸들러
    $("#resetBtn").click(function() {
        $(".arrange-option").removeClass("clicked");
        $(".filter-keep-btn").removeClass("clicked");
        localStorage.removeItem("clickedButton"); // 클릭 상태 초기화
        localStorage.removeItem("clickedArea"); // 클릭 상태 초기화
        window.location.href = "${pageContext.request.contextPath}/tourlist";
    });

    // filter-reset-btn에 대한 클릭 이벤트 핸들러
    $(".filter-keep-btn").click(function() {
        // 이전에 선택된 버튼의 스타일 제거
        $(".filter-keep-btn").removeClass("clicked");
        
        // 클릭한 버튼에 스타일 추가
        $(this).addClass("clicked");
        
        // localStorage에 클릭한 버튼 저장
        var clickedButton = $(this).data("arrange");
        var clickedArea = $(this).data("area");
        
        if (clickedButton) {
            localStorage.setItem("clickedButton", clickedButton);
            localStorage.removeItem("clickedArea");
        }
        
        if (clickedArea) {
            localStorage.setItem("clickedArea", clickedArea);
            localStorage.removeItem("clickedButton");
        }
    });

    // filter-reset-btn에 대한 호버 이벤트 핸들러
    $(".filter-keep-btn").hover(function() {
        $(this).addClass("hovered");
    }, function() {
        $(this).removeClass("hovered");
    });

    $(".area").click(function() {
        var area = $(this).data("area");
        var arrange = $(".arrange-option.selected").data("arrange");
        var url = "${pageContext.request.contextPath}/tourlist?pageNo=1&arrange=" + arrange + "&area=" + area;
        window.location.href = url;
    });

    // 관광지 정보 클릭 이벤트 핸들러
    $(".content").click(function() {
        var contentId = $(this).data("contentid");
        var contentTypeId = $(this).data("contenttypeid");
        window.location.href = "${pageContext.request.contextPath}/tourlist/tourInfo?contentId=" + contentId + "&contentTypeId=" + contentTypeId;
    });
});

        
var areaBtns = document.querySelectorAll('.area');
var monthBtns = document.querySelectorAll('.month');
var resetBtn = document.querySelector('.filter-reset-btn');

var previousAreaBtn = null;
var previousMonthBtn = null;
       
function areaBtnEvent() {
    this.classList.add('clickEvent');
    
    // 중복 클릭 방지
    if (previousAreaBtn && previousAreaBtn !== this) {
        previousAreaBtn.classList.remove('clickEvent');
    }

    previousAreaBtn = this;
}
       
function monthBtnEvent() {
    this.classList.add('clickEvent');

    //중복 클릭 방지
    if (previousMonthBtn && previousMonthBtn !== this) {
        previousMonthBtn.classList.remove('clickEvent');
    }

    previousMonthBtn = this;

}

function resetBtnEvent() {
   areaBtns.forEach(function(btn) {
        btn.classList.remove('clickEvent');
    });

    monthBtns.forEach(function(btn) {
        btn.classList.remove('clickEvent');
    });

    previousAreaBtn = null;
    previousMonthBtn = null;
}

areaBtns.forEach(function(btn) {
    btn.addEventListener("click", areaBtnEvent);
});
monthBtns.forEach(function(btn) {
    btn.addEventListener("click", monthBtnEvent);
});

resetBtn.addEventListener("click", resetBtnEvent);

</script>

</body>
</html>
