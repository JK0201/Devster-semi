package devster.semi.controller;

import devster.semi.dto.AcademyBoardDto;
import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.NoticeBoardDto;
import devster.semi.service.AcademyBoardService;
import devster.semi.service.MemberService;
import devster.semi.service.NoticeBoardService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Controller
@RequestMapping("/academyboard")
public class AcademyBoardController {

    @Autowired
    private AcademyBoardService academyBoardService;

    @Autowired
    private NoticeBoardService noticeBoardService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName = "devster-bucket";


    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage, Model model,HttpSession session) {

        int totalCount = academyBoardService.getTotalCount();
        int perPage = 20; // 한 페이지당 보여줄 글 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int no; // 글 출력시 출력할 시작번호

        // 각 페이지의 시작번호 (1페이지: 0, 2페이지 : 3, 3페이지 6 ....)
        startNum = (currentPage - 1) * perPage;

        // 각 글마다 출력할 글 번호 (예 : 10개일 경우 1페이지 10, 2페이지 7...)
        // no = totalCount - (currentPage - 1) * perPage;
        no = totalCount - startNum;

        int ai_idx = memberService.getOneDataByM_idx((int)session.getAttribute("memidx")).getAi_idx();

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<AcademyBoardDto> list = academyBoardService.getPagingList(startNum, perPage,ai_idx);

        List<Map<String, Object>> fulllList = new ArrayList<>();

        for (AcademyBoardDto dto : list) {

            Map<String, Object> map = new HashMap<>();
            map.put("nickName", academyBoardService.selectNickName2OfMidx(dto.getAb_idx()));
            map.put("commentCnt", academyBoardService.getCommentCnt(dto.getAb_idx()));

            String m_photo = academyBoardService.selectPhoto2OfMidx(dto.getAb_idx());
            if(m_photo.equals("no")) {
                m_photo = "/photo/profile.jpg";
            } else {
                m_photo = "http://kr.object.ncloudstorage.com/devster-bucket/member/"+m_photo;
            }
            map.put("m_photo",m_photo);
            map.put("commentCnt",academyBoardService.getCommentCnt(dto.getAb_idx()));
            map.put("ab_subject", dto.getAb_subject());
            map.put("ab_content", dto.getAb_content());
            map.put("ab_like", dto.getAb_like());
            map.put("ab_dislike", dto.getAb_dislike());
            map.put("ab_readcount", dto.getAb_readcount());
            map.put("ab_writeday", dto.getAb_writeday());
            map.put("ab_photo",dto.getAb_photo());
            map.put("ab_idx",dto.getAb_idx());
            fulllList.add(map);
        }
            model.addAttribute("list", fulllList);
            model.addAttribute("totalCount", totalCount);
            model.addAttribute("no", no);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("ai_idx",ai_idx);

            //===========================공지사항===============================//

            int NoticeBoardTotalCount = noticeBoardService.getTotalCount();
            List<NoticeBoardDto> nblist = noticeBoardService.getTopThree();

            model.addAttribute("nblist", nblist);
            model.addAttribute("NoticeBoardTotalCount", NoticeBoardTotalCount);

//            String ai_name = academyBoardService.selectAcademyName(ab_idx);
//            model.addAttribute("ai_name",ai_name);



            return "/main/academyboard/academyboardlist";
        }

    // 검색
    @PostMapping("/academyboardsearchlist")
    @ResponseBody
    public List<Map<String, Object>> searchlist(@RequestParam(defaultValue = "1") int currentPage,
                                                @RequestParam(defaultValue = "") String keyword,
                                                @RequestParam(defaultValue = "all") String searchOption,
                                                Model model) {


        int searchCount = academyBoardService.countsearch(searchOption, keyword);
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
        List<AcademyBoardDto> list = academyBoardService.searchlist(searchOption, keyword, startNum, perPage);

        List<Map<String, Object>> fulllList = new ArrayList<>();

        for (AcademyBoardDto dto : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("ab_idx", String.valueOf(dto.getAb_idx()));
            map.put("m_nickname", academyBoardService.selectNickNameOfMidx(dto.getAb_idx()));
            map.put("commentCnt", academyBoardService.commentCnt(dto.getAb_idx()));

            String m_photo = academyBoardService.selectPhotoOfMidx(dto.getAb_idx());
            if (m_photo != "no") {
                map.put("m_photo", m_photo);
            } else {
                map.put("m_photo", "/photo/profile.jpg");
            }
            map.put("ab_subject", dto.getAb_subject());
            map.put("ab_content", dto.getAb_content());
            map.put("ab_like", dto.getAb_like());
            map.put("ab_dislike", dto.getAb_dislike());
            map.put("ab_readcount", dto.getAb_readcount());
            map.put("ab_writeday", dto.getAb_writeday());

            map.put("searchOption", searchOption);
            map.put("keyword", keyword);

            // 출력시 필요한 변수들 model에 전부 저장
            model.addAttribute("searchCount", searchCount);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);
            model.addAttribute("totalPage", totalPage);
            model.addAttribute("no", no);
            model.addAttribute("currentPage", currentPage);


            // 사진이 들어있으면
            if (dto.getAb_photo() != "n") {
                // 사진이 두장이상이면
                if (dto.getAb_photo().contains(",")) {
                    int index = dto.getAb_photo().indexOf(",");
                    String result = dto.getAb_photo().substring(0, index);
                    map.put("ab_photo", result);
                } else { //사진이 한장이면
                    map.put("ab_photo", dto.getAb_photo());
                }
            }


            fulllList.add(map);
        }

        return fulllList;
    }


    @GetMapping("/academywriteform")
    public String form(@RequestParam(defaultValue = "1") int currentPage,
                       @RequestParam(defaultValue = "0") int ab_idx, Model model){

        // m_idx는 세션으로 받아와야할듯..
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("ab_idx",ab_idx);

        return "/main/academyboard/academyboardform";
    }

    @PostMapping("/academyinsert")
    public String insert(AcademyBoardDto dto,  List<MultipartFile> upload){

        String ab_photo="";
        if(upload.get(0).getOriginalFilename().equals("")){
            ab_photo="no";

        } else{
            int i =0;
            for(MultipartFile mfile : upload) {
                //사진 업로드.
                ab_photo += (storageService.uploadFile(bucketName, "academyboard", mfile) + ",");
            }
        }

        ab_photo=ab_photo.substring(0,ab_photo.length()-1);
//        업로드를 한 경우에만 버킷에 이미지를 저장한다.
        dto.setAb_photo(ab_photo);

//        System.out.println(dto.getAi_idx());

        academyBoardService.insertAcademyBoard(dto);
        return "redirect:list";

    }


    @GetMapping("/academyboarddetail")
    public String detail(int ab_idx, Model model, HttpSession session){

        academyBoardService.updateReadCount(ab_idx);
        AcademyBoardDto dto = academyBoardService.getData(ab_idx);
        String nickName = academyBoardService.selectNickNameOfMidx(dto.getAb_idx());
        String m_photo = academyBoardService.selectPhotoOfMidx(dto.getAb_idx());

        //        버튼 상태에 관한 정보를 디테일 페이지로 보내줌.
        boolean isAlreadyAddGoodRp = academyBoardService.isAlreadyAddGoodRp(ab_idx,(int)session.getAttribute("memidx"));
        boolean isAlreadyAddBadRp = academyBoardService.isAlreadyAddBadRp(ab_idx,(int)session.getAttribute("memidx"));

        if(m_photo.equals("no")) {
            m_photo = "photo/profile.jpg"; // 버켓에 넣어야 뜰듯....
        }

        model.addAttribute("dto", dto);
        model.addAttribute("nickname",nickName);
        model.addAttribute("m_photo",m_photo);
        model.addAttribute("isAlreadyAddGoodRp", isAlreadyAddGoodRp);
        model.addAttribute("isAlreadyAddBadRp", isAlreadyAddBadRp);

        if(dto.getAb_photo()!="n"){
            //Controller 디테일 페이지 보내는 부분.
            //사진 여러장 분할 처리.
            List<String> list = new ArrayList<>();
            StringTokenizer st = new StringTokenizer(dto.getAb_photo(),",");
            while (st.hasMoreElements()) {
                list.add(st.nextToken());
            }
            model.addAttribute("list",list);
        }

        return "/main/academyboard/academyboarddetail";
    }

    @GetMapping("/academydelete")
    public String deleteAcademy(int ab_idx){

        String ab_photo = academyBoardService.getData(ab_idx).getAb_photo();

        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(ab_photo,",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "academyboard", st.nextToken());
        }
        academyBoardService.deleteAcademyBoard(ab_idx);

        return "redirect:list";
    }

    @GetMapping("/academyupdateform")
    public String academyupdateform(int ab_idx, Model model){

        AcademyBoardDto dto = academyBoardService.getData(ab_idx);
        model.addAttribute("dto",dto);


        return "/main/academyboard/academyboardupdateform";
    }

    @PostMapping("/academyupdate")
    public String updateAcademy(AcademyBoardDto dto, List<MultipartFile> upload, int ab_idx){

        dto.setAb_idx(ab_idx);
        String ab_photo="";

        String filename = academyBoardService.getData(ab_idx).getAb_photo();
        // 버켓에서 삭제
        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(filename,",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "academyboard", st.nextToken());
        }

        if(upload.get(0).getOriginalFilename().equals("")){
            ab_photo="no";
        } else {
            int i =0;
            for(MultipartFile mfile : upload) {

                //사진 업로드.
                ab_photo += (storageService.uploadFile(bucketName, "academyboard", mfile) + ",");
            }
        }
        ab_photo=ab_photo.substring(0,ab_photo.length()-1);
        dto.setAb_photo(ab_photo);

        academyBoardService.updateAcademyBoard(dto);

        return "redirect:./academyboarddetail?ab_idx="+dto.getAb_idx();
    }


    //좋아요 증가 메서드
    @RequestMapping("/increaseGoodRp")
    @ResponseBody
    public int increaseGoodRp(int ab_idx,int m_idx) {
        // article 테이블에서 해당 게시물의 좋아요 1 증가
        academyBoardService.increaseGoodRp(ab_idx);
        // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
        int goodRp = academyBoardService.getGoodRpCount(ab_idx);

        // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id)를 기록
        academyBoardService.addIncreasingGoodRpInfo(ab_idx,m_idx);

        return goodRp;
    }

    //좋아요 감소 메서드
    @RequestMapping("/decreaseGoodRp")
    @ResponseBody
    public int decreaseGoodRp(int ab_idx,int m_idx) {
        // article 테이블에서 해당 게시물의 좋아요 1 감소
        academyBoardService.decreaseGoodRp(ab_idx);
        // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
        int goodRp = academyBoardService.getGoodRpCount(ab_idx);

        // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id) 기록을 삭제
        academyBoardService.deleteGoodRpInfo(ab_idx,m_idx);

        return goodRp;
    }

    //싫어요 증가 메서드
    @RequestMapping("/increaseBadRp")
    @ResponseBody
    public int increaseBadRp(int ab_idx, int m_idx) {
        academyBoardService.increaseBadRp(ab_idx);
        int badRp = academyBoardService.getBadRpCount(ab_idx);

        academyBoardService.addIncreasingBadRpInfo(ab_idx,m_idx);

        return badRp;
    }

    //싫어요 감소 메서드
    @RequestMapping("/decreaseBadRp")
    @ResponseBody
    public int decreaseBadRp(int ab_idx, int m_idx) {
        academyBoardService.decreaseBadRp(ab_idx);
        int badRp = academyBoardService.getBadRpCount(ab_idx);

        academyBoardService.deleteBadRpInfo(ab_idx, m_idx);

        return badRp;
    }

    // 무한스크롤
    @GetMapping("/listajax")
    @ResponseBody
    public List<Map<String, Object>> list(@RequestParam(defaultValue = "1")int currentPage, int ai_idx) {
        int totalCount = academyBoardService.getTotalCount();
        int perPage = 20; // 한 페이지당 보여줄 글 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int no; // 글 출력시 출력할 시작번호

        // 각 페이지의 시작번호 (1페이지: 0, 2페이지 : 3, 3페이지 6 ....)
        startNum = (currentPage - 1) * perPage;

        // 각 글마다 출력할 글 번호 (예 : 10개일 경우 1페이지 10, 2페이지 7...)
        // no = totalCount - (currentPage - 1) * perPage;
        no = totalCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<AcademyBoardDto> list = academyBoardService.getPagingList(startNum, perPage, ai_idx);

        List<Map<String, Object>> fulllList = new ArrayList<>();

        for (AcademyBoardDto dto : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("ab_idx", String.valueOf(dto.getAb_idx()));
            map.put("nickName", academyBoardService.selectNickNameOfMidx(dto.getAb_idx()));
            map.put("commentCnt", academyBoardService.getCommentCnt(dto.getAb_idx()));

            String m_photo = academyBoardService.selectPhoto2OfMidx(dto.getAb_idx());

            if(m_photo.equals("no")) {
                m_photo = "/photo/profile.jpg";
            } else {
                m_photo = "http://kr.object.ncloudstorage.com/devster-bucket/member/"+m_photo;
            }
            map.put("m_photo",m_photo);
            map.put("ab_subject", dto.getAb_subject());
            map.put("ab_content", dto.getAb_content());
            map.put("ab_like", dto.getAb_like());
            map.put("ab_dislike", dto.getAb_dislike());
            map.put("ab_readcount", dto.getAb_readcount());
            map.put("ab_writeday",timeForToday(dto.getAb_writeday()));
            map.put("ab_photo",dto.getAb_photo());

            fulllList.add(map);
        }
        return fulllList;
    }

    @GetMapping("/other_profile")
    public String message(String other_nick){
        String encodedNick = URLEncoder.encode(other_nick, StandardCharsets.UTF_8);
        return "redirect:/message/other_profile?other_nick="+encodedNick;
    }

    public String timeForToday(Timestamp value) {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime timeValue = value.toLocalDateTime();

        long betweenTime = ChronoUnit.MINUTES.between(timeValue, now);
        if (betweenTime < 1) {
            return "방금전";
        }
        if (betweenTime < 60) {
            return betweenTime + "분전";
        }

        long betweenTimeHour = betweenTime / 60;
        if (betweenTimeHour < 24) {
            return betweenTimeHour + "시간전";
        }

        long betweenTimeDay = betweenTime / 1440; // 60 minutes * 24 hours
        if (betweenTimeDay < 8) {
            return betweenTimeDay + "일전";
        }

        String month = String.format("%02d", timeValue.getMonthValue());
        String day = String.format("%02d", timeValue.getDayOfMonth());
        String formattedDate = month + "-" + day;

        return formattedDate;
    }



}