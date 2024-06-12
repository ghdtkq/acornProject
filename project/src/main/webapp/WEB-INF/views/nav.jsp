<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<!-- index.css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css" >


<style>

/***************
****** nav *****
****************/
nav {
    width: 100%;
    height: 75px;
    background-color: white;
    box-shadow: 2px 5px 5px lightgray;
}
.nav-container {
    position: relative;
    width: 95%;
    height: 100%;
    margin: 0 auto;
    padding-top: 10px;

    display: flex;
    justify-content: space-between;
}
.nav-icon {
    width: 150px;
    height: 50px;
}
.nav-icon img {
   width: 150px;
    height: 50px;
}
.nav-menu ul {
    display: flex;
    line-height: 50px;
}
.nav-menu ul li {
    padding: 0 2vw;
}
.nav-menu ul li a {
    font-size: 84%;
    font-weight: bold;
}
.nav-proflie-text {
    width: 180px;
    height: 50px;
    text-align: center; 
    line-height: 50px;  
}
.nav-proflie-text a {
    font-size: 14px;
    margin: 0px 10px;
}
</style>
</head>
<body>

   <!-- nav -->
   <nav>
       <div class="nav-container">
           <div class="nav-icon">
              <a href="/project/">
                  <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="logo-icon">  
               </a>
           </div>
           <div class="nav-menu">
                    <ul>
                        <li><a href="/project/tourlist">관광지</a></li>
                        <li><a href="/project/eventlist">축제/행사</a></li>
                        <li><a href="/project/board/route">경로게시판</a></li>
                        <li><a href="/project/board/free?type=-1">자유게시판</a></li>
                        <li><a href="/project/board/faq">고객센터</a></li>
                    </ul>
                </div> 
          <div class="nav-proflie">
               <div class="nav-proflie-text">
                   <c:if test="${empty sessionScope.user}">
                      <a href="/project/user/login.do">로그인 / 회원가입</a>
                   </c:if>
                   <c:if test="${not empty sessionScope.user}">
                      <a href="/project/user/logout.do">로그아웃</a>
                      <a href="/project/user/mypage.do">마이페이지</a>
                   </c:if>
                    </div>
           </div>
       </div>
   </nav>
</body>
</html>