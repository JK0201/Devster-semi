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
<style>
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

<div class="hb_wrap clear">


    <!-- 검색창 -->
    <div class="searchdiv">
        <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off" class="searchbar">
        <i class="bi bi-search"></i>
    </div>

    <!-- 글쓰기 버튼 -->
    <c:if test="${sessionScope.cmidx!=null || sessionScope.memstate==100}">
        <button type="button" class="btn btn-sm btn-outline-success hb_write_btn"
                onclick="location.href='form'" style="margin-bottom: 10px">글쓰기
        </button>
    </c:if>

    <script>

        $("#searchinput").keydown(function (e){

            // 일단은 엔터 눌러야 검색되는걸로 -> 나중에 뭐 클릭해도 검색되게 바꿔도될듯?
            if(e.keyCode==13){
                // 검색내용
                var keyword = $(this).val();
               //var searchOption = $("#searchOption").val();
                console.log(keyword);
                //console.log(searchOption);

                // null 값 검색시 -> 아무일도 안일어남
                if(keyword==''){
                    alert("검색하실 내용을 입력해주세요.")
                    return
                } else {
                    //alert("검색결과출력.");

                    $.ajax({
                        type: "post",
                        url: "./hboardsearchlist",
                        data: {"keyword":keyword},
                        dataType: "json",
                        success: function (res) {
                            let s = '';

                            $.each(res, function (idx, ele) {

                                s += `번호 : \${ele.hb_idx}<br>`;
                                s += `제목 : \${ele.hb_subject}<br>`;
                                s += `cm_idx : \${ele.cm_idx}<br>`;

                                s += `내용 : \${ele.hb_content}<br>`;
                                s += `검색한내용 : \${ele.keyword}<br>`;
                                s += `조회수 : \${ele.hb_readcount}<br>`;

                                s += `작성일 : \${ele.hb_writeday}<br>`;

                                s += `사진 : <hr>`;

                            })
                            $(".hb_wrap").html(s);
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
        <img src="${root}/photo/809.gif" alt="Loading..." style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"> <!-- 로딩 이미지의 경로를 설정하세요 -->
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



