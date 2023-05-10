package devster.semi.controller;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.QboardDto;

import devster.semi.service.QboardService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.*;


@Controller
@RequestMapping("/qboard")
public class QboardController {
    @Autowired
    QboardService qboardService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName = "devster-bucket";

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage, Model model) {
        int totalCount = qboardService.getTotalCount();
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
        List<QboardDto> list = qboardService.getPagingList(startNum, perPage);


        List<Map<String,Object>> fulllList =new ArrayList<>();

            for(QboardDto dto : list) {
                Map<String,Object> map = new HashMap<>();
                map.put("qb_idx",dto.getQb_idx());
                map.put("nickName",qboardService.selectNickNameOfQb_idx(dto.getQb_idx()));
                String photo = qboardService.selectPhotoOfQb_idx(dto.getQb_idx());

                if(photo.equals("no")) {
                    photo = "/photo/profile.jpg";
                } else {
                    photo = "http://kr.object.ncloudstorage.com/devster-bucket/member/"+qboardService.selectPhotoOfQb_idx(dto.getQb_idx());
                }
                map.put("photo",photo);
                map.put("qb_subject",dto.getQb_subject());
                map.put("qb_content",dto.getQb_content());
                map.put("qb_writeday", dto.getQb_writeday());
                map.put("qb_readcount",dto.getQb_readcount());
                map.put("qb_like",dto.getQb_like());
                map.put("qb_dislike",dto.getQb_dislike());
                fulllList.add(map);
            }

        // 출력시 필요한 변수들 model에 전부 저장
        model.addAttribute("list", fulllList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("no", no);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalCount",totalCount);

        return "/main/qboard/qboardlist";
    }

    @GetMapping("/writeform")
    public String writeform() {
        return "/main/qboard/qboardform";
    }

    @PostMapping("/insert")

    public String insert(QboardDto dto, List<MultipartFile> upload) {
        String fileName = "";

        if(upload.get(0).getOriginalFilename().equals("")) { // 업로드를 안한경우.
            fileName = "no";
        } else {
            int i =0;
            for(MultipartFile mfile : upload) {
                //사진 업로드.
                fileName += (storageService.uploadFile(bucketName, "qboard", mfile) + ",");
            }
        }
        fileName=fileName.substring(0,fileName.length()-1);
//        업로드를 한 경우에만 버킷에 이미지를 저장한다.
        dto.setQb_photo(fileName);

        qboardService.insertPost(dto);
        return "redirect:list";
    }

    @GetMapping("/delete")
    public String delete(int qb_idx) {

        QboardDto dto = qboardService.getOnePost(qb_idx);

        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(dto.getQb_photo(),",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "qboard", st.nextToken());
        }

        qboardService.deletePost(qb_idx);

        return "redirect:list";
    }

    @GetMapping("/updateform")

    public String updateForm(int qb_idx, Model model,int currentPage) {
        QboardDto dto = qboardService.getOnePost(qb_idx);

        model.addAttribute("dto", dto);
        model.addAttribute("currentPage",currentPage);

        return "/main/qboard/qboardupdateform";
    }

    @PostMapping("/update")
    public String update(int qb_idx, QboardDto dto, List<MultipartFile> upload,int currentPage) {
        dto.setQb_idx(qb_idx);

        String oriPhoto = qboardService.getOnePost(qb_idx).getQb_photo();
        String fileName ="";

        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(oriPhoto,",");
        while (st.hasMoreTokens()) {
            storageService.deleteFile(bucketName, "qboard", st.nextToken());
        }

        if(upload.get(0).getOriginalFilename().equals("")) { // 업로드를 안한경우.
            fileName = "no";
        } else {
            int i =0;
            for(MultipartFile mfile : upload) {
                //사진 업로드.
                fileName += (storageService.uploadFile(bucketName, "qboard", mfile) + ",");

            }
            fileName=fileName.substring(0,fileName.length()-1);
        }
//        업로드를 한 경우에만 버킷에 이미지를 저장한다.
        dto.setQb_photo(fileName);

        qboardService.updatePost(dto);
        return "redirect:detail?qb_idx="+qb_idx+"&currentPage="+currentPage;
    }

    @GetMapping("/detail")
    public String detail(int qb_idx, Model model, int currentPage, HttpSession session) {
        qboardService.updateReadCount(qb_idx);

        QboardDto dto = qboardService.getOnePost(qb_idx);
        String nickName = qboardService.selectNickNameOfQb_idx(dto.getQb_idx());
        String photo = qboardService.selectPhotoOfQb_idx(dto.getQb_idx());
        
//        버튼 상태에 관한 정보를 디테일 페이지로 보내줌.
        boolean isAlreadyAddGoodRp = qboardService.isAlreadyAddGoodRp(qb_idx,(int)session.getAttribute("memidx"));
        boolean isAlreadyAddBadRp = qboardService.isAlreadyAddBadRp(qb_idx,(int)session.getAttribute("memidx"));

        if(photo.equals("no")) {
            photo = "/photo/profile.jpg";
        } else {
            photo = "http://kr.object.ncloudstorage.com/devster-bucket/member/"+qboardService.selectPhotoOfQb_idx(dto.getQb_idx());
        }
        //사진 여러장 분할 처리.
        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(dto.getQb_photo(),",");
        while (st.hasMoreTokens()) {
            list.add(st.nextToken());
        }

        model.addAttribute("profilePhoto",photo);
        model.addAttribute("list",list);
        model.addAttribute("dto",dto);
        model.addAttribute("nickname",nickName);
        model.addAttribute("photo",photo);
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("isAlreadyAddGoodRp", isAlreadyAddGoodRp);
        model.addAttribute("isAlreadyAddBadRp", isAlreadyAddBadRp);


        return "/main/qboard/qboarddetail";
    }

    
    //좋아요 증가 메서드
    @RequestMapping("/increaseGoodRp")
    @ResponseBody
    public int increaseGoodRp(int qb_idx,int m_idx) {
        // article 테이블에서 해당 게시물의 좋아요 1 증가
        qboardService.increaseGoodRp(qb_idx);
        // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
        int goodRp = qboardService.getGoodRpCount(qb_idx);

        // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id)를 기록
        qboardService.addIncreasingGoodRpInfo(qb_idx,m_idx);

        return goodRp;
    }

    //좋아요 감소 메서드
    @RequestMapping("/decreaseGoodRp")
    @ResponseBody
    public int decreaseGoodRp(int qb_idx,int m_idx) {
        // article 테이블에서 해당 게시물의 좋아요 1 감소
        qboardService.decreaseGoodRp(qb_idx);
        // article 테이블에서 해당 게시물의 최신화된 좋아요 수 불러오기
        int goodRp = qboardService.getGoodRpCount(qb_idx);

        // reactionPoint 테이블에 리액션 정보(게시물 id, 사용자 id) 기록을 삭제
        qboardService.deleteGoodRpInfo(qb_idx,m_idx);

        return goodRp;
    }

    //싫어요 증가 메서드
    @RequestMapping("/increaseBadRp")
    @ResponseBody
    public int increaseBadRp(int qb_idx, int m_idx) {
        qboardService.increaseBadRp(qb_idx);
        int badRp = qboardService.getBadRpCount(qb_idx);

        qboardService.addIncreasingBadRpInfo(qb_idx,m_idx);

        return badRp;
    }

    //싫어요 감소 메서드
    @RequestMapping("/decreaseBadRp")
    @ResponseBody
    public int decreaseBadRp(int qb_idx, int m_idx) {
        qboardService.decreaseBadRp(qb_idx);
        int badRp = qboardService.getBadRpCount(qb_idx);

        qboardService.deleteBadRpInfo(qb_idx, m_idx);

        return badRp;
    }

    @PostMapping("/bestPostsForBanner")
    @ResponseBody
    public List<FreeBoardDto> bestPosts(){
        List<FreeBoardDto> list = qboardService.bestfreeboardPosts();
        return list;
    }

}