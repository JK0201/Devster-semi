package devster.semi.controller;

import devster.semi.dto.FreeCommentDto;
import devster.semi.service.FreeBoardService;
import devster.semi.service.FreeCommentService;
import naver.cloud.NcpObjectStorageService;
import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/freecomment")
public class FreeCommentController {
    @Autowired
    FreeCommentService freeCommentService;

    @Autowired
    FreeBoardService freeBoardService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName="devster-bucket";


    @PostMapping("/commentlist")
    public List<FreeCommentDto> list(Model model, int fb_idx){

        List<FreeCommentDto> list = freeCommentService.getAllCommentList(fb_idx);

        model.addAttribute("list", list);
        model.addAttribute("commentCnt", list.size());

        return list;
    }

    @ResponseBody
    @PostMapping("/insert")
    public void insert(FreeCommentDto dto, int fb_idx, int m_idx){
        dto.setFb_idx(fb_idx);
        dto.setM_idx(m_idx);
        freeCommentService.insertFreeComment(dto);
    }
}









