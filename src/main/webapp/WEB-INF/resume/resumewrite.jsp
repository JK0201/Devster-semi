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
    <form action="resumeinsert" enctype="multipart/form-data" method="post">

        <!--hidden-->
        <input type="hidden" name="r_idx" value="${r_idx}">
        <input type="hidden" name="m_idx" value="${sessionScope.memidx}">
        <div id="r_intro" style="width: 800px;">
            <div style="font-size: 20px">간단 소개줄</div>
            <HR>
            <div style="background-color: #FFF2FE;">
                * 본인의 업무 경험을 기반으로 핵심역량과업무 스킬을 간단히 작성해주세요.<br>
                * 3~5줄로 요약하여 작성하는 것을 추천합니다.
            </div>

            <br>
            <textarea style="width: 800px;height: 150px;border: none " name="r_self"
                      placeholder="간단한 자기소개를 통해 이력서를 돋보이게 만들어보세요,(3~5줄 권장)"></textarea>

        </div>

        <div id="r_car" style="width: 800px; height: 300px;">
            <div style="font-size: 20px">경력</div>
            <HR>
            <div style="background-color: #FFF2FE; font-size: 15px">
                * 담당하신 업무 중 우선순위가 높은 업무를 선별하여 최신순으로 작성해주세요.<br>
                * 신입의 경우, 직무와 관련된 대외활동, 인턴, 계약직 경력 등이 있다면 작성해주세요.<br>
                * 업무 또는 활동 시 담당했던 역할과 과정, 성과에 대해 자세히 작성해주세요.<br>
                * 업무 성과는 되도록 구체적인 숫자 혹은 [%]로 표현해주세요.<br>
            </div>
            <br>
            <div id="form-car">
                <div class="form-group" style="width: 800px;">
                    <input type="date"  class="r_carstartdate" name="r_carstartdate" id="car-start-date">
                    <input type="date" class="r_carenddate" name="r_carenddate" id="car-end-date">
                    <input type="text" class="r_company" name="r_company" placeholder="회사명">
                    <input type="text" class="r_department" name="r_department" placeholder="부서">
                    <input type="text" class="r_position" name="r_position" placeholder="직책">
                </div>
            </div>
            <i class="bi bi-plus-square" id="car-add"></i>
        </div>


        <div id="r_pos" style="width: 800px; height: 300px;">
            <div style="font-size: 20px">포지션</div>
            <HR>
            <div style="background-color: #FFF2FE; font-size: 15px">
                * 지원하는 포지션을 작성해주세요.<br>
            </div>
            <br>
            <input type="text" name="r_pos" placeholder="포지션" style="width: 300px">
        </div>

        <div id="r_deg" style="width: 800px; height: 300px;">
            <div style="font-size: 20px">학력</div>
            <hr>
            <div style="background-color: #FFF2FE; font-size: 15px">
                * 최종학력으로 작성해주세요.<br>
            </div>
            <br>
            <div class="form-group-grade" style="width: 800px;">
                <input type="date" name="r_gradestart" class="r_gradestart" id="grade-start-date">
                <input type="date" name="r_gradeend" class="r_gradeend" id="grade-end-date">
                <input type="text" class="r_gradecom" name="r_gradecom" placeholder="학교명">
                <select class="grade-staus" name="r_sta">
                    <option value="재학">재학</option>
                    <option value="졸업">졸업</option>
                </select>
            </div>
        </div>

                <div id="r_skills" style="width: 800px; height: 300px;">
                    <div style="font-size: 20px">스킬</div>
                    <HR>
                    <div style="background-color: #FFF2FE; font-size: 15px">
                        * 개발스택,디자인 툴, 마케팅 툴등 가지고 있는 직무와 관련된 스킬을 추가해보세요.<br>
                        * 데이터분석 툴이나 협업 툴 등의 사용해본 경험이 있으신 툴들고 추가해보세요.
                    </div>
                    <br>
                    <input type="text" id="skillinput" placeholder="사용가능한 툴 ex:java" style="width: 300px">
                </div>
        <input type="hidden" id="r_skill" name="r_skill">
                <div id="result" ></div>


                <div id="r_lic" style="width: 800px; height: 300px;">
                    <div style="font-size: 20px">자격증</div>
                    <hr>
                    <div style="background-color: #FFF2FE; font-size: 15px">
                        * 자격증을 보유한 경우 작성해주세요.<br>
                    </div>
                    <br>
                    <div id="form-lic">
                        <div class="form-group-lic" style="width: 800px;">
                            <input type="date" name="r_licdate" id="lic-date">
                            <input type="text" name="r_licname" placeholder="자격증" style="width: 300px">
                        </div>
                    </div>
                    <i class="bi bi-plus-square" id="lic-add"></i>
                </div>



        <div id="r_file" style="width: 800px; height: 300px;">
            <div style="font-size: 20px">첨부파일 업로드</div>
            <HR>
            <div style="background-color: #FFF2FE; font-size: 15px">
                * 자격증 파일을 업로드 해주세요.<br>
                * 하나의 pdf 로 업로드 해주세요.
            </div>
            <br>
            <input type="file" name="upload_r" class="r_file">
            <br><br>
            <div style="font-size: 20px">이력서 업로드</div>
            <HR>
            <div style="background-color: #FFF2FE; font-size: 15px" class="">
                * 이력서 파일을 업로드 해주세요.<br>
            </div>
            <br>
            <input type="file" name="upload_re" class="r_refile">
            <br><br>
            <div style="font-size: 20px">링크 업로드</div>
            <HR>
            <div style="background-color: #FFF2FE; font-size: 15px">
                * 깃허브, 깃랩, 블로그 주소를 입력해주세요.<br>
            </div>
            <input type="text" style="width: 300px" name="r_link">
            <br><br><br>
            <button type="submit">게시글등록</button>
        </div>
    </form>
