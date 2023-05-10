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
import org.springframework.web.multipart.MultipartFile;

import javax.sound.midi.Soundbank;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
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
    public List<Map<String, Object>> list(@RequestParam int fb_idx){

        List<FreeCommentDto> list = freeCommentService.getAllCommentList(fb_idx);

        List<Map<String,Object>> fullList = new ArrayList<>();

        int totalCount = freeCommentService.getTotalComment(fb_idx);

        for(FreeCommentDto dto : list){
            Map<String, Object> map = new HashMap<>();

            SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
            String formattedDate = sdf.format(dto.getFbc_writeday());

            map.put("m_photo", freeCommentService.selectPhotoOfFbc_idx(dto.getFbc_idx()));
            map.put("nickname", freeCommentService.selectNickNameOfFbc_idx(dto.getFbc_idx()));
            map.put("replyCnt", freeCommentService.countReply(dto.getFbc_idx()));


            map.put("fbc_content",dto.getFbc_content());
            map.put("fbc_idx",dto.getFbc_idx());
            map.put("m_idx",dto.getM_idx());
            map.put("fbc_step",dto.getFbc_step());
            map.put("fbc_ref",dto.getFbc_ref());
            map.put("fbc_depth",dto.getFbc_depth());
//            map.put("fbc_like",dto.getFbc_like());
            map.put("fbc_writeday",formattedDate);
            map.put("totalCount",totalCount);

            fullList.add(map);
        }


        return fullList;
    }

    @ResponseBody
    @PostMapping("/insert")
    public void insert(String fbc_content, int fb_idx, int m_idx){
        FreeCommentDto dto = new FreeCommentDto();
        dto.setM_idx(m_idx);
        dto.setFb_idx(fb_idx);
        dto.setFbc_content(fbc_content);

        freeCommentService.insertFreeComment(dto);
    }

    @GetMapping("/delete")
    public void delete(int fbc_idx) {
        freeCommentService.deleteFreeComment(fbc_idx);
    }


    @GetMapping("/updateform")
    public FreeCommentDto updateForm(int fbc_idx) {
        return freeCommentService.getFreeComment(fbc_idx);
    }

    @PostMapping("/update")
    public void update(FreeCommentDto dto, int fbc_idx) {
        dto.setFbc_idx(fbc_idx);
        freeCommentService.updateFreeComment(dto);
    }

    @GetMapping("/recommentlist")
    public List<Map<String, Object>> replylist(@RequestParam int fbc_ref){
        List<FreeCommentDto> list = freeCommentService.getReplyOfRef(fbc_ref);

        List<Map<String,Object>> fullList = new ArrayList<>();

        for(FreeCommentDto dto : list){
            Map<String, Object> map = new HashMap<>();

            SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
            String formattedDate = sdf.format(dto.getFbc_writeday());

            map.put("m_photo", freeCommentService.selectPhotoOfFbc_idx(dto.getFbc_idx()));
            map.put("nickname", freeCommentService.selectNickNameOfFbc_idx(dto.getFbc_idx()));


            map.put("fbc_content",dto.getFbc_content());
            map.put("fbc_idx",dto.getFbc_idx());
            map.put("m_idx",dto.getM_idx());
            map.put("fbc_step",dto.getFbc_step());
            map.put("fbc_ref",dto.getFbc_ref());
            map.put("fbc_depth",dto.getFbc_depth());
            //map.put("fbc_like",dto.getFbc_like());
            map.put("fbc_writeday",formattedDate);

            fullList.add(map);
        }

        return fullList;

    }

    @ResponseBody
    @PostMapping("/insertreply")
    public void insertreply(String fbc_content, int fbc_ref, int m_idx, int fb_idx){
        FreeCommentDto dto = new FreeCommentDto();

        dto.setM_idx(m_idx);
        dto.setFbc_ref(fbc_ref);
        dto.setFbc_content(fbc_content);
        dto.setFb_idx(fb_idx);
        System.out.println(dto);
        freeCommentService.insertFreeReply(dto);
    }
}









