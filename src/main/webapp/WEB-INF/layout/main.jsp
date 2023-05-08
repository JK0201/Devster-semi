<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="wrap clear">
    <div class="container">
        <div class="searchdiv">
            <input name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off" value=""
                   class="searchbar">
            <i class="bi bi-search"></i>
        </div>


        <div class="maincontent clear">

            <!-- ========================= 일반게시판 ===========================-->
            <table class="freeboard_table">
                <caption align="top" class="clear">

                    <h2>
                        <img src="/photo/ico-best.png">일반게시판
                        <span><a href="freeboard/list" class="btn-more">더보기<i
                                class="bi bi-chevron-right"></i></a></span>
                    </h2>

                </caption>


                <tbody>
                <c:if test="${totalCount==0}">
                    <h2>등록된 게시글이 없습니다..</h2>
                </c:if>

                <c:if test="${totalCount>0}">
                    <c:forEach var="dto" items="${fblist}">
                        <tr>
                                <%-- <td>${dto.fb_idx}번</td>

                                 <td>${dto.m_idx}(번호)</td>--%>

                            <td class="fb_subject clear">
                                <a href="freeboard/freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}"
                                   style="color: #000;">
                                        ${dto.fb_subject}
                                    <c:if test="${dto.fb_photo!=''}">
                                        &nbsp; <%--<i class="bi bi-images"></i>--%>
                                        <div class="icon_img"><img></div>
                                    </c:if>
                                </a>
                            </td>
                            <td class="fb_readcount clear">
                                <div class="icon_read"><img></div>
                                <span>${dto.fb_readcount}</span>
                            </td>

                            <td class="fb_like">
                                <div class="icon_like"><img></div>
                                <span>${dto.fb_like}</span>
                            </td>

                                <%--   <td>${dto.fb_dislike}</td>

                                   <td>
                                       <fmt:formatDate value="${dto.fb_writeday}" pattern="yyyy.MM.dd"/>
                                   </td>--%>
                        </tr>

                    </c:forEach>
                </c:if>
                </tbody>
                <%--<tfoot>
                <tr>
                    <td>총 ${totalCount}개의 게시글
                        <button type="button" onclick="location.href='./freewriteform'">글쓰기</button>
                    </td>
                </tr>
                </tfoot>--%>
            </table>

            <!-- ==================================== 질문게시판 =================================-->

            <table class="qboard_table">

                <caption align="top" class="clear">
                    <h2>
                        <img src="/photo/ico-best.png">질문게시판
                        <span><a href="qboard/list" class="btn-more">더보기<i class="bi bi-chevron-right"></i></a></span>
                    </h2>
                </caption>

                <tbody>
                <c:if test="${totalCount == 0}">
                    <h2>등록된 게시글이 없습니다..</h2>
                </c:if>

                <c:if test="${totalCount>0}">
                    <c:forEach var="dto" items="${qblist}">
                        <tr>
                            <td class="qb_subject clear">
                                <a href="qboard/detail?qb_idx=${dto.qb_idx}&currentPage=${currentPage}"
                                   style="color: #000;">
                                        ${dto.qb_subject}
                                    <c:if test="${dto.qb_photo!=''}">
                                        &nbsp; <%--<i class="bi bi-images"></i>--%>
                                        <div class="icon_img"><img></div>
                                    </c:if>
                                </a>
                            </td>


                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>

            <!-- ========================= 채용정보 게시판 ===========================-->

            <table class="hireboard_table">
                <caption align="top" class="clear">

                    <h2>
                        <img src="/photo/ico-best.png">채용정보
                        <span><a href="hire/list" class="btn-more">더보기<i class="bi bi-chevron-right"></i></a></span>
                    </h2>

                </caption>


                <tbody>
                <c:if test="${totalCount==0}">
                    <h2>등록된 게시글이 없습니다..</h2>
                </c:if>

                <c:if test="${totalCount>0}">
                    <c:forEach var="dto" items="${hirelist}">
                        <tr>
                            <td class="hb_subject clear">
                                <a href="hire/hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}"
                                   style="color: #000;">
                                        ${dto.hb_subject}
                                    <c:if test="${dto.hb_photo!=''}">
                                        &nbsp; <%--<i class="bi bi-images"></i>--%>
                                        <div class="icon_img"><img></div>
                                    </c:if>
                                </a>
                            </td>

                            <td class="hb_readcount clear">
                                <div class="icon_read"><img></div>
                                <span>${dto.hb_readcount}</span>
                            </td>
                        </tr>

                    </c:forEach>
                </c:if>
                </tbody>
            </table>

        </div>
    </div>
    <!--=========================================aside=====================================-->
    <div class="aside">
        <div class="aside_content_1">
            <img src="photo/aside_banner_1.png">
        </div>
        <div class="aside_content_2">
            <img src="photo/aside_banner_2.png">
        </div>

    </div>

</div>
