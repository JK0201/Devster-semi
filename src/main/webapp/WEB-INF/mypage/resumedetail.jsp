
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>
<html>
<head>
    <title>Title</title>
  <style>

        .file:hover{
            color: #EA3FF7;
            text-decoration: none;
        }
        span{
            border: #0D3EA3 1px solid;
            border-radius: 50px;
        }
        .quanbox{
            width: 1100px;
            height: 220px;
            margin: 32px auto;
            border-bottom: 1px solid #eee;
            padding-right: 20px;
        }
        .mainrpos{
            font-size: 30px;
        }
        .rpos{
            border: #cccccc 1px solid;
            border-radius: 50px;

        }
    </style>
</head>
<body>
<c:if test="${empty dto}">
    <button type="button" onclick="location.href='./writer'">Go to Write Form</button>
</c:if>
<div class="quanbox">
<c:if test="${not empty dto}">
    <table class="main2">
        <thead>개발 직무</thead>
        <thead> <span>${dto.r_pos}</thead>
        <tr>
            <td>개발 직무</td>
            <td><span class="rskill"> <div id="result"></div> </span></td>
        </tr>
 \
    </table>




자기소개  &nbsp; ${dto.r_self}<br>
포지션 &nbsp;&nbsp; ${dto.r_pos}<br>
스킬  &nbsp;&nbsp;<%-- ${dto.r_skill}--%> <br>
<%--    <div id="result">--%>
        <script>
            var existingSkills = "${dto.r_skill}".split(",");

            existingSkills.forEach(function (skill, index) {
                const skillElement = document.createElement("span");
                skillElement.textContent = skill.trim();
                document.getElementById("result").appendChild(skillElement);

                if (index !== existingSkills.length - 1) {
                    const separator = document.createTextNode('\u00A0'); // &nbsp;
                    document.getElementById("result").appendChild(separator);
                }
            });
        </script>
    </div>


    학교 &nbsp;&nbsp;  ${dto.r_gradecom} <br>
상태  &nbsp;&nbsp;  ${dto.r_sta} <br>

<fmt:formatDate value="${dto.r_gradestart}" pattern="yyyy-MM-dd" var="r_gradestart" />
<p>입학년도: ${r_gradestart}</p>
<fmt:formatDate value="${dto.r_gradeend}" pattern="yyyy-MM-dd" var="r_gradeend" />
<p>졸업년도: ${r_gradeend}</p> <br>

링크 &nbsp;&nbsp;  ${dto.r_link}
    <br>
    <c:forEach items="${clist}" var="car">
        <fmt:formatDate value="${car.r_carstartdate}" pattern="yyyy-MM-dd" var="r_carstartdate" />
        <fmt:formatDate value="${car.r_carenddate}" pattern="yyyy-MM-dd" var="r_carenddate" />
    company name: &nbsp;&nbsp;${car.r_company}<br>
    depart : &nbsp;&nbsp;${car.r_department}<br>
    position :  &nbsp;&nbsp;${car.r_position} <br>
    carstart : &nbsp;&nbsp;${r_carstartdate}<br>
    carend :  &nbsp;&nbsp;${r_carenddate}<br>
    <br>
</c:forEach>

<br><c:forEach items="${llist}" var="lic">
    <fmt:formatDate value="${lic.r_licdate}" pattern="yyyy-MM-dd" var="r_licdate" />
    ${r_licdate} &nbsp;
    ${lic.r_licname} <br>
</c:forEach>
    <a href="http://${imageUrl}/re_resume/${dto.r_refile}" download class="file">첨부파일</a> <br>
    <a href="http://${imageUrl}/re_resume/${dto.r_refile}" download class="file">이력서 파일</a> <br><br>
    <button type="button" onclick="location.href='../mypage/updateform?m_idx=${sessionScope.memidx}'"class="btn btn-outline-dark">수정</button>

</c:if>
</div>

</body>
</html>
