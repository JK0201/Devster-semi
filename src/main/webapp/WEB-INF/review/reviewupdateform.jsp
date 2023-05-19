<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-03
  Time: PM 2:39
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        .post .contact form .fileupload {
            display: inline-block;
            margin-left: 10px;
            margin-bottom: 15px;
            position: relative;
        }

        .col-lg-6 {
            width: 50%;
        }

        .post .contact {
            display: inline-block;
            width: 100%;
            text-align: center;
        }

        .post .contact .title {
            display: inline-block;
            width: 100%;
        }

        .post .contact form {
            display: table;
            margin: 0 auto;
        }

        .post .contact form .message {
            display: inline-block;
            margin-left: 10px;
            margin-bottom: 15px;
            position: relative;
        }

        .post .contact form .input-group label {
            color: #8e8e8e;
        }

        .post .contact form .input-group input[type="text"] {
            background: #ebebeb;
            border: 0;
            outline: 0;
            height: 50px;
            border-radius: 5px;
            padding: 0 15px;
            font-size: 16px;
            width: 100%;
            margin-top: 10px;

        }

        .clear:after{    /* 자식이 모두 float 을 사용할때 부모가 높이를 갖게하기 위함 */
            content:"";
            display:block;
            clear:both;
        }

        .post .contact form .form-select{
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
            height: 50px;
            border-radius: 5px;
            padding: 0 15px;
        }


        .post .contact form .input-group input[type="file"] {
            background: #ebebeb;
            border: 0;
            outline: 0;
            height: 50px;
            border-radius: 5px;
            padding: 0 15px;
            font-size: 16px;
            width: 60%;
        }

        .post .contact form .input-group input#file-upload-btn{
            height: 40px;
        }

        .post .contact form .input-group textarea {
            background: #ebebeb;
            border: 0;
            outline: 0;
            border-radius: 5px;
            padding: 15px;
            font-size: 16px;

            width: 60%;
            margin-top: 20px;
        }

        .selecttype, .inputci{
            width: 30%;
        }

        .post .contact form .post {
            width: 100%;
            background: #8007ad;
            color: #fff;
            font-size: 16px;
            border-radius: 5px;
            display: inline-block;
        }

        .post .contact form .full {
            width: 100%;
        }

        .post .contact form .half {
            width: 100%;
        }

        .post .contact form .half input[type="text"] {
            width: 90%;
        }

        .post .contact form .name input[type="text"] {
            float: left;
        }

        .post .btn-block{
            width: 15%;
            background-color: #7f07ac;
            margin-bottom: 100px;
            margin-top: 30px;
            height: 50px;
        }

        <%--  별점 style   --%>
        .star-rb_star {
            flex-direction: row-reverse;
            display:flex;
            font-size:1.8em;
            padding:0 .2em;
            width:100%;
            margin-bottom: 20px;
            justify-content: center;
            align-items: center;
        }

        .star-rb_star input {
            display:none;

        }

        .star-rb_star label {
            color:#ccc;
            cursor:pointer;
        }

        .star-rb_star :checked ~ label {
            color:#f90;
        }

        .star-rb_star label:hover,
        .star-rb_star label:hover ~ label {
            color:#fc0;
        }

        /* explanation */

        article {
            background-color:#ffe;
            box-shadow:0 0 1em 1px rgba(0,0,0,.25);
            color:#006;
            font-family:cursive;
            font-style:italic;
            margin:4em;
            max-width:30em;
            padding:2em;
        }
    </style>
