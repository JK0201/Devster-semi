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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        * {
            margin: 0px;
            padding: 0px;
        }

        #dropbox {
            width: 800px;
            height: 500px;
            cursor: default;
        }

        .uploadbox {
            width: 800px;
            height: 430px;
            border: 3px dashed #808080;
            border-radius: 10px;
        }

        #dndtext {
            text-align: center;
            background-color: #8007AD;
            font-size: 30px;
            width: 220px;
            height: 50px;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            margin: 0 auto;
            border:1px solid gray;
        }

        #sizetxt {
            font-size: 23px;
            float: left;
            margin-left: 15px;
            font-weight: bold;
            color: #bdbebd;
        }

        .btnupload {
            font-size: 25px;
            float: right;
            margin-right: 15px;
            font-weight: bold;
            cursor: pointer;
            color: #bdbebd;
        }

        .btnupload:hover {
            color: #8007AD;
        }

        .alldelbtn {
            font-size: 25px;
            float: right;
            margin-right: 20px;
            font-weight: bold;
            cursor: pointer;
            color: #bdbebd;
        }

        .alldelbtn:hover {
            color: #8007AD;
        }

        #preview {
            margin: 0 auto;
            width: 800px;
            height: 300px;
            text-align: center;
        }

        #divimgbox {
            margin: 0 auto;
            width: 750px;
        }

        .imgpreview {
            width: 140px;
            height: 140px;
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .previewdelbtn {
            width: 120px;
            color: red;
            opacity: 60%;
            font-size: 90px;
            position: absolute;
            left: 47%;
            top: 47%;
            transform: translate(-50%, -50%);
            display: none;
        }

        /*modal*/
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fefefe;
            padding: 20px;
            border: 1px solid #888;
            width: 63%;
        }

        .close {
            color: #bdbebd;
            font-size: 40px;
            cursor: pointer;
            font-weight: bold;
        }

        .close:hover {
            color: #8007AD;
        }

        #uploadbtn {
            text-align: center;
            background-color: #bdbebd;
            font-size: 25px;
            width: 120px;
            height: 45px;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            border:1px solid gray
        }

        #uploadbtn:hover {
            background-color: #8007AD;
        }

        .progress {
            margin: 0 auto;
            position: relative;
            width: 50%;
            border: 1px solid #bdbebd;
            padding: 1px;
            border-radius: 5px;
            display: none;
        }

        .bar {
            background-color: #8007AD;
            width: 0%;
            height: 20px;
            border-radius: 3px;
        }

        .percent {
            position: absolute;
            display: inline-block;
            top: -3px;
            left: 48%;
            font-weight: bold;
        }
    </style>
</head>
<body>
<button type="button" id="uploadmodal">UPLOAD</button>
<div id="myUploadModal" class="modal">
    <div class="modal-content">
        <div style="width:35px; margin:0 auto; width: 100%; text-align: center; padding-bottom: 10px;">
            <i class="bi bi-x-circle close"></i>
        </div>
        <section id="dropbox" style="margin:0 auto;">
            <div class="uploadbox">
                <input type="file" accept=".jpg, .jpeg, .png, .gif" multiple id="filebtn"
                       class="btn-file d-none">
                <div style="width:800px; height:70px; line-height: 60px;">
                    <span id="sizetxt" style="height:45px;"><span id="mbsize">0.0</span> / 50Mb</span>
                    <i class="bi bi-recycle alldelbtn" style="height:45px;"></i>
                    <i class="bi bi-plus-circle btnupload" style="height:45px;"></i>
                </div>
                <div id="preview">
                    <div id="divimgbox" style="margin:0 auto; width:750px;">
                        <div style="padding-top:40px;">
                            <i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>
                            <div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">
                                최대 10장이내의 jpeg, jpg, png, gif 파일만 업로드 가능
                            </div>
                            <div id="dndtext">Drag & Drop</div>
                        </div>
                    </div>
                </div>
                <div style="width:800px; height:60px; padding-top:15px;">
                    <div class="progress">
                        <div class="bar progress-bar-striped progress-bar-animated"></div>
                        <div class="percent">0%</div>
                    </div>
                </div>
            </div>
            <div style="width:800px; height:60px; padding-top: 15px; text-align:center;">
                    <button type=button id="uploadbtn">확인</button>
            </div>
        </section>
    </div>
</div>

