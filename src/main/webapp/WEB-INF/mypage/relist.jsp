
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>
<html>
<head>
    <title>Title</title>
  <style>
      .re_box{
          width: 1100px;
          height: 220px;
          margin: 32px auto;
          border-bottom: 1px solid #C9C9C9;
          padding-top: 1px;
          padding-right: 20px;
      }

      .re_pos {
          height: 50px;
          font-size: 30px;
          margin-top: 5px; /* 원하는 여백 값으로 설정 */
      }
       .re_self{
           height: 80px;
           overflow: hidden;
           text-overflow: ellipsis;
           white-space: nowrap;
           max-width: 600px;
       }
      .re_info{
          font-size: 12px;
          display: inline-block;
          /*  padding: 1px 8px 0px 7px;*/
          vertical-align : bottom;
          text-align: right;
          display: flex;
          justify-content: space-between;
          align-items: center;
      }

      .re_mphoto {
          order: 1;
          margin-right: 10px;
      }

      .re_mnick {
          order: 2;
          margin-right: 10px;
          font-size: 20px;
      }

      .ldate {
          order: 3;
          margin-left: auto;
          font-size: 20px;
          margin-left: auto;
      }

    </style>
</head>
<body>

    <c:forEach var="dto" items="${list1}" varStatus="i">
        <div class="re_box">
            <a href="redetail?m_idx=${dto.m_idx}">
            <div class="re_pos">  포지션${dto.r_pos}</div>
          <div class="re_self"> 자기소개서${dto.r_self}</div>
          <div class="re_info">
            <span class="re_mphoto">
            <img src="${dto.photo}" style="width:50px; height: 50px; border:3px solid black; border-radius:100px;">
            </span>
            <span class="re_mnick"> ${dto.nickName}</span>
              <fmt:formatDate value="${dto.r_ldate}" pattern="yyyy-MM-dd" var="r_ldate" />
              <span class="ldate"> ${r_ldate}</span>
          </div>
            </a>
        </div>

    </c:forEach>

</body>

<%--script>
    $(document).ready(function() {
        var currentPage = 1; // 현재 페이지 번호 설정
        $.ajax({
            url: "/relistajax",
            method: "GET",
            data: { currentPage: currentPage },
            success: function(response) {
                var nblist = response; // 받은 데이터를 nblist 변수에 저장
                // nblist 변수를 사용하여 데이터 출력 또는 필요한 처리 수행
                // 예시로 간단히 데이터 출력
                &lt;%&ndash; 여기부터는 JSP 코드로 처리 &ndash;%&gt;
                <c:forEach var="dto" items="${nblist}">
                ${dto.r_self}


                        <p>${dto.m_idx}</p>
                        <p>${dto.nickName}</p>


                        </c:forEach>
                &lt;%&ndash; 여기까지는 JSP 코드로 처리 &ndash;%&gt;
            },
            error: function(xhr, status, error) {
                console.log("AJAX Error: " + error);
            }
        });
    });
</script>--%>

<!--페이징 처리  -->
<%--<div style="width: 700px; text-align: center; font-size: 20px;">
    <!-- 이전 -->
    <c:if test="${currentPage > 1}">
        <a style="color: black; text-decoration: none; cursor: pointer;"
           href="list?currentPage=${currentPage - 1}">이전</a>
    </c:if>

    <!-- 페이지 번호 출력 -->
    <c:forEach var="pp" begin="${startpage}" end="${endpage}">
        <c:if test="${currentPage == pp}">
            <a style="color: green; text-decoration: none; cursor: pointer;"
               href="list?currentPage=${pp}">${pp}</a>
        </c:if>
        <c:if test="${currentPage != pp}">
            <a style="color: black; text-decoration: none; cursor: pointer;"
               href="list?currentPage=${pp}">${pp}</a>
        </c:if>
        &nbsp;
    </c:forEach>

    <!-- 다음 -->
    <c:if test="${endpage < totalpage}">
        <a style="color: black; text-decoration: none; cursor: pointer;"
           href="list?currentPage=${endpage + 1}">다음</a>
    </c:if>
</div>--%>

</html>
