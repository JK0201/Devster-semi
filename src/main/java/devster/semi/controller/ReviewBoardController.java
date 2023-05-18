package devster.semi.controller;

import devster.semi.dto.CompanyinfoDto;
import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.NoticeBoardDto;
import devster.semi.dto.ReviewDto;
import devster.semi.service.ReviewService;
import org.apache.catalina.connector.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.convert.PeriodUnit;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
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
    private String bucketName = "devster-bucket";//각자 자기 버켓이름

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage, Model model) {


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

        List<Map<String, Object>> fulllList = new ArrayList<>();


        for (ReviewDto dto : list) {
            Map<String, Object> map = new HashMap<>();
            // 버튼 상태에 대한 정보를 디테일 페이지로 보내줌.
            boolean isAlreadyAddGoodRp = reviewService.isAlreadyAddGoodRp(dto.getRb_idx(),dto.getM_idx());
            boolean isAlreadyAddBadRp = reviewService.isAlreadyAddBadRp(dto.getRb_idx(), dto.getM_idx());

            map.put("rb_idx", String.valueOf(dto.getRb_idx()));
            map.put("m_idx", String.valueOf(dto.getM_idx()));
            map.put("rb_like", dto.getRb_like());
            map.put("rb_dislike", dto.getRb_dislike());
            map.put("rb_type", dto.getRb_type());
            map.put("rb_star", dto.getRb_star());
            map.put("nickName", reviewService.selectnicnameofmidx(dto.getM_idx()));
            map.put("rb_content", dto.getRb_content());
            String currentTimestampToString = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(dto.getRb_writeday());
            map.put("rb_writeday", currentTimestampToString);
            map.put("isAlreadyAddGoodRp",isAlreadyAddGoodRp);
            map.put("isAlreadyAddBadRp",isAlreadyAddBadRp);


            List<CompanyinfoDto> ciDtoList = reviewService.getDataciinfo(dto.getCi_idx());
            if (ciDtoList != null && !ciDtoList.isEmpty()) {
                CompanyinfoDto ciDto = ciDtoList.get(0);
                map.put("ci_name", ciDto.getCi_name());
                map.put("ci_ppl", ciDto.getCi_ppl());
                DecimalFormat decimalFormat = new DecimalFormat("#,###");
                map.put("ci_sale", ciDto.getCi_sale());
                map.put("ci_sal", decimalFormat.format(ciDto.getCi_sal()) + "원");
                map.put("ci_photo", ciDto.getCi_photo());
                map.put("ci_star", ciDto.getCi_star());
                map.put("ci_idx", ciDto.getCi_idx());
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


        model.addAttribute("totalCount", totalCount);

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
                       @RequestParam(defaultValue = "0") int rb_idx, Model model) {
        List<CompanyinfoDto> ciNameList = reviewService.selectciname();
        model.addAttribute("ciNameList", ciNameList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("rb_idx", rb_idx);
        return "/main/review/reviewform";
    }


    @PostMapping("/insert")
    @ResponseBody
    public boolean insertreview(@RequestParam int rb_type, String rb_content, int rb_star, int m_idx, Integer
            ci_idx) {

        ReviewDto dto = new ReviewDto();
        dto.setRb_type(rb_type);
        dto.setRb_content(rb_content);
        dto.setRb_star(rb_star);
        dto.setM_idx(m_idx);
        dto.setCi_idx(ci_idx);

        reviewService.insertreview(dto); // ReviewDto 객체 insert 하기

        // updateCompanyinfoStar 메서드 호출
        CompanyinfoDto companyinfoDto = new CompanyinfoDto();
        companyinfoDto.setCi_idx(ci_idx);
        reviewService.updateCompanyinfoStar(companyinfoDto);
        return true;

    }

    @GetMapping("/updateform")

    public String update(int rb_idx, Model model) {
        ReviewDto dto = reviewService.getData(rb_idx);
        model.addAttribute("dto", dto);
        List<CompanyinfoDto> ciNameList = reviewService.selectciname();
        model.addAttribute("ciNameList", ciNameList);
        model.addAttribute("rb_idx", rb_idx);
        reviewService.updatereview(dto);
        reviewService.updateCompanyinfoStar(campanyinfoDto);
        return "/main/review/reviewupdateform";

    }


    @PostMapping("/update")
    @ResponseBody
    public boolean update(@RequestParam int rb_type, String rb_content, int rb_star, int m_idx, int ci_idx,int rb_idx) {
        ReviewDto dto = new ReviewDto();
        dto.setRb_type(rb_type);
        dto.setRb_content(rb_content);
        dto.setRb_star(rb_star);
        dto.setM_idx(m_idx);
        dto.setCi_idx(ci_idx);
        dto.setRb_idx(rb_idx);
        reviewService.updatereview(dto);

        // updateCompanyinfoStar 메서드 호출
        CompanyinfoDto companyinfoDto = new CompanyinfoDto();
        companyinfoDto.setCi_idx(ci_idx);
        reviewService.updateCompanyinfoStar(companyinfoDto);

        return  true;
    };

    @GetMapping("/delete")
    public String delete(int rb_idx) {
        reviewService.deletereview(rb_idx);
        return "redirect:list";
    }


    @GetMapping("/search")
    public @ResponseBody List<CompanyinfoDto> getSearchResult(String keyword) {
        List<CompanyinfoDto> ciNameList = reviewService.insertselciname(keyword);
        return ciNameList;
    }


 //좋아요 증가 메서드
 @RequestMapping("/increaseGoodRp")
 @ResponseBody
 public int increaseGoodRp(int rb_idx,int m_idx) {
     // article 테이블에서 해당 게시물의 좋아요 1 증가
     reviewService.increaseGoodRp(rb_idx);
     // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
     int goodRp = reviewService.getGoodRpCount(rb_idx);

     // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id)를 기록
     reviewService.addIncreasingGoodRpInfo(rb_idx,m_idx);

     return goodRp;
 }

    //좋아요 감소 메서드
    @RequestMapping("/decreaseGoodRp")
    @ResponseBody
    public int decreaseGoodRp(int rb_idx,int m_idx) {
        // article 테이블에서 해당 게시물의 좋아요 1 감소
        reviewService.decreaseGoodRp(rb_idx);
        // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
        int goodRp = reviewService.getGoodRpCount(rb_idx);

        // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id) 기록을 삭제
        reviewService.deleteGoodRpInfo(rb_idx,m_idx);

        return goodRp;
    }

    //싫어요 증가 메서드
    @RequestMapping("/increaseBadRp")
    @ResponseBody
    public int increaseBadRp(int rb_idx, int m_idx) {
        reviewService.increaseBadRp(rb_idx);
        int badRp = reviewService.getBadRpCount(rb_idx);

        reviewService.addIncreasingBadRpInfo(rb_idx,m_idx);

        return badRp;
    }

    //싫어요 감소 메서드
    @RequestMapping("/decreaseBadRp")
    @ResponseBody
    public int decreaseBadRp(int rb_idx, int m_idx) {
        reviewService.decreaseBadRp(rb_idx);
        int badRp = reviewService.getBadRpCount(rb_idx);

        reviewService.deleteBadRpInfo(rb_idx, m_idx);

        return badRp;
    }

    // 검색
    @PostMapping("/reviewboardsearchlist")
    @ResponseBody
    public List<Map<String, Object>> searchlist(@RequestParam(defaultValue = "1") int currentPage,
                                                @RequestParam(defaultValue = "") String keyword,
                                                @RequestParam(defaultValue = "all") String searchOption,
                                                Model model){


        int searchCount = reviewService.countsearch(searchOption,keyword);
        int totalPage; // 총 페이지 수
        int perPage = 20; // 한 페이지당 보여줄 글 갯수
        int perBlock = 10; // 한 블록당 보여질 페이지의 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int startPage; // 각 블록에서 보여질 시작 페이지 번호
        int endPage; // 각 블록에서 보여질 끝 페이지 번호
        int no; // 글 출력시 출력할 시작번호

        // 총 페이지 수
        totalPage = searchCount / perPage + (searchCount % perPage == 0 ? 0 : 1);
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
        no = searchCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<ReviewDto> list = reviewService.searchlist(searchOption, keyword, startNum, perPage);

        List<Map<String,Object>> fulllList =new ArrayList<>();

        for(ReviewDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            map.put("rb_idx",String.valueOf(dto.getRb_idx()));
            map.put("m_nickname",reviewService.selectnicnameofmidx(dto.getRb_idx()));


            map.put("rb_content",dto.getRb_content());
            map.put("rb_like",dto.getRb_like());
            map.put("rb_dislike",dto.getRb_dislike());
            map.put("rb_type",dto.getRb_type());
            map.put("rb_star",dto.getRb_star());

            map.put("rb_writeday", dto.getRb_writeday());

            map.put("searchOption", searchOption);
            map.put("keyword", keyword);

            // 출력시 필요한 변수들 model에 전부 저장
            model.addAttribute("searchCount", searchCount);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);
            model.addAttribute("totalPage", totalPage);
            model.addAttribute("no", no);
            model.addAttribute("currentPage", currentPage);


            fulllList.add(map);
        }

        return fulllList;
    }

    // 메인페이지 검색
    @GetMapping("/searchlist")
    public String searchlist(@RequestParam(defaultValue = "1") int currentPage, Model model,@RequestParam(defaultValue = "") String keyword){


        int searchCount = reviewService.countsearch("all",keyword);
        int totalPage; // 총 페이지 수
        int perPage = 20; // 한 페이지당 보여줄 글 갯수
        int perBlock = 10; // 한 블록당 보여질 페이지의 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int startPage; // 각 블록에서 보여질 시작 페이지 번호
        int endPage; // 각 블록에서 보여질 끝 페이지 번호
        int no; // 글 출력시 출력할 시작번호

        // 총 페이지 수
        totalPage = searchCount / perPage + (searchCount % perPage == 0 ? 0 : 1);
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
        no = searchCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<ReviewDto> list = reviewService.searchlist("all", keyword,startNum, perPage);

        List<Map<String,Object>> fulllList =new ArrayList<>();

        for(ReviewDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            map.put("rb_idx",String.valueOf(dto.getRb_idx()));
            map.put("nickName",reviewService.selectnicnameofmidx(dto.getRb_idx()));


            map.put("rb_content",dto.getRb_content());
            map.put("rb_like",dto.getRb_like());
            map.put("rb_dislike",dto.getRb_dislike());
            map.put("rb_type",dto.getRb_type());
            map.put("rb_star",dto.getRb_star());

            map.put("rb_writeday", dto.getRb_writeday());

            fulllList.add(map);
        }

        model.addAttribute("list", fulllList);

        // 출력시 필요한 변수들 model에 전부 저장
        model.addAttribute("searchCount", searchCount);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("no", no);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("keyword", keyword);




        return "/main/review/reviewsearchlist";
    }


    @GetMapping("/other_profile")
    public String message(String other_nick){
        String encodedNick = URLEncoder.encode(other_nick, StandardCharsets.UTF_8);
        return "redirect:/message/other_profile?other_nick="+encodedNick;
    }
}
