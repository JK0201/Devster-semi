<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        #menu {
            float: left;
            width: 20%;
        }
        #main {
            float: left;
            width: 80%;
        }
        #name {
            font-size: larger;
        }

        #menu ul li {
            cursor: pointer;
        }

        #menu ul li:hover {
            color: #8007ad;
        }
    </style>
</head>
<body>
<div id="menu">
    <c:choose>
        <c:when test="${sessionScope.cmidx != null || sessionScope.memidx == null}">
        <div id="name">${sessionScope.cmname} 님</div>
            <ul>
                <li onclick="">나의 정보</li>
                <hr/>
                <li onclick="">계정 설정</li>
                <li onclick="">계정 탈퇴</li>
                <hr/>
                <li onclick="">구직자 이력서 보기</li>
            </ul>
        </div>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${sessionScope.memstate == 1}">
                    <div id="name">${sessionScope.memnick} 님</div>
                    <ul>
                        <li onclick="">나의 정보</li>
                        <li onclick="">채용정보 스크랩</li>
                        <li onclick="">내 이력서</li>
                        <hr/>
                        <li onclick="">계정 설정</li>
                        <li onclick="">계정 탈퇴</li>
                        <hr/>
                    </ul>
                    </div>
                </c:when>
                <c:when test="${sessionScope.memstate == 100}">
                    <div id="name">관리자 님</div>
                    <ul>
                        <li onclick="">공지사항 리스트</li>
                        <li onclick="">일반 회원 가입 승인</li>
                        <li onclick="">기업 회원 가입 승인</li>
                    </ul>
                    </div>
                </c:when>
            </c:choose>
        </c:otherwise>
    </c:choose>
<div id="main">
    <h1>메인 컨텐츠 입니다.</h1>
</div>
</body>
</html>