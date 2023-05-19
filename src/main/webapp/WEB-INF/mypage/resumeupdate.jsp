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
            position: relative;
            width: 1140px;
            padding: 50px;
            padding-bottom: 50px;
            padding-left: 250px;
        }

        hr {
            width: 1100px;
        }

        #r_ * {
            height: 300px;
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

        /*토글*/

        .toggle_box {
            display: flex;
            align-items: center;
            z-index: -1;
            margin-top: 20px;
        }

        #custom_input {
            display: none;
        }

        #custom_input + label.toggle_btn_label {
            position: relative;
            width: 12rem;
            height: 3rem;
        }

        #custom_input + label.toggle_btn_label > span {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            border-radius: 40px;
            background-color: #ccc;

            transition: all .4s;

        }

        #custom_input + label.toggle_btn_label > span:before {
            display: flex;
            position: absolute;
            height: 2.5rem;
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

        #custom_input:checked + label.toggle_btn_label > span {
            background-color: black;
        }

        #custom_input:checked + label.toggle_btn_label > span:before {
            -webkit-transform: translateX(calc(11.5rem - 100%));
            -ms-transform: translateX(calc(11.5rem - 100%));
            transform: translateX(calc(11.5rem - 100%));
            right: 0.25rem;
            bottom: 0.25rem;
            content: "공개";
        }

        #custom_input:disabled + label.toggle_btn_label {
            display: none;
        }
    </style>
</head>
<body>
<div class="quanbu">
    <form action="resumeupdate" enctype="multipart/form-data" method="post">
        <%--hidden--%>
        <input type="hidden" name="r_idx" value="${dto.r_idx}">
        <input type="hidden" name="m_idx" value="${sessionScope.memidx}">


            <div class="toggle_box">
                <c:if test="${dto.r_status == 1}">
                    <input type="checkbox" id="custom_input" name="r_status" value="${dto.r_status}" checked onchange="updateToggleValue()">
                </c:if>
                <c:if test="${dto.r_status != 1}">
                    <input type="checkbox" id="custom_input" name="r_status" value="${dto.r_status}" onchange="updateToggleValue()">
                </c:if>
                <label for="custom_input" class="toggle_btn_label">
                    <span></span>
                </label>
            </div>

            <script>
                function updateToggleValue() {
                    var toggle = document.getElementById("custom_input");
                    if (toggle.checked) {
                        toggle.value = "1";
                    } else {
                        toggle.value = "0";
                    }
                }
            </script>

            <div id="r_intro">
            <div style=" font-size: 20px">간단 소개줄</div>
            <hr>
            <div style="background-color: #FFF2FE;">
                * 본인의 업무 경험을 기반으로 핵심역량과업무 스킬을 간단히 작성해주세요.<br>
                * 3~5줄로 요약하여 작성하는 것을 추천합니다.
            </div>
            <br>
            <textarea style="width: 1140px;height: 150px;border: none " name="r_self">${dto.r_self}</textarea>
        </div>

        <div id="r_car" style="width: 1140px; height: 300px;">
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
                <c:forEach items="${clist}" var="car">
                    <fmt:formatDate value="${car.r_carstartdate}" pattern="yyyy-MM-dd" var="r_carstartdate"/>
                    <fmt:formatDate value="${car.r_carenddate}" pattern="yyyy-MM-dd" var="r_carenddate"/>

                    <div class="form-group" style="width: 800px;">
                        <input type="hidden" value="${car.recar_idx}" name="recar_idx">
                        <input type="date" value="${r_carstartdate}" class="r_carstartdate" name="r_carstartdate"
                               id="car-start-date">
                        <input type="date" value="${r_carenddate}" class="r_carenddate" name="r_carenddate"
                               id="car-end-date">
                        <input type="text" value="${car.r_company}" class="r_company" name="r_company">
                        <input type="text" value="${car.r_department}" class="r_department" name="r_department">
                        <input type="text" value="${car.r_position}" class="r_position" name="r_position">
                    </div>
                </c:forEach>
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
            <input type="text" name="r_pos" value="${dto.r_pos}" style="width: 300px">
        </div>

        <div id="r_deg" style="width: 800px; height: 300px;">
            <div style="font-size: 20px">학력</div>
            <hr>
            <div style="background-color: #FFF2FE; font-size: 15px">
                * 최종학력으로 작성해주세요.<br>
            </div>
            <br>
            <div class="form-group-grade" style="width: 800px;">
                <fmt:formatDate value="${dto.r_gradestart}" pattern="yyyy-MM-dd" var="r_gradestart"/>
                <fmt:formatDate value="${dto.r_gradeend}" pattern="yyyy-MM-dd" var="r_gradeend"/>
                <input type="date" value="${r_gradestart}" name="r_gradestart" class="r_gradestart"
                       id="grade-start-date">
                <input type="date" value="${r_gradeend}" name="r_gradeend" class="r_gradeend" id="grade-end-date">
                <input type="text" value="${dto.r_gradecom}" class="r_gradecom" name="r_gradecom">
                <select class="grade-staus" name="r_sta">
                    <option value="재학"${dto.r_sta == '재학' ? 'selected' : ''}>재학</option>
                    <option value="졸업"${dto.r_sta == '졸업' ? 'selected' : ''}>졸업</option>
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
            <input type="text" id="skillinput" placeholder="사용가능한 툴 ex:java" name="r_skill"  style="width: 300px">

           <input type="hidden" id="r_skill" name="r_skill" value="${dto.r_skill}">
            <div id="result" value="${dto.r_skill}"  ><span style="display: none"> ${dto.r_skill}</span></div>

        </div>

        <div id="r_lic" style="width: 800px; height: 300px;">
            <div style="font-size: 20px">자격증</div>
            <hr>
            <div style="background-color: #FFF2FE; font-size: 15px">
                * 자격증을 보유한 경우 작성해주세요.<br>
            </div>
            <br>
            <div id="form-lic">
                <c:forEach items="${llist}" var="lic">
                    <fmt:formatDate value="${lic.r_licdate}" pattern="yyyy-MM-dd" var="r_licdate"/>
                    <div class="form-group-lic" style="width: 800px;">
                        <input type="hidden" value="${lic.relic_idx}" name="relic_idx">
                        <input type="date" value="${r_licdate}" name="r_licdate" id="lic-date">
                        <input type="text" value="${lic.r_licname}" name="r_licname" style="width: 300px">

                    </div>
                </c:forEach>
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
            <input type="file" name="upload_r" class="r_file" value="${dto.r_file}">
            <br><br>
            <div style="font-size: 20px">이력서 업로드</div>
            <HR>
            <div style="background-color: #FFF2FE; font-size: 15px" class="">
                * 이력서 파일을 업로드 해주세요.<br>
            </div>
            <br>
            <input type="file" name="upload_re" class="r_refile" value="${dto.r_refile}">
            <br><br>
        </div>

        <div id="r_link">;
            <div style="font-size: 20px">링크 업로드</div>
            <HR>
            <div style="background-color: #FFF2FE; font-size: 15px">
                * 깃허브, 깃랩, 블로그 주소를 입력해주세요.<br>
            </div>
            <input type="text" style="width: 300px" name="r_link" value="${dto.r_link}">
            <br><br><br>
            <button type="submit">게시글등록</button>
        </div>
    </form>
