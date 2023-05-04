<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="fb_wrap">

    <!-- Slideshow container -->
    <div id="slideShow"> <!-- 메인슬라이드이미지 -->
        <div class="slide">
            <ul>
                <li class="i1"><a href="#"><img class="slide" src="/photo/slide_banner_01.jpg" alt="image 1"></a></li>
                <li class="i2"><a href="#"><img class="slide" src="/photo/slide_banner_02.jpg" alt="image 2"></a></li>
                <li class="i3"><a href="#"><img class="slide" src="/photo/slide_banner_03.png" alt="image 3"></a></li>
            </ul>
        </div>

        <%--<div class="slide_btn">
            <ul>
                <li class="indent active">m1</li>
                <li class="indent">m2</li>
                <li class="indent">m3</li>
                <li class="indent">m4</li>
            </ul>
        </div>--%>

        <div class="side_btn">
            <div class="pre indent"> prev </div>
            <div class="nex indent"> next </div>
        </div>

    </div>


    <table class="freeboard_table">
        <caption align="top"><h1>Free Board</h1></caption>

        <thead>
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>조회</th>
            <th>좋아요</th>
            <th>싫어요</th>
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
                    <td>${dto.fb_idx}번</td>

                    <td>${dto.nickName}</td>

                    <td>
                        <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}" style="color: #000;">
                                ${dto.fb_subject}
                            <c:if test="${dto.fb_photo!='no'}">
                                &nbsp; <i class="bi bi-images"></i>
                            </c:if>
                        </a>
                    </td>

                    <td>${dto.fb_readcount}</td>

                    <td>${dto.fb_like}</td>

                    <td>${dto.fb_dislike}</td>

                    <td>${dto.fb_writeday}</td>
                </tr>

            </c:forEach>
        </c:if>
        </tbody>
        <tfoot>
        <tr>
            <td>총 ${totalCount}개의 게시글
                <button type="button" onclick="location.href='./freewriteform'">글쓰기</button>
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
        <script>


        </script>



















