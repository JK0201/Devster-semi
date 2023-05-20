package devster.semi.controller;

import devster.semi.dto.NoticeBoardDto;
import devster.semi.service.NoticeBoardService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/noticeboard")
public class NoticeBoardController {

    @Autowired
    private NoticeBoardService noticeBoardService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName="devster-bucket";

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage, Model model)
    {

        int totalCount = noticeBoardService.getTotalCount();
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

        List<NoticeBoardDto> list = noticeBoardService.getPagingList(startNum, perPage);

        List<Map<String,Object>> fulllList =new ArrayList<>();

        for(NoticeBoardDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            map.put("nb_idx",String.valueOf(dto.getNb_idx()));
            /*map.put("nickName",noticeBoardService.selectNickNameOfMstate(dto.getNb_idx()));*/
            map.put("nb_subject",dto.getNb_subject());
            map.put("nb_photo",dto.getNb_photo());
            map.put("nb_content",dto.getNb_content());
            map.put("nb_readcount",dto.getNb_readcount());
            String currentTimestampToString = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(dto.getNb_writeday());
            map.put("nb_writeday", currentTimestampToString);
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

        return "/main/noticeboard/noticeboardlist";
    }

    @GetMapping("/noticewriteform")
    public String form(@RequestParam(defaultValue = "1") int currentPage,
                       @RequestParam(defaultValue = "0") int nb_idx, Model model){

        model.addAttribute("currentPage",currentPage);
        model.addAttribute("nb_idx",nb_idx);

        return "/main/noticeboard/noticeboardform";
    }

    @PostMapping("/noticeinsert")
    public String insert(NoticeBoardDto dto,  List<MultipartFile> upload){

        String nb_photo="";

        if(upload.get(0).getOriginalFilename().equals("")){
            nb_photo="no";
        }else{
            int i =0;
            for(MultipartFile mfile : upload) {
                //사진 업로드.
                nb_photo += (storageService.uploadFile(bucketName, "noticeboard", mfile) + ",");
            }
        }

        nb_photo=nb_photo.substring(0,nb_photo.length()-1);
        //업로드를 한 경우에만 버킷에 이미지를 저장한다
        dto.setNb_photo(nb_photo);

        noticeBoardService.insertBoard(dto);

        return "redirect:../mypage/list";
    }

    @GetMapping("/noticeboarddetail")
    public String detail(int nb_idx, int currentPage, Model model){

        noticeBoardService.updateReadCount(nb_idx);
        NoticeBoardDto dto = noticeBoardService.getData(nb_idx);
        /*String nickName = noticeBoardService.selectNickNameOfMstate(dto.getNb_idx());*/

        model.addAttribute("dto", dto);
        /*model.addAttribute("nickname",nickName);*/
        model.addAttribute("currentPage",currentPage);

        //Controller 디테일 페이지 보내는 부분.
        //사진 여러장 분할 처리.
        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(dto.getNb_photo(),",");
        while (st.hasMoreElements()) {
            list.add(st.nextToken());
        }

        model.addAttribute("list",list);

        return "/main/noticeboard/noticeboarddetail";
    }

    @GetMapping("/noticedelete")
    public String deleteNotice(int nb_idx){

        String nb_photo = noticeBoardService.getData(nb_idx).getNb_photo();

        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(nb_photo,",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "noticeboard", st.nextToken());
        }
        noticeBoardService.deleteBoard(nb_idx);

        return "redirect:../mypage/list";
    }

    @GetMapping("/noticeupdateform")
    public String updateform(int nb_idx, int currentPage, Model model){

        NoticeBoardDto dto = noticeBoardService.getData(nb_idx);
        model.addAttribute("dto",dto);
        model.addAttribute("currentPage",currentPage);

        return "/main/noticeboard/noticeboardupdateform";
    }

    @PostMapping("/noticeupdate")
    public String updateNotice(NoticeBoardDto dto, List<MultipartFile> upload, int currentPage, int nb_idx){

        dto.setNb_idx(nb_idx);
        String nb_photo="";

        String filename = noticeBoardService.getData(nb_idx).getNb_photo();
        // 버켓에서 삭제
        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(filename,",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "noticeboard", st.nextToken());
        }

        if(upload.get(0).getOriginalFilename().equals("")){
            nb_photo="no";
        } else {
            int i =0;
            for(MultipartFile mfile : upload) {

                //사진 업로드.
                nb_photo += (storageService.uploadFile(bucketName, "noticeboard", mfile) + ",");
            }
        }

        nb_photo=nb_photo.substring(0,nb_photo.length()-1);
        dto.setNb_photo(nb_photo);

        noticeBoardService.updateBoard(dto);

        return "redirect:../mypage/noticeboarddetail?nb_idx="+dto.getNb_idx()+"&currentPage="+currentPage;
    }


}