<script>
    //modal
    $(document).ready(function () {
        // Open modal
        $("#uploadmodal").click(function () {
            $("#myUploadModal").fadeIn();
        });

        // Close modal
        $(".close").click(function () {
            $("#myUploadModal").fadeOut();
        });
    });

    //upload
    var filesarr = [];

    $(".btnupload").click(function () {
        $("#filebtn").click();
    });

    $(document).on("change", "#filebtn", function (e) {
        var cnt = e.target.files.length;
        var data = e.target.files;

        if (!isValidBtn(data)) {
            return false
        } else {
            var file = Array.prototype.slice.call(data);
            imgpreview(file);
            filesarr = filesarr.concat(file);
            console.log(filesarr.length);
            updatetotalsize();
        }

        //유효성
        function isValidBtn(data) {
            //이미지인가?
            for (let i = 0; i < cnt; i++) {
                if (data[i].type.indexOf("image") < 0) {
                    alert("이미지만 업로드 가능합니다");
                    return false;
                }
            }

            //클릭 업로드 개수
            if (filesarr.length + cnt > 10) {
                alert("이미지는 최대 10개까지 업로드 가능합니다");
                return false;
            }

            //파일의 사이즈는 20MB
            let totalsize = filestotalsize(filesarr) + filestotalsize(data);
            if (totalsize >= 1024 * 1024 * 50) {
                alert("전체 업로드 파일의 크기가 50Mb를 초과하였습니다");
                return false;
            }

            return true;
        }
    });

    //DnD
    var doc = document.querySelector("#dropbox");
    var btnupload = doc.querySelector(".btnupload");
    var inputfile = doc.querySelector("input[type='file']");
    var uploadbox = doc.querySelector(".uploadbox");

    //박스안에 drag 들어왔을 경우
    uploadbox.addEventListener("dragenter", function (e) {
        e.preventDefault();
    });

    //박스 안에 drag를 하고있을 경우
    uploadbox.addEventListener("dragover", function (e) {
        e.preventDefault();
        var vaild = e.dataTransfer.types.indexOf('Files') >= 0;
        if (!vaild) {
            this.style.borderColor = 'red';
        } else {
            $(this).css("border-color", "#8007AD");
            $("#dndtext").css("backgroundColor", "#bdbebd");
        }
    });

    //박스 밖으로 Drag가 나갈때
    uploadbox.addEventListener("dragleave", function (e) {
        e.preventDefault();
        $(this).css("border-color", "#bdbebd");
        $("#dndtext").css("backgroundColor", "#8007AD");
    });

    //박스안에서 drag를 drop했을떄
    uploadbox.addEventListener("drop", function (e) {
        e.preventDefault();
        $(this).css("border-color", "#808080");
        var data = e.dataTransfer;

        if (!isValid(data)) {
            return false;
        } else {
            var file = Array.prototype.slice.call(data.files);
            imgpreview(file);
            filesarr = filesarr.concat(file);
            console.log(filesarr.length);
            updatetotalsize();
        }
    });

    //preview
    var fileidx = 0;

    function imgpreview(file) {
        file.forEach(function (f) {
            if (!f.type.match("image.*")) {
                alert("이미지만 업로드 가능합니다");
                return;
            }

            if (filesarr.length == 0) {
                $("#divimgbox").html("");
            }
            var reader = new FileReader();
            var s = "";
            reader.onload = function (e) {
                f.index = fileidx
                s += "<div id='box" + fileidx + "' style='float:left; position: relative;'>";
                s += "<div class='imgbox'>";
                s += "<img src='" + e.target.result + "' class='img-thumbnail imgpreview'>";
                s += "<i class='bi bi-dash-circle previewdelbtn' onclick='deletefile(\"" + fileidx + "\")'></i>";
                s += "</div>"
                s += "</div>";
                $("#divimgbox").hide().fadeIn("fast");
                $("#divimgbox").append(s);
                fileidx++;
            }
            reader.readAsDataURL(f);
        });
    }

    //del btn anime
    $(document).ready(function () {
        $(document).on("mouseenter", ".imgbox", function () {
            $(this).find(".previewdelbtn").show();
        });

        $(document).on("mouseleave", ".imgbox", function () {
            $(this).find(".previewdelbtn").hide();
        });
    });

    //delete
    function deletefile(index) {
        $("#box" + index).fadeOut("fast", function () {
            $(this).remove();

            let indexToRemove;
            for (let i = 0; i < filesarr.length; i++) {
                if (filesarr[i].index == index) {
                    indexToRemove = i;
                    break;
                }
            }
            if (indexToRemove != undefined) {
                filesarr.splice(indexToRemove, 1);
            }
            console.log(filesarr.length);
            if (filesarr.length == 0) {
                $("#divimgbox").html('<div style="padding-top:40px;">' +
                    '<i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>' +
                    '<div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">' +
                    '최대 10장이내의 jpeg, jpg, png, gif 파일만 업로드 가능</div>' +
                    '<div id="dndtext">Drag & Drop</div></div>').hide().fadeIn("fast");
            }
            updatetotalsize();
        });
    }

    //all del button
    $(".alldelbtn").click(function () {
        console.log(fileidx);

        filesarr = [];
        fileidx = 0;

        console.log(filesarr.length);
        if (filesarr.length == 0) {
            $("#divimgbox").html('<div style="padding-top:40px;">' +
                '<i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>' +
                '<div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">' +
                '최대 10장이내의 jpeg, jpg, png, gif 파일만 업로드 가능</div>' +
                '<div id="dndtext">Drag & Drop</div></div>').hide().fadeIn("fast");
        }
        updatetotalsize();
    });

    //유효성 검사
    function isValid(data) {
        //파일인가?
        if (data.types.indexOf('Files') < 0)
            return false;

        //이미지인가?
        for (let i = 0; i < data.files.length; i++) {
            if (data.files[i].type.indexOf("image") < 0) {
                alert("이미지만 업로드 가능합니다");
                return false;
            }
        }

        //파일개수 최대 3개
        if (filesarr.length + data.files.length > 10) {
            alert("파일은 최대 10개까지 업로드 가능합니다");
            return false;
        }

        //파일의 사이즈는 총 20MB

        let totalsize = filestotalsize(filesarr) + filestotalsize(data.files);
        if (totalsize >= 1024 * 1024 * 50) {
            alert("전체 업로드 파일의 크기가 50MB를 초과하였습니다");
            return false;
        }
        return true;
    }

    //filestotal size
    function filestotalsize(files) {
        let totalsize = 0;
        for (let i = 0; i < files.length; i++) {
            totalsize += files[i].size;
        }
        return totalsize
    }

    //update total size
    function updatetotalsize() {
        let totalsize = filestotalsize(filesarr);
        let mbsize = (totalsize / (1024 * 1024)).toFixed(1);
        $("#mbsize").html(mbsize);
    }

    //submit (json)
    $("#uploadbtn").click(function () {
        Swal.fire({
            title: '파일을 업로드 하시겠습니까?',
            text: '확인 버튼을 누르면 파일이 업로드 됩니다',
            icon: 'warning',

            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
            confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
            cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
            cancelButtonText: '취소', // cancel 버튼 텍스트 지정

            reverseButtons: true // 버튼 순서 거꾸로
        }).then(result => {
            if (result.isConfirmed) {

                let formData = new FormData();
                console.log(filesarr);
                console.log(filesarr.length);

                for (i = 0; i < filesarr.length; i++) {
                    console.log(filesarr[i]);
                    formData.append("upload", filesarr[i]);
                }

                var bar = $('.bar');
                var percent = $('.percent');

                $.ajax({
                    xhr: function () {
                        var xhr = new window.XMLHttpRequest();
                        xhr.upload.addEventListener('progress', function (e) {
                            if (e.lengthComputable) {
                                var percentComplete = Math.floor((e.loaded / e.total) * 100);

                                var percentVal = percentComplete + '%';
                                bar.width(percentVal);
                                percent.html(percentVal);
                            }
                        }, false);
                        return xhr;
                    },
                    type: "post",
                    url: "dndupdatetest",
                    dataType: "text",
                    data: formData,
                    processData: false,
                    contentType: false,
                    beforeSend: function () {
                        $("#uploadbtn").prop("disabled",true);
                        $(".progress").fadeIn('fast');
                        var percentVal = '0%';
                        bar.width(percentVal);
                        percent.html(percentVal);
                    },
                    complete: function () {
                        $(".progress").fadeOut('fast');
                    },
                    success: function () {
                        $("#uploadbtn").prop("disabled",false);
                        Swal.fire({
                            title: '파일 업로드를 완료했습니다',
                            icon: 'success',
                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        }).then(result => {
                            console.log(result);
                            $("#myUploadModal").fadeOut('fast');
                        });
                    }
                });
            } else {
                return false;
            }
        });
    });

</script>
</body>
</html>
