<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>


<html>
<head>
    <title>Title</title>
    <style>
        .quanbox {
            width: 1100px;
            height: 220px;
            margin: 10px auto;
            padding-top: 10px;
            padding-right: 20px;
        }

        .main2 {
            width: 1100px;
            /* border: 1px solid black;*/

        }

        .r_skill {
            display: inline-block;
            border: #cccccc solid 1px; /* 테두리 색상과 초기 두께 설정 */
            border-radius: 50px;
            padding: 10px;
            font-size: 24px;
        }

        .rpos {
            display: inline-block;
            border: #cccccc solid 1px; /* 테두리 색상과 초기 두께 설정 */
            border-radius: 50px;
            padding: 10px;
            font-size: 24px;
        }

        .grdinfo {
            font-size: 20px;
            color: #4c4c4c;

        }

        .grd2 {
            font-size: 22px;
            color: #4c4c4c;
        }

        .bi-circle {
            font-size: 10px;
        }

        .main2 hr {
            border: none; /* 기본 선 제거 */
            height: 3px; /* 선의 두께 */
            background-color: black; /* 선의 색상 */
        }


        .rena {
            font-size: 40px;
            line-height: 55px;
        }

        .rein {
            font-size: 20px;
            color: #4c4c4c;
        }

        .reemail {
            font-size: 20px;
            line-height: 40px;
        }
        .rewrite{
            width: 900px;
            height: 400px;
            margin: 10px auto;
            padding-top: 10px;
            padding-right: 20px;
            border-radius: 10px;
            background-color: #E7E2E7;
        }
      /*  .w-btn-green-outline{

          margin-left: 350px;
            margin-top: 40px;
        }*/
        .w-btn-green-outline {
            border: 3px solid #C973E8;
            color: darkgray;
            margin-left: 330px;
            margin-top: 30px;
        }
        .w-btn-outline {
            position: relative;
            padding: 15px 30px;
            border-radius: 15px;
            font-family: "paybooc-Light", sans-serif;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            font-weight: 600;
            transition: 0.25s;
        }
        .w-btn-green-outline {
            background-color: #9908CF;
            color: #d7fff1;
        }
        .w-btn-green-outline:hover {
            transform: scale(1.5);
            background-color: #9908CF;
            color: #d7fff1;}
        .resinfo{
            text-align: center;
            font-size: 30px;
            margin-top: 85px;
        }
    </style>


</head>
<body>
<c:if test="${empty dto}">
    <div class="rewrite">
        <div class="resinfo"><b>작성된 이력서가 없어요.</b>
            <br>
          <span style="font-size: 26px">이력서를 작성해주세요.</span>
        </div>
    <button type="button" class="w-btn-outline w-btn-green-outline" onclick="location.href='./writer'">이력서 작성하러 가기</button>
    </div>
</c:if>
<div class="quanbox">

    <c:if test="${not empty dto}">

    <fmt:formatDate value="${dto.r_gradestart}" pattern="yyyy-MM-dd" var="r_gradestart"/>
    <fmt:formatDate value="${dto.r_gradeend}" pattern="yyyy-MM-dd" var="r_gradeend"/>
    <span class="rena"><B>${name}</B></span><br>
    <i class="bi bi-envelope reemail"></i> &nbsp;&nbsp; <span class="rein">${email}</span><br>
    <i class="bi bi-telephone reemail"></i> &nbsp;&nbsp; <span class="rein">${tele}</span><br><br><br>

    <table class="main2">
        <thead></thead>
        <thead></thead>

        <tr style="height: 100px;">
            <td style="width: 200px;font-size: 26px; align-content: center"><b>개발 직무</b></td>
            <td><span class="rpos">${dto.r_pos}</span></td>
        </tr>

        <tr style="height: 100px;">
            <td style="width: 200px;font-size: 26px; align-content: center"><b>개발 스킬</b></td>
            <td style="width: 800px;font-size: 30px; text-align: left">
                <div id="result"></div>
            </td>
        </tr>
        <tr style="height: 30px;">
            <td colspan="2" style="width: 1000px;"></td>
        </tr>
        <tr style="height: 50px;">
            <td style="width: 200px;font-size: 28px; align-content: center"><b>학력</b></td>
            <td style="width: 800px;font-size: 30px; text-align: left"></td>
        </tr>
        <tr style="height: 10px;">
            <td colspan="2" style="width: 1000px;">
                <hr style="border-color: black;">
            </td>
        </tr>
        <tr style="height: 100px;">
            <td style="width: 400px;font-size: 25px; align-content: center">
                <i class="bi bi-circle"></i> <span class="grdinfo">${r_gradestart} 입학</span><br>
                <i class="bi bi-circle"></i> <span class="grdinfo"> ${r_gradeend} ${dto.r_sta}</span>
            </td>
            <td style="width: 800px;font-size: 30px; text-align: left">
                <span class="grd2">대학교</span> &nbsp;&nbsp;&nbsp;
                <span class="grd3"> <b>${dto.r_gradecom}</b></span>
            </td>
        </tr>

        <tr style="height: 25px;">
            <td colspan="2" style="width: 1000px;"></td>
        </tr>

        <tr style="height: 70px;">
            <td style="width: 200px;font-size: 28px; align-content: center"><b>경력(업무경험)</b></td>
            <td style="width: 800px;font-size: 30px; text-align: left">
            </td>
        </tr>
        <tr style="height: 10px;">
            <td colspan="2" style="width: 1000px;">
                <hr style="border-color: black;">
            </td>
        </tr>

        <c:forEach items="${clist}" var="car">
            <fmt:formatDate value="${car.r_carstartdate}" pattern="yyyy-MM" var="r_carstartdate"/>
            <fmt:formatDate value="${car.r_carenddate}" pattern="yyyy-MM" var="r_carenddate"/>


            <tr style="height: 100px;">
                <td style="width: 400px;font-size: 25px; vertical-align: top;">
                    <i class="bi bi-circle"></i>
                    <span class="grdinfo">${r_carstartdate} ~ &nbsp;${r_carenddate}</span><br>
                    <span class="grdinfo"></span>
                </td>
                <td style="width: 800px;font-size: 30px; text-align: left">
                    <span class="grd3"> <b>${car.r_company}</b></span> <br>
                    <span class="grd2">${car.r_department}</span><br>
                    <span class="grd2">${car.r_position}</span><br>
                </td>
            </tr>
            <tr style="height: 25px;">
                <td colspan="2" style="width: 1000px;"></td>
            </tr>
        </c:forEach>

        <tr style="height: 30px;">
            <td colspan="2" style="width: 1000px;"></td>
        </tr>
        <tr style="height: 50px;">
            <td style="width: 200px;font-size: 28px; align-content: center"><b>자격증</b></td>
            <td style="width: 800px;font-size: 30px; text-align: left">
            </td>
        </tr>
        <tr style="height: 10px;">
            <td colspan="2" style="width: 1000px;">
                <hr style="border-color: black;">
            </td>
        </tr>
        <tr>
            <c:forEach items="${llist}" var="lic">
                <fmt:formatDate value="${lic.r_licdate}" pattern="yyyy-MM-dd" var="r_licdate"/>
        <tr style="height: 15px;">
            <td colspan="2" style="width: 1000px;"></td>
        </tr>
        <td style="width: 400px; font-size: 25px; align-content: center">
            <i class="bi bi-circle"></i> <span class="grdinfo">${r_licdate} </span><br>
            <span class="grdinfo"></span>
        </td>
        <td style="width: 800px; font-size: 30px; text-align: left">
            <span class="grd3"><b>${lic.r_licname}</b></span>
        </td>
        </tr>

        </c:forEach>


        <tr style="height: 30px;">
            <td colspan="2" style="width: 1000px;"></td>
        </tr>
        <tr style="height: 50px;">
            <td style="width: 200px;font-size: 28px; align-content: center"><b>링크</b></td>
            <td style="width: 800px;font-size: 30px; text-align: left"></td>
        </tr>
        <tr style="height: 10px;">
            <td colspan="2" style="width: 1000px;">
                <hr style="border-color: black;">
            </td>
        </tr>
        <tr style="height: 100px;">
            <td style="width: 400px;font-size: 25px; align-content: center">
                <i class="bi bi-circle"></i> <span class="grdinfo">개인 블로그</span>
                <span class="grdinfo"></span>
            </td>
            <td style="width: 800px;font-size: 30px; text-align: left">
                <span class="grd3"><b><a id="link" href="${dto.r_link}">${dto.r_link}</a></b></span>
                <span class="grd2"> </span>
            </td>
        </tr>

        <tr style="height: 30px;">
            <td colspan="2" style="width: 1000px;"></td>
        </tr>
        <tr style="height: 50px;">
            <td style="width: 200px;font-size: 28px; align-content: center"><b>첨부파일</b></td>
            <td style="width: 800px;font-size: 30px; text-align: left"></td>
        </tr>
        <tr style="height: 10px;">
            <td colspan="2" style="width: 1000px;">
                <hr style="border-color: black;">
            </td>
        </tr>
        <tr style="height: 100px;">
            <td style="width: 400px;font-size: 25px; align-content: center">
                <i class="bi bi-circle"></i> <span class="grdinfo">이력서</span><br>
                <i class="bi bi-circle"></i> <span class="grdinfo">자격증</span>
            </td>
            <td style="width: 800px;font-size: 30px; text-align: left">
              <span class="grd2">
                <b> <a href="http://${imageUrl}/re_resume/${dto.r_refile}" download class="file">제출한 이력서</a></b>
                 </span>
                <br>
                <span class="grd2">
                <b><a href="http://${imageUrl}/re_resume/${dto.r_refile}" download class="file">제출한 첨부파일</a></b>
               </span>
            </td>
        </tr>
    </table>
    <div style="text-align: right;">
        <button type="button" onclick="location.href='../mypage/updateform?m_idx=${sessionScope.memidx}'"
                class="btn btn-outline-dark btndresume">수정
        </button>
    </div>
    <div style="height: 120px; width: 1000px; "></div>
</div>
</c:if>
</body>
<script>

    //skill 이벤트
    var existingSkills = "${dto.r_skill}".split(",");

    existingSkills.forEach(function (skill, index) {
        const skillElement = document.createElement("span");
        skillElement.classList.add("r_skill");
        skillElement.textContent = skill.trim();
        document.getElementById("result").appendChild(skillElement);

        if (index !== existingSkills.length - 1) {
            const separator = document.createTextNode('\u00A0'); // &nbsp;
            document.getElementById("result").appendChild(separator);
        }
    });

</script>
</html>
