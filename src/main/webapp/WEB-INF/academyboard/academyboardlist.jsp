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

        /*top btn*/
        #myBtn {
            display: none; /* Hidden by default */
            position: fixed; /* Fixed/sticky position */
            bottom: 20px; /* Place the button at the bottom of the page */
            right: 30px; /* Place the button 30px from the right */
            z-index: 99; /* Make sure it does not overlap */
            border: none; /* Remove borders */
            outline: none; /* Remove outline */
            background-color: #7f07ac; /* Set a background color */
            color: white; /* Text color */
            cursor: pointer; /* Add a mouse pointer on hover */
            padding: 15px; /* Some padding */
            border-radius: 10px; /* Rounded corners */
            font-size: 18px; /* Increase font size */
        }

        #myBtn:hover {
            background-color: #530871; /* Add a dark-grey background on hover */
        }

    </style>

    <script>
        //몇시간전글인지
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

        // 퀵메뉴
        $(document).ready(function () {

            var currentpage = 1;
            var isLoading = false;
            var noMoreData = false;

            var currentPosition = parseInt($(".quickmenu").css("top"));
            $(window).scroll(function () {
                var position = $(window).scrollTop();
                $(".quickmenu").stop().animate({"top": position + currentPosition + "px"}, 1000);


                // 무한스크롤
                // 무한스크롤
                if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                    if (!isLoading && !noMoreData) {
                        isLoading = true;
                        var nextPage = currentpage + 1;

                        $.ajax({
                            type: "GET",
                            url: "./listajax",
                            data: { currentPage: nextPage },
                            beforeSend: function () {
                                $("#loading").show();
                            },
                            complete: function () {
                                isLoading = false;
                            },
                            success: function (res) {
                                if (res.totalCount == 0) {
                                    $(".listbox").append(`<h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>`);
                                    $("#loading").hide();
                                } else {
                                    if (res.length == 0) {
                                        noMoreData = true;
                                        $("#loading").hide();
                                    } else {
                                        setTimeout(function () {
                                            currentpage++;
                                            var s = '';
                                            $.each(res, function (idx,dto) {
                                                if (dto.fb_dislike > 19) {
                                                    if(idx % 2 == 1) {
                                                        s += `<div class="blurbox" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                    } else {
                                                        s += `<div class="blurbox">`;
                                                    }
                                                } else {
                                                    if(idx % 2 == 1) {
                                                        s += `<div class="box" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                    } else {
                                                        s += `<div class="box">`;
                                                    }
                                                }
                                                s += `<span class="fb_writeday">\${dto.fb_writeday}</span>`
                                                s += `<span class="fb_readcount"><div class="icon_read"></div>\${dto.fb_readcount}</span><br><br>`;
                                                s += `<span class="nickName"><img src="\${dto.photo}" class="memberimg">&nbsp;\${dto.nickName}</span>`;
                                                s += `<div class="mainbox">`
                                                s += `<h3 class="fb_subject"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}"><b>\${dto.fb_subject}</b></a></h3>`;
                                                if (dto.fb_photo == 'n') {
                                                    var content = dto.fb_content.substring(0, 120);
                                                    if (dto.fb_content.length >= 120) {
                                                        content += ".....";
                                                    }
                                                    s += `<h5 class="fb_content" style="width: 90%"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span>\${content}</span></a></h5>`;
                                                } else {
                                                    var content = dto.fb_content.substring(0, 80);
                                                    if (dto.fb_content.length >= 80) {
                                                        content += ".....";
                                                    }
                                                    s += `<h5 class="fb_content" style="width:80%"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span class="photocontent">\${content}</span></a></h5>`;
                                                    s += `<div style="position:relative; right:0; top: -80px;"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span class="fb_photo"><img src="http://${imageUrl}/freeboard/\${dto.fb_photo.split(",")[0]}" id="fb_photo"></span></a></div>`;
                                                }
                                                s += `<div class="hr_tag"><div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;\${dto.fb_like}&nbsp;&nbsp;<i class="bi bi-hand-thumbs-down"></i>&nbsp;\${dto.fb_dislike}</div><div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;\${dto.commentCnt}</div></div>`;
                                                s += `</div>`;
                                                s += `</div>`;
                                            })
                                            $(".listbox").append(s);
                                            $("#loading").hide();
                                        }, 1000);  // 1초 후에 실행
                                    }
                                }
                            },
                            error: function (xhr, status, error) {
                                console.log("Error:", error);
                                $("#loading").hide();
                            }

                        })
                    }
                }

                //------------------


            });

        });


    </script>