</head>
<body>
<div class="post">
    <div class="contact col-lg-6">
        <div class="title" style="margin-top: 30px;">
            <img src="/photo/logoimage.png" style="width: 100px;">
            <h2>Riview Board</h2>
        </div>

        <form form name="update-form">

            <c:set var="m_idx"  value="${sessionScope.memidx}"/>
            <c:set var="m_nic"  value="${sessionScope.memnick}"/>
            <input type="hidden" name="m_idx" value="${m_idx}" >
            <%-- 세션에서 로그인한 회원의 아이디를 가져옴 --%>
            <input type="hidden" name="rb_idx" value="${dto.rb_idx}" class="rb_idx">


            <div class="clear" style="display: flex; justify-content: center;, align-items: center; margin-bottom: 20px; margin-top: 10px;">
                <div class="input-group selecttype" style="display: inline-block; margin-right: 3px;">
                    <select class="rb_type form-select" name="rb_type">
                        <option value="1"${dto.rb_type == 1 ? 'selected' : ''}>면접 후기</option>
                        <option value="2"${dto.rb_type == 2 ? 'selected' : ''}>코딩테스트 후기</option>
                        <option value="3"${dto.rb_type == 3 ? 'selected' : ''}>합격 후기</option>
                    </select>

                </div>
                <div class="input-group inputci" style="display: inline-block; margin-left: 3px;">
                    <%--<label>Question</label>--%>
                    <input id="rearch-input" class="subject" type="text" name="ci_idx" placeholder="회사 이름을 검색하세요." required value="${ci_idx}">
                </div>
            </div>



            <div id="search-result"></div>

            <div class="input-group message">
                <label>토픽에 맞지 않는 글로 판단되어 다른 유저로부터 일정 수 이상의 신고를 받는 경우 글이 자동으로 블라인드처리 될 수 있습니다.</label>
                <textarea name="rb_content" class="content rb_content" cols="47"
                          rows="7" required> ${dto.rb_content}</textarea>
            </div>

            <!--별점-->

            <label style="font-size: 16px; color: #8e8e8e;">별점을 선택해주세요 :&nbsp;</label>
            <div class="star-rb_star">

                <c:if test="${dto.rb_star == 1}">
                    <input type="radio" id="5-stars" name="rb_star" value="5"/>
                    <label for="5-stars" class="star">&#9733;</label>
                    <input type="radio" id="4-stars" name="rb_star" value="4"/>
                    <label for="4-stars" class="star">&#9733;</label>
                    <input type="radio" id="3-stars" name="rb_star" value="3"/>
                    <label for="3-stars" class="star">&#9733;</label>
                    <input type="radio" id="2-stars" name="rb_star" value="2"/>
                    <label for="2-stars" class="star">&#9733;</label>
                    <input type="radio" id="1-stars" name="rb_star" value="1" checked="checked"/>
                    <label for="1-stars" class="star">&#9733;</label>
                </c:if>
                <c:if test="${dto.rb_star == 2}">
                    <input type="radio" id="5-stars" name="rb_star" value="5"/>
                    <label for="5-stars" class="star">&#9733;</label>
                    <input type="radio" id="4-stars" name="rb_star" value="4"/>
                    <label for="4-stars" class="star">&#9733;</label>
                    <input type="radio" id="3-stars" name="rb_star" value="3"/>
                    <label for="3-stars" class="star">&#9733;</label>
                    <input type="radio" id="2-stars" name="rb_star" value="2" checked="checked"/>
                    <label for="2-stars" class="star">&#9733;</label>
                    <input type="radio" id="1-stars" name="rb_star" value="1"/>
                    <label for="1-stars" class="star">&#9733;</label>
                </c:if>
                <c:if test="${dto.rb_star == 3}">
                    <input type="radio" id="5-stars" name="rb_star" value="5"/>
                    <label for="5-stars" class="star">&#9733;</label>
                    <input type="radio" id="4-stars" name="rb_star" value="4"/>
                    <label for="4-stars" class="star">&#9733;</label>
                    <input type="radio" id="3-stars" name="rb_star" value="3" checked="checked"/>
                    <label for="3-stars" class="star">&#9733;</label>
                    <input type="radio" id="2-stars" name="rb_star" value="2"/>
                    <label for="2-stars" class="star">&#9733;</label>
                    <input type="radio" id="1-stars" name="rb_star" value="1"/>
                    <label for="1-stars" class="star">&#9733;</label>
                </c:if>
                <c:if test="${dto.rb_star == 4}">
                    <input type="radio" id="5-stars" name="rb_star" value="5"/>
                    <label for="5-stars" class="star">&#9733;</label>
                    <input type="radio" id="4-stars" name="rb_star" value="4" checked="checked"/>
                    <label for="4-stars" class="star">&#9733;</label>
                    <input type="radio" id="3-stars" name="rb_star" value="3"/>
                    <label for="3-stars" class="star">&#9733;</label>
                    <input type="radio" id="2-stars" name="rb_star" value="2"/>
                    <label for="2-stars" class="star">&#9733;</label>
                    <input type="radio" id="1-stars" name="rb_star" value="1"/>
                    <label for="1-stars" class="star">&#9733;</label>
                </c:if>
                <c:if test="${dto.rb_star == 5}">
                    <input type="radio" id="5-stars" name="rb_star" value="5" checked="checked"/>
                    <label for="5-stars" class="star">&#9733;</label>
                    <input type="radio" id="4-stars" name="rb_star" value="4"/>
                    <label for="4-stars" class="star">&#9733;</label>
                    <input type="radio" id="3-stars" name="rb_star" value="3"/>
                    <label for="3-stars" class="star">&#9733;</label>
                    <input type="radio" id="2-stars" name="rb_star" value="2"/>
                    <label for="2-stars" class="star">&#9733;</label>
                    <input type="radio" id="1-stars" name="rb_star" value="1"/>
                    <label for="1-stars" class="star">&#9733;</label>
                </c:if>
            </div>

            <div class="col-md-12 form-group">
                <button type="submit" id="btnSb" class="btn_write btn btn-block btn-primary">등록</button>
                <button type="button" class="btn_cancle btn btn-block btn-primary" onclick="history.back()">취소
                </button>
            </div>

        </form>
    </div>
