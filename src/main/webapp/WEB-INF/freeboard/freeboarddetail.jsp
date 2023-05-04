<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body, body * {
            font-family: 'Jua'
        }
    </style>
</head>
<body>

<div>
    번호 : ${dto.fb_idx} <br>
    제목 : ${dto.fb_subject}<br>
    내용 : ${dto.fb_content}<br>
    작성자 : ${nickname}<br>
    조회: ${dto.fb_readcount}<br>
    좋아요 : ${dto.fb_like}<br>
    싫어요 : ${dto.fb_dislike}<br>
    작성일 :  <fmt:formatDate value="${dto.fb_writeday}" pattern="yyyy.MM.dd"/><br>

    <c:forEach items="${list}" var="images">
        <img src="http://${imageUrl}/freeboard/${images}" style="float: left">
    </c:forEach>

 <br><hr>



</div>
<div>
    <button type="button" onclick="location.href='./freeupdateform?fb_idx=${dto.fb_idx}&currentPage=${currentPage}'">수정</button>
    <button type="button" onclick="del(${dto.fb_idx})">삭제</button>
    <button type="button" onclick="location.href='./list?currenPage=${currentPage}'">목록</button>
    <button type="button" onclick="">댓글쓰기</button>

    <button type="button" onclick="like()" id="btnlike">좋아요</button>
    <button type="button" onclick="dislike()" id="btndislike">싫어요</button>
</div>
<hr>
<div>
    <!--댓글출력-->
    <table>
        <tr>
            <td>
                <img src="">&nbsp;작성자
            </td>
            <td>
                <div name="comment" >내용출력</div>
            </td>
        </tr>
    </table>
</div>

<script>
    function del(fb_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "./freedelete?fb_idx=" + fb_idx;
        }
    }

    function like() {
        let fb_idx = ${dto.fb_idx};
        let fb_readcount = ${dto.fb_readcount};

        $.ajax({
            type: "post",
            url: "./like",
            data: {"fb_idx":fb_idx},
            dataType: "json",
            success: function(response) {
                $("#btnlike").prop("disabled", true);
                $("#btndislike").prop("disabled", true);

                location.href=`./freeboarddetail?fb_idx=\${fb_idx}&currentPage=`+${currentPage};

                alert("좋아요를 눌렀어요.");
            }
        });
    }

    function dislike() {

        let fb_idx = ${dto.fb_idx}

        $.ajax({
            type: "post",
            url: "./dislike",
            data: {"fb_idx": fb_idx},
            dataType: "json",
            success: function(response) {
                $("#btnlike").prop("disabled", true);
                $("#btndislike").prop("disabled", true);

                location.href=`./freeboarddetail?fb_idx=\${fb_idx}&currentPage=`+${currentPage};

                alert("싫어요를 눌렀어요.");
            }
        });
    }
</script>

</body>
</html>















