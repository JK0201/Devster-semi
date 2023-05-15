<%--
  Created by IntelliJ IDEA.
  User: hyunohsmacbook
  Date: 2023/05/02
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>




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


    <c:forEach var="dto" items="${list}" varStatus="i">
        <div class="box" <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

            <span class="hb_writeday"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM/dd"/></span>
            <span class="hb_readcount"><div class="icon_read"></div> ${dto.hb_readcount}</span>

            <span class="hb_photo">
                <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}">
                    <img src="http://${imageUrl}/hire/${dto.hb_photo}" id="photo">
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
        <%-- <c:if test="${i.count%2==0}">
             <br style="clear: both;"><br>
         </c:if>--%>
    </c:forEach>

</div>

<div class="paginate">
    <!-- 이전 -->
    <c:if test="${startPage > 1}">
        <a style="color: black; text-decoration: none; cursor: pointer;"
           href="list?currentPage=${startPage-1}"><div class="icon_pre"></div></a>
    </c:if>
    <c:if test="${startPage <= 1}">
        <a style="color: black; text-decoration: none; cursor: pointer;
        visibility: hidden;" href="list?currentPage=${startPage-1}"><div class="icon_pre"></div></a>
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
       <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${endPage+1}"><div class="icon_next"></div></a>
    </c:if>
    <c:if test="${endPage >= totalPage}">
       <a style="color: black; text-decoration: none; cursor: pointer;
        visibility: hidden;" href="list?currentPage=${endPage+1}"><div class="icon_next"></div></a>
    </c:if>


</div>


<button type="button" class="btn btn-sm btn-outline-success hb_write_btn"
        onclick="location.href='form'" style="margin-bottom: 10px">글쓰기

</button>






