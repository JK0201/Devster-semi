<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .noticeboard_table{
        border-bottom-style: none;
    }

    .noticeboard_table thead {
        background-color: #e3e3e3;
        font-size: 15px;
    }
    .noticeboard_table tfoot {
        font-size: 15px;
        font-weight: bold;
    }
    .page{

        text-align: center;
        font-size: 16px;
        background-color: white;
        color: grey;

    }

</style>


<div class="nb_wrap">

    <table class="noticeboard_table table">
        <!--=============================================================================-->
        <caption align="top">
            <h4 class="boardname" style="font-weight: bold; color: black; margin-bottom: 20px">
             <div class="yellowbar">&nbsp;</div>&nbsp;&nbsp;Devster 공지사항
            </h4>
        </caption>

        <!--=============================================================================-->

        <thead>
        <tr>
           <%-- <th width="50">번호</th>--%>
            <th width="600">제목</th>
            <th width="80">조회</th>
            <th width="130">작성일</th>
        </tr>
        </thead>

        <tbody>
        <c:if test="${totalCount==0}">
            <h2>등록된 게시글이 없습니다..</h2>
        </c:if>

        <c:if test="${totalCount>0}">
            <c:forEach var="dto" items="${list}">
                <tr>

                  <%--  &lt;%&ndash;번호&ndash;%&gt;
                    <td>${dto.nb_idx}번</td>--%>

                    <%--제목--%>
                    <td>
                        <a href="noticeboarddetail?nb_idx=${dto.nb_idx}&currentPage=${currentPage}"
                           style="color: #000;">
                                ${dto.nb_subject}
                            <c:if test="${dto.nb_photo!='n'}">
                                &nbsp; <i class="bi bi-images"></i>
                            </c:if>
                        </a>
                    </td>

                    <%--조회수--%>
                    <td>${dto.nb_readcount}</td>

                    <%--작성일--%>
                    <td>${dto.nb_writeday}</td>
                </tr>

            </c:forEach>
        </c:if>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="5" style="background-color: #e3e3e3;">
                <b>▪&nbsp;총 ${totalCount}개의 게시글</b>
            </td>
        </tr>
        <tr>
            <td colspan="5" style="border-bottom-width:0px">
                <!-- 페이징 처리 -->
                <div class="page">
                <!-- 이전 -->
                <c:if test="${startPage>1}">
                <a style="font-size:17px; font-weight: bold; color: black; text-decoration: none; cursor: pointer;"
                   href="list?currentPage=${startPage-1 }">&nbsp;이전&nbsp;</a>
                </c:if>

                <!-- 페이지번호출력 -->
                <c:forEach var="pp" begin="${startPage }" end="${endPage }">

                <c:if test="${currentPage == pp }">
                <a style="color: #3366CC; text-decoration: none; cursor: pointer; font-weight: bold;"
                   href="list?currentPage=${pp }">&nbsp;${pp}&nbsp;</a>
                </c:if>
                <c:if test="${currentPage != pp }">
                <a style="color: black; text-decoration: none; cursor: pointer; font-weight: bold;"
                   href="list?currentPage=${pp }">&nbsp;${pp}&nbsp;</a>
                </c:if>
                </c:forEach>

                <!-- 다음 -->
                <c:if test="${endPage<totalPage}">
                <a style="font-size:17px; font-weight: bold; color: black; text-decoration: none; cursor: pointer;"
                   href="list?currentPage=${endPage+1 }">&nbsp;다음&nbsp;</a>
                </c:if>
</div>
            </td>
        </tr>
        </tfoot>
    </table>

    <c:if test="${sessionScope.memstate == 100}">
        <button id="myWriteBtn" type="button" onclick="location.href='/noticeboard/noticewriteform'">글쓰기</button>
    </c:if>




</div>