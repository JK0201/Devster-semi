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
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Gothic+A1&family=Gowun+Batang&family=Hahmlet&family=Song+Myung&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body, body * {
            font-family: 'Gowun Batang'
        }

        img{
            width: 100px;
        }

        .headbox{
            margin-bottom: 30px;
        }
        .bodybox{
            margin-bottom: 30px;
            height: 100%;
        }
        .footbox{
            margin-bottom: 20px;
            margin-top: 10px;
            font-size: 18px;
        }
        .btnbox{
            margin-left: 130px;
        }

      .thumbsup,.thumbsdown{
          cursor: pointer;
      }

      .thumbsup:hover{
          color:cornflowerblue;
      }

      .thumbsdown:hover{
          color: crimson;
      }

        .commentwrite{
            margin-left: 100px;
            width: 80%;
            margin-bottom: 50px;
            text-align: center;
        }

        .memberimg{
            width: 23px;
            height: 23px;
            border-radius: 100px;
        }

    </style>

    <script>
        $(document).ready(function (){
            commentList();
        })

    </script>
</head>

<body>

<div class="container">
    <div class="headbox">
        <b style="font-size: 15px; color: #94969B; margin-bottom: 20px;">no.${dto.fb_idx}</b><br>
        <h4 style="font-family: 'Hahmlet'; color: black; font-weight: bolder; margin-top: 5px;margin-bottom: 20px;">${dto.fb_subject}</h4>

        <b style="font-size: 15px; color: black;" margin-bottom: 10px;>
            <img src="http://${imageUrl}/member/${m_photo}" class="memberimg">&nbsp;
            ${nickname}&nbsp;</b><br>

        <b style="font-size: 13px; color: #94969B;"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM/dd HH:mm"/>&nbsp;&nbsp;</b>
        <b style="font-size: 13px; color: #94969B;"><i class="bi bi-eye"></i>&nbsp;${dto.fb_readcount}&nbsp;&nbsp;</b>
        <b style="font-size: 13px; color: #94969B;"><i class="bi bi-chat-right"></i>&nbsp;<b id="commentCnt">0</b></b>
    </div>
    <div class="bodybox">
        <p style="margin-bottom: 50px;">${dto.fb_content}</p>

        <c:forEach items="${list}" var="images">
            <c:if test="${images!='n'}">
                <img src="http://${imageUrl}/freeboard/${images}"><br>
            </c:if>
        </c:forEach>
    </div>
    <div class="footbox">
        <i class="bi bi-hand-thumbs-up thumbsup" onclick="like()"></i>&nbsp;${dto.fb_like}&nbsp;
        <i class="bi bi-hand-thumbs-down thumbsdown" onclick="dislike()"></i>&nbsp;${dto.fb_dislike}&nbsp;
    </div>


</div>

<div class="btnbox">
    <c:if test="${dto.m_idx == sessionScope.memidx}">
        <button type="button" onclick="location.href='./freeupdateform?fb_idx=${dto.fb_idx}&currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-pencil-square"></i>&nbsp;수정</button>
        <button type="button" onclick="del(${dto.fb_idx})" class="btn btn-sm btn-outline-secondary"><i class="bi bi-trash"></i>&nbsp;삭제</button>
    </c:if>

    <button type="button" onclick="location.href='./list?currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-card-list"></i>&nbsp;목록</button>
</div>
<hr>

<div class="commentwrite">
    <form name="commentinsert">
        <input type="hidden" name="fb_idx" value="${dto.fb_idx}">
        <input type="text" name="fbc_content" id="commentContent" class="form-control">
        <button type="button" id="writepost" class="btn btn-sm btn-secondary"><i class="bi bi-pencil"></i>&nbsp;댓글쓰기</button>
    </form>
</div>
<div id="commentBox" style="margin-left: 100px; width: 600px; border: 3px solid black"></div>


