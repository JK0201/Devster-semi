package devster.semi.controller;

import devster.semi.dto.ReviewDto;
import devster.semi.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
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
    public String list(){

        /*@ResponseBody public List<ReviewDto> list =reviewService.GetAllReview();
        for(ReviewDto dto:list){

        }*/


        return "/main/review/reviewlist";
    }

    @GetMapping("/reviewriterform")
    public String form(@RequestParam(defaultValue = "1") int currentPage,
                       @RequestParam(defaultValue = "0") int m_idx, Model model){

        model.addAttribute("currentPage",currentPage);
        model.addAttribute("m_idx",m_idx);

        return "/main/review/reviewform";
    }

  /*  @PostMapping("/insert")
    public String insertreview(ReviewDto dto, HttpSession session)
    {
        int memidx=(int)session.getAttribute("memidx");
        reviewDto.setM_idx(memidx);
      reviewService.insertreview(dto);
        return "redirect:/review/list";
    }*/
  @PostMapping("/insert")
  public String insertreview(ReviewDto dto, HttpSession session) {
      int memidx = (int) session.getAttribute("memidx");
      dto.setM_idx(memidx);
      reviewService.insertreview(dto);
      return "redirect:/review/list";
  }





}
