package devster.semi.controller;

import devster.semi.dto.FreeCommentDto;
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
@RequestMapping("freeboard/freecomment")
public class FreeCommentController {
    @Autowired
    private FreeCommentService freeCommentService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName="devster-bucket";


    @GetMapping("/commentlist")
    public String list(Model model, int fb_idx){

        Map<String, Integer> map = new HashMap<>();
        List<FreeCommentDto> list = freeCommentService.selectOfFbidx(fb_idx);
        model.addAttribute("list", list);
        model.addAttribute("commentCnt", list.size());

        return "/main/freeboard/freeboarddetail";
    }

    @ResponseBody
    @PostMapping("/writecomment")
    public String commentPost(){

        return "/main/freeboard/freeboarddetail";
    }
}









