<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<script>
    let photos ='';
</script>

<div class="hb_wrap clear">


    <c:forEach var="dto" items="${list}" varStatus="i">
        <div class="box" <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

            <span class="hb_writeday"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM/dd"/></span>
            <span class="hb_readcount"><div class="icon_read"></div> ${dto.hb_readcount}</span>

            <span class="hb_photo">
                <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}">
                    <script>
                        photos = '${dto.hb_photo}'.split(',');
                        $("#photo${dto.hb_idx}").attr("src",`http://${imageUrl}/hire/${photos[0]}`);
                    </script>
                    <img src="" id="photo${dto.hb_idx}">
                </a>
            </span>

            <h3 class="hb_subject">
                <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}"><b>${dto.hb_subject}</b></a>
            </h3>


            <div class="hr_tag">
                <div class="hr_tag_1">이직시200만원</div>
                <div class="hr_tag_2">유연근무</div>
            </div>

        </div>
        <%-- <c:if test="${i.count%2==0}">
             <br style="clear: both;"><br>
         </c:if>--%>
    </c:forEach>

</div>

<div class="paginate">
    <!-- 이전 -->
    <c:if test="${startPage > 1}">
        <a style="color: black; text-decoration: none; cursor: pointer;"
           href="list?currentPage=${startPage-1}"><div class="icon_pre"></div></a>
    </c:if>
    <c:if test="${startPage <= 1}">
        <a style="color: black; text-decoration: none; cursor: pointer;
        visibility: hidden;" href="list?currentPage=${startPage-1}"><div class="icon_pre"></div></a>
    </c:if>
    <!-- 페이지 번호 출력 -->
    <c:forEach var="pp" begin="${startPage}" end="${endPage}">
        <c:if test="${currentPage == pp }">
            <a style="color: green; text-decoration: none; cursor: pointer;" href="list?currentPage=${pp}">${pp}</a>
        </c:if>
        <c:if test="${currentPage != pp }">
            <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${pp}">${pp}</a>
        </c:if>
        &nbsp;
    </c:forEach>
    <!-- 다음 -->
    <c:if test="${endPage < totalPage}">
       <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${endPage+1}"><div class="icon_next"></div></a>
    </c:if>
    <c:if test="${endPage >= totalPage}">
       <a style="color: black; text-decoration: none; cursor: pointer;
        visibility: hidden;" href="list?currentPage=${endPage+1}"><div class="icon_next"></div></a>
    </c:if>


</div>

<button type="button" class="btn btn-sm btn-outline-success hb_write_btn"
        onclick="location.href='form'" style="margin-bottom: 10px">글쓰기
</button>






