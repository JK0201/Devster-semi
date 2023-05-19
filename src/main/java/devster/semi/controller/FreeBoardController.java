package devster.semi.controller;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.HireBoardDto;
import devster.semi.dto.NoticeBoardDto;
import devster.semi.service.FreeBoardService;
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
@RequestMapping("/freeboard")
public class FreeBoardController {

    @Autowired
    private FreeBoardService freeBoardService;


    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName = "devster-bucket";

    @Autowired
    private NoticeBoardService noticeBoardService;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage, Model model) {


        int totalCount = freeBoardService.getTotalCount();

        int perPage = 20; // 한 페이지당 보여줄 글 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int no; // 글 출력시 출력할 시작번호

        startNum = (currentPage - 1) * perPage;

        no = totalCount - (currentPage - 1) * perPage;
        no = totalCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<FreeBoardDto> list = freeBoardService.getPagingList(startNum, perPage);

        List<Map<String, Object>> fulllList = new ArrayList<>();

        for (FreeBoardDto dto : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("fb_idx", String.valueOf(dto.getFb_idx()));
            map.put("nickName", freeBoardService.selectNickNameOfMidx(dto.getFb_idx()));
            map.put("commentCnt", freeBoardService.commentCnt(dto.getFb_idx()));

            String m_photo = freeBoardService.selectPhotoOfMidx(dto.getFb_idx());
            if (m_photo != "no") {
                map.put("m_photo", m_photo);
            } else {
                map.put("m_photo", "/photo/profile.jpg");
            }
            map.put("fb_subject", dto.getFb_subject());
            map.put("fb_content", dto.getFb_content());
            map.put("fb_like", dto.getFb_like());
            map.put("fb_dislike", dto.getFb_dislike());
            map.put("fb_readcount", dto.getFb_readcount());
            map.put("fb_writeday", dto.getFb_writeday());


            // 사진이 들어있으면
            if (dto.getFb_photo() != "n") {
                // 사진이 두장이상이면
                if (dto.getFb_photo().contains(",")) {
                    int index = dto.getFb_photo().indexOf(",");
                    String result = dto.getFb_photo().substring(0, index);
                    map.put("fb_photo", result);
                } else { //사진이 한장이면
                    map.put("fb_photo", dto.getFb_photo());
                }
            }


            fulllList.add(map);
        }

        model.addAttribute("list", fulllList);

        // 출력시 필요한 변수들 model에 전부 저장
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("no", no);
        model.addAttribute("currentPage", currentPage);

        //===========================공지사항===============================//

        int NoticeBoardTotalCount = noticeBoardService.getTotalCount();
        List<NoticeBoardDto> nblist = noticeBoardService.getTopThree();

        model.addAttribute("nblist", nblist);
        model.addAttribute("NoticeBoardTotalCount", NoticeBoardTotalCount);


        return "/main/freeboard/freeboardlist";
    }

    // 검색
    @PostMapping("/freeboardsearchlist")
    @ResponseBody
    public List<Map<String, Object>> searchlist(@RequestParam(defaultValue = "1") int currentPage,
                                                @RequestParam(defaultValue = "") String keyword,
                                                @RequestParam(defaultValue = "all") String searchOption,
                                                Model model) {


        int searchCount = freeBoardService.countsearch(searchOption, keyword);
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
        List<FreeBoardDto> list = freeBoardService.searchlist(searchOption, keyword, startNum, perPage);

        List<Map<String, Object>> fulllList = new ArrayList<>();

        for (FreeBoardDto dto : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("fb_idx", String.valueOf(dto.getFb_idx()));
            map.put("m_nickname", freeBoardService.selectNickNameOfMidx(dto.getFb_idx()));
            map.put("commentCnt", freeBoardService.commentCnt(dto.getFb_idx()));

            String m_photo = freeBoardService.selectPhotoOfMidx(dto.getFb_idx());
            if (m_photo != "no") {
                map.put("m_photo", m_photo);
            } else {
                map.put("m_photo", "/photo/profile.jpg");
            }
            map.put("fb_subject", dto.getFb_subject());
            map.put("fb_content", dto.getFb_content());
            map.put("fb_like", dto.getFb_like());
            map.put("fb_dislike", dto.getFb_dislike());
            map.put("fb_readcount", dto.getFb_readcount());
            map.put("fb_writeday", timeForToday(dto.getFb_writeday()));

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
            if (dto.getFb_photo() != "n") {
                // 사진이 두장이상이면
                if (dto.getFb_photo().contains(",")) {
                    int index = dto.getFb_photo().indexOf(",");
                    String result = dto.getFb_photo().substring(0, index);
                    map.put("fb_photo", result);
                } else { //사진이 한장이면
                    map.put("fb_photo", dto.getFb_photo());
                }
            }


            fulllList.add(map);
        }

        return fulllList;
    }

    // 메인페이지 검색
    @GetMapping("/searchlist")
    public String searchlist(@RequestParam(defaultValue = "1") int currentPage, Model model, @RequestParam(defaultValue = "") String keyword) {


        int searchCount = freeBoardService.countsearch("all", keyword);
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
        List<FreeBoardDto> list = freeBoardService.searchlist("all", keyword, startNum, perPage);

        List<Map<String, Object>> fulllList = new ArrayList<>();

        for (FreeBoardDto dto : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("fb_idx", String.valueOf(dto.getFb_idx()));
            map.put("nickName", freeBoardService.selectNickNameOfMidx(dto.getFb_idx()));
            map.put("commentCnt", freeBoardService.commentCnt(dto.getFb_idx()));

            String m_photo = freeBoardService.selectPhotoOfMidx(dto.getFb_idx());
            if (m_photo != "no") {
                map.put("m_photo", m_photo);
            } else {
                map.put("m_photo", "/photo/profile.jpg");
            }
            map.put("fb_subject", dto.getFb_subject());
            map.put("fb_content", dto.getFb_content());
            map.put("fb_like", dto.getFb_like());
            map.put("fb_dislike", dto.getFb_dislike());
            map.put("fb_readcount", dto.getFb_readcount());
            map.put("fb_writeday", dto.getFb_writeday());


            // 사진이 들어있으면
            if (dto.getFb_photo() != "no") {
                // 사진이 두장이상이면
                if (dto.getFb_photo().contains(",")) {
                    int index = dto.getFb_photo().indexOf(",");
                    String result = dto.getFb_photo().substring(0, index);
                    map.put("fb_photo", result);
                } else { //사진이 한장이면
                    map.put("fb_photo", dto.getFb_photo());
                }
            }

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


        //===========================공지사항===============================//

        int NoticeBoardTotalCount = noticeBoardService.getTotalCount();
        List<NoticeBoardDto> nblist = noticeBoardService.getTopThree();

        model.addAttribute("nblist", nblist);
        model.addAttribute("NoticeBoardTotalCount", NoticeBoardTotalCount);


        return "/main/freeboard/freeboardsearchlist";
    }

    @GetMapping("/freewriteform")
    public String form(@RequestParam(defaultValue = "1") int currentPage,
                       @RequestParam(defaultValue = "0") int fb_idx, Model model) {


        model.addAttribute("currentPage", currentPage);
        model.addAttribute("fb_idx", fb_idx);

        return "/main/freeboard/freeboardform";
    }

    @PostMapping("/freeinsert")
    public String insert(FreeBoardDto dto, List<MultipartFile> upload) {

        String fb_photo = "";
        if (upload.get(0).getOriginalFilename().equals("")) {
            fb_photo = "no";

        } else {
            int i = 0;
            for (MultipartFile mfile : upload) {
                //사진 업로드.
                fb_photo += (storageService.uploadFile(bucketName, "freeboard", mfile) + ",");
            }
        }

        fb_photo = fb_photo.substring(0, fb_photo.length() - 1);
//        업로드를 한 경우에만 버킷에 이미지를 저장한다.
        dto.setFb_photo(fb_photo);

        freeBoardService.insertFreeBoard(dto);
        return "redirect:list";

    }

    @GetMapping("/freeboarddetail")
    public String detail(int fb_idx, Model model, HttpSession session) {

        freeBoardService.updateReadCount(fb_idx);
        FreeBoardDto dto = freeBoardService.getData(fb_idx);
        String nickName = freeBoardService.selectNickNameOfMidx(dto.getFb_idx());
        String m_photo = freeBoardService.selectPhotoOfMidx(dto.getFb_idx());

        int commentCnt = freeBoardService.commentCnt(dto.getFb_idx());

        //        버튼 상태에 관한 정보를 디테일 페이지로 보내줌.
        boolean isAlreadyAddGoodRp = freeBoardService.isAlreadyAddGoodRp(fb_idx, (int) session.getAttribute("memidx"));
        boolean isAlreadyAddBadRp = freeBoardService.isAlreadyAddBadRp(fb_idx, (int) session.getAttribute("memidx"));

        if (m_photo.equals("no")) {
            m_photo = "photo/profile.jpg"; // 버켓에 넣어야 뜰듯....
        }

        model.addAttribute("dto", dto);
        model.addAttribute("nickname", nickName);
        model.addAttribute("m_photo", m_photo);
//        model.addAttribute("currentPage", currentPage);
        model.addAttribute("isAlreadyAddGoodRp", isAlreadyAddGoodRp);
        model.addAttribute("isAlreadyAddBadRp", isAlreadyAddBadRp);

        model.addAttribute("commentCnt",commentCnt);
        model.addAttribute("fb_writeday", timeForToday(dto.getFb_writeday()));

        if (dto.getFb_photo() != "n") {
            //Controller 디테일 페이지 보내는 부분.
            //사진 여러장 분할 처리.
            List<String> list = new ArrayList<>();
            StringTokenizer st = new StringTokenizer(dto.getFb_photo(), ",");
            while (st.hasMoreElements()) {
                list.add(st.nextToken());
            }
            model.addAttribute("list", list);
        }

        return "/main/freeboard/freeboarddetail";
    }

    @GetMapping("/freedelete")
    public String deleteFree(int fb_idx) {

        String fb_photo = freeBoardService.getData(fb_idx).getFb_photo();

        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(fb_photo, ",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "freeboard", st.nextToken());
        }
        freeBoardService.deleteBoard(fb_idx);

        return "redirect:list";
    }

    @GetMapping("/freeupdateform")
    public String updateform(int fb_idx, Model model) {

        FreeBoardDto dto = freeBoardService.getData(fb_idx);
        model.addAttribute("dto", dto);

        return "/main/freeboard/freeboardupdateform";
    }

    @PostMapping("/freeupdate")
    public String updateFree(FreeBoardDto dto, List<MultipartFile> upload, int fb_idx) {

        dto.setFb_idx(fb_idx);
        String fb_photo = "";

        String filename = freeBoardService.getData(fb_idx).getFb_photo();
        // 버켓에서 삭제
        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(filename, ",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "freeboard", st.nextToken());
        }

        if (upload.get(0).getOriginalFilename().equals("")) {
            fb_photo = "no";
        } else {
            int i = 0;
            for (MultipartFile mfile : upload) {

                //사진 업로드.
                fb_photo += (storageService.uploadFile(bucketName, "freeboard", mfile) + ",");
            }
        }
        fb_photo = fb_photo.substring(0, fb_photo.length() - 1);
        dto.setFb_photo(fb_photo);

        freeBoardService.updateBoard(dto);

        return "redirect:./freeboarddetail?fb_idx=" + dto.getFb_idx();
    }

    //좋아요 증가 메서드
    @RequestMapping("/increaseGoodRp")
    @ResponseBody
    public int increaseGoodRp(int fb_idx, int m_idx) {
        // article 테이블에서 해당 게시물의 좋아요 1 증가
        freeBoardService.increaseGoodRp(fb_idx);
        // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
        int goodRp = freeBoardService.getGoodRpCount(fb_idx);

        // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id)를 기록
        freeBoardService.addIncreasingGoodRpInfo(fb_idx, m_idx);

        return goodRp;
    }

    //좋아요 감소 메서드
    @RequestMapping("/decreaseGoodRp")
    @ResponseBody
    public int decreaseGoodRp(int fb_idx, int m_idx) {
        // article 테이블에서 해당 게시물의 좋아요 1 감소
        freeBoardService.decreaseGoodRp(fb_idx);
        // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
        int goodRp = freeBoardService.getGoodRpCount(fb_idx);

        // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id) 기록을 삭제
        freeBoardService.deleteGoodRpInfo(fb_idx, m_idx);

        return goodRp;
    }


    //싫어요 증가 메서드
    @RequestMapping("/increaseBadRp")
    @ResponseBody
    public int increaseBadRp(int fb_idx, int m_idx) {
        freeBoardService.increaseBadRp(fb_idx);
        int badRp = freeBoardService.getBadRpCount(fb_idx);

        freeBoardService.addIncreasingBadRpInfo(fb_idx, m_idx);

        return badRp;
    }

    //싫어요 감소 메서드
    @RequestMapping("/decreaseBadRp")
    @ResponseBody
    public int decreaseBadRp(int fb_idx, int m_idx) {
        freeBoardService.decreaseBadRp(fb_idx);
        int badRp = freeBoardService.getBadRpCount(fb_idx);

        freeBoardService.deleteBadRpInfo(fb_idx, m_idx);

        return badRp;
    }


    @PostMapping("/bestPostsForBanner")
    @ResponseBody
    public List<FreeBoardDto> bestPosts() {
        List<FreeBoardDto> list = freeBoardService.bestfreeboardPosts();
        return list;
    }

    // 무한스크롤
    @GetMapping("/listajax")
    @ResponseBody
    public List<Map<String,Object>> list(int currentPage) {
        int totalCount = freeBoardService.getTotalCount();
        int perPage = 10; // 한 페이지당 보여줄 글 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int no; // 글 출력시 출력할 시작번호

        // 각 페이지의 시작번호 (1페이지: 0, 2페이지 : 3, 3페이지 6 ....)
        startNum = (currentPage - 1) * perPage;

        // 각 글마다 출력할 글 번호 (예 : 10개일 경우 1페이지 10, 2페이지 7...)
        // no = totalCount - (currentPage - 1) * perPage;
        no = totalCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<FreeBoardDto> list = freeBoardService.getPagingList(startNum, perPage);

        List<Map<String, Object>> fulllList = new ArrayList<>();

        for (FreeBoardDto dto : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("fb_idx", String.valueOf(dto.getFb_idx()));
            map.put("nickName", freeBoardService.selectNickNameOfMidx(dto.getFb_idx()));
            map.put("commentCnt", freeBoardService.commentCnt(dto.getFb_idx()));

            String m_photo = freeBoardService.selectPhotoOfMidx(dto.getFb_idx());
            if (m_photo != "no") {
                map.put("m_photo", m_photo);
            } else {
                map.put("m_photo", "/photo/profile.jpg");
            }
            map.put("fb_subject", dto.getFb_subject());
            map.put("fb_content", dto.getFb_content());
            map.put("fb_like", dto.getFb_like());
            map.put("fb_dislike", dto.getFb_dislike());
            map.put("fb_readcount", dto.getFb_readcount());
            map.put("fb_writeday", timeForToday(dto.getFb_writeday()));
            map.put("currentPage", currentPage);
            map.put("totalCount", totalCount);
            map.put("no", no);


            // 사진이 들어있으면
            if (dto.getFb_photo() != "no") {
                // 사진이 두장이상이면
                if (dto.getFb_photo().contains(",")) {
                    int index = dto.getFb_photo().indexOf(",");
                    String result = dto.getFb_photo().substring(0, index);
                    map.put("fb_photo", result);
                } else { //사진이 한장이면
                    map.put("fb_photo", dto.getFb_photo());
                }
            }


            fulllList.add(map);
        }

        return fulllList;
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

    @GetMapping("/other_profile")
    public String message(String other_nick){
        String encodedNick = URLEncoder.encode(other_nick, StandardCharsets.UTF_8);
        return "redirect:/message/other_profile?other_nick="+encodedNick;
    }

}










