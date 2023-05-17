package devster.semi.controller;


import devster.semi.dto.HireBoardDto;

import devster.semi.dto.NoticeBoardDto;
import devster.semi.mapper.HireMapper;
import devster.semi.service.HireService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.*;

@Controller
@RequestMapping("/hire")
public class HireBoardController {

    @Autowired
    private HireService hireService;

    @Autowired
    HireMapper hireMapper;

    @Autowired
    private NcpObjectStorageService storageService;

    //버켓이름지정
    private String bucketName="devster-bucket";//각자 자기 버켓이름


    @GetMapping("/listajax")
    @ResponseBody
    public Map<String,Object> list(int currentPage)
    {
        int totalCount = hireService.getHireTotalCount();
        int perPage = 10; // 한 페이지당 보여줄 글 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int no; // 글 출력시 출력할 시작번호

        // 각 페이지의 시작번호 (1페이지: 0, 2페이지 : 3, 3페이지 6 ....)
        startNum = (currentPage - 1) * perPage;

        // 각 글마다 출력할 글 번호 (예 : 10개일 경우 1페이지 10, 2페이지 7...)
        // no = totalCount - (currentPage - 1) * perPage;
        no = totalCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<HireBoardDto> list = hireService.getHirePagingList(startNum, perPage);

        Map<String,Object> map = new HashMap<>();
        map.put("list",list);
        map.put("currentPage",currentPage);
        map.put("totalCount", totalCount);
        map.put("no", no);

        return map;
    }
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage,Model model)

    {
        int totalCount = hireService.getHireTotalCount();
        int perPage = 10; // 한 페이지당 보여줄 글 갯수
        int startNum= 1; // 각 페이지에서 보여질 글의 시작번호
        int no; // 글 출력시 출력할 시작번호

        // 각 페이지의 시작번호 (1페이지: 0, 2페이지 : 3, 3페이지 6 ....)
        startNum = (currentPage - 1) * perPage;

        // 각 글마다 출력할 글 번호 (예 : 10개일 경우 1페이지 10, 2페이지 7...)
        // no = totalCount - (currentPage - 1) * perPage;
        no = totalCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<HireBoardDto> list = hireService.getHirePagingList(startNum, perPage);

        Map<String,Object> map = new HashMap<>();
        model.addAttribute("list",list);
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("no", no);

        return "/main/hire/hirelist";
    }

    @GetMapping("/form")
    public String form(@RequestParam(defaultValue = "1") int currentPage,
                       @RequestParam(defaultValue = "0") int hb_idx, Model model){

        model.addAttribute("currentPage",currentPage);
        model.addAttribute("hb_idx",hb_idx);

        return "/main/hire/hireform";
    }


    @PostMapping("/insertHireBoard")
    public String insert(HireBoardDto dto,List<MultipartFile> upload,HttpSession session)
    {
        String hb_photo="";
        if(upload.get(0).getOriginalFilename().equals("")){
            hb_photo="no";

        } else{
            int i=0;
            for(MultipartFile mfile : upload) {
//            hb_photo = storageService.uploadFile(bucketName,"hire",upload);

            //사진 업로드.
            hb_photo += (storageService.uploadFile(bucketName, "hire", mfile) + ",");
            }
        }

        hb_photo=hb_photo.substring(0,hb_photo.length()-1);
        dto.setHb_photo(hb_photo);
        //db insert
        dto.setCm_idx((int)session.getAttribute("cmidx"));
        hireMapper.insertHireBoard(dto);

        return "redirect:list";
    }

    @GetMapping("/hireboarddetail")
    public String detail(int hb_idx, Model model, HttpSession session){

        boolean isAlreadyAddBkmk = false;

        hireService.updateReadCount(hb_idx);
        HireBoardDto dto = hireService.getData(hb_idx);

        //        버튼 상태에 관한 정보를 디테일 페이지로 보내줌.
        if(session.getAttribute("memidx") != null) {
             isAlreadyAddBkmk = hireService.isAlreadyAddBkmk((int)session.getAttribute("memidx"),hb_idx);
        }

        model.addAttribute("dto", dto);

        //Controller 디테일 페이지 보내는 부분.
        //사진 여러장 분할 처리.
        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(dto.getHb_photo(),",");
        while (st.hasMoreElements()) {
            list.add(st.nextToken());
        }

        model.addAttribute("list",list);
        System.out.println(isAlreadyAddBkmk);
        model.addAttribute("isAlreadyAddBkmk", isAlreadyAddBkmk);


        model.addAttribute("cm_name",hireService.getCompName(hb_idx));
        return "/main/hire/hireboarddetail";
    }

    //북마크 추가 메서드
    @RequestMapping("/increaseBkmk")
    @ResponseBody
    public void increaseBkmk(int m_idx,int hb_idx) {
//        // article 테이블에서 해당 게시물 등록
//        hireService.increaseBkmk(hb_idx);
//        // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
//        int bookMark = hireService.getBkmkCount(hb_idx);

        // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id)를 기록
        hireService.addIncreasingBkmkInfo(m_idx, hb_idx);

//        return;
    }

    //좋아요 감소 메서드
    @RequestMapping("/decreaseBkmk")
    @ResponseBody
    public void decreaseBkmk(int m_idx,int hb_idx) {
//        // article 테이블에서 해당 게시물의 좋아요 1 감소
//        qboardService.decreaseGoodRp(qb_idx);
//        // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
//        int goodRp = qboardService.getGoodRpCount(qb_idx);

        // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id) 기록을 삭제
        hireService.deleteBkmkInfo(m_idx,hb_idx);

//        return goodRp;
    }

    @GetMapping("/hireboarddelete")
    public String deleteHireBoard(int hb_idx){

        String hb_photo = hireService.getData(hb_idx).getHb_photo();
        storageService.deleteFile(bucketName,"hire",hb_photo);

        hireService.deleteHireBoard(hb_idx);

        return "redirect:list";
    }




    @GetMapping("/hireupdateform")
    public String updateHireBoardform(@RequestParam(defaultValue = "1") int currentPage,
                                      @RequestParam(defaultValue = "0") int hb_idx, Model model)
    {
        HireBoardDto dto=hireService.getData(hb_idx);

        model.addAttribute("dto", dto);
        model.addAttribute("currentPage", currentPage);

        return "/main/hire/hireupdateform";
    }

    @PostMapping("/hireupdate")
    public String updateHireBoard(HireBoardDto dto,MultipartFile upload,int currentPage)
    {
        String filename="";
        //사진선택을 한경우에는 기존 사진을 버켓에서 지우고 다시 업로드를 한다
        if(!upload.getOriginalFilename().equals("")) {
            //기존 파일명 알아내기
            filename=hireService.getData(dto.getHb_idx()).getHb_photo();
            //버켓에서 삭제
            storageService.deleteFile(bucketName, "hire", filename);

            //다시 업로드후 업로드한 파일명 얻기
            filename=storageService.uploadFile(bucketName, "hire", upload);
            dto.setHb_photo(filename);
        }

        dto.setHb_photo(filename);
        //수정
        hireService.updateHireBoard(dto);


        //수정후 내용보기로 이동한다
        return "redirect:./hireboarddetail?hb_idx="+dto.getHb_idx()+"&currentPage="+currentPage;
    }

    // 검색
    @PostMapping("/hboardsearchlist")
    @ResponseBody
    public List<Map<String, Object>> searchlist(@RequestParam(defaultValue = "1") int currentPage, @RequestParam(defaultValue = "") String keyword, Model model){


        int searchCount = hireService.countsearch(keyword);
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
        List<HireBoardDto> list = hireService.searchlist(keyword, startNum, perPage);

        List<Map<String,Object>> fulllList =new ArrayList<>();

        for(HireBoardDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            map.put("hb_idx",String.valueOf(dto.getHb_idx()));


            map.put("hb_subject",dto.getHb_subject());
            map.put("hb_content",dto.getHb_content());
            map.put("hb_readcount",dto.getHb_readcount());
            map.put("hb_writeday", dto.getFb_writeday());

            map.put("keyword", keyword);

            // 출력시 필요한 변수들 model에 전부 저장
            model.addAttribute("searchCount", searchCount);
            model.addAttribute("startPage", startPage);
            model.addAttribute("endPage", endPage);
            model.addAttribute("totalPage", totalPage);
            model.addAttribute("no", no);
            model.addAttribute("currentPage", currentPage);


            // 사진이 들어있으면
            if(dto.getHb_photo()!="no"){
                // 사진이 두장이상이면
                if(dto.getHb_photo().contains(",")){
                    int index = dto.getHb_photo().indexOf(",");
                    String result = dto.getHb_photo().substring(0, index);
                    map.put("hb_photo", result);
                } else { //사진이 한장이면
                    map.put("hb_photo", dto.getHb_photo());
                }
            }

            fulllList.add(map);
        }

        return fulllList;
    }

    @GetMapping("/searchlist")
    public String searchlist(@RequestParam(defaultValue = "1") int currentPage, Model model,@RequestParam(defaultValue = "") String keyword){


        int searchCount = hireService.countsearch(keyword);
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
        List<HireBoardDto> list = hireService.searchlist(keyword,startNum, perPage);

        List<Map<String,Object>> fulllList =new ArrayList<>();

        for(HireBoardDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            map.put("hb_idx",String.valueOf(dto.getHb_idx()));


            map.put("hb_subject",dto.getHb_subject());
            map.put("hb_content",dto.getHb_content());

            map.put("hb_readcount",dto.getHb_readcount());
            map.put("hb_writeday", dto.getFb_writeday());


            // 사진이 들어있으면
            if(dto.getHb_photo()!="no"){
                // 사진이 두장이상이면
                if(dto.getHb_photo().contains(",")){
                    int index = dto.getHb_photo().indexOf(",");
                    String result = dto.getHb_photo().substring(0, index);
                    map.put("hb_photo", result);
                } else { //사진이 한장이면
                    map.put("hb_photo", dto.getHb_photo());
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



        return "/main/hire/hiresearchlist";
    }

}
