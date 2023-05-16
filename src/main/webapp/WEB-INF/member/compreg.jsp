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
    </style>
</head>
<body>
<input type="text" id="cm_reg">
<button type="button" id="regbtn" disabled>확인</button>
<span id="regchk"></span>
<script>
    let regvaild = false;
    let regcheck = false;

    $("#cm_reg").keyup(function () {
        var cm_reg = $("#cm_reg").val();

        //comp reg pattern
        function validReg(reg) {
            let regPattern = /^[0-9]{1,10}$/;
            return regPattern.test(reg);
        }

        if (!validReg(cm_reg)) {
            $("#regchk").html("<i class='bi bi-x' style='color:red;'></i>" +
                "<span>사업자 등록번호를 확인해 주세요</span>");
            regvaild = false;
        } else {
            var data = {"b_no": ["" + cm_reg + ""]};
            $.ajax({
                type: "get",
                url: "compregchk",
                data: {"cm_reg": cm_reg},
                dataType: "json",
                success: function (res) {
                    if (res.result == "yes") {
                        regvaild=true;

                        $.ajax({
                            url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=kYbAam15j7wPd1O5PHbUtOdqbBzCRyOv4LQ%2BFuiG2nEg%2B4SdfDDlD73gLiTvIHJ61svb7odiR3FCaNr%2FmHBEyQ%3D%3D",  // serviceKey 값을 xxxxxx에 입력
                            type: "POST",
                            data: JSON.stringify(data),
                            dataType: "JSON",
                            contentType: "application/json",
                            accept: "application/json",
                            success: function (res) {
                                code = res.data[0].b_stt_cd;
                                b_no = res.data[0].b_no;

                                if (code == "01") {
                                    $("#regchk").html("정상적인 사업자번호입니다");
                                    regcheck = true;
                                } else if (code == "02") {
                                    $("#regchk").html("휴/폐업한 사업자번호입니다");
                                    regcheck = false;
                                } else {
                                    $("#regchk").html("등록되지 않은 사업자 번호입니다");
                                    regcheck = false;
                                }
                            }
                        });
                    } else {
                        $("#regchk").html("등록되지 않은 사업자 번호입니다");
                        regcheck = false;
                        return false;
                    }
                }
            });
        }
    });

    $(document).on("mouseover keyup",function(){
       if(regcheck && regvaild) {
           $("#regbtn").prop("disabled",false);
           console.log(regcheck);
           console.log(regvaild);
       }
       else {
           $("#regbtn").prop("disabled",true);
           console.log(regcheck);
           console.log(regvaild);
       }
    });

    $("#regbtn").click(function(){
       if(!regcheck||!regvaild) {
           alert("사업자 등록번호를 확인해주세요");
       }else {
           alert("굿");
       }
    });
</script>
</body>
</html>
