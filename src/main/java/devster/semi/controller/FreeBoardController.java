package devster.semi.controller;

import devster.semi.dto.FreeBoardDto;
import devster.semi.service.FreeBoardService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/freeboard")
public class FreeBoardController {

    @Autowired
    private FreeBoardService freeBoardService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName="devster-bucket";

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage, Model model){


        int totalCount = freeBoardService.getTotalCount();
        int totalPage; // 총 페이지 수
        int perPage = 20; // 한 페이지당 보여줄 글 갯수
        int perBlock = 10; // 한 블록당 보여질 페이지의 갯수
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
        List<FreeBoardDto> list = freeBoardService.getPagingList(startNum, perPage);

        List<Map<String,Object>> fulllList =new ArrayList<>();

        for(FreeBoardDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            map.put("fb_idx",String.valueOf(dto.getFb_idx()));
            map.put("nickName",freeBoardService.selectNickNameOfMidx(dto.getFb_idx()));

            String m_photo = freeBoardService.selectPhotoOfMidx(dto.getFb_idx());
            if(m_photo!="no"){
                map.put("m_photo", m_photo);
            } else {

            }
            map.put("fb_subject",dto.getFb_subject());
            map.put("fb_content",dto.getFb_content());
            map.put("fb_like",dto.getFb_like());
            map.put("fb_dislike",dto.getFb_dislike());
            map.put("fb_readcount",dto.getFb_readcount());


            // 사진이 들어있으면
            if(dto.getFb_photo()!="no"){
                // 사진이 두장이상이면
                if(dto.getFb_photo().contains(",")){
                    int index = dto.getFb_photo().indexOf(",");
                    String result = dto.getFb_photo().substring(0, index);
                    map.put("fb_photo", result);
                } else { //사진이 한장이면
                    map.put("fb_photo", dto.getFb_photo());
                }
            }

            String currentTimestampToString = new SimpleDateFormat("MM-dd HH:mm").format(dto.getFb_writeday());
           map.put("fb_writeday", currentTimestampToString);


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


        return "/main/freeboard/freeboardlist";
    }

    @GetMapping("/freewriteform")
    public String form(@RequestParam(defaultValue = "1") int currentPage,
                       @RequestParam(defaultValue = "0") int fb_idx, Model model){

        // m_idx는 세션으로 받아와야할듯..
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("fb_idx",fb_idx);

        return "/main/freeboard/freeboardform";
    }

    @PostMapping("/freeinsert")
    public String insert(FreeBoardDto dto,  List<MultipartFile> upload){

        String fb_photo="";
        if(upload.get(0).getOriginalFilename().equals("")){
            fb_photo="no";

        } else{
            int i =0;
            for(MultipartFile mfile : upload) {
                //사진 업로드.
                fb_photo += (storageService.uploadFile(bucketName, "freeboard", mfile) + ",");
            }
        }

            fb_photo=fb_photo.substring(0,fb_photo.length()-1);
//        업로드를 한 경우에만 버킷에 이미지를 저장한다.
            dto.setFb_photo(fb_photo);

            freeBoardService.insertFreeBoard(dto);
            return "redirect:list";

    }

    @GetMapping("/freeboarddetail")
    public String detail(int fb_idx, int currentPage, Model model){

        freeBoardService.updateReadCount(fb_idx);
        FreeBoardDto dto = freeBoardService.getData(fb_idx);
        String nickName = freeBoardService.selectNickNameOfMidx(dto.getFb_idx());
        String m_photo = freeBoardService.selectPhotoOfMidx(dto.getFb_idx());

        model.addAttribute("dto", dto);
        model.addAttribute("nickname",nickName);
        model.addAttribute("m_photo",m_photo);
        model.addAttribute("currentPage",currentPage);

        if(dto.getFb_photo()!="n"){
            //Controller 디테일 페이지 보내는 부분.
            //사진 여러장 분할 처리.
            List<String> list = new ArrayList<>();
            StringTokenizer st = new StringTokenizer(dto.getFb_photo(),",");
            while (st.hasMoreElements()) {
                list.add(st.nextToken());
            }
            model.addAttribute("list",list);
        }

        return "/main/freeboard/freeboarddetail";
    }

    @GetMapping("/freedelete")
    public String deleteFree(int fb_idx){

        String fb_photo = freeBoardService.getData(fb_idx).getFb_photo();

        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(fb_photo,",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "freeboard", st.nextToken());
        }
        freeBoardService.deleteBoard(fb_idx);

        return "redirect:list";
    }

    @GetMapping("/freeupdateform")
    public String updateform(int fb_idx, int currentPage, Model model){

        FreeBoardDto dto = freeBoardService.getData(fb_idx);
        model.addAttribute("dto",dto);
        model.addAttribute("currentPage",currentPage);

        return "/main/freeboard/freeboardupdateform";
    }

    @PostMapping("/freeupdate")
    public String updateFree(FreeBoardDto dto, List<MultipartFile> upload, int currentPage, int fb_idx){

        dto.setFb_idx(fb_idx);
        String fb_photo="";

        String filename = freeBoardService.getData(fb_idx).getFb_photo();
        // 버켓에서 삭제
        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(filename,",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "freeboard", st.nextToken());
        }

        if(upload.get(0).getOriginalFilename().equals("")){
            fb_photo="no";
        } else {
            int i =0;
            for(MultipartFile mfile : upload) {

                //사진 업로드.
                fb_photo += (storageService.uploadFile(bucketName, "freeboard", mfile) + ",");
            }
        }
        fb_photo=fb_photo.substring(0,fb_photo.length()-1);
       dto.setFb_photo(fb_photo);

        freeBoardService.updateBoard(dto);

        return "redirect:./freeboarddetail?fb_idx="+dto.getFb_idx()+"&currentPage="+currentPage;
    }

    @PostMapping("/like")
    @ResponseBody
    public Map<String, Object> like(@RequestParam int fb_idx) {
        freeBoardService.increaseLikeCount(fb_idx);
        freeBoardService.notUpdateReadCount(fb_idx);

        Map<String, Object> result = new HashMap<>();

        result.put("likeCount", freeBoardService.getData(fb_idx).getFb_like());
        result.put("likeText", "좋아요 " + freeBoardService.getData(fb_idx).getFb_like());
        result.put("dislikeCount", freeBoardService.getData(fb_idx).getFb_dislike());
        result.put("dislikeText", "싫어요 " + freeBoardService.getData(fb_idx).getFb_dislike());

        return result;
    }

    @PostMapping("/dislike")
    @ResponseBody
    public Map<String, Object> dislike(@RequestParam int fb_idx) {
        freeBoardService.increaseDislikeCount(fb_idx);
        freeBoardService.notUpdateReadCount(fb_idx);

        Map<String, Object> result = new HashMap<>();
        result.put("likeCount", freeBoardService.getData(fb_idx).getFb_like());
        result.put("likeText", "좋아요 " + freeBoardService.getData(fb_idx).getFb_like());
        result.put("dislikeCount", freeBoardService.getData(fb_idx).getFb_dislike());
        result.put("dislikeText", "싫어요 " + freeBoardService.getData(fb_idx).getFb_dislike());
        return result;
    }
}










