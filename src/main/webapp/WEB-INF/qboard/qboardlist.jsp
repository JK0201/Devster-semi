<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script>
    $(document).ready(function(){
        var currentPosition = parseInt($(".quickmenu").css("top"));
        $(window).scroll(function() {
            var position = $(window).scrollTop();
            $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
        });
    });

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
        if (betweenTimeDay < 8) {
            return `\${betweenTimeDay}일전`;
        }

        const month = String(timeValue.getMonth() + 1).padStart(2, '0');
        const day = String(timeValue.getDate()).padStart(2, '0');
        const formattedDate = `\${month}-\${day}`;

        return `\${formattedDate}`;
    }
</script>

<style>
    div, ul, li {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;padding:0;margin:0}
    a {text-decoration:none;}

    .quickmenu {position:absolute;width:300px;top:50%;margin-top:-50px;right:10px;background:#fff;}
    .quickmenu ul {position:relative;float:left;width:100%;display:inline-block;*display:inline;border:1px solid #ddd;}
    .quickmenu ul li {float:left;width:100%;border-bottom:1px solid #ddd;text-align:center;display:inline-block;*display:inline;}
    .quickmenu ul li a {position:relative;float:left;width:100%;height:30px;line-height:30px;text-align:center;color:#999;font-size:9.5pt;}
    .quickmenu ul li a:hover {color:#000;}
    .quickmenu ul li:last-child {border-bottom:0;}

    .content {position:relative;min-height:1000px;}

    .notice-item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    .title, .author, .writeday {
        text-align: left;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .title {
        width: 65%;
    }
    .author {
        width: 10%;
    }
    .writeday {
        width: 25%;
    }
</style>

<h2 style="margin-top: 60px; font-family:'배달의민족 을지로체 TTF'">QnA Board</h2>
<h5 class="alert alert-danger" style="width: 800px">총 ${totalCount}개의 글이 있습니다.</h5>
<h5 class="alert alert-warning" style="width: 800px">
    공지사항<br>
    <ul>
<%--        <c:forEach items="${notices}" var="notice">--%>
            <li class="notice-item">
                <div class="title">제목: ${notice.title}</div>
                <div class="author">작성자: ${notice.author}</div>
                <div class="writeday">작성일자: ${notice.writeday}</div>
            </li>
<%--        </c:forEach>--%>
    </ul>
</h5>
<table class="table table-bordered" style="width: 800px">

    <tr style="background-color: #ddd">
        <th style="width: 40px">번호</th>
        <th style="width: 250px">제목</th>
        <th style="width: 100px">작성자</th>
        <th style="width: 60px">조회수</th>
        <th style="width: 60px">추천</th>
        <th style="width: 60px">비추천</th>
        <th style="width: 120px">작성일</th>
    </tr>
    <c:if test="${totalCount == 0}">
        <tr height="50">
            <td colspan="5" align="center" valign="middle">
                <b style="font-size: 1.3em">등록된 게시글이 없습니다.</b>
            </td>
        </tr>
    </c:if>
    <c:if test="${totalCount>0}">
        <c:forEach var="dto" items="${list}">

            <c:if test="${dto.qb_dislike > 19}">
                <tbody class="backdrop">
            <tr style="filter: blur(2px);">

                <td align="center">
                        ${no}
                    <c:set var="no" value="${no-1}"/>
                </td>
                <!-- 제목 -->
                <td>
                    <a href="detail?qb_idx=${dto.qb_idx}&currentPage=${currentPage}" style="color: black; text-decoration: none; cursor: pointer;">
                        <!-- 사진이 있을경우 아이콘 출력 -->

<%--                        <c:if test="${dto.qb_photo!=''}">--%>
<%--                            <i class="bi bi-images"></i>--%>
<%--                        </c:if>--%>
                            <%--   제목이 길경우 150px 만 나오고 말 줄임표...--%>
                        <span style="text-overflow:ellipsis;overflow: hidden;white-space: nowrap;display: inline-block;max-width: 300px;">${dto.qb_subject}
                        </span>
                    </a>
                </td>
                <td>
                    <img src="${dto.photo}" style="width:25px; height: 25px; border:3px solid black; border-radius:100px;"><br>
                        ${dto.nickName}
                </td>
                <td>
                        ${dto.qb_readcount}
                </td>
                <td>
                        ${dto.qb_like}
                </td>
                <td>
                        ${dto.qb_dislike}
                </td>
                <td>
                    <span id="writeday-${dto.qb_idx}"></span>
                </td>
            </tr>
                </tbody>
            </c:if>
            <c:if test="${dto.qb_dislike < 20}">
                    <tr>
                        <td align="center">
                                ${no}
                            <c:set var="no" value="${no-1}"/>
                        </td>
                        <!-- 제목 -->
                        <td>
                            <a href="detail?qb_idx=${dto.qb_idx}&currentPage=${currentPage}" style="color: black; text-decoration: none; cursor: pointer;">
                                <!-- 사진이 있을경우 아이콘 출력 -->
                                    <%--                        <c:if test="${dto.qb_photo!=''}">--%>
                                    <%--                            <i class="bi bi-images"></i>--%>
                                    <%--                        </c:if>--%>
                                    <%--   제목이 길경우 150px 만 나오고 말 줄임표...--%>
                                <span style="text-overflow:ellipsis;overflow: hidden;white-space: nowrap;display: inline-block;max-width: 300px;">${dto.qb_subject}
                                </span>
                            </a>
                        </td>
                        <td>
                            <img src="${dto.photo}" style="width:25px; height: 25px; border:3px solid black; border-radius:100px;"><br>
                                ${dto.nickName}
                        </td>
                        <td>
                                ${dto.qb_readcount}
                        </td>
                        <td>
                                ${dto.qb_like}
                        </td>
                        <td>
                                ${dto.qb_dislike}
                        </td>
                        <td class="writeday">
                            <span id="writeday-${dto.qb_idx}"></span>
                        </td>
                    </tr>
            </c:if>
            <script>
                var writedayElement = document.getElementById("writeday-${dto.qb_idx}");
                var formattedWriteday = timeForToday("${dto.qb_writeday}");
                writedayElement.textContent = formattedWriteday;
            </script>

        </c:forEach>
    </c:if>
</table>

<div style="width: 700px; text-align: center; font-size: 20px">
    <!-- 이전 -->
        <c:if test="${startPage > 1}">
            <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${startPage-1}">이전</a>
        </c:if>
        <c:if test="${startPage <= 1}">
            <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;" href="list?currentPage=${startPage-1}">이전</a>
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
            <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${endPage+1}">다음</a>
        </c:if>
        <c:if test="${endPage >= totalPage}">
            <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;" href="list?currentPage=${endPage+1}">다음</a>
        </c:if>
    </div>

<button class="btn btn-outline-dark" type="button" onclick="location.href='./writeform'">
    작성
</button>

<div class="quickmenu">
    <ul>
        <li class="quickmenu_head"><p style="font-size: 30px">베스트 게시글</p></li>
    </ul>
</div>

<script>
    $.ajax({
        type: "post",
        url: "./bestPostsForBanner",
        dataType: "json",
        success: function(response) {
            let s = "";
            $.each(response, function(index, item) {
                s +=
                    `
                        <li>
                            <a href="../freeboard/freeboarddetail?fb_idx=\${item.fb_idx}&currentPage=1">
                                <div class="name">
                                    <div class="num">\${index+1} \${item.fb_subject}</div>
                                </div>
                            </a>
                        </li>
                    `
            });
            $(".quickmenu ul").append(s);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log("Error: " + textStatus + " - " + errorThrown);
        }
    });

</script>

