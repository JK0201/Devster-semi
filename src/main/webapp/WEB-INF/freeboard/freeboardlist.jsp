<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../commonvar.jsp" %>


<div class="fb_wrap">


    <h1>Free Board</h1>

    <!--=============================================================================-->

    <div class="noticeboard_part" style="border: 1px solid red">
        <h1>공지</h1>
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

    <table class="freeboard_table">



<%--<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Gothic+A1&family=Gowun+Batang&family=Hahmlet&family=Song+Myung&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">--%>

<style>
    .freeboard_table{
        font-family: 'Gowun Batang';
        margin-left: 30px;
        margin-top: 30px;
        width: 100%;
    }
    .dtocontainer{
        font-family: 'Gowun Batang';
        width: 100%;
    }
    caption *{
        font-family: 'Hahmlet';
    }

    .idxbox{
        font-size: 13px;
        color: gray;
        height: 30px;
    }
    .subjectbox{
        font-size: 18px;
        font-weight: bold;
    }


    .namebox{
        font-size: 13px;
        font-weight: bold;
    }
    img{
        width: 100px;
    }

    .writedaybox{
        font-size: 14px;
        color: gray;
        float: right;
    }
    .etcbox{
        font-size: 14px;
        color: gray;
    }

    .memberimg{
        width: 23px;
        height: 23px;
        border-radius: 100px;
    }

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



        $(document).ready(function(){
        var currentPosition = parseInt($(".quickmenu").css("top"));
        $(window).scroll(function() {
        var position = $(window).scrollTop();
        $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},1000);
    });
    });
