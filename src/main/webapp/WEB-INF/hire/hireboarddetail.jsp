<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>



<%--로그인 : ${sessionScope.logstat}--%>
<%--<br>--%>
<%--m_idx : ${sessionScope.memidx}--%>
<%--<br>--%>
<%--nickname : ${sessionScope.memnick}--%>
<%--<br>--%>
<%--state : ${sessionScope.memstate}--%>
<%--<br>--%>
<%--ai_idx : ${sessionScope.acaidx}--%>

<div class="hb_detail_wrap">

    <div class="article_view_head">
        <p>회사후기</p>
        <div class="show_tag">
            <span class="tag_dday">마감</span>
            <span class="">경력무관</span>
        </div>

    </div>

    <div>
        제목 : ${dto.hb_subject}<br>
        내용 : ${dto.hb_content}<br>
        작성자 (hb_idx) : ${dto.hb_idx}<br>
        조회수: ${dto.hb_readcount}<br>
        작성일 : <fmt:formatDate value="${dto.fb_writeday}" pattern="yyyy.MM.dd"/><br>


        <%--    <c:if test="${dto.hb_photo!='no'}">--%>
        <%--        사진 주소 : ${dto.hb_photo}--%>
        <c:forEach items="${list}" var="images">
            <img src="http://${imageUrl}/hire/${images}" style="float: left">
            <br style="clear: both;"><br>
        </c:forEach>
        <%--    </c:if><br><hr>--%>
    </div>
    <div>
        <%--    <c:if test="${sessionScope.memdix==dto.hb_idx}">--%>
        <button type="button" class="btn btn-sm btn-outline-success"
                onclick="location.href='./hireupdateform?hb_idx=${dto.hb_idx}&currentPage=${currentPage}'">수정
        </button>
        <button type="button" class="btn btn-sm btn-outline-success" onclick="del(${dto.hb_idx})">삭제</button>
        <%--    </c:if>--%>
        <button type="button" class="btn btn-sm btn-outline-success"
                onclick="location.href='./list?currentPage=${currentPage}'">목록
        </button>
    </div>
</div>


<script>
    function del(hb_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "./hireboarddelete?hb_idx=" + hb_idx
        }
    }
</script>