</head>
<body>

<!--=============================================================================-->
<!-- 검색창 -->
<div class="searchdiv">
    <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off"
           class="searchbar">
    <i class="bi bi-search"></i>

    <select id="searchOption">
        <option id="all" value="all">전체검색</option>
        <option id="searchnickname" value="m_nickname">작성자 검색</option>
        <option id="searchsubject" value="ab_subject">제목 검색</option>
    </select>
</div>
<script>

    $("#searchinput").keydown(function (e) {

        // 일단은 엔터 눌러야 검색되는걸로 -> 나중에 뭐 클릭해도 검색되게 바꿔도될듯?
        if (e.keyCode == 13) {
            // 검색내용
            var keyword = $(this).val();
            var searchOption = $("#searchOption").val();
            console.log(keyword);
            console.log(searchOption);

            // null 값 검색시 -> 아무일도 안일어남
            if (keyword == '') {
                alert("검색하실 내용을 입력해주세요.")
                return
            } else {
                //alert("검색결과출력.");

                $.ajax({
                    type: "post",
                    url: "./academyboardsearchlist",
                    data: {"keyword": keyword, "searchOption": searchOption},
                    dataType: "json",
                    success: function (res) {
                        let s = '';

                        $.each(res, function (idx, ele) {

                            s += `번호 : \${ele.ab_idx}<br>`;
                            s += `제목 : \${ele.ab_subject}<br>`;
                            s += `작성자 : \${ele.m_nickname}<br>`;

                            s += `내용 : \${ele.ab_content}<br>`;
                            s += `검색한내용 : \${ele.keyword}<br>`;
                            s += `검색 카테고리 : \${ele.searchOption}<br>`;
                            s += `작성일 : \${ele.ab_writeday}<br>`;
                            s += `댓글수 : \${ele.commentCnt}<br>`;
                            s += `조회 : \${ele.ab_readcount}<br>`;
                            s += `좋아요 : \${ele.ab_like}<br>`;
                            s += `싫어요 : \${ele.ab_dislike}<br>`;
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


<div class="ab_wrap clear">
<%--    <button class="btn btn-secondary btn-sm" type="button" style="float: right;" onclick="location.href='./academywriteform'">글쓰기</button>--%>
<%--    <h2><b><i class="bi bi-chat-square-quote-fill"></i>&nbsp;${sessionScope.memacademy}&nbsp;게시판</b></h2><br>--%>

    <div class="headbox">
        <h4 style="color: black; font-weight: bold;"><i class="bi bi-chat-square-quote-fill"></i>&nbsp;${sessionScope.memacademy}게시판
            <button class="btn btn-secondary" type="button"
                    style="float: right; margin-right: 150px; "
                    onclick="location.href='./academywriteform'"><i class="bi bi-pen"></i>&nbsp;글쓰기
            </button>
        </h4>
<%--        <b>총 ${totalCount}개의 게시글</b><br>--%>
    </div>
    <br><br>

    <div class="listbox">
        <c:forEach var="dto" items="${list}" varStatus="i">
            <c:if test="${dto.ai_idx==sessionScope.acaidx}">
            <div class="box" <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>
                 <c:if test="${dto.ab_dislike>19}">style="filter:blur(2px);"</c:if>>

<%--                <span class="ab_writeday" id="writeday-${dto.ab_idx}"><fmt:formatDate value="${dto.ab_writeday}" pattern="MM/dd"/></span>--%>
        <span class="ab_writeday" id="writeday-${dto.ab_idx}"></span>
        <script>
            var writedayElement = document.getElementById("writeday-${dto.ab_idx}");
            var formattedWriteday = timeForToday("${dto.ab_writeday}");
            writedayElement.textContent = formattedWriteday;
        </script>

        <span class="ab_readcount"><div class="icon_read"></div> ${dto.ab_readcount}</span><br><br>
        <span class="nickName"><img src="http://${imageUrl}/member/${dto.m_photo}"
                                class="memberimg">&nbsp;${dto.nickName}</span>

                <span class="ab_photo">
                    <a href="academyboarddetail?ab_idx=${dto.ab_idx}&currentPage=${currentPage}">
                        <img src="http://${imageUrl}/academyboard/${dto.ab_photo.split(",")[0]}" id="photo">
                    </a>
                </span>
                    <h3 class="ab_subject">
                        <a href="academyboarddetail?ab_idx=${dto.ab_idx}&currentPage=${currentPage}"><b>${dto.ab_subject}</b></a>
                        <br><br><div class="ar_tag">
                            <div class="ar_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;${dto.ab_like}&nbsp;&nbsp;<i
                                    class="bi bi-hand-thumbs-down"></i>&nbsp;${dto.ab_dislike}</div>
                            <div class="ar_tag_2"><i class="bi bi-chat"></i>&nbsp;${dto.commentCnt}</div>
                        </div>
                    </h3>


            </div>
            </c:if>
        </c:forEach>
    </div>


<%--    <table class="academyboard_table table table-bordered">--%>
<%--        <caption align="top"><h2> ${sessionScope.memacademy}게시판--%>
<%--            <button class="btn btn-secondary btn-sm" type="button" style="float: right;" onclick="location.href='./academywriteform'">글쓰기</button>--%>
<%--        </h2>--%>
<%--        </caption>--%>

<%--&lt;%&ndash;        <tr>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <td class="alert alert-outline-secondary">총 ${totalCount}개의 게시글&ndash;%&gt;--%>
<%--&lt;%&ndash;            </td>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </tr>&ndash;%&gt;--%>
<%--        <tr>--%>

<%--&lt;%&ndash;        <c:if test="${totalCount==0}">&ndash;%&gt;--%>
<%--&lt;%&ndash;            <h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </c:if>&ndash;%&gt;--%>
<%--        <c:if test="${totalCount>0}">--%>
<%--            <c:forEach var="dto" items="${list}" varStatus="i">--%>
<%--            <c:if test="${dto.ai_idx==sessionScope.acaidx}">--%>
<%--            <td>--%>
<%--                <table id="dtocontainer">--%>
<%--                    <tr>--%>
<%--                        <td id="idxbox">no. ${dto.ab_idx}</td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <td id="subjectbox">--%>
<%--                            <a href="academyboarddetail?ab_idx=${dto.ab_idx}&currentPage=${currentPage}" style="color: #000;">${dto.ab_subject}</a></td>--%>
<%--                    </tr>--%>

<%--                    <c:if test="${dto.ab_photo=='n'}">--%>
<%--                        &nbsp;<tr style="height: 130px;">--%>
<%--                        <td style="width: 100%">--%>
<%--                            <a href="academyboarddetail?ab_idx=${dto.ab_idx}&currentPage=${currentPage}" style="color: #000;">--%>
<%--                                <span >--%>

<%--                                    <c:set var="length" value="${fn:length(dto.ab_content)}"/>--%>
<%--                                    ${fn:substring(dto.ab_content, 0, 130)}--%>

<%--                                    <c:if test="${length>=130}">--%>
<%--                                        .....--%>
<%--                                    </c:if>--%>

<%--                                   </span></a>--%>

<%--                        </td></tr>--%>
<%--                    </c:if>--%>
<%--                    <c:if test="${dto.ab_photo!='n'}">--%>
<%--                        &nbsp;<tr style="height: 130px;">--%>
<%--                        <td style="width: 80%">--%>
<%--                            <a href="academyboarddetail?ab_idx=${dto.ab_idx}&currentPage=${currentPage}" style="color: #000;">--%>
<%--                                    <span>--%>

<%--                                    <c:set var="length" value="${fn:length(dto.ab_content)}"/>--%>
<%--                                    ${fn:substring(dto.ab_content, 0, 90)}--%>

<%--                                    <c:if test="${length>=90}">--%>
<%--                                        .....--%>
<%--                                    </c:if>--%>

<%--                                   </span></a>--%>
<%--                        </td>--%>

<%--                        <td style="width: 20%">--%>
<%--                                <span id="imgbox">--%>

<%--                                        <img src="http://${imageUrl}/academyboard/${dto.ab_photo}" style="width: 70%; border: 1px solid lightgray; margin-right: 5px;">--%>


<%--                                </span>--%>
<%--                        </td>--%>
<%--                        </tr>--%>
<%--                    </c:if>--%>

<%--                    <tr>--%>
<%--                        <td id="namebox">--%>
<%--                            <img src="http://${imageUrl}/member/${dto.m_photo}" class="memberimg">&nbsp; ${dto.nickName}--%>
<%--                        </td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <td>--%>
<%--                            <b id="etcbox">--%>
<%--                                <i class="bi bi-eye"></i>&nbsp;조회&nbsp;${dto.ab_readcount}&nbsp;--%>
<%--                                <i class="bi bi-hand-thumbs-up"></i>&nbsp;좋아요&nbsp;${dto.ab_like}&nbsp;&nbsp;--%>
<%--                                <i class="bi bi-hand-thumbs-down"></i>&nbsp;싫어요&nbsp;${dto.ab_dislike}&nbsp;--%>
<%--&lt;%&ndash;                                <i class="bi bi-chat-right"></i>&nbsp;댓글&nbsp;${dto.commentCnt}&ndash;%&gt;--%>
<%--                            </b>--%>

<%--                            <p id="writedaybox">--%>
<%--                                <span id="writeday-${dto.ab_idx}"></span>--%>
<%--                            </p>--%>
<%--                            <script>--%>
<%--                                var writedayElement = document.getElementById("writeday-${dto.ab_idx}");--%>
<%--                                var formattedWriteday = timeForToday("${dto.ab_writeday}");--%>
<%--                                writedayElement.textContent = formattedWriteday;--%>
<%--                            </script>--%>

<%--                        </td>--%>
<%--                    </tr>--%>
<%--                </table>--%>
<%--            </td>--%>

<%--            <c:if test="${i.index % 1 == 0}"></tr><tr></c:if>--%>
<%--        </c:if>--%>

<%--        </c:forEach>--%>
<%--        </c:if>--%>
<%--    </tr>--%>





<%--    </table>--%>


<%--    <!-- 페이징 처리 -->--%>
<%--    <div style="width:700px; text-align: center; font-size: 20px; background-color: rgba(255, 255, 255, 0.6)">--%>
<%--        <!-- 이전 -->--%>
<%--        <c:if test="${startPage>1}">--%>
<%--            <a style="font-size:17px; font-weight: bold; color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${startPage-1 }">&nbsp;이전&nbsp;</a>--%>
<%--        </c:if>--%>

<%--        <!-- 페이지번호출력 -->--%>
<%--        <c:forEach var="pp" begin="${startPage }" end="${endPage }">--%>

<%--            <c:if test="${currentPage == pp }">--%>
<%--                <a style="color: #3366CC; text-decoration: none; cursor: pointer; font-weight: bold;" href="list?currentPage=${pp }">&nbsp;${pp}&nbsp;</a>--%>
<%--            </c:if>--%>
<%--            <c:if test="${currentPage != pp }">--%>
<%--                <a style="color: black; text-decoration: none; cursor: pointer; font-weight: bold;" href="list?currentPage=${pp }">&nbsp;${pp}&nbsp;</a>--%>
<%--            </c:if>--%>

<%--        </c:forEach>--%>

<%--        <!-- 다음 -->--%>
<%--        <c:if test="${endPage<totalPage}">--%>
<%--            <a style="font-size:17px; font-weight: bold; color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${endPage+1 }">&nbsp;다음&nbsp;</a>--%>
<%--        </c:if>--%>
<%--    </div>--%>

</div>
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>

<div id="loading"
     style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999;">
    <img src="${root}/photo/809.gif" alt="Loading..."
         style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
    <!-- 로딩 이미지의 경로를 설정하세요 -->
</div>
<!--=============================================================================-->
<%--quickmenu--%>
<div class="quickmenu">
    <ul>
<%--        <li class="quickmenu_head"><p style="font-size: 30px">베스트 게시글</p></li>--%>
    </ul>
</div>
<script>
    // When the user scrolls down 20px from the top of the document, show the button
    window.onscroll = function () {
        scrollFunction()
    };

    function scrollFunction() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            document.getElementById("myBtn").style.display = "block";
        } else {
            document.getElementById("myBtn").style.display = "none";
        }
    }


    // When the user clicks on the button, scroll to the top of the document
    function topFunction() {
        document.body.scrollTop = 0; // For Safari
        document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
    }

</script>
</body>
</html>
