<%--
  Created by IntelliJ IDEA.
  User: JuminManeul
  Date: 2023-05-11
  Time: 오후 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<%--<c:forEach var="tmp" items="${list}">

</c:forEach>--%>

<c:forEach var="tmp" items="${list}">
    <div class="chat_list_box${tmp.room} chat_list_box">
        <div type="button" class="chat_list" room="${tmp.room}" other-nick="${tmp.other_nick}">
            <!-- active-chat -->
            <div class="chat_people clear">
                <div class="chat_img">
                    <a href="other_profile.do?other_nick=${tmp.other_nick}">
                        <img src="http://${imageUrl}/member/${tmp.profile}" width="50px">
                    </a>
                </div>

                <div class="chat_ib clear">
                    <h5>${tmp.other_nick}</h5>
                    <div class="chat_date">${tmp.send_time}</div>
                </div>
                <div class="row">
                    <div class="col-10">
                        <p>${tmp.content}</p>
                    </div>
                    <!--만약 현재 사용자가 안읽은 메세지 갯수가 0보다 클 때만 뱃지를 표시한다. -->
                    <c:if test="${tmp.unread > 0}">
                        <div class="col-2 unread${tmp.room}">
                            <span class="badge bg-danger">${tmp.unread}</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

</c:forEach>
