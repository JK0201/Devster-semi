
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="wrap">
    <div class="searchdiv">
        <input name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off" value="" class="searchbar">
        <i class="bi bi-search"></i>
    </div>


    <div class="maincontent">
        <table class="freeboard_table">
            <caption align="top" class="clear">

                <h2><img src="/photo/ico-best.png">일반게시판</h2>
            </caption>



            <tbody>
            <c:if test="${totalCount==0}">
                <h2>등록된 게시글이 없습니다..</h2>
            </c:if>

            <c:if test="${totalCount>0}">
                <c:forEach var="dto" items="${list}">
                    <tr>
                            <%-- <td>${dto.fb_idx}번</td>

                             <td>${dto.m_idx}(번호)</td>--%>

                        <td class="fb_subject">
                            <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}"
                               style="color: #000;">
                                    ${dto.fb_subject}
                                <c:if test="${dto.fb_photo!=''}">
                                    &nbsp; <i class="bi bi-images"></i>
                                </c:if>
                            </a>
                        </td>

                        <td class="fb_readcount"><i class="bi bi-eye"></i>${dto.fb_readcount}</td>

                        <td class="fb_like"><i class="bi bi-hand-thumbs-up"></i>${dto.fb_like}</td>

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
    </div>
</div>

