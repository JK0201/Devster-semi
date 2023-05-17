package devster.semi.controller;


import devster.semi.dto.*;
import devster.semi.service.Resumeservice;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping("/resume")
public class ResumeController {

    @Autowired
    private Resumeservice resumeservice;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName = "devster-bucket";


    @PostMapping("/search")
    @ResponseBody
    public String search(@RequestParam("q") String query) {
        // 결과 문자열을 생성합니다.
        String searchResult = query;
        // 결과 문자열을 반환합니다.
        return searchResult;
    }

    @GetMapping("/writer")
    public String writer(@RequestParam(defaultValue = "0") int r_idx, Model model) {
        model.addAttribute("r_idx", r_idx);
        return "/main/resume/resumewrite";
    }

    @PostMapping("/resumeinsert")
    public String insert(MultipartFile upload_r, MultipartFile upload_re,
                         int m_idx, String r_self, String r_pos, String r_link,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate r_gradestart,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate r_gradeend, String r_gradecom,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_licdate, String r_sta, String[] r_licname,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_carstartdate,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_carenddate, String[] r_company,
                         String[] r_department, String[] r_position, String r_skill) {
        ResumeDto dto = new ResumeDto();
        //자격증 파일
        String r_file = storageService.uploadFile(bucketName, "resume", upload_r);
        dto.setR_file(r_file);

        // 이력서 파일
        String r_refile = storageService.uploadFile(bucketName, "re_resume", upload_re);
        dto.setR_refile(r_refile);

        /*    dto.setR_idx();*/
        dto.setM_idx(m_idx);
        dto.setR_self(r_self);
        dto.setR_pos(r_pos);
        dto.setR_link(r_link);
        dto.setR_sta(r_sta);
        dto.setR_gradestart(Timestamp.valueOf(r_gradestart.atStartOfDay()));
        dto.setR_gradeend(Timestamp.valueOf(r_gradeend.atStartOfDay()));
        dto.setR_gradecom(r_gradecom);
        dto.setR_skill(r_skill.substring(0,r_skill.length()-1));
        resumeservice.insertresume(dto);


        for (int i = 0; i < r_company.length; i++) {
            Re_carDto cdto = new Re_carDto();
            cdto.setM_idx(m_idx);
            cdto.setR_company(r_company[i]);
            cdto.setR_position(r_position[i]);
            cdto.setR_department(r_department[i]);
            cdto.setR_carstartdate(Timestamp.valueOf(r_carstartdate[i].atStartOfDay()));
            cdto.setR_carenddate(Timestamp.valueOf(r_carenddate[i].atStartOfDay()));
            resumeservice.insertcar(cdto);
        }

        for (int k = 0; k < r_licname.length; k++) {
            Re_licDto ldto = new Re_licDto();
            ldto.setR_licdate(Timestamp.valueOf(r_licdate[k].atStartOfDay()));
            ldto.setR_licname(r_licname[k]);
            ldto.setM_idx(m_idx);
            resumeservice.insertlic(ldto);
        }
        /*    System.out.println(dto.toString());*/


        return "main/review/list";

    }

    @GetMapping("/detail")
    public String resumelist(Model model, @RequestParam("m_idx") int m_idx) {
        ResumeDto dto = resumeservice.getDataresume(m_idx); // m_idx를 이용하여 ResumeDto 조회

        List<Re_licDto> llist = resumeservice.getDatare_lic(m_idx);
        List<Re_carDto> clist = resumeservice.getDatare_car(m_idx);


        model.addAttribute("dto", dto); // ResumeDto를 모델에 추가
        model.addAttribute("clist", clist);
        model.addAttribute("llist", llist);
        return "/main/resume/resumedetail";
    }

    @GetMapping("/updateform")
    public String updateform(@RequestParam("m_idx")int m_idx,Model model){

        ResumeDto dto=resumeservice.getDataresume(m_idx);
        List<Re_licDto> llist = resumeservice.getDatare_lic(m_idx);
        List<Re_carDto> clist = resumeservice.getDatare_car(m_idx);

        model.addAttribute("dto", dto);
        model.addAttribute("llist",llist);
        model.addAttribute("clist",clist);


        return "/main/resume/resumeupdate";
    }
    @PostMapping("/update")
    public String update(MultipartFile upload_r, MultipartFile upload_re,
                         int m_idx, String r_self, String r_pos, String r_link,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate r_gradestart,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate r_gradeend, String r_gradecom,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_licdate, String r_sta, String[] r_licname,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_carstartdate,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_carenddate, String[] r_company,
                         String[] r_department, String[] r_position, String r_skill,int recar_idx[],int relic_idx[]) {


        ResumeDto dto = new ResumeDto();
        //자격증 파일
        String r_file = storageService.uploadFile(bucketName, "resume", upload_r);
        dto.setR_file(r_file);

        // 이력서 파일
        String r_refile = storageService.uploadFile(bucketName, "re_resume", upload_re);
        dto.setR_refile(r_refile);

        dto.setR_idx(dto.getR_idx());
        dto.setM_idx(m_idx);
        dto.setR_self(r_self);
        dto.setR_pos(r_pos);
        dto.setR_link(r_link);
        dto.setR_sta(r_sta);
        dto.setR_gradestart(Timestamp.valueOf(r_gradestart.atStartOfDay()));
        dto.setR_gradeend(Timestamp.valueOf(r_gradeend.atStartOfDay()));
        dto.setR_gradecom(r_gradecom);
        dto.setR_skill(r_skill.substring(0,r_skill.length()-1));
        resumeservice.updateresume(dto);

        for (int i = 0; i < r_company.length; i++) {
            Re_carDto cdto = new Re_carDto();
            cdto.setM_idx(m_idx);
            cdto.setR_company(r_company[i]);
            cdto.setR_position(r_position[i]);
            cdto.setR_department(r_department[i]);
            cdto.setR_carstartdate(Timestamp.valueOf(r_carstartdate[i].atStartOfDay()));
            cdto.setR_carenddate(Timestamp.valueOf(r_carenddate[i].atStartOfDay()));

            if (i < recar_idx.length) {
                // recar_idx 배열의 인덱스가 범위 내에 있는 경우에만 실행
                cdto.setRecar_idx(recar_idx[i]);
                resumeservice.updatecar(cdto);
               /* System.out.println("recar" + cdto.getRecar_idx());*/
            } else {
                // recar_idx 배열의 인덱스가 범위를 벗어난 경우에 대한 처리
                resumeservice.insertcar(cdto);
            }
        }


        for (int k = 0; k < r_licname.length; k++) {
            Re_licDto ldto = new Re_licDto();
            ldto.setR_licdate(Timestamp.valueOf(r_licdate[k].atStartOfDay()));
            ldto.setR_licname(r_licname[k]);
            ldto.setM_idx(m_idx);

            if (k < relic_idx.length) {
                // recar_idx 배열의 인덱스가 범위 내에 있는 경우에만 실행
                ldto.setRelic_idx(relic_idx[k]);
                resumeservice.updatelic(ldto);
              /*  System.out.println("relic" + ldto.getRelic_idx());*/
            } else {
                // recar_idx 배열의 인덱스가 범위를 벗어난 경우에 대한 처리
                resumeservice.insertlic(ldto);
            }

        }

        return "/main/resume/detail?m_idx="+dto.getM_idx();


    }



}


