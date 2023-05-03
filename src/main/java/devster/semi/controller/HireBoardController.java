package devster.semi.controller;


import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.HireBoardDto;
import devster.semi.mapper.HireMapper;
import devster.semi.service.HireService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

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


    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int currentPage, Model model)

    {
        List<HireBoardDto> list=hireMapper.getAllPosts();
        //model 에 저장
        model.addAttribute("currentPage",currentPage);
        model.addAttribute("list", list);
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
    public String insert(HireBoardDto dto,MultipartFile upload)
    {
        String hb_photo="";
        if(!upload.getOriginalFilename().equals("")){
            hb_photo = storageService.uploadFile(bucketName,"hire",upload);
        } else{
            hb_photo="no";
        }

        dto.setHb_photo(hb_photo);
        //db insert
        hireMapper.insertHireBoard(dto);

        return "redirect:list";
    }

    @GetMapping("/hireboarddetail")
    public String detail(int hb_idx, int currentPage, Model model){

        hireService.updateReadCount(hb_idx);
        HireBoardDto dto = hireService.getData(hb_idx);

        model.addAttribute("dto", dto);
        model.addAttribute("currentPage",currentPage);

        return "/main/hire/hireboarddetail";
    }

    @GetMapping("/hireboarddelete")
    public String deleteHireBoard(int hb_idx){

        String hb_photo = hireService.getData(hb_idx).getHb_photo();
        storageService.deleteFile(bucketName,"hire",hb_photo);

        hireService.deleteHireBoard(hb_idx);

        return "redirect:list";
    }


}
