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
        <c:if test="${sessionScope.memnick == null && sessionScope.cmname != null}">
            <c:choose>
                <c:when test="${sessionScope.cmname ne tmp.send_nick}">
                    <!--받은 메세지 -->
                    <div class="incoming_msg">
                        <div class="incoming_msg_img">
                                <img src="http://${imageUrl}/member/${tmp.m_photo}" width="50px">
                        </div>

                        <div class="received_msg">
                            <div class="received_withd_msg">
                                <pre>${tmp.content}</pre>
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
                            <pre>${tmp.content}</pre>
                            <span class="time_date">${tmp.send_time}</span>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
        <c:if test="${sessionScope.memnick != null && sessionScope.cmname == null}">
            <c:choose>
                <c:when test="${sessionScope.memnick ne tmp.send_nick}">
                    <!--받은 메세지 -->
                    <div class="incoming_msg">
                        <div class="incoming_msg_img">
                                <img src="http://${imageUrl}/member/${tmp.m_photo}" width="50px">
                        </div>
                        &nbsp;
                        <div class="received_msg">
                            <div class="received_withd_msg">
                                <pre>${tmp.content}</pre>
                            </div>
                            <span class="time_date">${tmp.send_time}</span>
                        </div>

                    </div>
                </c:when>
                <c:otherwise>
                    <%--<img src="http://${imageUrl}/member/${tmp.m_photo}" width="50px">--%>
                    <!-- 보낸 메세지 -->
                    <div class="outgoing_msg">
                        <div class="sent_msg">
                            <pre>${tmp.content}</pre>
                            <span class="time_date">${tmp.send_time}</span>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
    <%--    <img src="http://${imageUrl}/member/${tmp.m_photo}" width="50px">--%>
</c:forEach>













