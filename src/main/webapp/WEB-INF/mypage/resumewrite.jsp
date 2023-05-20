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
        /*토글*/


        .toggle_box {
            display: flex;
            align-items: center;
            z-index: -1;
            margin-top: 20px;
        }

        #uptoggle {
            display: none;
        }

        #uptoggle + label.toggle_btn_label {
            position: relative;
            width: 8rem;
            height: 2.9rem; /* 높이를 10px 줄임 */
            margin-left: 600px;
        }

        #uptoggle + label.toggle_btn_label > span {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            border-radius: 40px;
            background-color:#F1DCF5;

            transition: all .4s;
        }

        #uptoggle + label.toggle_btn_label > span:before {
            display: flex;
            position: absolute;
            height: 2.4rem; /* 높이를 10px 줄임 */
            width: fit-content;
            padding: 0 1rem;
            left: 0.25rem;
            bottom: 0.25rem;
            border-radius: 20px;
            background-color: #fff;

            content: "비공개";
            align-items: center;
            font-weight: bold;
            color: rgb(29, 29, 29);

            -webkit-transition: all .4s;
            transition: all .4s;
        }

        #uptoggle:checked + label.toggle_btn_label > span {
            background-color: #EE64F5;
        }

        #uptoggle:checked + label.toggle_btn_label > span:before {
            -webkit-transform: translateX(calc(7.5rem - 100%)); /* 가로를 3분의 2로 줄임 */
            -ms-transform: translateX(calc(7.5rem - 100%));
            transform: translateX(calc(7.5rem - 100%));
            right: 0.25rem;
            bottom: 0.25rem;
            content: "공개";
        }

        #uptoggle:disabled + label.toggle_btn_label {
            display: none;
        }

        body, body * {
            font-family: 'Jua'
        }

        div.quanbu {
            width: 1000px;
            margin: 10px auto;
            padding-top: 10px;
            padding-right: 50px;
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
        .main2 {
            width: 1100px;
            /* border: 1px solid black;*/
        }
        .repoint{
            font-size: 30px;
            font-weight: bold;
        }
        #result span{
            display: inline-block;
            border: #E9D4F0 solid 1px; /* 테두리 색상과 초기 두께 설정 */
            background-color: #E9D4F0;
            border-radius: 70%;
            padding: 10px;
            font-size: 24px;
        }
        .main2 hr {
            border: none; /* 기본 선 제거 */
            height: 3px; /* 선의 두께 */
            background-color: black; /* 선의 색상 */
            width: 750px;
        }
        input{
            border: none;
            background-color: #EEEBF0;
            width: 800px;
            height: 45px;
            font-size: 22px;
        }
        textarea{
            border: none;
            background-color: #EEEBF0;
            width: 800px;
            height: 200px;
            font-size: 22px;
            border-radius: 20px;
        }

    </style>
</head>
<body>
<div class="quanbu">
    <form action="resumeinsert" enctype="multipart/form-data" method="post">

        <span class="rena"><B>${mdto.m_name}</B></span><br>
        <i class="bi bi-envelope reemail"></i> &nbsp;&nbsp; <span class="rein">${mdto.m_email}</span><br>
        <i class="bi bi-telephone reemail"></i> &nbsp;&nbsp; <span class="rein">${mdto.m_tele}</span>
        <div class="toggle_box">
            <input type="checkbox" id="uptoggle" name="r_status" value="${dto.r_status}" onchange="updateToggleValue()"></input>
            <label for="uptoggle" class="toggle_btn_label">
                <span></span>
            </label>
        </div>

        <!--hidden-->
        <input type="hidden" name="r_idx" value="${r_idx}">
        <input type="hidden" name="m_idx" value="${sessionScope.memidx}">

        <div id="r_pos" style="width: 800px; height: 200px;">
            <div  class="repoint">개발 직무</div>
            <HR>
            <br>
            <input type="text" name="r_pos" placeholder="직무를 작성해주세요">
        </div>

        <div id="r_skills" style="width: 800px; height: 200px;">
            <div  class="repoint">기술 스택(업무 툴/스킬)</div>
            <HR>
            <br>
            <input type="text" id="skillinput" placeholder="사용가능한 툴 ex:java">
        </div>
        <input type="hidden" id="r_skill" name="r_skill">
        <div id="result" ></div>

  <%--링크--%>
        <div class="repoint"  style="width: 800px; height: 180px;">링크 업로드
        <HR>
            <i class="bi bi-link-45deg" style="font-size: 30px"></i>
        <input type="text" name="r_link" placeholder="http://,https://를 포함해 작성해주세요." style="width: 750px">
        </div>