</div>
</body>
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
        <input type="date" name="r_carstartdate" class="car-start-date">
        <input type="date" name="r_carenddate" class="car-end-date">
        <input type="text" name="r_company" placeholder="회사명">
        <input type="text" name="r_department" placeholder="부서">
        <input type="text" name="r_position" placeholder="직책">
    `;
        form.appendChild(newInputGroup);

        const startDateInputs = document.querySelectorAll('.car-start-date');
        const endDateInputs = document.querySelectorAll('.car-end-date');

        startDateInputs.forEach(function (input) {
            const currentDate = new Date().toISOString().split('T')[0];
            input.setAttribute('max', currentDate);

            input.addEventListener('change', function () {
                const selectedDate = input.value;
                if (selectedDate > currentDate) {
                    alert('오늘 이후의 날짜는 선택할 수 없습니다.');
                    input.value = currentDate;
                }

                const endDateInput = input.parentNode.querySelector('.car-end-date');
                if (endDateInput.value !== '' && selectedDate > endDateInput.value) {
                    endDateInput.value = selectedDate;
                }
            });
        });

        endDateInputs.forEach(function (input) {
            const currentDate = new Date().toISOString().split('T')[0];
            input.setAttribute('max', currentDate);

            input.addEventListener('change', function () {
                const selectedDate = input.value;
                if (selectedDate > currentDate) {
                    alert('오늘 이후의 날짜는 선택할 수 없습니다.');
                    input.value = currentDate;
                }

                const startDateInput = input.parentNode.querySelector('.car-start-date');
                if (startDateInput.value !== '' && selectedDate < startDateInput.value) {
                    input.value = startDateInput.value;
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
        <input type="date" class="lic-date" name="r_licdate">
        <input type="text" placeholder="자격증" style="width: 300px" name="r_licname">
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
</html>