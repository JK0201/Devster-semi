<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<div>
    번호 : ${dto.nb_idx} <br>
    제목 : ${dto.nb_subject}<br>
    내용 : ${dto.nb_content}<br>
    작성자 : ${nickname}<br>
    조회: ${dto.nb_readcount}<br>
    작성일 :  <fmt:formatDate value="${dto.nb_writeday}" pattern="yyyy.MM.dd"/><br>

    <c:forEach items="${list}" var="images">
        <c:if test="${images!='n'}">
        <img src="http://${imageUrl}/noticeboard/${images}" style="float: left">
        </c:if>
    </c:forEach>

    <br><hr>

</div>

<div>
    <button type="button" onclick="location.href='noticeupdateform?nb_idx=${dto.nb_idx}&currentPage=${currentPage}'">수정</button>
    <button type="button" onclick="del(${dto.nb_idx})">삭제</button>
    <button type="button" onclick="location.href='./list?currentPage=${currentPage}'">목록</button>
</div>

<script>
    function del(nb_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "./noticedelete?nb_idx=" + nb_idx;
        }
    }
</script>