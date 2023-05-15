<%--
  Created by IntelliJ IDEA.
  User: JuminManeul
  Date: 2023-05-11
  Time: 오후 5:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<c:forEach var="tmp" items="${clist}">
    <c:choose>
        <c:when test="${sessionScope.memnick ne tmp.send_nick}">
        <!--받은 메세지 -->
            <div class="incoming_msg">

                <div class="incoming_msg_img">
                    <a href="other_profile.do?other_nick=${tmp.send_nick}">
                        <img src="http://${imageUrl}/member/${tmp.m_photo}" width="50px">
                    </a>
                </div>

                <div class="received_msg">
                    <div class="received_withd_msg">
                        <p>${tmp.content}</p>
                        <span class="time_date">${tmp.send_time}</span>
                    </div>
                </div>

            </div>
        </c:when>

        <c:otherwise>
            <%--<img src="http://${imageUrl}/member/${tmp.m_photo}" width="50px">--%>
            <!-- 보낸 메세지 -->
            <div class="outgoing_msg">
                <div class="sent_msg">
                    <p>${tmp.content}</p>
                    <span class="time_date">${tmp.send_time}</span>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
<%--    <img src="http://${imageUrl}/member/${tmp.m_photo}" width="50px">--%>
</c:forEach>













