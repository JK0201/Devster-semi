<%--
  Created by IntelliJ IDEA.
  User: hyunohsmacbook
  Date: 2023/05/02
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<div class="hb_wrap clear">


    <c:forEach var="dto" items="${list}" varStatus="i">
        <div class="box" <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

            <span class="hb_writeday"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM/dd"/></span>
            <span class="hb_readcount"><div class="icon_read"></div> ${dto.hb_readcount}</span>

            <span class="hb_photo">
                <a href="../hire/hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=1">
                    <img src="http://${imageUrl}/hire/${dto.hb_photo}" id="photo">
                </a>
            </span>

            <h3 class="hb_subject">
                <a href="../hire/hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=1"><b>${dto.hb_subject}</b></a>
            </h3>


            <div class="hr_tag">
                <div class="hr_tag_1">이직시200만원</div>
                <div class="hr_tag_2">유연근무</div>
            </div>

        </div>
    </c:forEach>

</div>






