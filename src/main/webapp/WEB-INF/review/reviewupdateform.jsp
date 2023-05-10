<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-04
  Time: PM 3:37
  To change this template use File | Settings | File Templates.
--%>
<<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-03
  Time: PM 2:39
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

        .star-rb_star {
           /* border: solid 1px #ccc;*/
            display: flex;
            flex-direction: row-reverse;
            font-size: 1.5em;
            justify-content: space-around;
            padding: 0 .2em;
            text-align: center;
            width: 5em;
        }

        .star-rb_star input {
            display: none;
        }

        .star-rb_star label {
            color: #ccc;
            cursor: pointer;
        }

        .star-rb_star :checked ~ label {
            color: #f90;
        }

        .star-rb_star label:hover,
        .star-rb_star label:hover ~ label {
            color: #fc0;
        }

        /* explanation */

        article {
            background-color: #ffe;
            box-shadow: 0 0 1em 1px rgba(0, 0, 0, .25);
            color: #006;
            font-family: cursive;
            font-style: italic;
            margin: 4em;
            max-width: 30em;
            padding: 2em;
        }
    </style>
</head>
<body>



<form name="update-form">


    <div style="width: 500px; margin-left: 100px;">
        <%-- 세션에서 로그인한 회원의 아이디를 가져옴 --%>
        <input type="hidden" name="rb_idx" value="${dto.rb_idx}">

        <c:set var="m_idx" value="${sessionScope.memidx}"/>
        <c:set var="m_nic" value="${sessionScope.memnick}"/>

        <p>로그인한 회원: ${m_nic}</p>
        <input type="hidden" name="m_idx" value="${m_idx}" >

        타입 : <select class="rb_type" name="rb_type">
        <option value="1"${dto.rb_type == 1 ? 'selected' : ''}>면접 후기</option>
        <option value="2"${dto.rb_type == 2 ? 'selected' : ''}>코딩테스트 후기</option>
        <option value="3"${dto.rb_type == 3 ? 'selected' : ''}>합격 후기</option>
    </select>
            <input id="rearch-input" type="text" name="ci_idx" >
            <div id="search-result"></div>
        <br>

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
                <input type="radio" id="1-stars" name="rb_star" value="1"checked="checked"/>
                <label for="1-stars" class="star">&#9733;</label>
            </c:if>
            <c:if test="${dto.rb_star == 2}">
                <input type="radio" id="5-stars" name="rb_star" value="5"/>
                <label for="5-stars" class="star">&#9733;</label>
                <input type="radio" id="4-stars" name="rb_star" value="4"/>
                <label for="4-stars" class="star">&#9733;</label>
                <input type="radio" id="3-stars" name="rb_star" value="3"/>
                <label for="3-stars" class="star">&#9733;</label>
                <input type="radio" id="2-stars" name="rb_star" value="2"checked="checked"/>
                <label for="2-stars" class="star">&#9733;</label>
                <input type="radio" id="1-stars" name="rb_star" value="1"/>
                <label for="1-stars" class="star">&#9733;</label>
            </c:if>
            <c:if test="${dto.rb_star == 3}">
                <input type="radio" id="5-stars" name="rb_star" value="5"/>
                <label for="5-stars" class="star">&#9733;</label>
                <input type="radio" id="4-stars" name="rb_star" value="4"/>
                <label for="4-stars" class="star">&#9733;</label>
                <input type="radio" id="3-stars" name="rb_star" value="3"checked="checked"/>
                <label for="3-stars" class="star">&#9733;</label>
                <input type="radio" id="2-stars" name="rb_star" value="2"/>
                <label for="2-stars" class="star">&#9733;</label>
                <input type="radio" id="1-stars" name="rb_star" value="1"/>
                <label for="1-stars" class="star">&#9733;</label>
            </c:if>
            <c:if test="${dto.rb_star == 4}">
                <input type="radio" id="5-stars" name="rb_star" value="5"/>
                <label for="5-stars" class="star">&#9733;</label>
                <input type="radio" id="4-stars" name="rb_star" value="4"checked="checked"/>
                <label for="4-stars" class="star">&#9733;</label>
                <input type="radio" id="3-stars" name="rb_star" value="3"/>
                <label for="3-stars" class="star">&#9733;</label>
                <input type="radio" id="2-stars" name="rb_star" value="2"/>
                <label for="2-stars" class="star">&#9733;</label>
                <input type="radio" id="1-stars" name="rb_star" value="1"/>
                <label for="1-stars" class="star">&#9733;</label>
            </c:if>
            <c:if test="${dto.rb_star == 5}">
                <input type="radio" id="5-stars" name="rb_star" value="5"checked="checked"/>
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

        <textarea style="width: 80%; height: 100px" class="form-control rb_content" id="rb_content" name="rb_content">
           ${dto.rb_content}</textarea>

        <button type="button" id="btnup">게시글등록</button>
        <button type="button" onclick="history.back()">뒤로가기</button>

    </div>
</form>
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

    $("#btnup").click(function (){
        var rb_type = $(".rb_type").val();
        var rb_star = $("input[name='rb_star']:checked").val();
        var rb_content = $(".rb_content").val();
        var m_idx = $("input[name='m_idx']").val();
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
                "ci_idx": ci_idx

            },

            method: 'post',
            success : function (res) {
                alert("수정 완료");
                location.href="list";
            }

        });
    }

</script>
</body>
</html>

