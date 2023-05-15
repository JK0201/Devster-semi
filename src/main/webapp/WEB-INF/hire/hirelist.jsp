<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

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
    .overlay-loader {
        display: block;
        margin: auto;
        width: 97px;
        height: 97px;
        position: relative;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
    }
    .loader {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        margin: auto;
        width: 97px;
        height: 97px;
        animation-name: rotateAnim;
        -o-animation-name: rotateAnim;
        -ms-animation-name: rotateAnim;
        -webkit-animation-name: rotateAnim;
        -moz-animation-name: rotateAnim;
        animation-duration: 0.4s;
        -o-animation-duration: 0.4s;
        -ms-animation-duration: 0.4s;
        -webkit-animation-duration: 0.4s;
        -moz-animation-duration: 0.4s;
        animation-iteration-count: infinite;
        -o-animation-iteration-count: infinite;
        -ms-animation-iteration-count: infinite;
        -webkit-animation-iteration-count: infinite;
        -moz-animation-iteration-count: infinite;
        animation-timing-function: linear;
        -o-animation-timing-function: linear;
        -ms-animation-timing-function: linear;
        -webkit-animation-timing-function: linear;
        -moz-animation-timing-function: linear;
    }
    .loader div {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        border: 1px solid rgb(0,0,0);
        position: absolute;
        top: 2px;
        left: 0;
        right: 0;
        bottom: 0;
        margin: auto;
    }
    .loader div:nth-child(odd) {
        border-top: none;
        border-left: none;
    }
    .loader div:nth-child(even) {
        border-bottom: none;
        border-right: none;
    }
    .loader div:nth-child(2) {
        border-width: 2px;
        left: 0px;
        top: -4px;
        width: 12px;
        height: 12px;
    }
    .loader div:nth-child(3) {
        border-width: 2px;
        left: -1px;
        top: 3px;
        width: 18px;
        height: 18px;
    }
    .loader div:nth-child(4) {
        border-width: 3px;
        left: -1px;
        top: -4px;
        width: 23px;
        height: 23px;
    }
    .loader div:nth-child(5) {
        border-width: 3px;
        left: -1px;
        top: 4px;
        width: 31px;
        height: 31px;
    }
    .loader div:nth-child(6) {
        border-width: 4px;
        left: 0px;
        top: -4px;
        width: 39px;
        height: 39px;
    }
    .loader div:nth-child(7) {
        border-width: 4px;
        left: 0px;
        top: 6px;
        width: 49px;
        height: 49px;
    }


    @keyframes rotateAnim {
        from {
            transform: rotate(360deg);
        }
        to {
            transform: rotate(0deg);
        }
    }

    @-o-keyframes rotateAnim {
        from {
            -o-transform: rotate(360deg);
        }
        to {
            -o-transform: rotate(0deg);
        }
    }

    @-ms-keyframes rotateAnim {
        from {
            -ms-transform: rotate(360deg);
        }
        to {
            -ms-transform: rotate(0deg);
        }
    }

    @-webkit-keyframes rotateAnim {
        from {
            -webkit-transform: rotate(360deg);
        }
        to {
            -webkit-transform: rotate(0deg);
        }
    }

    @-moz-keyframes rotateAnim {
        from {
            -moz-transform: rotate(360deg);
        }
        to {
            -moz-transform: rotate(0deg);
        }
    }

</style>

<div class="hb_wrap clear">

    <!--=============================================================================-->

    <!-- 검색창 -->
    <div class="searchdiv">
        <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off" class="searchbar">
        <i class="bi bi-search"></i>
    </div>

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


<%--    <c:forEach var="dto" items="${list}" varStatus="i">--%>
<%--        <div class="box" <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>--%>

<%--            <span class="hb_writeday"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM/dd"/></span>--%>
<%--            <span class="hb_readcount"><div class="icon_read"></div> ${dto.hb_readcount}</span>--%>

<%--            <span class="hb_photo">--%>
<%--                <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}">--%>
<%--                    <img src="http://${imageUrl}/hire/${dto.hb_photo.split(",")[0]}" id="photo">--%>
<%--                </a>--%>
<%--            </span>--%>

<%--            <h3 class="hb_subject">--%>
<%--                <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}"><b>${dto.hb_subject}</b></a>--%>
<%--            </h3>--%>


<%--            <div class="hr_tag">--%>
<%--                <div class="hr_tag_1">이직시200만원</div>--%>
<%--                <div class="hr_tag_2">유연근무</div>--%>
<%--            </div>--%>

<%--        </div>--%>
<%--    </c:forEach>--%>

    <div class="box" <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

</div>
<div id="loading" style="display: none;">
    <div class="overlay-loader">
        <div class="loader">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div> <!-- 로딩 이미지의 경로를 설정하세요 -->
</div>

<%--<div class="paginate">--%>
<%--    <!-- 다음 -->--%>
<%--    <c:if test="${endPage < totalPage}">--%>
<%--       <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${endPage+1}"><div class="icon_next"></div></a>--%>
<%--    </c:if>--%>
<%--    <c:if test="${endPage >= totalPage}">--%>
<%--       <a style="color: black; text-decoration: none; cursor: pointer;--%>
<%--        visibility: hidden;" href="list?currentPage=${endPage+1}"><div class="icon_next"></div></a>--%>
<%--    </c:if>--%>
<%--</div>--%>


<button type="button" class="btn btn-sm btn-outline-success hb_write_btn"
        onclick="location.href='form'" style="margin-bottom: 10px">글쓰기

</button>

<script>
    $(document).ready(function () {

        var currentpage = 1;
        var isLoading = false;
        var noMoreData = false;

        $(window).scroll(function () {
            if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                if (!isLoading && !noMoreData) {
                    isLoading = true;
                    var nextPage = currentpage + 1;

                    $.ajax({
                        type: "GET",
                        url: "list",
                        data: { currentPage: nextPage },
                        beforeSend: function () {
                            $("#loading").show();
                        },
                        complete: function () {
                            $("#loading").hide();
                            isLoading = false;
                        },
                        success: function (res) {
                            if (res.length == 0) {
                                noMoreData = true;
                            } else {
                                var s = '';
                                $.each(res, function (idx, ele) {
                                    s += `<div class="box">`;
                                    s += `<span class="hb_writeday">\${ele.fb_writeday}</span>`;
                                    s += `<span class="hb_readcount"><div class="icon_read"></div>\${ele.hb_readcount}</span>`;
                                    s += `<span class="hb_photo"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}&currentPage=${page}"><img src="http://${imageUrl}/hire/\${ele.hb_photo}" id="photo"></a></span>`;
                                    s += `<h3 class="hb_subject"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}&currentPage=${page}"><b>\${ele.hb_subject}</b></a></h3>`;
                                    s += `<div class="hr_tag"><div class="hr_tag_1">이직시200만원</div><div class="hr_tag_2">유연근무</div></div>`;
                                    s += `</div>`;
                                })
                                $(".hb_wrap").append(s);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log("Error:", error);
                        }
                    });
                }
            }
        });
    });
</script>






