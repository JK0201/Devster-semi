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

    /* 서치바 */
    .searchdiv{
        /*position: absolute;*/
        position: relative;
    }
    .searchbar{
        width: 736px;
        height: 60px;
        padding: 0 10px 0 62px;
        border: 2px solid #222;
        border-radius: 30px;
        font-size: 18px;
        box-sizing: border-box;
    }

    .bi-search {
        position: absolute;
        right: 5px; /* 아이콘과 입력란 사이의 공간을 조절합니다. */
        top: 31px;
        left: 27px;
        transform: translateY(-50%); /* 아이콘을 입력란의 정중앙에 배치합니다. */
        pointer-events: none; /* 입력란 위에서 클릭이나 기타 동작이 가능하게 합니다. */
        font-size: 24px;
    }
</style>

<h2 style="margin-top: 60px; font-family:'배달의민족 을지로체 TTF'">QnA Board</h2>
<h5 class="alert alert-danger" style="width: 800px">총 ${searchCount}개의 글이 있습니다.</h5>

<!--=============================================================================-->

<div class="noticeboard_part" style="border: 1px solid red; width: 800px">
    <h1>공지</h1>
    <div>
       <b>'${keyword}' 검색결과 :
           총 ${searchCount}개의 게시글</b>
    </div>
    <ul class="clear">
        <c:if test="${NoticeBoardTotalCount>0}">
        <c:forEach var="dto" items="${nblist}">


        <li>
            <a href="../noticeboard/noticeboarddetail?nb_idx=${dto.nb_idx}&currentPage=${currentPage}"
               style="color: #000;">
                    ${dto.nb_subject}
                <c:if test="${dto.nb_photo!='n'}">
                    &nbsp; <i class="bi bi-images"></i>
                </c:if>
            </a>
        </li>

    </ul>
    </c:forEach>
    </c:if>
    </ul>
</div>

<!--=============================================================================-->

<!-- 검색창 -->
<div class="searchdiv">
    <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off" class="searchbar">
    <i class="bi bi-search"></i>

    <select id="searchOption">
        <option id="all" value="all">전체검색</option>
        <option id="searchnickname" value="m_nickname">작성자 검색</option>
        <option id="searchsubject" value="qb_subject">제목 검색</option>
    </select>
</div>

<script>

    $("#searchinput").keydown(function (e){

        // 일단은 엔터 눌러야 검색되는걸로 -> 나중에 뭐 클릭해도 검색되게 바꿔도될듯?
        if(e.keyCode==13){
            // 검색내용
            var keyword = $(this).val();
            var searchOption = $("#searchOption").val();
            console.log(keyword);
            console.log(searchOption);

            // null 값 검색시 -> 아무일도 안일어남
            if(keyword==''){
                alert("검색하실 내용을 입력해주세요.")
                return
            } else {
                //alert("검색결과출력.");

                $.ajax({
                    type: "post",
                    url: "./qboardsearchlist",
                    data: {"keyword":keyword, "searchOption":searchOption},
                    dataType: "json",
                    success: function (res) {
                        let s = '';

                        $.each(res, function (idx, ele) {

                            s += `번호 : \${ele.qb_idx}<br>`;
                            s += `제목 : \${ele.qb_subject}<br>`;
                            s += `작성자 : \${ele.m_nickname}<br>`;

                            s += `내용 : \${ele.qb_content}<br>`;
                            s += `검색한내용 : \${ele.keyword}<br>`;
                            s += `검색 카테고리 : \${ele.searchOption}<br>`;
                            s += `작성일 : \${ele.qb_writeday}<br>`;
                            s += `댓글수 : \${ele.commentCnt}<br>`;
                            s += `조회 : \${ele.qb_readcount}<br>`;
                            s += `좋아요 : \${ele.qb_like}<br>`;
                            s += `싫어요 : \${ele.qb_dislike}<br>`;
                            s += `사진 : <hr>`;

                        })
                        $(".table").html(s);
                    },
                    error: function (xhr, status, error) {
                        // 요청이 실패했을 때의 처리 로직
                        console.log("Error:", error);
                    }
                });
            }
        }
    });

</script>


<!--=============================================================================-->

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
    <c:if test="${searchCount == 0}">
        <tr height="50">
            <td colspan="5" align="center" valign="middle">
                <b style="font-size: 1.3em">등록된 게시글이 없습니다.</b>
            </td>
        </tr>
    </c:if>
    <c:if test="${searchCount>0}">
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
                                <span style="text-overflow:ellipsis;overflow: hidden;white-space: nowrap;display: inline-block;max-width: 300px;">${dto.qb_subject} <span style="color: red; font-size: 14px">[${dto.count}]</span>
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
                s+=
                    `
                        <button type="button" onclick="window.scrollTo({top:0});">
                         <i class="bi bi-arrow-up-square-fill"></i>
                        </button>
                    `;
            $(".quickmenu ul").append(s);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log("Error: " + textStatus + " - " + errorThrown);
        }
    });

</script>

