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

        #custom_input {
            display: none;
        }

        #custom_input + label.toggle_btn_label {
            position: relative;
            width: 8rem;
            height: 2.9rem; /* 높이를 10px 줄임 */
            margin-left: 600px;
        }

        #custom_input + label.toggle_btn_label > span {
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

        #custom_input + label.toggle_btn_label > span:before {
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

        #custom_input:checked + label.toggle_btn_label > span {
            background-color: #EE64F5;
        }

        #custom_input:checked + label.toggle_btn_label > span:before {
            -webkit-transform: translateX(calc(7.5rem - 100%)); /* 가로를 3분의 2로 줄임 */
            -ms-transform: translateX(calc(7.5rem - 100%));
            transform: translateX(calc(7.5rem - 100%));
            right: 0.25rem;
            bottom: 0.25rem;
            content: "공개";
        }

        #custom_input:disabled + label.toggle_btn_label {
            display: none;
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
            font-size: 25px;
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
    <form action="resumeupdate" enctype="multipart/form-data" method="post">

        <span class="rena"><B>${mdto.m_name}</B></span><br>
        <i class="bi bi-envelope reemail"></i> &nbsp;&nbsp; <span class="rein">${mdto.m_email}</span><br>
        <i class="bi bi-telephone reemail"></i> &nbsp;&nbsp; <span class="rein">${mdto.m_tele}</span>
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

        <!--hidden-->
        <input type="hidden" name="r_idx" value="${r_idx}">
        <input type="hidden" name="m_idx" value="${sessionScope.memidx}">

        <div id="r_pos" style="width: 800px; height: 200px;">
            <div  class="repoint">개발 직무</div>
            <HR>
            <input type="text" name="r_pos"  value="${dto.r_pos}" placeholder="직무를 작성해주세요">
        </div>

        <div id="r_skills" style="width: 800px; height: auto;">
            <div class="repoint">기술 스택 &nbsp;<span style="font-size: 20px">(업무 툴/스킬)</span></div>
            <hr>
            <input type="text" id="skillinput" placeholder="사용가능한 툴 ex:java">
            <br> <br>
            <div id="result" style="height: auto"></div>
            <input type="hidden" id="r_skill" name="r_skill" value="${dto.r_skill}">
            <br>     <br>
        </div>



    <%--링크--%>
        <div class="repoint"  style="width: 800px; height: 180px;">링크 업로드
            <HR>
            <i class="bi bi-link-45deg" style="font-size: 30px"></i>
            <input type="text" value="${dto.r_link}" name="r_link" placeholder="http://,https://를 포함해 작성해주세요." style="width: 750px">
        </div>

        <%-- 학력--%>
        <div id="r_deg"style="width: 800px; height: 200px;" >
            <div  class="repoint">학력<span style="font-size: 20px">(최종학력)</span></div>
            <hr>
            <br>
            <div class="form-group-grade" style="width: 800px;">
                <fmt:formatDate value="${dto.r_gradestart}" pattern="yyyy-MM-dd" var="r_gradestart"/>
                <fmt:formatDate value="${dto.r_gradeend}" pattern="yyyy-MM-dd" var="r_gradeend"/>
                <input type="date" name="r_gradestart" class="r_gradestart" id="grade-start-date"
                       style="width: 175px; height: 45px;" value="${r_gradestart}" >
                <input type="date" name="r_gradeend" class="r_gradeend" id="grade-end-date"
                       style="width: 175px; height: 45px;" value="${r_gradeend}">
                <input type="text" class="r_gradecom" name="r_gradecom" placeholder="학교명"
                       style="width: 280px; height: 45px;" value="${dto.r_gradecom}" >
                <select class="grade-staus" name="r_sta" style="width: 150px; height: 45px;">
                    <option value="재학"${dto.r_sta == '재학' ? 'selected' : ''}>재학</option>
                    <option value="졸업"${dto.r_sta == '졸업' ? 'selected' : ''}>졸업</option>
                </select>
            </div>
        </div>


        <%--경력--%>
        <div id="r_car" style="width: 800px; height: auto;">
            <div class="repoint">경력</div>
            <HR>
            <br>
            <div id="form-car">
                <c:forEach items="${clist}" var="car">
                <fmt:formatDate value="${car.r_carstartdate}" pattern="yyyy-MM-dd" var="r_carstartdate"/>
                <fmt:formatDate value="${car.r_carenddate}" pattern="yyyy-MM-dd" var="r_carenddate"/>
                <div class="form-group" style="width: 800px;">
                    <input type="hidden" value="${car.recar_idx}" name="recar_idx">
                    <input type="date"  class="r_carstartdate" name="r_carstartdate" id="car-start-date"
                           style="width: 280px; height: 45px;" value="${r_carstartdate}">
                    <input type="date" class="r_carenddate" name="r_carenddate" id="car-end-date"
                           style="width: 280px; height: 45px;" value="${r_carenddate}">
                    <br><br>
                    <input type="text" class="r_company" name="r_company" placeholder="회사명"
                           style="width: 250px; height: 45px;"  value="${car.r_company}">
                    <input type="text" class="r_department" name="r_department" placeholder="부서"
                           style="width: 250px; height: 45px;"  value="${car.r_department}">
                    <input type="text" class="r_position" name="r_position" placeholder="직책"
                           style="width: 250px; height: 45px;"  value="${car.r_position}">
                    <br> <br>
                </div>
                </c:forEach>
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
                <c:forEach items="${llist}" var="lic">
                    <fmt:formatDate value="${lic.r_licdate}" pattern="yyyy-MM-dd" var="r_licdate"/>
                <div class="form-group-lic" style="width: 800px;height: auto">
                    <input type="hidden" value="${lic.relic_idx}" name="relic_idx">
                    <input type="date" value="${r_licdate}" name="r_licdate" class="r_licdate" id="lic-end-date" style="width: 250px; height: 40px;">&nbsp;&nbsp;
                    <input type="text"  value="${lic.r_licname}" name="r_licname" placeholder="자격증" style="width: 520px; height: 40px;">
