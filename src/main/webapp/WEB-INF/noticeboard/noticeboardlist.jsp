<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="nb_wrap">

    <table class="noticeboard_table">
        <caption align="top"><h1>Notice Board</h1></caption>

        <thead>
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>조회</th>
            <th>작성일</th>
        </tr>
        </thead>

        <tbody>
        <c:if test="${totalCount==0}">
            <h2>등록된 게시글이 없습니다..</h2>
        </c:if>

        <c:if test="${totalCount>0}">
            <c:forEach var="dto" items="${list}">
                <tr>

                    <td>${dto.nb_idx}번</td>

                    <td>${dto.nickName}</td>

                    <td>
                        <a href="noticeboarddetail?nb_idx=${dto.nb_idx}&currentPage=${currentPage}"
                           style="color: #000;">
                                ${dto.nb_subject}
                            <c:if test="${dto.nb_photo!='n'}">
                                &nbsp; <i class="bi bi-images"></i>
                            </c:if>
                        </a>
                    </td>

                    <td>${dto.nb_readcount}</td>

                    <td>${dto.nb_writeday}</td>
                </tr>

            </c:forEach>
        </c:if>
        </tbody>
        <tfoot>
        <tr>
            <td>총 ${totalCount}개의 게시글
                <button type="button" onclick="location.href='./noticewriteform'">글쓰기</button>
            </td>
        </tr>
        </tfoot>
    </table>

    <!-- 페이징 처리 -->
    <div style="width:700px; text-align: center; font-size: 20px; background-color: rgba(255, 255, 255, 0.6)">
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
</div>