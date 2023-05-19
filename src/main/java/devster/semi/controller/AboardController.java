package devster.semi.controller;

import devster.semi.dto.AboardDto;
import devster.semi.dto.QboardDto;
import devster.semi.service.AboardService;
import devster.semi.service.QboardService;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.awt.image.VolatileImage;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

@RestController
@RequestMapping("/aboard")
public class AboardController {

    @Autowired
    AboardService aboardService;
    @Autowired
    QboardService qboardService;
    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName = "devster-bucket";

    @PostMapping("/insert")
    public void insert(AboardDto dto, List<MultipartFile> upload,int qb_idx,int m_idx) {

        String fileName = "";

        if (upload.get(0).getOriginalFilename().equals("")) { // 업로드를 안한경우.
            fileName = "no";
        } else {
            for(MultipartFile mfile : upload) {
                //사진 업로드.
                fileName += (storageService.uploadFile(bucketName, "aboard", mfile) + ",");
            }
            fileName=fileName.substring(0,fileName.length()-1);
        }
//        업로드를 한 경우에만 버킷에 이미지를 저장한다.
        dto.setAb_photo(fileName);
        dto.setQb_idx(qb_idx);
        dto.setM_idx(m_idx);

        aboardService.insertAboard(dto);
    }

    @PostMapping("/list")
    public List<Map<String,Object>> list(@RequestParam int qb_idx) {
        List<AboardDto> list = aboardService.getAllAnswers(qb_idx);

        List<Map<String,Object>> fullList = new ArrayList<>();

        for(AboardDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            List<String> photo = new ArrayList<>();
            String strPhoto = dto.getAb_photo();
            if(!strPhoto.equals("no")) {
                StringTokenizer st = new StringTokenizer(strPhoto,",");
                while (st.hasMoreTokens()){
                    photo.add(st.nextToken());
                }
            }

            // 변환할 포맷 설정
            SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");

            // Timestamp 객체를 원하는 형식의 문자열로 변환
            String formattedDate = sdf.format(dto.getAb_writeday());

            map.put("m_photo",aboardService.selectPhotoOfAb_idx(dto.getAb_idx()));
            map.put("nickname",aboardService.selectNickNameOfAb_idx(dto.getAb_idx()));
            map.put("ab_content",dto.getAb_content());
            /*map.put("ab_writeday",formattedDate)*/;
            map.put("m_idx",dto.getM_idx());
            map.put("ab_idx",dto.getAb_idx());
            map.put("photo",photo);

            map.put("ab_writeday", timeForToday(dto.getAb_writeday()));

            fullList.add(map);
        }
        return fullList;
    }

    @GetMapping("/delete")
    public void delete(int ab_idx) {

        AboardDto dto = aboardService.getOneAnswer(ab_idx);

        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(dto.getAb_photo(),",");
        while (st.hasMoreElements()) {
            storageService.deleteFile(bucketName, "aboard", st.nextToken());
        }

        aboardService.deleteComment(ab_idx);
    }

    @GetMapping("/updateform")
    public AboardDto updateForm(int ab_idx, Model model) {
        return aboardService.getOneAnswer(ab_idx);
    }

    @PostMapping("/update")
    public void update(AboardDto dto, List<MultipartFile> upload,int ab_idx) {
        dto.setAb_idx(ab_idx);

        String oriPhoto = aboardService.getOneAnswer(ab_idx).getAb_photo();
        String fileName ="";

        List<String> list = new ArrayList<>();
        StringTokenizer st = new StringTokenizer(oriPhoto,",");
        while (st.hasMoreTokens()) {
            storageService.deleteFile(bucketName, "aboard", st.nextToken());
        }

        if (upload.get(0).getOriginalFilename().equals("")) { // 업로드를 안한경우.
            fileName = "no";
        } else {
            for(MultipartFile mfile : upload) {
                //사진 업로드.
                fileName += (storageService.uploadFile(bucketName, "aboard", mfile) + ",");
            }
            fileName=fileName.substring(0,fileName.length()-1);
        }
//        업로드를 한 경우에만 버킷에 이미지를 저장한다.
        dto.setAb_photo(fileName);
        aboardService.updateAnswer(dto);
    }

    public String timeForToday(Timestamp value) {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime timeValue = value.toLocalDateTime();

        long betweenTime = ChronoUnit.MINUTES.between(timeValue, now);
        if (betweenTime < 1) {
            return "방금전";
        }
        if (betweenTime < 60) {
            return betweenTime + "분전";
        }

        long betweenTimeHour = betweenTime / 60;
        if (betweenTimeHour < 24) {
            return betweenTimeHour + "시간전";
        }

        long betweenTimeDay = betweenTime / 1440; // 60 minutes * 24 hours
        if (betweenTimeDay < 8) {
            return betweenTimeDay + "일전";
        }

        String month = String.format("%02d", timeValue.getMonthValue());
        String day = String.format("%02d", timeValue.getDayOfMonth());
        String formattedDate = month + "-" + day;

        return formattedDate;
    }

}
