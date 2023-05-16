<%--
  Created by IntelliJ IDEA.
  User: JuminManeul
  Date: 2023-05-11
  Time: 오전 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

    </style>
    <script>
        function showCompanyInfo(other_nick) {
            $.ajax({
                url: "/message/other_profile",
                type: "GET",
                dataType: "JSON",
                data: {"other_nick": other_nick},
                success: function (res) {
                    let s = "";

                    $.each(res.blist, function (idx, ele) {


                        s += `
                          <div class="incoming_msg">
                            보낸사람: \${ele.send_nick}
                            받은사람: \${ele.recv_nick} 명
                            보낸시간: \${ele.send_time}
                            받은시간: \${ele.read_time}
                            내용: \${ele.content}
                          </div>
                        `;
                    });
                    $("div.carlist").html(s);
                }
            });
        };

        showCompanyInfo('${other_nick}');
    </script>
</head>
<body>




<div class="carlist">

</div>

</body>
</html>




