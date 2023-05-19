
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="root" value="<%=request.getContextPath()%>" />


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        .outline {
            width: 400px;
        }

        #name {
            font-size: larger;
        }

        .outline ul li {
            cursor: pointer;
        }

        .outline ul li:hover {
            color: #8007ad;
        }
    </style>
</head>

<c:set var="root" value="<%=request.getContextPath()%>"/>
<body>
<div class="outline">
    <input type="hidden" >
<c:choose>
    <c:when test="${sessionScope.cmidx != null && sessionScope.memidx == null}">
        <h2 id="name">${sessionScope.cmname} 님</h2>
        <ul>
            <li><a href="/mypage/">나의 정보</a></li>
            <li><a href="/mypage/updateuserform">계정 설정</a></li>
            <li><a href="/mypage/deleteuserform">계정 탈퇴</a></li>
            <hr/>
            <li ><a href="/mypage/relist">구직자 이력서 보기</a></li>
            <hr/>
            <li><a href="/mypage/list">공지사항</a></li>

        </ul>
        </div>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${sessionScope.memstate == 1}">
                <h2 id="name">${sessionScope.memnick} 님</h2>
                <ul>
                    <li><a href="/mypage/">나의 정보</a></li>
                    <li><a href="/mypage/bookmark">채용정보 북마크</a></li>
                    <c:set var="m_idx"  value="${sessionScope.memidx}"/>
                    <li><a href="/mypage/detail?m_idx=${m_idx}">내 이력서</a></li>
                    <hr/>
                    <li><a href="/mypage/updateuserform">계정 설정</a></li>
                    <li><a href="/mypage/deleteuserform">계정 탈퇴</a></li>
                    <hr/>
                    <li><a href="/mypage/list">공지사항</a></li>

                </ul>
                </div>
            </c:when>
            <c:when test="${sessionScope.memstate == 100}">
                <h2 id="name">관리자 님</h2>
                <ul>
                    <li><a href="/mypage/list">공지사항</a></li>
                    <li><a href="/mypage/approvelist?iscomp=0">일반 회원 가입 승인</a></li>
                    <li><a href="/mypage/approvelist?iscomp=1">기업 회원 가입 승인</a></li>
                </ul>
                </div>
            </c:when>
            <c:when test="${sessionScope.memstate == 0}">
                <h2 id="name">${sessionScope.memnick} 님</h2>
                <ul>
                    <li><a href="/mypage/">학원 인증 사진 업로드</a></li>
                    <li><a href="/mypage/deleteuserform">계정 탈퇴</a></li>
                </ul>
                </div>
            </c:when>
        </c:choose>
    </c:otherwise>
</c:choose>
</div>
</body>
</html>
