<%--
  Created by IntelliJ IDEA.
  User: JuminManeul
  Date: 2023-05-02
  Time: 오후 4:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style>
</style>


<div id="slide_banner">
    <div class="slide_wrapper">
        <ul class="slides">
            <li><img src="/photo/slide_banner_01.jpg" alt="image1"></li>
            <li><img src="/photo/slide_banner_02.jpg" alt="image2"></li>
            <li><img src="/photo/slide_banner_03.png" alt="image3"></li>
        </ul>

    </div>

    <div class="controls">
        <span class="prev"><div class="pre_icon"></div></span>
        <span class="next"><div class="next_icon"></div></span>
    </div>
</div>




<!--=======================================================스크립트==============================================-->

<script>

    var slides = document.querySelector(('.slides')),
        slide = document.querySelectorAll('.slides li'),
        currentIdx =0,
        slideCount = slide.length,
        slideWidth = 1100, //현재 슬라이드 길이
        slideMargin = 0, //마진 길이
        prevBtn = document.querySelector('.prev'),
        nextBtn = document.querySelector('.next');

    makeClone();

    function makeClone(){
        for (var i = 0; i<slideCount; i++){
            //a.cloneNode(), a.cloneNode(true)
            var cloneSlide = slide[i].cloneNode(true);
            cloneSlide.classList.add('clone');
            //a.appendChild(b)
            slides.appendChild(cloneSlide);
        }

        for (var i= slideCount-1; i>=0; i--){

            //a.cloneNode(), a.cloneNode(true)
            var cloneSlide = slide[i].cloneNode(true);
            cloneSlide.classList.add('clone');
            //a.prepend(b)
            slides.prepend(cloneSlide);
        }

        updateWidth();

        setInitialPos();

        setTimeout(function (){
            slides.classList.add('animated');
        },100);

    }

    function updateWidth(){
        var currentSlide = document.querySelectorAll('.slides li');
        var newSlideCount = currentSlide.length;

        // 슬라이드  ul 총길이
        var newWidth = (slideWidth + slideMargin)*newSlideCount - slideMargin + 'px';
        slides.style.width = newWidth;
    }

    // 슬라이드 ul 전체를 가운데 위치시키는 함수
    function setInitialPos(){
        var initialTranslateValue = -(slideWidth + slideMargin)*slideCount;

        slides.style.transform = 'translateX(' + initialTranslateValue+'px)';
    }

    nextBtn.addEventListener('click',function(){
       moveSlide(currentIdx + 1);
    });

    prevBtn.addEventListener('click',function(){
        moveSlide(currentIdx - 1);
    });

    function moveSlide(num){
         slides.style.left = -num * (slideWidth + slideMargin) +'px';
        currentIdx = num;
        console.log(currentIdx, slideCount);

        if(currentIdx == slideCount || currentIdx == -slideCount){

            setTimeout(function(){
                slides.classList.remove('animated');
                slides.style.left = '0px';
                currentIdx =0;
            },500);

            setTimeout(function(){
                slides.classList.add('animated');
            },600)

        }
    }

    //자동 슬라이드

    var timer = undefined;

    function autoSlide(){
        if(timer == undefined){
            timer = setInterval(function(){
                moveSlide(currentIdx + 1);
            }, 3000);
        }
    }

    autoSlide();

    function stopSlide(){
        clearInterval(timer);
        timer = undefined;
    }
    slides.addEventListener('mouseenter', function(){
        stopSlide();
    });
    slides.addEventListener('mouseleave', function(){
        autoSlide();
    });



</script>