</div>

<!------------------------------>

<script>
    var ci_idx;
    $(function() {

        // 검색창에서 키 입력 시, 검색어에 해당하는 회사 정보를 검색하여 표시
        $('#rearch-input').on('keyup', function() {
            var query = $(this).val();
            $.ajax({
                url: "search",
                method: 'GET',
                data: {
                    "keyword": query
                },
                dataType: "json",
                success: function (data) {
                    var html = '';
                    $.each(data, function (idx, ele) {
                        if (ele.ci_name.includes(query)) {
                            html += '<div class="data" data-ci-idx="' + ele.ci_idx + '">' + ele.ci_name + '</div>';
                            html += "<br>";
                        }
                    });
                    $('#search-result').html(html);
                },
                error: function () {
                    $('#search-result').html('Error occurred');
                }
            });
        });

        // 엔터 키 입력 시, 가장 비슷한 값 자동 선택
        $('#rearch-input').on('keydown', function(event) {
            if (event.keyCode === 13) { // Enter key pressed
                event.preventDefault();
                var selected = $('#search-result .data:first-child');
                if (selected.length > 0) {
                    var ci_name = selected.text(); // 회사명(ci_name) 가져오기
                    $('#rearch-input').val(ci_name); // 검색창에 선택한 회사 정보의 이름을 표시
                }
            }
        });


        $(document).on('click', '.data', function() {
            ci_idx = $(this).attr("data-ci-idx");

            var ci_name = $(this).text();
            $('#rearch-input').val(ci_name);
        });
    });

    $("#btnSb").click(function (){
        var rb_type = $(".rb_type").val();
        var rb_star = $("input[name='rb_star']:checked").val();
        var rb_content = $(".rb_content").val();
        var m_idx = $("input[name='m_idx']").val();
        /*    var ci_idx = $("input[name='ci_idx']").val() || null;*/
        updateAjax(ci_idx, rb_type, rb_star, rb_content, m_idx);
    });

    function updateAjax(ci_idx, rb_type, rb_star, rb_content, m_idx) {


        $.ajax({
            url : "./update",
            dataType: "json",
            data: { "rb_type": rb_type,
                "rb_star": rb_star,
                "rb_content": rb_content,
                "m_idx": m_idx,
                "ci_idx": ci_idx,
                "rb_idx":rb_idx
            },

            method: 'post',
            success : function (res) {
                if(res){
                    alert("입력 완료");
                    location.href="list";
                }}

        });
    }

</script>


</body>
</html>