</div>
<script>
    //skill ajax 이벤트
    document.addEventListener("DOMContentLoaded", function () {
        const input = document.getElementById("skillinput");
        const result = document.getElementById("result");
        let r_text = "";

        input.addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
                event.preventDefault(); // Prevent the default form submission behavior
                const values = input.value.split(","); // Split the input value into an array of values

                values.forEach(function (value) {
                    if (value.trim() !== "") { // Ignore empty values
                        const span = document.createElement("span");
                        span.textContent = value.trim();
                        r_text += span.textContent + ',';
                        result.appendChild(span);
                        result.appendChild(document.createTextNode('\u00A0')); // &nbsp;
                    };
                });
                $("#r_skill").val(r_text);
                input.value = ""; // Clear the input field
            };
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
            <input type="date" name="r_carstartdate" id="car-start-date" >
            <input type="date" name="r_carenddate"  id="car-end-date">
            <input type="text" name="r_company" placeholder="회사명">
            <input type="text" name="r_department" placeholder="부서">
            <input type="text" name="r_position" placeholder="직책">
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
      <input type="date" id="lic-date" name="r_licdate">
      <input type="text" placeholder="자격증" style="width: 300px" name="r_licname">
    `;
        licform.appendChild(newInputGroup);
    });


        // Get the input element for the date
        const dateInputcar = document.getElementById('car-start-date');

        // Get the current date
        const currentDatecar = new Date().toISOString().split('T')[0];

        // Set the min attribute of the date input to the current date
        dateInputcar.setAttribute('max', currentDatecar);

        // Add event listener to check date on change
        dateInputcar.addEventListener('change', function() {
        const selectedDate = dateInputcar.value;
        if (selectedDate > currentDatecar) {
        alert('오늘 이후의 날짜는 선택할 수 없습니다.');
        dateInputcar.value = currentDatecar; // Reset the input value to current date
    }
    });
        // Get the input element for the date
        const dateInput = document.getElementById('car-end-date');

        // Get the current date
        const currentDate = new Date().toISOString().split('T')[0];

        // Set the min attribute of the date input to the current date
        dateInput.setAttribute('max', currentDate);

        // Add event listener to check date on change
        dateInput.addEventListener('change', function() {
        const selectedDate = dateInput.value;
        if (selectedDate > currentDate) {
        alert('오늘 이후의 날짜는 선택할 수 없습니다.');
        dateInput.value = currentDate; // Reset the input value to current date
    }
    });

        // Get the input element for the date
        const gsdateInput = document.getElementById('grade-start-date');

        // Get the current date
        const gscurrentDate = new Date().toISOString().split('T')[0];

        // Set the min attribute of the date input to the current date
        gsdateInput.setAttribute('max', gscurrentDate);

        // Add event listener to check date on change
        gsdateInput.addEventListener('change', function() {
        const selectedDate = gsdateInput.value;
        if (selectedDate > gscurrentDate) {
        alert('오늘 이후의 날짜는 선택할 수 없습니다.');
        gsdateInput.value = gscurrentDate; // Reset the input value to current date
    }
    });
        // Get the input element for the date
        const gedateInput = document.getElementById('grade-end-date');

        // Get the current date
        const gecurrentDate = new Date().toISOString().split('T')[0];

        // Set the min attribute of the date input to the current date
        gedateInput.setAttribute('max', gecurrentDate);

        // Add event listener to check date on change
        gedateInput.addEventListener('change', function() {
        const selectedDate = gedateInput.value;
        if (selectedDate > gecurrentDate) {
        alert('오늘 이후의 날짜는 선택할 수 없습니다.');
        dateInput.value = gecurrentDate; // Reset the input value to current date
    }
    });

        // Get the input element for the date
        const licdateInput = document.getElementById('lic-date');

        // Get the current date
        const liccurrentDate = new Date().toISOString().split('T')[0];

        // Set the min attribute of the date input to the current date
        licdateInput.setAttribute('max', liccurrentDate);

        // Add event listener to check date on change
        licdateInput.addEventListener('change', function() {
        const selectedDate = licdateInput.value;
        if (selectedDate > liccurrentDate) {
        alert('오늘 이후의 날짜는 선택할 수 없습니다.');
        licdateInput.value = liccurrentDate; // Reset the input value to current date
    }
    });


</script>
</body>
</html>