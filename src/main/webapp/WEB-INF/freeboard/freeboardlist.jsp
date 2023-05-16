<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../commonvar.jsp" %>


<div class="fb_wrap">
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

    <style>
        /* quickmenu */
        div, ul, li {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            padding: 0;
            margin: 0
        }

        a {
            text-decoration: none;
        }

        .quickmenu {
            position: absolute;
            width: 300px;
            top: 50%;
            margin-top: -50px;
            right: 10px;
            background: #fff;
        }

        .quickmenu ul {
            position: relative;
            float: left;
            width: 100%;
            display: inline-block;
            *display: inline;
            border: 1px solid #ddd;
        }

        .quickmenu ul li {
            float: left;
            width: 100%;
            border-bottom: 1px solid #ddd;
            text-align: center;
            display: inline-block;
            *display: inline;
        }

        .quickmenu ul li a {
            position: relative;
            float: left;
            width: 100%;
            height: 30px;
            line-height: 30px;
            text-align: center;
            color: #999;
            font-size: 9.5pt;
        }

        .quickmenu ul li a:hover {
            color: #000;
        }

        .quickmenu ul li:last-child {
            border-bottom: 0;
        }

        /* 서치바 */
        .searchdiv {
            /*position: absolute;*/
            position: relative;
        }

        .searchbar {
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
        // 몇시간전글인지
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
                if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                    if (!isLoading && !noMoreData) {
                        isLoading = true;
                        var nextPage = currentpage + 1;

                        $.ajax({
                            type: "GET",
                            url: "./listajax",
                            data: {currentPage: nextPage},
                            beforeSend: function () {
                                $("#loading").show();
                            },
                            complete: function () {
                                isLoading = false;
                            },
                            success: function (res) {
                                if (res.list.length == 0) {
                                    noMoreData = true;
                                    $("#loading").hide();
                                } else {
                                    setTimeout(function () {
                                        currentpage++;
                                        var s = '';
                                        $.each(res.list, function (idx, ele) {
                                            var writedayElement = document.getElementById("writeday-${ele.fb_idx}");
                                            var formattedWriteday = timeForToday("${ele.fb_writeday}");
                                            writedayElement.textContent = formattedWriteday;



                                        }) //foreach
                                        $(".listbox").append(s);
                                        $("#loading").hide();
                                    }, 1000);  // 1초 후에 실행

                                }
                            },
                            error: function (xhr, status, error) {
                                console.log("Error:", error);
                                $("#loading").hide();
                            }
                        });
                    }
                }
            });


        });


    </script>

    <!--=============================================================================-->
    <!-- 검색창 -->
    <div class="searchdiv">
        <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off"
               class="searchbar">
        <i class="bi bi-search"></i>

        <select id="searchOption">
            <option id="all" value="all">전체검색</option>
            <option id="searchnickname" value="m_nickname">작성자 검색</option>
            <option id="searchsubject" value="fb_subject">제목 검색</option>
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
                        url: "./freeboardsearchlist",
                        data: {"keyword": keyword, "searchOption": searchOption},
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

    <!--=============================================================================-->

    <div class="headbox">
        <h4 style="color: black; font-weight: bold;"><img src="/photo/icon_fb.png" style="width: 40px;">일반게시판
            <button class="btn btn-secondary" type="button"
                    style="float: right; margin-right: 150px; margin-top: 30px;"
                    onclick="location.href='./freewriteform'"><i class="bi bi-pen"></i>&nbsp;글쓰기
            </button>
        </h4>
        <b>총 ${totalCount}개의 게시글</b><br>
    </div>

    <!--=============================================================================-->
    <!-- listbox -->
    <div class="listbox">
        <c:if test="${totalCount==0}">
            <h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>
        </c:if>

        <c:if test="${totalCount>0}">
            <c:forEach var="dto" items="${list}" varStatus="i">
                <!-- blurbox-->
                <c:if test="${dto.fb_dislike > 19}">
                    <div class="blurbox"
                         <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

                        <span class="fb_writeday" id="writeday-${dto.fb_idx}"></span>
                        <script>
                            var writedayElement = document.getElementById("writeday-${dto.fb_idx}");
                            var formattedWriteday = timeForToday("${dto.fb_writeday}");
                            writedayElement.textContent = formattedWriteday;
                        </script>

                        <span class="fb_readcount"><div class="icon_read"></div>
                                ${dto.fb_readcount}</span><br><br>

                        <span class="nickName"><img src="http://${imageUrl}/member/${dto.m_photo}"
                                                    class="memberimg">&nbsp;${dto.nickName}</span>

                        <h3 class="fb_subject">
                            <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}"><b>${dto.fb_subject}</b></a>
                        </h3>

                        <c:if test="${dto.fb_photo=='n'}">
                            <h5 class="fb_content" style="width: 90%">
                                <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}"
                                   style="color: #000;">
                                <span>
                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 120)}

                                    <c:if test="${length>=120}">
                                        .....
                                    </c:if>
                                   </span></a>
                            </h5>
                        </c:if>
                        <c:if test="${dto.fb_photo!='n'}">
                            <h5 class="fb_content">
                                <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}"
                                   style="color: #000;">
                                <span class="photocontent">
                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 80)}

                                    <c:if test="${length>=80}">
                                        .....
                                    </c:if>
                                   </span>
                                    <span class="fb_photo">
                    <img src="http://${imageUrl}/freeboard/${dto.fb_photo.split(",")[0]}" id="fb_photo_blur">
            </span>
                                </a>
                            </h5>
                        </c:if>

                        <div class="hr_tag">
                            <div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;${dto.fb_like}&nbsp;&nbsp;<i
                                    class="bi bi-hand-thumbs-down-"></i>&nbsp;${dto.fb_dislike}</div>
                            <div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;${dto.commentCnt}</div>
                        </div>

                    </div>

                </c:if>
                <!-- blurbox-->
                <!-- box-->
                <div class="box"
                     <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

                    <span class="fb_writeday" id="writeday-${dto.fb_idx}"></span>
                    <script>
                        var writedayElement = document.getElementById("writeday-${dto.fb_idx}");
                        var formattedWriteday = timeForToday("${dto.fb_writeday}");
                        writedayElement.textContent = formattedWriteday;
                    </script>

                    <span class="fb_readcount"><div class="icon_read"></div>
                            ${dto.fb_readcount}</span><br><br>

                    <span class="nickName"><img src="http://${imageUrl}/member/${dto.m_photo}"
                                                class="memberimg">&nbsp;${dto.nickName}</span>

                    <h3 class="fb_subject">
                        <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}"><b>${dto.fb_subject}</b></a>
                    </h3>

                    <c:if test="${dto.fb_photo=='n'}">
                        <h5 class="fb_content" style="width: 90%">
                            <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}"
                               style="color: #000;">
                                <span>
                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 120)}

                                    <c:if test="${length>=120}">
                                        .....
                                    </c:if>
                                   </span></a>
                        </h5>
                    </c:if>
                    <c:if test="${dto.fb_photo!='n'}">
                        <h5 class="fb_content">
                            <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}"
                               style="color: #000;">
                                <span class="photocontent">
                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 80)}

                                    <c:if test="${length>=80}">
                                        .....
                                    </c:if>
                                   </span>
                            </a>
                            <a href="freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}">
                                <span class="fb_photo">
                    <img src="http://${imageUrl}/freeboard/${dto.fb_photo.split(",")[0]}" id="fb_photo">
            </span>
                            </a>
                        </h5>
                    </c:if>

                    <div class="hr_tag">
                        <div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;${dto.fb_like}&nbsp;&nbsp;<i
                                class="bi bi-hand-thumbs-down"></i>&nbsp;${dto.fb_dislike}</div>
                        <div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;${dto.commentCnt}</div>
                    </div>


                </div>

                <!-- box-->
            </c:forEach>
        </c:if>
    </div>
    <!-- listbox -->

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
            <li class="quickmenu_head"><p style="font-size: 30px">베스트 게시글</p></li>
        </ul>
    </div>

    <script>
        $.ajax({
            type: "post",
            url: "./bestPostsForBanner",
            dataType: "json",
            success: function (response) {
                let s = "";
                $.each(response, function (index, item) {
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
                s +=
                    `
    <button type="button" onclick="window.scrollTo({top:0});">
    <i class="bi bi-arrow-up-square-fill"></i>
    </button>
    `;
                $(".quickmenu ul").append(s);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error: " + textStatus + " - " + errorThrown);
            }
        });


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
</div>