<br><br>                </div>
                </c:forEach>
            </div>
            <i class="bi bi-plus-square" id="lic-add"></i>
        </div>

        <%-- 간단 소개줄 --%>
        <br><br>
        <div id="r_deg"style="width: 800px; height: auto;" >
            <div  class="repoint">간단 소개줄</div>
            <hr>
            <br>
            <textarea name="r_self" style="font-size: 20px; "
                      placeholder=" 간단한 자기소개를 통해 이력서를 돋보이게 만들어보세요,(3~5줄 권장)">${dto.r_self}</textarea>
        </div>

        <br><br><br>

        <div id="r_deg" style="width: 800px; height: auto;" >
            <div  class="repoint">첨부파일 업로드<span style="font-size: 15px">(자격증,포트폴리오)</span></div>
            <hr>
            <br>
            <input type="file" name="upload_r" class="r_file" value="${dto.r_file}">
        </div>

        <br><br>

        <div id="r_deg" style="width: 800px; height: auto;" >
            <div  class="repoint">이력서 업로드</div>
            <hr>
            <br>
            <input type="file" name="upload_re" class="r_refile" value="${dto.r_refile}">
        </div>

        <br><br>
        <div style="text-align: right;">
            <button type="submit"  class="btn btn-outline-dark">게시글등록   </button>
        </div>
        <DIV STYLE="height: 60PX"></DIV>

    </form>
</div>

<script>
    //토글 이벤트
    function updateToggleValue() {
        var toggle = document.getElementById("custom_input");
        if (toggle.checked) {
            toggle.value = "1";
        } else {
            toggle.value = "0";
        }
    }
