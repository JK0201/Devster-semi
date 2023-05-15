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

        div.quanbu {
            padding: 50px;
        }

        span {
            display: inline-block;
            border-radius: 20%;
            background-color: skyblue;
        }

        #car-start-date {
            width: 120px;
        }

        #car-end-date {
            width: 120px;
        }
    </style>
</head>
<body>
<div class="quanbu">
    <div id="r_intro" style="width: 800px;">
        <div style="font-size: 20px">간단 소개줄</div>
        <HR>
        <div style="background-color: #F3F9FE;">
            * 본인의 업무 경험을 기반으로 핵심역량과업무 스킬을 간단히 작성해주세요.<br>
            * 3~5줄로 요약하여 작성하는 것을 추천합니다.
        </div>

        <br>
        <textarea style="width: 800px;height: 150px;border: none " class="r_self"
                  placeholder="간단한 자기소개를 통해 이력서를 돋보이게 만들어보세요,(3~5줄 권장)" ;></textarea>

    </div>

    <div id="r_car" style="width: 800px; height: 300px;">
        <div style="font-size: 20px">경력</div>
        <HR>
        <div style="background-color: #F3F9FE; font-size: 15px">
            * 담당하신 업무 중 우선순위가 높은 업무를 선별하여 최신순으로 작성해주세요.<br>
            * 신입의 경우, 직무와 관련된 대외활동, 인턴, 계약직 경력 등이 있다면 작성해주세요.<br>
            * 업무 또는 활동 시 담당했던 역할과 과정, 성과에 대해 자세히 작성해주세요.<br>
            * 업무 성과는 되도록 구체적인 숫자 혹은 [%]로 표현해주세요.<br>
        </div>
        <br>
        <form id="form-car">
            <div class="form-group" style="width: 800px;">
                <input type="date"  class="r_carstartdate" name="carstartdate" id="car-start-date">
                <input type="date" class="r_carenddate" name="carenddate" id="car-end-date">
                <input type="text" class="r_company" name="company" placeholder="회사명">
                <input type="text" class="r_department" name="department" placeholder="부서">
                <input type="text" class="r_position" name="position" placeholder="직책">
            </div>
        </form>
        <i class="bi bi-plus-square" id="car-add"></i>
    </div>

    <div id="r_pos" style="width: 800px; height: 300px;">
        <div style="font-size: 20px">포지션</div>
        <HR>
        <div style="background-color: #F3F9FE; font-size: 15px">
            * 지원하는 포지션을 작성해주세요.<br>
        </div>
        <br>
        <input type="text" class="r_pos" placeholder="포지션" style="width: 300px">
    </div>

    <div id="r_deg" style="width: 800px; height: 300px;">
        <div style="font-size: 20px">학력</div>
        <hr>
        <div style="background-color: #F3F9FE; font-size: 15px">
            * 최종학력으로 작성해주세요.<br>
        </div>
        <br>
        <div class="form-group-grade" style="width: 800px;">
            <input type="date" class="r_gradestart" name="gradestartdate" id="grade-start-date">
            <input type="date" class="r_gradeend" name="gradeenddate" id="grade-end-date">
            <input type="text" class="r_gradecom"  name="company" placeholder="학교명">
            <select name="grade-staus" class="r_sta">
                <option value="재학">재학</option>
                <option value="졸업">졸업</option>
            </select>
        </div>
    </div>


<div id="r_skill" style="width: 800px; height: 300px;">
    <div style="font-size: 20px">스킬</div>
    <HR>
    <div style="background-color: #F3F9FE; font-size: 15px">
        * 개발스택,디자인 툴, 마케팅 툴등 가지고 있는 직무와 관련된 스킬을 추가해보세요.<br>
        * 데이터분석 툴이나 협업 툴 등의 사용해본 경험이 있으신 툴들고 추가해보세요.
    </div>
    <br>
    <input type="text"  id="skillinput" placeholder="사용가능한 툴 ex:java" style="width: 300px">
</div>
<div id="result" class="r_skill"></div>


<div id="r_lic" style="width: 800px; height: 300px;">
    <div style="font-size: 20px">자격증</div>
    <hr>
    <div style="background-color: #F3F9FE; font-size: 15px">
        * 자격증을 보유한 경우 작성해주세요.<br>
    </div>
    <br>
    <form id="form-lic">
        <div class="form-group-lic" style="width: 800px;">
            <input type="date" class="r_licdate" id="lic-date">
            <input type="text" class="r_licname" placeholder="자격증" style="width: 300px">
        </div>
    </form>
    <i class="bi bi-plus-square" id="lic-add"></i>
</div>

<div id="r_file"  style="width: 800px; height: 300px;">
    <div style="font-size: 20px">첨부파일 업로드</div>
    <HR>
    <div style="background-color: #F3F9FE; font-size: 15px">
        * 자격증 파일을 업로드 해주세요.<br>
        * 하나의 pdf 로 업로드 해주세요.
    </div>
    <br>
    <input type="file" class="r_file">
    <br><br>
    <div style="font-size: 20px">이력서 업로드</div>
    <HR>
    <div style="background-color: #F3F9FE; font-size: 15px" class="">
        * 이력서 파일을 업로드 해주세요.<br>
    </div>
    <br>
    <input type="file" class="r_refile">
    <br><br>
    <div style="font-size: 20px">링크 업로드</div>
    <HR>
    <div style="background-color: #F3F9FE; font-size: 15px">
        * 깃허브, 깃랩, 블로그 주소를 입력해주세요.<br>
    </div>
    <input type="text" style="width: 300px" class="r_link">
    <br><br><br>
</div>

</div>
<script>
    //skill ajax 이벤트
    document.addEventListener("DOMContentLoaded", function () {
        const input = document.getElementById("skillinput");
        const result = document.getElementById("result");

        input.addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
                const value = input.value;
                const xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        const searchResult = xhr.responseText;
                        const span = document.createElement("span");
                        span.textContent = searchResult;
                        result.appendChild(span);
                        result.appendChild(document.createTextNode('\u00A0')); // &nbsp;
                    }
                };
                xhr.open("POST", "/resume/search");
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.send("q=" + encodeURIComponent(value));
                input.value = "";
            }
        });
    });
    //경력 + 이벤트
    const addInputButton = document.getElementById("car-add");
    const form = document.getElementById("form-car");
    let inputCount = 1;

    addInputButton.addEventListener("click", function () {
        inputCount++;
        const newInputGroup = document.createElement("div");
        newInputGroup.classList.add("form-group");
        newInputGroup.innerHTML = `

             <input type="date" name="date${inputCount}" id="car-start-date" >
            <input type="date" name="date${inputCount}"  id="car-end-date">
            <input type="text" name="company${inputCount}" placeholder="회사명">
            <input type="text" name="department${inputCount}" placeholder="부서">
            <input type="text" name="position${inputCount}" placeholder="직책">
        `;
        form.appendChild(newInputGroup);
    });
    //자격증 + 이벤트
    const addInputlic = document.getElementById("lic-add");
    const licform = document.getElementById("form-lic");
    let inputCountlic = 1;

    addInputlic.addEventListener("click", function () {
        inputCountlic++;
        const newInputGroup = document.createElement("div");
        newInputGroup.classList.add("form-group-lic");
        newInputGroup.innerHTML = `
      <input type="date" id="lic-date">
      <input type="text" placeholder="자격증" style="width: 300px">
    `;
        licform.appendChild(newInputGroup);
    });
</script>
</body>
</html>