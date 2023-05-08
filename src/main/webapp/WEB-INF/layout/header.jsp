<%--
  Created by IntelliJ IDEA.
  User: JuminManeul
  Date: 2023-05-02
  Time: 오후 4:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="root" value="<%=request.getContextPath()%>" />

<div class="black_bar"></div>
<div class="wrap clear">
    <div class="logo">
        <a href="${root}/"> <img src="/photo/logo.png" class="logotext">
            <span><img src="/photo/logoimage.png" class="logoimage"></span>
        </a>
    </div>
    <ul class="clear gnb">
        <li><a href="${root}/" class="selected">홈</a></li>
        <li><a href="${root}/freeboard/list">일반게시판</a></li>
        <li><a href="${root}/qboard/list">질문게시판</a></li>
        <li><a href="${root}/hire/list">채용정보</a></li>
        <li><a href="${root}/guest/list">학원별게시판</a></li>
        <li><a href="${root}/contact">회사후기</a></li>
    </ul>

    <ul class="clear util_menu">
        <li><button type="button" class="btn btnsignup" onclick="location.href='member/signup'">회원가입</button></li>
        <li><button type="button" class="btn btnsignin" onclick="location.href='member/signin'">로그인</button></li>
    </ul>
</div>
<%--</body>
</html>--%>