<script>

    function insert(){
        let fb_idx = ${dto.fb_idx};
        let m_idx = ${sessionScope.memidx};
        let fbc_content = $('#commentContent').val();

        $.ajax({
            type: "post",
            url: "/freecomment/insert",
            data: {"fb_idx" : fb_idx, "m_idx" : m_idx, "fbc_content":fbc_content},

            success: function (response) {
                // alert("댓글이 작성되었습니다.");
                commentList();
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "error: " + error);
            }

        });
    }

    // 댓글 리스트 가져오는 사용자 함수
    function commentList(){
        let fb_idx = ${dto.fb_idx}
            $.ajax({
                type: "post",
                url: "/freecomment/commentlist",
                data:{"fb_idx":fb_idx},
                dataType:"json",
                success: function(res) {
                    // const count = res.list.length;
                    // if (res.length > 0) {
                        let s = "";
                        $.each(res, function (idx, ele) {
                            s += `
                            <div class='answerBox' data-index="\${idx}">
                            <h4>`;

                            if (ele.m_photo === null || ele.m_photo === 'no') {
                                s += `<img src="/photo/profile.jpg" style="width:50px; height: 50px; border:3px solid black; border-radius:100px;">`;
                            } else {
                                s += `<img src="http://${imageUrl}/member/\${item.m_photo}" style="width:50px; height: 50px; border:3px solid black; border-radius:100px;">`;
                            }

s+=`\${ele.nickname}</h4>
                            <h6>\${ele.fbc_writeday}</h6>
                            <h5>\${ele.fbc_content}</h5>`;

                            if (ele.m_idx == ${sessionScope.memidx}) {
                                s += `<button class="btn btn-outline-dark" type="button" onclick="deleteComment(\${ele.fbc_idx})">삭제</button>
                                <button class="btn btn-outline-dark" type="button" data-fbcidx="\${ele.fbc_idx}" onclick="updateCommentForm(\${ele.fbc_idx},\${idx})">수정</button>`;
                            }

                            s += `<button class="btn btn-outline-dark" type="button" style="float: right; margin-right: 10px;" onclick="">답글</button><hr></div>`;
                        });

                        var totalCount = res[0].totalCount;
                        document.getElementById("commentCnt").innerHTML = totalCount;
                        $("#commentBox").html(s);
                    // } else {
                    //     let html = "<div class='mb-2'>";
                    //     html += "<h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                    //     html += "</div>";
                    //     $("#commentCnt").html(0);
                    //     $("#commentBox").html(html);
                    // }
                }
            });
    }


    function deleteComment(fbc_idx) {

        if(confirm("댓글을 삭제하시겠습니까? ")) {
            $.ajax({
                type: "get",
                url: "/freecomment/delete",
                data: {"fbc_idx":fbc_idx},
                success: function (response) {
                    alert("댓글이 삭제되었습니다.");
                    commentList()
                },
                error: function (xhr, status, error) {
                    // 에러 처리를 여기에서 처리합니다.
                }
            });
        }
    }

    function updateCommentForm(fbc_idx, idx) {
        let $targetAnswerBox = $(`.answerBox[data-index="\${idx}"]`);

        $.ajax({
            type: "get",
            url: "/freecomment/updateform",
            data: {"fbc_idx": fbc_idx},
            dataType : "json",
            success: function (response) {
                let s =
                    `
            <h3>수정</h3>
            <form name="commentupdate">
        <input type="hidden" name="fb_idx" value="\${response.fb_idx}">
        <input type="text" name="fbc_content" id="commentContent" class="form-control" value="\${response.fbc_content}">
        <button type="button" id="writepost" class="btn btn-sm btn-secondary"><i class="bi bi-pencil"></i>&nbsp;댓글수정</button>
    </form>
            <hr>
            `;
                $targetAnswerBox.html(s);

                $targetAnswerBox.find('#writepost').on('click', function() {
                    // 이벤트 리스너 내부에서 수정을 처리하는 코드를 작성합니다.
                    updateComment(fbc_idx, idx);
                });

            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }

    function updateComment(fbc_idx, idx) {
        let $targetAnswerBox = $(`.answerBox[data-index="\${idx}"]`);
        let formData = new FormData($targetAnswerBox.find('form')[0]);

        formData.append("fbc_idx",fbc_idx);

        $.ajax({
            type: "post",
            url: "/freecomment/update",
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                alert("댓글이 수정되었습니다.")
               commentList();
            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }


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

    $("#writepost").click(function (){
        insert();
        $("#commentContent").val("");
    })
</script>

</body>
</html>















