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
<body>
<b>${cm_name}</b>
<br>
<b>${cm_cp}</b>
<div>
    <div>
        기업회원 아이디 찾기<br>
        ------------------------<br>
        ${cm_name} 담당자님이 요청하신 이메일이 ${list.size()}건 검색되었습니다

    </div>
    <table class="table">
        <tr>
            <th>이메일</th>
            <th>회사명</th>
            <th>가입일</th>
        </tr>
        <c:forEach items="${list}" var="dto">
            <tr>
                <td>
                        ${dto.cm_email}
                </td>
                <td>
                        ${dto.cm_compname}
                </td>
                <td>
                    <fmt:formatDate value="${dto.cm_date}" pattern="yyyy-MM-dd"/>
                </td>
            </tr>
        </c:forEach>
        <button type="button">로그인</button>
        <button type="button">비밀번호 찾기</button>
    </table>
</div>
</body>
</html>

