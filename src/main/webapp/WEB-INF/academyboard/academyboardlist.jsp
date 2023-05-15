<%--
  Created by IntelliJ IDEA.
  User: hyunohsmacbook
  Date: 2023/05/12
  Time: 1:52 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../commonvar.jsp" %>
<html>
<head>
    <style>
        .academyboard_table{
            font-family: 'Gowun Batang';
            margin-left: 30px;
            margin-top: 30px;
            width: 100%;
        }
        #dtocontainer{
            font-family: 'Gowun Batang';
            width: 100%;
        }
        caption *{
            font-family: 'Hahmlet';
        }

        #idxbox{
            font-size: 13px;
            color: gray;
        }
        #subjectbox{
            font-size: 18px;
            font-weight: bold;
        }


        #namebox{
            font-size: 13px;
            font-weight: bold;
        }
        img{
            width: 100px;
        }

        #writedaybox{
            font-size: 14px;
            color: gray;
            float: right;
        }
        #etcbox{
            font-size: 14px;
            color: gray;
        }



        .memberimg{
            width: 23px;
            height: 23px;
            border-radius: 100px;
        }

    </style>

    <script>
        function timeForToday(value) {
            const valueConv = value.slice(0, -2);
            const today = new Date();
            const timeValue = new Date(valueConv);

            const betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
            if (betweenTime < 1) return '방금전';
            if (betweenTime < 60) {
                return `\${betweenTime}분전`;
            }

            const betweenTimeHour = Math.floor(betweenTime / 60);
            if (betweenTimeHour < 24) {
                return `\${betweenTimeHour}시간전`;
            }

            const betweenTimeDay = Math.floor(betweenTime / 60 / 24);
            if (betweenTimeDay < 7) {
                return `\${betweenTimeDay}일전`;
            }

            const month = String(timeValue.getMonth() + 1).padStart(2, '0');
            const day = String(timeValue.getDate()).padStart(2, '0');
            const formattedDate = `\${month}-\${day}`;

            return `\${formattedDate}`;
        }

    </script>
</head>
<body>

    <table class="academyboard_table table table-bordered">
        <caption align="top"><h2> ${sessionScope.memacademy}게시판
            <button class="btn btn-secondary btn-sm" type="button" style="float: right;" onclick="location.href='./academywriteform'">글쓰기</button>
        </h2>
        </caption>

<%--        <tr>--%>
<%--            <td class="alert alert-outline-secondary">총 ${totalCount}개의 게시글--%>
<%--            </td>--%>
<%--        </tr>--%>
        <tr>

<%--        <c:if test="${totalCount==0}">--%>
<%--            <h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>--%>
<%--        </c:if>--%>
        <c:if test="${totalCount>0}">
            <c:forEach var="dto" items="${list}" varStatus="i">
            <c:if test="${dto.ai_idx==sessionScope.acaidx}">
            <td>
                <table id="dtocontainer">
                    <tr>
                        <td id="idxbox">no. ${dto.ab_idx}</td>
                    </tr>
                    <tr>
                        <td id="subjectbox">
                            <a href="academyboarddetail?ab_idx=${dto.ab_idx}&currentPage=${currentPage}" style="color: #000;">${dto.ab_subject}</a></td>
                    </tr>

                    <c:if test="${dto.ab_photo=='n'}">
                        &nbsp;<tr style="height: 130px;">
                        <td style="width: 100%">
                            <a href="academyboarddetail?ab_idx=${dto.ab_idx}&currentPage=${currentPage}" style="color: #000;">
                                <span >

                                    <c:set var="length" value="${fn:length(dto.ab_content)}"/>
                                    ${fn:substring(dto.ab_content, 0, 130)}

                                    <c:if test="${length>=130}">
                                        .....
                                    </c:if>

                                   </span></a>

                        </td></tr>
                    </c:if>
                    <c:if test="${dto.ab_photo!='n'}">
                        &nbsp;<tr style="height: 130px;">
                        <td style="width: 80%">
                            <a href="academyboarddetail?ab_idx=${dto.ab_idx}&currentPage=${currentPage}" style="color: #000;">
                                    <span>

                                    <c:set var="length" value="${fn:length(dto.ab_content)}"/>
                                    ${fn:substring(dto.ab_content, 0, 90)}

                                    <c:if test="${length>=90}">
                                        .....
                                    </c:if>

                                   </span></a>
                        </td>

                        <td style="width: 20%">
                                <span id="imgbox">

                                        <img src="http://${imageUrl}/academyboard/${dto.ab_photo}" style="width: 70%; border: 1px solid lightgray; margin-right: 5px;">


                                </span>
                        </td>
                        </tr>
                    </c:if>

                    <tr>
                        <td id="namebox">
                            <img src="http://${imageUrl}/member/${dto.m_photo}" class="memberimg">&nbsp; ${dto.nickName}
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b id="etcbox">
                                <i class="bi bi-eye"></i>&nbsp;조회&nbsp;${dto.ab_readcount}&nbsp;
                                <i class="bi bi-hand-thumbs-up"></i>&nbsp;좋아요&nbsp;${dto.ab_like}&nbsp;&nbsp;
                                <i class="bi bi-hand-thumbs-down"></i>&nbsp;싫어요&nbsp;${dto.ab_dislike}&nbsp;
<%--                                <i class="bi bi-chat-right"></i>&nbsp;댓글&nbsp;${dto.commentCnt}--%>
                            </b>

                            <p id="writedaybox">
                                <span id="writeday-${dto.ab_idx}"></span>
                            </p>
                            <script>
                                var writedayElement = document.getElementById("writeday-${dto.ab_idx}");
                                var formattedWriteday = timeForToday("${dto.ab_writeday}");
                                writedayElement.textContent = formattedWriteday;
                            </script>

                        </td>
                    </tr>
                </table>
            </td>

            <c:if test="${i.index % 1 == 0}"></tr><tr></c:if>
        </c:if>

        </c:forEach>
        </c:if>
    </tr>





    </table>


    <!-- 페이징 처리 -->
    <div style="width:700px; text-align: center; font-size: 20px; background-color: rgba(255, 255, 255, 0.6)">
        <!-- 이전 -->
        <c:if test="${startPage>1}">
            <a style="font-size:17px; font-weight: bold; color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${startPage-1 }">&nbsp;이전&nbsp;</a>
        </c:if>

        <!-- 페이지번호출력 -->
        <c:forEach var="pp" begin="${startPage }" end="${endPage }">

            <c:if test="${currentPage == pp }">
                <a style="color: #3366CC; text-decoration: none; cursor: pointer; font-weight: bold;" href="list?currentPage=${pp }">&nbsp;${pp}&nbsp;</a>
            </c:if>
            <c:if test="${currentPage != pp }">
                <a style="color: black; text-decoration: none; cursor: pointer; font-weight: bold;" href="list?currentPage=${pp }">&nbsp;${pp}&nbsp;</a>
            </c:if>

        </c:forEach>

        <!-- 다음 -->
        <c:if test="${endPage<totalPage}">
            <a style="font-size:17px; font-weight: bold; color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${endPage+1 }">&nbsp;다음&nbsp;</a>
        </c:if>
    </div>


</body>
</html>