//ajax skill 이벤트
    // skill ajax 이벤트
    document.addEventListener("DOMContentLoaded", function () {
        const input = document.getElementById("skillinput");
        const result = document.getElementById("result");
        let r_text = "";

        const r_skill = document.getElementById("r_skill").value || ""; // DB에서 가져온 값

        // 기존 값 출력
        if (r_skill) {
            r_skill.split(",").forEach(function (skill) {
                const trimmedSkill = skill.trim();
                if (trimmedSkill !== "") {
                    const span = document.createElement("span");
                    span.textContent = trimmedSkill;
                    result.appendChild(span);

                    const deleteButton = document.createElement("button");
                    deleteButton.textContent = "X";
                    deleteButton.addEventListener("click", function () {
                        result.removeChild(span);
                        result.removeChild(deleteButton);
                        r_text = r_text.replace(span.textContent, "").replace(/,,/g, ",");
                        document.getElementById("r_skill").value = r_text.replace(/,$/, "");
                    });

                    result.appendChild(deleteButton);

                    r_text += trimmedSkill + ",";
                }
            });
        }

        input.addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
                event.preventDefault();
                const values = input.value.split(",");

                values.forEach(function (value) {
                    const trimmedValue = value.trim();
                    if (trimmedValue !== "") {
                        const span = document.createElement("span");
                        span.textContent = trimmedValue;

                        const deleteButton = document.createElement("button");
                        deleteButton.textContent = "X";
                        deleteButton.addEventListener("click", function () {
                            result.removeChild(span);
                            result.removeChild(deleteButton);
                            r_text = r_text.replace(span.textContent, "").replace(/,,/g, ",");
                            document.getElementById("r_skill").value = r_text.replace(/,$/, "");
                        });

                        result.appendChild(span);
                        result.appendChild(deleteButton);

                        r_text += trimmedValue + ",";
                    }
                });

                document.getElementById("r_skill").value = r_text.replace(/,$/, "");
                input.value = "";
            }
        });
    });


    // 경력 + 이벤트
    const addInputButton = document.getElementById("car-add");
    const form = document.getElementById("form-car");
    let inputCount = document.querySelectorAll('.r_carstartdate').length;

    addInputButton.addEventListener("click", function () {
        inputCount++;
        const newInputGroup = document.createElement("div");
        newInputGroup.classList.add("form-group");

        newInputGroup.innerHTML = `

    <input type="date" class="r_carstartdate" name="r_carstartdate" id="car-start-date-${inputCount}"
        style="width: 280px; height: 45px;">
    <input type="date" class="r_carenddate" name="r_carenddate" id="car-end-date-${inputCount}"
        style="width: 280px; height: 45px;">
    <br><br>
    <input type="text" class="r_company" name="r_company" placeholder="회사명" style="width: 250px; height: 45px;">
    <input type="text" class="r_department" name="r_department" placeholder="부서" style="width: 250px; height: 45px;">
    <input type="text" class="r_position" name="r_position" placeholder="직책" style="width: 250px; height: 45px;">`;

        form.appendChild(newInputGroup);

        const startDateInput = document.getElementById(`car-start-date-${inputCount}`);
        const endDateInput = document.getElementById(`car-end-date-${inputCount}`);

        const currentDate = new Date().toISOString().split('T')[0];
        startDateInput.setAttribute('max', currentDate);
        endDateInput.setAttribute('max', currentDate);

        startDateInput.addEventListener('change', function () {
            const selectedDate = startDateInput.value;
            if (selectedDate > endDateInput.value) {
                endDateInput.value = selectedDate;
            }
        });

        endDateInput.addEventListener('change', function () {
            const selectedDate = endDateInput.value;
            if (selectedDate < startDateInput.value) {
                startDateInput.value = selectedDate;
                alert("시작일 이전은 선택할 수 없습니다.");
            }
        });
    });

    //경력 기본 값도 날짜 제한 하기
    // Get the existing start date and end date elements
    const existingStartDateInputs = document.querySelectorAll('.r_carstartdate');
    const existingEndDateInputs = document.querySelectorAll('.r_carenddate');
    const currentDate = new Date().toISOString().split('T')[0];

    // Loop through existing date inputs and apply date restrictions
    existingStartDateInputs.forEach(function (startDateInput) {
        const endDateInput = startDateInput.parentNode.querySelector('.r_carenddate');
        startDateInput.setAttribute('max', currentDate);

        startDateInput.addEventListener('change', function () {
            const selectedDate = startDateInput.value;
            if (selectedDate > endDateInput.value) {
                endDateInput.value = selectedDate;
            }
        });
    });

    existingEndDateInputs.forEach(function (endDateInput) {
        const startDateInput = endDateInput.parentNode.querySelector('.r_carstartdate');
        endDateInput.setAttribute('max', currentDate);

        endDateInput.addEventListener('change', function () {
            const selectedDate = endDateInput.value;
            if (selectedDate < startDateInput.value) {
                startDateInput.value = selectedDate;
                alert("시작일 이전은 선택할 수 없습니다.");
            }
        });
    });

    //학력 기본 값 제한하기
    // 학력 입력 부분에 대한 날짜 제한 설정
    const gradestartInput = document.getElementById("grade-start-date");
    const gradeendInput = document.getElementById("grade-end-date");
    const currentDateGrade = new Date().toISOString().split('T')[0];

    gradestartInput.setAttribute('max', currentDateGrade);
    gradestartInput.addEventListener('change', function () {
        const selectedDateGradeStart = gradestartInput.value;
        if (selectedDateGradeStart > gradeendInput.value) {
            gradeendInput.value = selectedDateGradeStart;
        }
    });

    gradeendInput.setAttribute('max', currentDateGrade);
    gradeendInput.addEventListener('change', function () {
        const selectedDateGradeEnd = gradeendInput.value;
        if (selectedDateGradeEnd < gradestartInput.value) {
            alert("시작일 이전은 선택할 수 없어요")
            gradestartInput.value = selectedDateGradeEnd;
        }
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
    <input type="date" name="r_licdate" class="lic-date" id="lic-end-date-${inputCountlic}" style="width: 250px; height: 40px;">
    <input type="text" name="r_licname" placeholder="자격증" style="width: 520px; height: 40px;"><br>
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
    //기존 정보 수정시

    const existingLicDateInputs = document.querySelectorAll('.r_licdate');

    existingLicDateInputs.forEach(function (dateInputlic) {
        const currentDate = new Date().toISOString().split('T')[0];
        dateInputlic.setAttribute('max', currentDate);

        dateInputlic.addEventListener('change', function () {
            const selectedDate = dateInputlic.value;
            if (selectedDate > currentDate) {
                alert('오늘 이후의 날짜는 선택할 수 없습니다.');
                dateInputlic.value = currentDate;
            }

            const allLicDateInputs = document.querySelectorAll('.r_licdate');
            allLicDateInputs.forEach(function (input) {
                if (input !== dateInputlic && input.value < selectedDate) {
                    input.value = selectedDate;
                }
            });
        });
    });




</script>

</body>
</html>