<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<script>
    let photos ='';
</script>

<div class="hb_wrap clear">
    <!--===============================Headbox==============================================-->

    <div class="headbox">
        <h4 class="boardname">
            <div class="yellowbar">&nbsp;</div>&nbsp;&nbsp;채용정보
        </h4>

        <!-- 검색창 -->
        <div class="searchdiv">
            <select id="searchOption" class="form-select" disabled>
                <option id="all" value="all" selected>전체검색</option>
            </select>
            <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off"
                   class="searchbar">
        </div>
    </div>

    <!--=============================================================================-->

    <script>
        // timefortoday 안넣기로

        // 검색

        // 검색 여부 전역변수
        var isSearch = false;

        $("#searchinput").keydown(function (e) {

            // 일단은 엔터 눌러야 검색되는걸로 -> 나중에 뭐 클릭해도 검색되게 바꿔도될듯?
            if (e.keyCode == 13) {

                isSearch = true;

                // 검색내용
                var keyword = $(this).val();

                var currentpage = 1;
                var isLoading = false;
                var noMoreData = false;

                // null 값 검색시 -> 아무일도 안일어남
                if (keyword == '') {
                    alert("검색하실 내용을 입력해주세요.")
                    return
                } else { // 검색 내용 있을때
                    // 기본 출력
                    $.ajax({
                        type: "post",
                        url: "./hboardsearchlist",
                        data: {"keyword": keyword, "currentpage": currentpage},
                        dataType: "json",
                        beforeSend: function () {
                            $("#loading").show();
                        },
                        complete: function () {
                            isLoading = false;
                        },
                        success: function (res) {
                            console.log(currentpage);
                            console.log(noMoreData);

                            if (res.length == 0) {
                                alert("검색 결과가 없습니다.");
                                noMoreData = true;
                                $("#loading").hide();
                            } else {
                                setTimeout(function () {
                                    currentpage++;
                                    var s = '';
                                    $.each(res, function (idx, ele) {
                                        var date = new Date(ele.fb_writeday);
                                        var formattedDate = date.toLocaleDateString("en-US", {month: '2-digit', day: '2-digit'});
                                        s += `<div class="box">`;
                                        s += `<span class="hb_writeday">\${formattedDate}</span>`;
                                        s += `<span class="hb_readcount"><div class="icon_read"></div>\${ele.hb_readcount}</span>`;
                                        s += `<span class="hb_photo"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}"><img src="http://${imageUrl}/hire/\${ele.hb_photo.split(",")[0]}" id="photo"></a></span>`;
                                        s += `<h3 class="hb_subject"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}"><b>\${ele.hb_subject}</b></a></h3>`;
                                        s += `<div class="hr_tag"><div class="hr_tag_1">이직시200만원</div><div class="hr_tag_2">유연근무</div></div>`;
                                        s += `</div>`;
                                    })
                                    s += ``;

                                    $(".listbox").html(s);
                                    $("#loading").hide();

                                }, 1000);  // 1초 후에 실행
                            }

                        },

                        error: function (xhr, status, error) {
                            // 요청이 실패했을 때의 처리 로직
                            console.log("Error:", error);
                        }
                    });

                    // 추가 리스트 출력 (스크롤)
                    $(window).scroll(function () {

                        if (Math.floor($(window).scrollTop()) == $(document).height() - $(window).height()) {

                            if (!isLoading && !noMoreData) {
                                isLoading = true;
                                let nextPage = currentpage;
                                $.ajax({
                                    type: "post",
                                    url: "./hboardsearchlist",
                                    data: {"keyword": keyword, "currentpage": nextPage},
                                    dataType: "json",
                                    beforeSend: function () {
                                        $("#loading").show();
                                    },
                                    complete: function () {
                                        isLoading = false;
                                    },
                                    success: function (res) {
                                        console.log(currentpage);
                                        console.log(noMoreData);
                                        console.log(res.length);
                                        if (res.searchCount == 0) {
                                            noMoreData = true;
                                            $("#loading").hide();
                                        } else {
                                            if (res.length == 0) {
                                                noMoreData = true;
                                                $("#loading").hide();
                                            } else {
                                                setTimeout(function () {
                                                    currentpage++;
                                                    var s = '';

                                                    $.each(res, function (idx, ele) {
                                                        var date = new Date(ele.fb_writeday);
                                                        var formattedDate = date.toLocaleDateString("en-US", {month: '2-digit', day: '2-digit'});
                                                        s += `<div class="box">`;
                                                        s += `<span class="hb_writeday">\${formattedDate}</span>`;
                                                        s += `<span class="hb_readcount"><div class="icon_read"></div>\${ele.hb_readcount}</span>`;
                                                        s += `<span class="hb_photo"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}"><img src="http://${imageUrl}/hire/\${ele.hb_photo.split(",")[0]}" id="photo"></a></span>`;
                                                        s += `<h3 class="hb_subject"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}"><b>\${ele.hb_subject}</b></a></h3>`;
                                                        s += `<div class="hr_tag"><div class="hr_tag_1">이직시200만원</div><div class="hr_tag_2">유연근무</div></div>`;
                                                        s += `</div>`;
                                                    })
                                                    s += ``;

                                                    $(".listbox").append(s);
                                                    $("#loading").hide();

                                                }, 1000);  // 1초 후에 실행
                                            }
                                        }
                                    },

                                    error: function (xhr, status, error) {
                                        // 요청이 실패했을 때의 처리 로직
                                        console.log("Error:", error);
                                    }
                                });
                            }
                        }
                    })
                }
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

      /*  // 프로필 클릭
        function message(nickname) {
            window.open("other_profile?other_nick=" + nickname, 'newwindow', 'width=700,height=700');
        }*/


    </script>
    <!--=============================================================================-->
    <div class="listbox">
        <c:forEach var="dto" items="${list}" varStatus="i">
            <div class="box" <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>
                <span class="hb_writeday"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM/dd"/></span>
                <span class="hb_readcount"><div class="icon_read"></div> ${dto.hb_readcount}</span>
                <span class="hb_photo">
                <a href="hireboarddetail?hb_idx=${dto.hb_idx}">
                    <img src="http://${imageUrl}/hire/${dto.hb_photo.split(",")[0]}" id="photo">
                </a>
            </span>
                <h3 class="hb_subject">
                    <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}"><b>${dto.hb_subject}</b></a>
                </h3>
                <div class="hr_tag">
                    <div class="hr_tag_1">이직시200만원</div>
                    <div class="hr_tag_2">유연근무</div>
                </div>
            </div>
        </c:forEach>
    </div>
    <c:if test="${sessionScope.cmidx!=null || sessionScope.memstate==100}">
        <button type="button" class="btn btn-sm btn-outline-success hb_write_btn"
                onclick="location.href='form'" style="margin-bottom: 10px">글쓰기
        </button>
    </c:if>
    <button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
    <div id="loading" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999;">
        <img src="${root}/photo/loading.gif" alt="Loading..." style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"> <!-- 로딩 이미지의 경로를 설정하세요 -->
    </div>
    <script>
        $(document).ready(function () {
            var currentpage = 1;
            var isLoading = false;
            var noMoreData = false;
            $(window).scroll(function () {
                var scrollHeight = Math.max(
                    document.body.scrollHeight, document.documentElement.scrollHeight,
                    document.body.offsetHeight, document.documentElement.offsetHeight,
                    document.body.clientHeight, document.documentElement.clientHeight
                );
                var scrollPos = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
                if (scrollPos + window.innerHeight >= scrollHeight) {
                    if (!isLoading && !noMoreData && !isSearch) {
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
                                if (res.list.length == 0) {
                                    noMoreData = true;
                                    $("#loading").hide();
                                } else {
                                    setTimeout(function () {
                                        currentpage++;
                                        var s = '';
                                        $.each(res.list, function (idx, ele) {
                                            var date = new Date(ele.fb_writeday);
                                            var formattedDate = date.toLocaleDateString("en-US", {month: '2-digit', day: '2-digit'});
                                            s += `<div class="box">`;
                                            s += `<span class="hb_writeday">\${formattedDate}</span>`;
                                            s += `<span class="hb_readcount"><div class="icon_read"></div>\${ele.hb_readcount}</span>`;
                                            s += `<span class="hb_photo"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}"><img src="http://${imageUrl}/hire/\${ele.hb_photo.split(",")[0]}" id="photo"></a></span>`;
                                            s += `<h3 class="hb_subject"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}"><b>\${ele.hb_subject}</b></a></h3>`;
                                            s += `<div class="hr_tag"><div class="hr_tag_1">이직시200만원</div><div class="hr_tag_2">유연근무</div></div>`;
                                            s += `</div>`;
                                        })
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
        // When the user scrolls down 20px from the top of the document, show the button
        window.onscroll = function() {scrollFunction()};
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

<!-- 글쓰기 버튼 -->
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
<br>
<c:if test="${sessionScope.cmidx!=null || sessionScope.memstate==100}">
    <button type="button" id="myWriteBtn" onclick="location.href='form'">글쓰기</button>
</c:if>