<%-- 학력--%>
        <div id="r_deg"style="width: 800px; height: 200px;" >
            <div  class="repoint">학력</div>
            <hr>
            <br>
            <div class="form-group-grade" style="width: 800px;">
                <input type="date" name="r_gradestart" class="r_gradestart" id="grade-start-date"
                       style="width: 175px; height: 45px;">
                <input type="date" name="r_gradeend" class="r_gradeend" id="grade-end-date"
                       style="width: 175px; height: 45px;">
                <input type="text" class="r_gradecom" name="r_gradecom" placeholder="학교명"
                       style="width: 280px; height: 45px;">
                <select class="grade-staus" name="r_sta" style="width: 150px; height: 45px;">
                    <option value="재학">재학</option>
                    <option value="졸업">졸업</option>
                </select>
            </div>
        </div>


    <%--경력--%>
        <div id="r_car" style="width: 800px; height: auto;">
            <div class="repoint">경력</div>
            <HR>
            <br>
            <div id="form-car">
                <div class="form-group" style="width: 800px;">
                    <input type="date"  class="r_carstartdate" name="r_carstartdate" id="car-start-date"
                           style="width: 280px; height: 45px;">
                    <input type="date" class="r_carenddate" name="r_carenddate" id="car-end-date"
                           style="width: 280px; height: 45px;">
                    <br><br>
                    <input type="text" class="r_company" name="r_company" placeholder="회사명" style="width: 250px; height: 45px;">
                    <input type="text" class="r_department" name="r_department" placeholder="부서" style="width: 250px; height: 45px;">
                    <input type="text" class="r_position" name="r_position" placeholder="직책" style="width: 250px; height: 45px;">
                </div>
            </div>
            <i class="bi bi-plus-square" id="car-add"></i>
        </div>

        <%-- 자격증--%>
        <br><br>
        <div id="r_deg"style="width: 800px; height: auto;" >
            <div  class="repoint">자격증</div>
            <hr>
            <br>
            <div id="form-lic">
                <div class="form-group-lic" style="width: 800px;height: auto">
                    <input type="date" name="r_licdate" id="lic-end-date" style="width: 250px; height: 40px;">&nbsp;&nbsp;
                    <input type="text" name="r_licname" placeholder="자격증" style="width: 520px; height: 40px;">
                </div>
            </div>
            <i class="bi bi-plus-square" id="lic-add"></i>
        </div>

        <%-- 간단 소개줄 --%>
        <br><br>
        <div id="r_deg"style="width: 800px; height: auto;" >
            <div  class="repoint">간단 소개줄</div>
            <hr>
            <br>
            <textarea name="r_self"
                      placeholder="   간단한 자기소개를 통해 이력서를 돋보이게 만들어보세요,(3~5줄 권장)"></textarea>
        </div>

        <br><br><br>

        <div id="r_deg" style="width: 800px; height: auto;" >
            <div  class="repoint">첨부파일 업로드<span style="font-size: 15px">(자격증,포트폴리오)</span></div>
            <hr>
            <br>
            <input type="file" name="upload_r" class="r_file">
        </div>

        <br><br>

        <div id="r_deg" style="width: 800px; height: auto;" >
            <div  class="repoint">이력서 업로드</div>
            <hr>
            <br>
            <input type="file" name="upload_re" class="r_refile">
        </div>

        <br><br>
        <div style="text-align: right;">
            <button type="submit"  class="btn btn-outline-dark">게시글등록   </button>
        </div>

    </form>
</div>
<script>
    //토글 이벤트
    function updateToggleValue() {
        var toggle = document.getElementById("uptoggle");
        if (toggle.checked) {
            toggle.value = "1";
        } else {
            toggle.value = "0";
        }
    }

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

                        const deleteButton = document.createElement("button"); // Create delete button
                        deleteButton.textContent = "X";
                        deleteButton.addEventListener("click", function () {
                            result.removeChild(span); // Remove the span element
                            result.removeChild(deleteButton); // Remove the delete button
                            r_text = r_text.replace(span.textContent + ",", ""); // Remove the value from the r_text variable
                            $("#r_skill").val(r_text); // Update the hidden input value
                        });

                        result.appendChild(span);
                        result.appendChild(deleteButton);
                        result.appendChild(document.createTextNode('\u00A0')); // &nbsp;

                        r_text += span.textContent + ',';
                    }
                });

                $("#r_skill").val(r_text);
                input.value = ""; // Clear the input field
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
        <br>
        <input type="date" class="r_carstartdate" name="r_carstartdate" id="car-start-date"
            style="width: 280px; height: 45px;">
        <input type="date" class="r_carenddate" name="r_carenddate" id="car-end-date"
            style="width: 280px; height: 45px;">
