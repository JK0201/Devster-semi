<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="root" value="<%=request.getContextPath()%>"/>


<style>
    .mypage_wrap {
        width: 1140px;
        margin: 0 auto;
    }

    .mypage_wrap .mypage_aside{
        width: 200px;
        float: left;
    }

    .mypage_aside h2#name{
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 40px;
        color: #222;
    }

    .mypage_aside ul li{
        font-size: 15px;
        color: #222;
        margin-bottom: 24px;
        cursor: pointer;
        font-weight: 400;
    }

    .mypage_aside ul li a.selected{
        font-weight: bold;
    }



</style>


<c:set var="root" value="<%=request.getContextPath()%>"/>


    <div class="mypage_aside">
    <input type="hidden">


        <c:choose>
            <c:when test="${sessionScope.cmidx != null && sessionScope.memidx == null}">
                <h2 id="name">${sessionScope.cmname}님</h2>
                <ul>
                    <li><a href="/mypage/" class="selected">회사 정보</a></li>
                    <li><a href="/mypage/updateuserform">계정 설정</a></li>
                    <li><a href="/mypage/deleteuserform">계정 탈퇴</a></li>
                    <hr/>
                    <li><a href="/mypage/relist">구직자 이력서 보기</a></li>
                    <hr/>
                    <li><a href="/mypage/list">공지사항</a></li>

                </ul>

            </c:when>

            <c:otherwise>
                <c:choose>
                    <c:when test="${sessionScope.memstate == 1}">
                        <h2 id="name">${sessionScope.memnick} 님</h2>
                        <ul>
                            <li><a href="/mypage/" class="selected">나의 정보</a></li>
                            <li><a href="/mypage/bookmark">채용정보 북마크</a></li>
                            <c:set var="m_idx" value="${sessionScope.memidx}"/>
                            <li><a href="/mypage/detail?m_idx=${m_idx}">내 이력서</a></li>
                            <hr/>
                            <li><a href="/mypage/updateuserform">계정 설정</a></li>
                            <li><a href="/mypage/deleteuserform">계정 탈퇴</a></li>
                            <hr/>
                            <li><a href="/mypage/list">공지사항</a></li>

                        </ul>

                    </c:when>

                    <c:when test="${sessionScope.memstate == 100}">
                        <h2 id="name">관리자 님</h2>
                        <ul>
                            <li><a href="/mypage/list" class="selected">공지사항 등록</a></li>
                            <li><a href="/mypage/approvelist?iscomp=0">일반 회원 가입 승인</a></li>
                            <li><a href="/mypage/approvelist?iscomp=1">기업 회원 가입 승인</a></li>
                        </ul>

                    </c:when>

                    <c:when test="${sessionScope.memstate == 0}">
                        <h2 id="name">${sessionScope.memnick} 님</h2>
                        <ul>
                            <li><a href="/mypage/" class="selected">학원 인증 받기</a></li>
                            <li><a href="/mypage/deleteuserform">계정 탈퇴</a></li>
                        </ul>

                    </c:when>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll(".mypage_aside ul li a");

        navLinks.forEach((link) => {
            if (link.getAttribute("href") === currentPath) {
                link.classList.add("selected");
            } else {
                link.classList.remove("selected");
            }
        });
    });

</script>