</script>

    <div class="allpage">
    <!-- 검색창 -->
    <div class="searchdiv">
        <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off" class="searchbar">
        <i class="bi bi-search"></i>

        <select id="searchOption">
            <option id="all" value="all">전체검색</option>
            <option id="searchnickname" value="m_nickname">작성자 검색</option>
            <option id="searchsubject" value="fb_subject">제목 검색</option>
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
                        url: "./freeboardsearchlist",
                        data: {"keyword":keyword, "searchOption":searchOption},
                       dataType: "json",
                        success: function (res) {
                            let s = '';

                            $.each(res, function (idx, ele) {

                                    s += `번호 : \${ele.fb_idx}<br>`;
                                    s += `제목 : \${ele.fb_subject}<br>`;
                                    s += `작성자 : \${ele.m_nickname}<br>`;

                                    s += `내용 : \${ele.fb_content}<br>`;
                                    s += `검색한내용 : \${ele.keyword}<br>`;
                                    s += `검색 카테고리 : \${ele.searchOption}<br>`;
                                    s += `작성일 : \${ele.fb_writeday}<br>`;
                                    s += `댓글수 : \${ele.commentCnt}<br>`;
                                    s += `조회 : \${ele.fb_readcount}<br>`;
                                    s += `좋아요 : \${ele.fb_like}<br>`;
                                    s += `싫어요 : \${ele.fb_dislike}<br>`;
                                    s += `사진 : <hr>`;

                            })
                            $(".roop").html(s);
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



<table class="freeboard_table table table-bordered">
    <caption align="top"><h4 style="color: black; font-weight: bold;"><img src="/photo/icon_fb.png" style="width: 40px;">일반게시판
        <button class="btn btn-secondary" type="button" style="float: right; margin-right: 150px; margin-top: 30px;" onclick="location.href='./freewriteform'"><i class="bi bi-pen"></i>&nbsp;글쓰기</button>
    </h4>
    </caption>


    <tr>
        <td class="alert alert-outline-secondary">총 ${totalCount}개의 게시글<hr>
        </td>
    </tr>
    <tr class="roop">


        <tbody>



        <c:if test="${totalCount==0}">
            <h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>
        </c:if>

        <c:if test="${totalCount>0}">
            <c:forEach var="dto" items="${list}" varStatus="i">

        <c:if test="${dto.fb_dislike > 19}">

        <td style="filter: blur(2px);">
            <table  class="dtocontainer" style="filter: blur(2px);">
                <tr>
                    <td class="idxbox">no. ${dto.fb_idx}</td>
                </tr>
                <tr>
                    <td class="subjectbox">
                        <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}" style="color: #000;">${dto.fb_subject}</a></td>
                </tr>

                <c:if test="${dto.fb_photo=='n'}">
                    &nbsp;<tr>
                    <td style="width: 90%">
                        <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}" style="color: #000;">
                                <span >

                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 130)}

                                    <c:if test="${length>=130}">
                                        .....
                                    </c:if>

                                   </span></a>

                    </td></tr>
                </c:if>
                <c:if test="${dto.fb_photo!='n'}">
                    &nbsp;<tr>
                    <td style="width: 80%">
                        <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}" style="color: #000;">
                                    <span>

                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 90)}

                                    <c:if test="${length>=90}">
                                        .....
                                    </c:if>

                                   </span></a>
                    </td>

                    <td style="width: 20%">
                                <span class="imgbox">

                                        <img src="http://${imageUrl}/freeboard/${dto.fb_photo}" style="width: 70%; border: 1px solid lightgray; margin-right: 5px;">


                                </span>
                    </td>
                    </tr>
                </c:if>

                <tr>
                    <td class="namebox">
                        <img src="http://${imageUrl}/member/${dto.m_photo}" class="memberimg">&nbsp; ${dto.nickName}
                    </td>
                </tr>
                <tr>
                    <td>
                        <b class="etcbox">
                            <i class="bi bi-eye"></i>&nbsp;조회&nbsp;${dto.fb_readcount}&nbsp;
                            <i class="bi bi-hand-thumbs-up"></i>&nbsp;좋아요&nbsp;${dto.fb_like}&nbsp;&nbsp;
                            <i class="bi bi-hand-thumbs-down"></i>&nbsp;싫어요&nbsp;${dto.fb_dislike}&nbsp;
                            <i class="bi bi-chat-right"></i>&nbsp;댓글&nbsp;${dto.commentCnt}
                        </b>

                        <p class="writedaybox">
                            <span id="writeday-${dto.fb_idx}"></span>
                        </p>
                        <script>
                            var writedayElement = document.getElementById("writeday-${dto.fb_idx}");
                            var formattedWriteday = timeForToday("${dto.fb_writeday}");
                            writedayElement.textContent = formattedWriteday;
                        </script>

                    </td>
                </tr>
            </table>
        </td>

        <c:if test="${i.index % 1 == 0}"></tr><tr></c:if>
        </c:if>

        <c:if test="${dto.fb_dislike < 20}">

        <td>
            <table class="dtocontainer">
                <tr>
                    <td class="idxbox">no. ${dto.fb_idx}</td>
                </tr>
                <tr>
                    <td class="subjectbox">
                        <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}" style="color: #000;">${dto.fb_subject}</a></td>
                </tr>

                <c:if test="${dto.fb_photo=='n'}">
                    &nbsp;<tr style="height: 90px;">
                    <td style="width: 90%">
                        <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}" style="color: #000;">
                                <span>

                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 130)}

                                    <c:if test="${length>=130}">
                                        .....
                                    </c:if>

                                   </span></a>

                    </td></tr>
                </c:if>
                <c:if test="${dto.fb_photo!='n'}">
                    &nbsp;<tr style="height: 90px;">
                    <td style="width: 80%">
                        <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}" style="color: #000;">
                                    <span>

                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 90)}

                                    <c:if test="${length>=90}">
                                        .....
                                    </c:if>

                                   </span></a>
                    </td>

                    <td style="width: 20%">
                                <span class="imgbox">

                                        <img src="http://${imageUrl}/freeboard/${dto.fb_photo}" style="width: 70%; border: 1px solid lightgray; margin-right: 5px;">


                                </span>
                    </td>
                    </tr>
                </c:if>

                <tr>
                    <td class="namebox">
                        <img src="http://${imageUrl}/member/${dto.m_photo}" class="memberimg">&nbsp; ${dto.nickName}
                    </td>
                </tr>
                <tr>
                    <td>
                        <b class="etcbox">
                            <i class="bi bi-eye"></i>&nbsp;조회&nbsp;${dto.fb_readcount}&nbsp;
                            <i class="bi bi-hand-thumbs-up"></i>&nbsp;좋아요&nbsp;${dto.fb_like}&nbsp;&nbsp;
                            <i class="bi bi-hand-thumbs-down"></i>&nbsp;싫어요&nbsp;${dto.fb_dislike}&nbsp;
                            <i class="bi bi-chat-right"></i>&nbsp;댓글&nbsp;${dto.commentCnt}
                        </b>

                        <p class="writedaybox">
                            <span id="writeday-${dto.fb_idx}"></span>
                        </p>
                        <script>
                            var writedayElement = document.getElementById("writeday-${dto.fb_idx}");
                            var formattedWriteday = timeForToday("${dto.fb_writeday}");
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


    <div class="quickmenu">
        <ul>
            <li class="quickmenu_head"><p style="font-size: 30px">베스트 게시글</p></li>
        </ul>
    </div>
</div>
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




</div>

