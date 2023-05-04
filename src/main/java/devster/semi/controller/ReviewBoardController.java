package devster.semi.controller;

import devster.semi.dto.ReviewDto;
import devster.semi.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.convert.PeriodUnit;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/review")
public class ReviewBoardController {
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private ReviewDto reviewDto;

    //버켓 이름
    private String bucketName="devster-bucket";//각자 자기 버켓이름

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage,/*int rb_idx ,*/Model model){

     /*   //닉네임 가져오기
        ReviewDto dto=reviewService.Getmidx(rb_idx);
        String nickname=reviewService.selectnicnameofmidx(reviewDto.getRb_idx());
        model.addAttribute("nickname",nickname);
        model.addAttribute("dto",dto);*/

        //총 상품갯수 출력
        int totalCount=reviewService.getTotalcount();
        int totalPage; // 총 페이지 수
        int perPage = 10; // 한 페이지당 보여줄 글 갯수
        int perBlock = 20; // 한 블록당 보여질 페이지의 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int startPage; // 각 블록에서 보여질 시작 페이지 번호
        int endPage; // 각 블록에서 보여질 끝 페이지 번호
        int no; // 글 출력시 출력할 시작번호
        //전체 데이타 가져오기
        List<ReviewDto> list=reviewService.GetAllReview();

        // 총 페이지 수
        totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
        // 시작 페이지
        startPage = (currentPage - 1) / perBlock * perBlock + 1;
        // 끝 페이지
        endPage = startPage + perBlock - 1;

        // endPage가 totalPage 보다 큰 경우
        if (endPage > totalPage)
            endPage = totalPage;

        // 각 페이지의 시작번호 (1페이지: 0, 2페이지 : 3, 3페이지 6 ....)
        startNum = (currentPage - 1) * perPage;

        // 각 글마다 출력할 글 번호 (예 : 10개일 경우 1페이지 10, 2페이지 7...)
        // no = totalCount - (currentPage - 1) * perPage;
        no = totalCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<ReviewDto> listp = reviewService.getPagingList(startNum, perPage);
      /*  System.out.println("startNum="+startNum);
        System.out.println("startPage="+startPage);
        System.out.println("endPage="+endPage);*/
        //model 에 저장
        model.addAttribute("totalCount", totalCount);
       /* model.addAttribute("list", list);*/ //페이징 처리 하기 전에 만든 리스트
        model.addAttribute("listp", listp);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("no", no);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalCount",totalCount);

        return "/main/review/reviewlist";
    }


    @GetMapping("/reviewriterform")
    public String form(){

        return "/main/review/reviewform";
    }


  @PostMapping("/insert")
  public String insertreview(ReviewDto dto, HttpSession session) {

      reviewService.insertreview(dto);
      return "redirect:/review/list";
  }

  @GetMapping("/updateform")
    public String update(int rb_idx,Model model){
        ReviewDto dto=reviewService.getData(rb_idx);
        model.addAttribute("dto",dto);


        return "/main/review/reviewupdateform";
  }


  @PostMapping("/update")
    public String update(int rb_idx,ReviewDto dto){
        dto.setRb_idx(rb_idx);
        reviewService.updatereview(dto);
        return "redirect:list";
  }

@GetMapping("/delete")
    public String delete(int rb_idx)
{
    reviewService.deletereview(rb_idx);
    return "redirect:list";
}




}
