package devster.semi.controller;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.QboardDto;
import devster.semi.dto.ReviewDto;
import devster.semi.mapper.ReviewMapper;
import devster.semi.service.QboardService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

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

        // 출력시 필요한 변수들 model에 전부 저장
        model.addAttribute("list", list);
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
    public String insert(QboardDto dto, MultipartFile upload) {

        String fileName = "";
        //업로드를 한 경우에만 버킷에 이미지를 저장한다.
        if (!upload.getOriginalFilename().equals("")) {
            fileName = storageService.uploadFile(bucketName, "qboard", upload);
        }
        //dto에 파일명 저장.
        dto.setQb_photo(fileName);

        qboardService.insertPost(dto);

        return "redirect:list";
    }

    @GetMapping("/delete")
    public String delete(int qb_idx) {
        qboardService.deletePost(qb_idx);

        return "redirect:list";
    }

    @GetMapping("/updateform")
    public String updateForm(int qb_idx, Model model) {
        QboardDto dto = qboardService.getOnePost(qb_idx);
        model.addAttribute("dto", dto);

        return "/main/qboard/qboardupdateform";
    }

    @PostMapping("/update")
    public String update(int qb_idx, QboardDto dto,MultipartFile upload) {
        dto.setQb_idx(qb_idx);
        String fileName = "";
        //업로드를 한 경우에만 버킷에 이미지를 저장한다.
        if (!upload.getOriginalFilename().equals("")) {
            fileName = storageService.uploadFile(bucketName, "qboard", upload);
        }
        //dto에 파일명 저장.
        dto.setQb_photo(fileName);

        qboardService.updatePost(dto);
        return "redirect:list";
    }

    @GetMapping("/detail")
    public String detail(int qb_idx,Model model) {
        QboardDto dto = qboardService.getOnePost(qb_idx);
        String nickName = qboardService.selectNickNameOfMidx(dto.getQb_idx());
        model.addAttribute("dto",dto);
        model.addAttribute("nickname",nickName);

        return "/main/qboard/qboarddetail";
    }

}