package devster.semi.controller;

import devster.semi.dto.CompanyinfoDto;
import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.ReviewDto;
import devster.semi.service.ReviewService;
import org.apache.catalina.connector.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.convert.PeriodUnit;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/review")
public class ReviewBoardController {
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private ReviewDto reviewDto;
    @Autowired
    private CompanyinfoDto campanyinfoDto;

    //버켓 이름
    private String bucketName="devster-bucket";//각자 자기 버켓이름

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage,Model model){


        int totalCount = reviewService.getTotalcount();
        int totalPage; // 총 페이지 수
        int perPage = 7; // 한 페이지당 보여줄 글 갯수
        int perBlock = 5; // 한 블록당 보여질 페이지의 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int startPage; // 각 블록에서 보여질 시작 페이지 번호
        int endPage; // 각 블록에서 보여질 끝 페이지 번호
        int no; // 글 출력시 출력할 시작번호

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
        List<ReviewDto> list = reviewService.getPagingList(startNum, perPage);

        List<Map<String,Object>> fulllList =new ArrayList<>();

        for(ReviewDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            map.put("rb_idx",String.valueOf(dto.getRb_idx()));
            map.put("m_idx",String.valueOf(dto.getM_idx()));
            map.put("rb_like",dto.getRb_like());
            map.put("rb_dislike",dto.getRb_dislike());
            map.put("rb_type",dto.getRb_type());
            map.put("rb_star",dto.getRb_star());
            map.put("nickName",reviewService.selectnicnameofmidx(dto.getM_idx()));
            map.put("rb_content",dto.getRb_content());
            String currentTimestampToString = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(dto.getRb_writeday());
            map.put("rb_writeday", currentTimestampToString);


            List<CompanyinfoDto> ciDtoList = reviewService.getDataciinfo(dto.getCi_idx());
            if (ciDtoList != null && !ciDtoList.isEmpty()) {
                CompanyinfoDto ciDto = ciDtoList.get(0);
                map.put("ci_name", ciDto.getCi_name());
                map.put("ci_ppl", ciDto.getCi_ppl());
                DecimalFormat decimalFormat = new DecimalFormat("#,###");
                map.put("ci_sale", decimalFormat.format(ciDto.getCi_sale()) + "원");
                map.put("ci_sal", decimalFormat.format(ciDto.getCi_sal()) + "원");
                map.put("ci_photo", ciDto.getCi_photo());
                map.put("ci_star", ciDto.getCi_star());
                map.put("ci_idx",ciDto.getCi_idx());
            }
            fulllList.add(map);
        }



        model.addAttribute("list", fulllList);

        // 출력시 필요한 변수들 model에 전부 저장
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("no", no);
        model.addAttribute("currentPage", currentPage);


        model.addAttribute("totalCount",totalCount);

        return "/main/review/reviewlist";
    }

    @GetMapping("/getCompanyInfo")
    @ResponseBody
    public List<CompanyinfoDto> getCompanyInfo(@RequestParam int ci_idx) {
        /*List<Map<String, Object>> ciinfoList = new ArrayList<>();*/
        List<CompanyinfoDto> companyinfoList = reviewService.getciinfoData(ci_idx);
        return companyinfoList;
    }


    @GetMapping("/reviewriterform")
    public String form(@RequestParam(defaultValue = "1") int currentPage,
                       @RequestParam(defaultValue = "0") int rb_idx, Model model){
        List<CompanyinfoDto> ciNameList = reviewService.selectciname();
        model.addAttribute("ciNameList", ciNameList);
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("rb_idx",rb_idx);
        return "/main/review/reviewform";
    }



    @PostMapping("/insert")
    @ResponseBody
    public void insertreview(@RequestParam int rb_type,String rb_content, int rb_star, int m_idx, int ci_idx) {
        ReviewDto dto = new ReviewDto();
        dto.setRb_type(rb_type);
        dto.setRb_content(rb_content);
        dto.setRb_star(rb_star);
        dto.setM_idx(m_idx);
        dto.setCi_idx(ci_idx);


        reviewService.insertreview(dto); // ReviewDto 객체 insert 하기

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

    @PostMapping("/like")
    @ResponseBody
    public Map<String, Object> like(@RequestParam int rb_idx) {
      reviewService.increaseLikeCount(rb_idx);

        Map<String, Object> result = new HashMap<>();

        result.put("likeCount", reviewService.getData(rb_idx).getRb_like());
        result.put("likeText", "좋아요 " + reviewService.getData(rb_idx).getRb_like());
        result.put("dislikeCount", reviewService.getData(rb_idx).getRb_dislike());
        result.put("dislikeText", "싫어요 " + reviewService.getData(rb_idx).getRb_dislike());

        return result;
    }

    @PostMapping("/dislike")
    @ResponseBody
    public Map<String, Object> dislike(@RequestParam int rb_idx) {
        reviewService.increaseDislikeCount(rb_idx);

        Map<String, Object> result = new HashMap<>();
        result.put("likeCount", reviewService.getData(rb_idx).getRb_like());
        result.put("likeText", "좋아요 " + reviewService.getData(rb_idx).getRb_like());
        result.put("dislikeCount", reviewService.getData(rb_idx).getRb_dislike());
        result.put("dislikeText", "싫어요 " + reviewService.getData(rb_idx).getRb_dislike());
        return result;
    }

    @GetMapping("/search")
    public @ResponseBody List<CompanyinfoDto> getSearchResult(String keyword) {
        List<CompanyinfoDto> ciNameList = reviewService.insertselciname(keyword);
        return ciNameList;
    }
}
