<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
    </style>
</head>
<script>
    $(function () {
        if ($("#m_name").val() == "" || $("#m_tele").val() == "") {
            location.replace("signin");
        }
    });
</script>
<body>
<input type="hidden" name="m_name" id="m_name" value="${m_name}">
<input type="hidden" name="m_name" id="m_tele" value="${m_tele}">
<b>${m_name}</b>
<br>
<b>${m_tele}</b>
<div>
    <div>
        개인회원 아이디 찾기<br>
        ------------------------<br>
        ${m_name}님의 이메일이 ${list.size()}건 검색되었습니다

    </div>
    <table class="table">
        <tr>
            <th>이메일</th>
            <th>가입일</th>
            <th>소셜계정 연동 정보</th>
        </tr>
        <c:forEach items="${list}" var="dto">
            <tr>
                <td>
                        ${dto.m_email}
                </td>
                <td>
                    <fmt:formatDate value="${dto.m_date}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
                    <c:if test="${dto.m_type==1}">
                        O
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <button type="button">로그인</button>
        <button type="button">비밀번호 찾기</button>

        <button type="button">간편로그인아이디찾기></button>
    </table>
</div>
</body>
</html>

