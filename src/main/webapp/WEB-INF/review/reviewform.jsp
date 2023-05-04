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
        body, body *{
            font-family: 'Jua'
        }
        .star-rb_star {
            border:solid 1px #ccc;
            display:flex;
            flex-direction: row-reverse;
            font-size:1.5em;
            justify-content:space-around;
            padding:0 .2em;
            text-align:center;
            width:5em;
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


    <img id="showimg">

 <form action="insert" method="post" enctype="multipart/form-data">


     <div style="width: 500px; margin-left: 100px;">
         <%-- 세션에서 로그인한 회원의 아이디를 가져옴 --%>
         <c:set var="m_idx"  value="${sessionScope.memidx}"/>
             <c:set var="m_nic"  value="${sessionScope.memnick}"/>

         <p>로그인한 회원: ${m_nic}</p>
             <input type="hidden" name="m_idx" value="${m_idx}">

         타입 : <select class="rb_type" name="rb_type" >
            <option value="1">면접 후기</option>
            <option value="2">코딩테스트 후기</option>
            <option value="3">합격 후기</option>
                </select>
         <br>
         <div class="star-rb_star">
             <input type="radio" id="5-stars" name="rb_star" value="5" />
             <label for="5-stars" class="star">&#9733;</label>
             <input type="radio" id="4-stars" name="rb_star" value="4" />
             <label for="4-stars" class="star">&#9733;</label>
             <input type="radio" id="3-stars" name="rb_star" value="3" />
             <label for="3-stars" class="star">&#9733;</label>
             <input type="radio" id="2-stars" name="rb_star" value="2" />
             <label for="2-stars" class="star">&#9733;</label>
             <input type="radio" id="1-star" name="rb_star" value="1" />
             <label for="1-star" class="star">&#9733;</label>
         </div>

         <textarea style="width: 80%; height: 100px" class="form-control rb_content" id="rb_content" name="rb_content"></textarea>

         <button type="submit">게시글등록</button>
     </div>



    </form>


</body>
</html>