<br><br>
        <input type="text" class="r_company" name="r_company" placeholder="회사명" style="width: 250px; height: 45px;">

        <input type="text" class="r_department" name="r_department" placeholder="부서" style="width: 250px; height: 45px;">

        <input type="text" class="r_position" name="r_position" placeholder="직책" style="width: 250px; height: 45px;">


    `;
        form.appendChild(newInputGroup);

        // Get the input elements for the dates
        const startDateInputs = document.querySelectorAll('.r_carstartdate');
        const endDateInputs = document.querySelectorAll('.r_carenddate');

        // Loop through each input element and apply date restrictions
        startDateInputs.forEach(function (input) {
            const currentDate = new Date().toISOString().split('T')[0];
            input.setAttribute('max', currentDate);

            input.addEventListener('change', function () {
                const selectedDate = input.value;
                if (selectedDate > currentDate) {
                    alert('오늘 이후의 날짜는 선택할 수 없습니다.');
                    input.value = currentDate;
                }
            });
        });
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
<br>
      <input type="date" name="r_licdate" id="lic-end-date" style="width: 250px; height: 40px;">&nbsp;&nbsp;
                    <input type="text" name="r_licname" placeholder="자격증" style="width: 520px; height: 40px;">
    `;
        licform.appendChild(newInputGroup);

        // Get the input element for the date
        const dateInputlic = newInputGroup.querySelector('.lic-date');

        // Get the current date
        const currentDatelic = new Date().toISOString().split('T')[0];

        // Set the max attribute of the date input to the current date
        dateInputlic.setAttribute('max', currentDatelic);

        // Add event listener to check date on change
        dateInputlic.addEventListener('change', function () {
            const selectedDate = dateInputlic.value;
            if (selectedDate > currentDatelic) {
                alert('오늘 이후의 날짜는 선택할 수 없습니다.');
                dateInputlic.value = currentDatelic; // Reset the input value to current date
            }
        });
    });


    // 경력 날짜 제한 - 오늘 이후 금지
    // Get the input elements for start date and end date
    const carstartDateInput = document.getElementById('car-start-date');
    const carendDateInput = document.getElementById('car-end-date');

    // Add event listener to check date on change
    carendDateInput.addEventListener('change', function() {
        const carstartDate = new Date(carstartDateInput.value);
        const carendDate = new Date(carendDateInput.value);

        if (carstartDate > carendDate) {
            alert('입학 날짜보다 졸업 날짜가 더 빠를 수 없습니다.');
            carendDateInput.value = ''; // Reset the end date input value
        }
    });

    // Get the input element for the date
    const cargsdateInput = document.getElementById('car-start-date');
    const cargedateInput = document.getElementById('car-end-date');

    // Get the current date
    const cargscurrentDate = new Date().toISOString().split('T')[0];

    // Set the min and max attributes of the date inputs
    cargsdateInput.setAttribute('max', cargscurrentDate);
    cargedateInput.setAttribute('max', cargscurrentDate);

    // Add event listener to check date on change
    cargsdateInput.addEventListener('change', function() {
        const carselectedDate = cargsdateInput.value;

        if (carselectedDate > cargscurrentDate) {
            alert('오늘 이후의 날짜는 선택할 수 없습니다.');
            cargsdateInput.value = cargscurrentDate; // Reset the input value to current date
        }
    });

    cargedateInput.addEventListener('change', function() {
        const carselectedDate = cargedateInput.value;

        if (carselectedDate > cargscurrentDate) {
            alert('오늘 이후의 날짜는 선택할 수 없습니다.');
            cargedateInput.value = cargscurrentDate; // Reset the input value to current date
        }
    });

    // 학력 날짜 제한 - 오늘 이후 금지

    // Get the input elements for start date and end date
    const gradestartDateInput = document.getElementById('grade-start-date');
    const gradeendDateInput = document.getElementById('grade-end-date');

    // Add event listener to check date on change
    gradeendDateInput.addEventListener('change', function() {
        const gradestartDate = new Date(gradestartDateInput.value);
        const gradeendDate = new Date(gradeendDateInput.value);

        if (gradestartDate > gradeendDate) {
            alert('입학 날짜보다 졸업 날짜가 더 빠를 수 없습니다.');
            gradeendDateInput.value = ''; // Reset the end date input value
        }
    });

    // Get the input element for the date
    const gsdateInput = document.getElementById('grade-start-date');
    const gedateInput = document.getElementById('grade-end-date');

    // Get the current date
    const gscurrentDate = new Date().toISOString().split('T')[0];

    // Set the min and max attributes of the date inputs
    gsdateInput.setAttribute('max', gscurrentDate);
    gedateInput.setAttribute('max', gscurrentDate);

    // Add event listener to check date on change
    gsdateInput.addEventListener('change', function() {
        const gresselectedDate = gsdateInput.value;

        if (gresselectedDate > gscurrentDate) {
            alert('오늘 이후의 날짜는 선택할 수 없습니다.');
            gsdateInput.value = gscurrentDate; // Reset the input value to current date
        }
    });

    gedateInput.addEventListener('change', function() {
        const gresselectedDate = gedateInput.value;

        if (gresselectedDate > gscurrentDate) {
            alert('오늘 이후의 날짜는 선택할 수 없습니다.');
            gedateInput.value = gscurrentDate; // Reset the input value to current date
        }
    });
    // 자격증 날짜 제한 - 오늘 이후 금지

    // Get the input element for the date
    const balicdateInput = document.getElementById('lic-end-date');

    // Get the current date
    const baliccurrentDate = new Date().toISOString().split('T')[0];

    // Set the min and max attributes of the date input
    balicdateInput.setAttribute('max', baliccurrentDate);

    // Add event listener to check date on change
    balicdateInput.addEventListener('change', function() {
        const bagresselectedDate = balicdateInput.value;
        if (bagresselectedDate > baliccurrentDate) {
            alert('오늘 이후의 날짜는 선택할 수 없습니다.');
            balicdateInput.value = baliccurrentDate; // Reset the input value to current date
        }
    });

</script>
</body>
</html>