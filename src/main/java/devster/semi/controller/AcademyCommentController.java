package devster.semi.controller;

import devster.semi.dto.AcademyCommentDto;
import devster.semi.service.AcademyBoardService;
import devster.semi.service.AcademyCommentService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/academycomment")
public class AcademyCommentController {
    @Autowired
    AcademyCommentService academyCommentService;

    @Autowired
    AcademyBoardService academyBoardService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName="devster-bucket";


    @PostMapping("/commentlist")
    public List<Map<String, Object>> list(@RequestParam int ab_idx){

        List<AcademyCommentDto> list = academyCommentService.getAllCommentList(ab_idx);

        List<Map<String,Object>> fullList = new ArrayList<>();

        int totalCount = academyCommentService.getTotalComment(ab_idx);

        for(AcademyCommentDto dto : list){
            Map<String, Object> map = new HashMap<>();

            SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
            String formattedDate = sdf.format(dto.getAbc_writeday());

            map.put("m_photo", academyCommentService.selectPhotoOfAbc_idx(dto.getAbc_idx()));
            map.put("nickname", academyCommentService.selectNickNameOfAbc_idx(dto.getAbc_idx()));
            map.put("replyCnt", academyCommentService.countReply(dto.getAbc_idx()));


            map.put("abc_content",dto.getAbc_content());
            map.put("abc_idx",dto.getAbc_idx());
            map.put("m_idx",dto.getM_idx());
            map.put("abc_step",dto.getAbc_step());
            map.put("abc_ref",dto.getAbc_ref());
            map.put("abc_depth",dto.getAbc_depth());
//            map.put("fbc_like",dto.getFbc_like());
            map.put("abc_writeday",formattedDate);
            map.put("totalCount",totalCount);

            fullList.add(map);
        }


        return fullList;
    }

    @ResponseBody
    @PostMapping("/insert")
    public void insert(String abc_content, int ab_idx, int m_idx){
        AcademyCommentDto dto = new AcademyCommentDto();
        dto.setM_idx(m_idx);
        dto.setAb_idx(ab_idx);
        dto.setAbc_content(abc_content);

        academyCommentService.insertAcademyComment(dto);
    }

    @GetMapping("/delete")
    public void delete(int abc_idx) {
        academyCommentService.deleteAcademyComment(abc_idx);
    }


    @GetMapping("/updateform")
    public AcademyCommentDto updateForm(int abc_idx) {
        return academyCommentService.getAcademyComment(abc_idx);
    }

    @PostMapping("/update")
    public void update(AcademyCommentDto dto, int abc_idx) {
        dto.setAbc_idx(abc_idx);
        academyCommentService.updateAcademyComment(dto);
    }

    @GetMapping("/recommentlist")
    public List<Map<String, Object>> replylist(@RequestParam int abc_ref){
        List<AcademyCommentDto> list = academyCommentService.getReplyOfRef(abc_ref);

        List<Map<String,Object>> fullList = new ArrayList<>();

        for(AcademyCommentDto dto : list){
            Map<String, Object> map = new HashMap<>();

            SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
            String formattedDate = sdf.format(dto.getAbc_writeday());

            map.put("m_photo", academyCommentService.selectPhotoOfAbc_idx(dto.getAbc_idx()));
            map.put("nickname", academyCommentService.selectNickNameOfAbc_idx(dto.getAbc_idx()));


            map.put("abc_content",dto.getAbc_content());
            map.put("abc_idx",dto.getAbc_idx());
            map.put("m_idx",dto.getM_idx());
            map.put("abc_step",dto.getAbc_step());
            map.put("abc_ref",dto.getAbc_ref());
            map.put("abc_depth",dto.getAbc_depth());
            //map.put("fbc_like",dto.getFbc_like());
            map.put("abc_writeday",formattedDate);

            fullList.add(map);
        }

        return fullList;

    }

    @ResponseBody
    @PostMapping("/insertreply")
    public void insertreply(String abc_content, int abc_ref, int m_idx, int ab_idx){
        AcademyCommentDto dto = new AcademyCommentDto();

        dto.setM_idx(m_idx);
        dto.setAbc_ref(abc_ref);
        dto.setAbc_content(abc_content);
        dto.setAb_idx(ab_idx);
        System.out.println(dto);
        academyCommentService.insertAcademyReply(dto);
    }
}









