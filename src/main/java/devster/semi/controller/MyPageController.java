package devster.semi.controller;

import devster.semi.dto.*;
import devster.semi.service.*;
import devster.semi.utilities.SHA256Util;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    MemberService memberService;

    @Autowired
    MyPageService myPageService;

    @Autowired
    Resumeservice resumeservice;

    @Autowired
    NoticeBoardService noticeBoardService;

    @Autowired
    MessageService messageService;

    @Autowired
    private NcpObjectStorageService storageService;


    private String bucketName = "devster-bucket";


    @GetMapping("/")
    public String main(HttpSession session,Model model) {
        if(session.getAttribute("memidx") == null && session.getAttribute("cmidx") !=null) {
            CompanyMemberDto dto = myPageService.getOneDatabyCm_idx((int)session.getAttribute("cmidx"));
            model.addAttribute("dto",dto);
            return "/mypage/mypage/mpageprofilecompanyuser";

        }else if(session.getAttribute("memidx") != null && session.getAttribute("cmidx") ==null){
            if((int)session.getAttribute("memstate") == 1) {
                MemberDto dto = memberService.getOneDataByM_idx((int)session.getAttribute("memidx"));
                model.addAttribute("dto",dto);
                return "/mypage/mypage/mpageprofilenormaluser";
            } else if((int)session.getAttribute("memstate") == 0) {
                return "/mypage/mypage/mpageprofileayetnormaluser";
            } else {
                return "redirect:list";
            }
        } else {
            return "에러났숑 여기 왔으면 틀려먹은거임 다시하셈";
        }
    }

    @GetMapping("/bookmark")
    public String bookmark(HttpSession session,Model model) {
        List<HireBoardDto> list = myPageService.getHireBookmarkList((int)session.getAttribute("memidx"));
        model.addAttribute("list",list);
        return "/mypage/mypage/mpagehirescrap";
    }

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

        return "/mypage/noticeboard/noticeboardlist";
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

        return "/mypage/noticeboard/noticeboarddetail";
    }

    @GetMapping("/nicknamechk")
    @ResponseBody
    public Map<String, String> nickNameChk(String m_nickname, HttpSession session) {
        int chk = memberService.nickNameChk(m_nickname);
        Map<String, String> map = new HashMap<>();
        if(memberService.getOneDataByM_idx((int)session.getAttribute("memidx")).getM_nickname().equals(m_nickname)) {
            chk = 0;
        }
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    @GetMapping("/compnamechk")
    @ResponseBody
    public Map<String, String> compNameChk(String cm_compname,HttpSession session) {
        int chk = memberService.compNameChk(cm_compname);
        Map<String, String> map = new HashMap<>();
        if(myPageService.getOneDatabyCm_idx((int)session.getAttribute("cmidx")).getCm_compname().equals(cm_compname)) {
            chk = 0;
        }
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    @PostMapping("/updateacaphoto")
    @ResponseBody
    public void updateacaphoto(MultipartFile upload,int m_idx) {
        MemberDto dto = new MemberDto();
        String filename = storageService.uploadFile(bucketName, "member_academy", upload);

        dto.setM_filename(filename);
        dto.setM_idx(m_idx);

        myPageService.updateAcaPhoto(dto);
    }

    @GetMapping("/updateuserform")
    public String updateuserform(HttpSession session,Model model) {
        if(session.getAttribute("memidx") == null && session.getAttribute("cmidx") !=null) {
            CompanyMemberDto dto =myPageService.getOneDatabyCm_idx((int)session.getAttribute("cmidx"));
            model.addAttribute("dto",dto);

            StringTokenizer st = new StringTokenizer(dto.getCm_addr(),",");
            model.addAttribute("cm_addr1",st.nextToken());
            model.addAttribute("cm_addr2",st.nextToken());

            return "/mypage/mypage/mpageupdatecompuserform";

        }else if(session.getAttribute("memidx") != null && session.getAttribute("cmidx") ==null){
            MemberDto dto = memberService.getOneDataByM_idx((int)session.getAttribute("memidx"));
            model.addAttribute("dto",dto);
            return "/mypage/mypage/mpageupdateuserform";

        } else {
            return "에러났숑 여기 왔으면 틀려먹은거임 다시하셈";
        }
    }
    @PostMapping("/update")
    @ResponseBody
    public void updateMember(MemberDto dto, MultipartFile upload,HttpSession session, String m_pass) {
        String salt = SHA256Util.generateSalt();
        String newM_pass = SHA256Util.getEncrypt(m_pass, salt);

        String[] tokens = dto.getM_tele().split("-");
        String phoneNoHyphen = String.join("", tokens);
        tokens = phoneNoHyphen.split("\\s");
        String m_tele = String.join("", tokens);

        String m_photo = "";
        String dto_Photo = memberService.getOneDataByM_idx((int)session.getAttribute("memidx")).getM_photo();

        if(upload == null && dto_Photo.equals("no")) {
            m_photo = "no";
        } else if(upload == null && !dto_Photo.equals("no") ) {
            m_photo = dto_Photo;
        } else {
            storageService.deleteFile(bucketName,"member",dto_Photo);
            m_photo = storageService.uploadFile(bucketName, "member", upload);
        }
        dto.setM_idx((int)session.getAttribute("memidx"));
        dto.setSalt(salt);
        dto.setM_pass(newM_pass);
        dto.setM_photo(m_photo);
        dto.setM_tele(m_tele);
        myPageService.updateProfile(dto);
    }
    @PostMapping("/updatecm")
    @ResponseBody
    public void updateCompMember(CompanyMemberDto dto, MultipartFile upload,HttpSession session, String cm_pass) {
        String salt = SHA256Util.generateSalt();
        String newM_pass = SHA256Util.getEncrypt(cm_pass, salt);

        String[] tokens = dto.getCm_tele().split("-");
        String phoneNoHyphen = String.join("", tokens);
        tokens = phoneNoHyphen.split("\\s");
        String cm_tele = String.join("", tokens);

        dto.setCm_idx((int)session.getAttribute("cmidx"));
        dto.setSalt(salt);
        dto.setCm_pass(newM_pass);
        dto.setCm_tele(cm_tele);
        myPageService.updateProfileCm(dto);
    }


    @GetMapping("/deleteuserform")
    public String deleteuserform() {
        return "/mypage/mypage/mpagedeleteuserform";
    }
    @GetMapping("/deleteuser")
    @ResponseBody
    public String deleteuser(HttpSession session, String email) {
        if(session.getAttribute("memidx") == null && session.getAttribute("cmidx") !=null) {
            CompanyMemberDto dto = myPageService.getOneDatabyCm_idx((int)session.getAttribute("cmidx"));
            String cm_email = dto.getCm_email();
            if(email.equals(cm_email)) {
                myPageService.deleteCompUser(cm_email);
                return "yes";
            } else {
                return "no";
            }
        }else if(session.getAttribute("memidx") != null && session.getAttribute("cmidx") ==null){
            MemberDto dto = memberService.getOneDataByM_idx((int)session.getAttribute("memidx"));
            String m_email = dto.getM_email();
            if(email.equals(m_email)) {
                myPageService.deleteNormalUser(m_email);
                return "yes";
            } else {
                return "no";
            }
        } else {
            return "error";
        }
    }

    @GetMapping("/checkacaphoto")
    @ResponseBody
    public String checkacaphoto(HttpSession session) {
        if(myPageService.checkAcaPhoto((int)session.getAttribute("memidx")).equals("no")) {
            return "false";
        } else {
            return "true";
        }
    }

    @GetMapping("/updatedefaultphoto")
    @ResponseBody
    public void updateDeafualtPhoto(HttpSession session){
        MemberDto dto = memberService.getOneDataByM_idx((int)session.getAttribute("memidx"));
        if(session.getAttribute("memidx") != null && session.getAttribute("cmidx") ==null){
            storageService.deleteFile(bucketName,"member",dto.getM_photo());
            myPageService.updateDeafualtPhoto((int)session.getAttribute("memidx"));
        }
    }

    @GetMapping("/approvelist")
    public String approvelist(int iscomp,Model model) {
        if(iscomp == 1) {
            model.addAttribute("iscomp",1);
            return "/mypage/mypage/mpageacademycheck";
        } else {
            return "/mypage/mypage/mpageacademycheck";
        }
    }

    @PostMapping("/normalacademycheck")
    @ResponseBody
    public List<MemberDto> checkacaname() {
        return myPageService.getDatasStateZeroByMember();
    }

    @PostMapping("/normalupgradestate")
    @ResponseBody
    public void updateMstate(int m_idx) {
        myPageService.updateMstate(m_idx);
    }

    @PostMapping("/normalrejectupgrade")
    @ResponseBody
    public void rejectUpgradeMstate(int m_idx) {
        MessageDto dto = new MessageDto();
        dto.setSend_nick("관리자");
        dto.setContent("학원 인증이 반려되었습니다. 가이드라인에 따라 인증 사진을 체크해서 다시 업로드해주세요.");
        dto.setRecv_nick(memberService.getOneDataByM_idx(m_idx).getM_nickname());
        messageService.MessageSendInList(dto);
        myPageService.rejectUpgradeMstate(m_idx);

    }
    @PostMapping("/companycheck")
    @ResponseBody
    public List<CompanyMemberDto> companycheck() {
        return myPageService.getDatasStateZeroByCompany();
    }

    @PostMapping("/companyupgradestate")
    @ResponseBody
    public void updateCmstate(int cm_idx) {
        myPageService.updateCmstate(cm_idx);
    }

    @PostMapping("/companyrejectupgrade")
    @ResponseBody
    public void rejectUpgradeCmstate(int cm_idx) {
        MessageDto dto = new MessageDto();
        dto.setSend_nick("관리자");
        dto.setContent("회사 인증이 반려되었습니다. 가이드라인에 따라 인증 사진을 체크해서 다시 업로드해주세요.");
        dto.setRecv_nick(myPageService.getOneDatabyCm_idx(cm_idx).getCm_compname());
        messageService.MessageSendInList(dto);
        myPageService.rejectUpgradeCmstate(cm_idx);
    }



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
        return "/mypage/mypage/resumewrite";


    }

    @PostMapping("/resumeinsert")
    public String insert(MultipartFile upload_r, MultipartFile upload_re,
                         int m_idx, String r_self, String r_pos, String r_link,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate r_gradestart,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate r_gradeend, String r_gradecom,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_licdate, String r_sta, String[] r_licname,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_carstartdate,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_carenddate, String[] r_company,
                         String[] r_department, String[] r_position, String r_skill,Integer r_status) {
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
        if (r_status == null) {
            r_status = 0; // 기본값 설정
        }
        dto.setR_status(r_status);

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

        return "redirect:/mypage/detail?m_idx=" + m_idx;



    }

    @GetMapping("/detail")
    public String resumelist(Model model, @RequestParam("m_idx") int m_idx) {
        ResumeDto dto = resumeservice.getDataresume(m_idx); // m_idx를 이용하여 ResumeDto 조회

        List<Re_licDto> llist = resumeservice.getDatare_lic(m_idx);
        List<Re_carDto> clist = resumeservice.getDatare_car(m_idx);


        model.addAttribute("dto", dto); // ResumeDto를 모델에 추가
        model.addAttribute("clist", clist);
        model.addAttribute("llist", llist);
        return "/mypage/mypage/resumedetail";

    }

    @GetMapping("/redetail")
    public String re_detail(Model model, @RequestParam("m_idx") int m_idx) {
        ResumeDto dto = resumeservice.getDataresume(m_idx); // m_idx를 이용하여 ResumeDto 조회

        List<Re_licDto> llist = resumeservice.getDatare_lic(m_idx);
        List<Re_carDto> clist = resumeservice.getDatare_car(m_idx);


        model.addAttribute("dto", dto); // ResumeDto를 모델에 추가
        model.addAttribute("clist", clist);
        model.addAttribute("llist", llist);
        return "/mypage/mypage/re_detail";

    }

    @GetMapping("/updateform")
    public String updateform(@RequestParam("m_idx")int m_idx,Model model){

        ResumeDto dto=resumeservice.getDataresume(m_idx);
        List<Re_licDto> llist = resumeservice.getDatare_lic(m_idx);
        List<Re_carDto> clist = resumeservice.getDatare_car(m_idx);

        model.addAttribute("dto", dto);
        model.addAttribute("llist",llist);
        model.addAttribute("clist",clist);


        return "/mypage/mypage/resumeupdate";
    }
    @PostMapping("/resumeupdate")
    public String update(MultipartFile upload_r, MultipartFile upload_re,
                         int m_idx, String r_self, String r_pos, String r_link,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate r_gradestart,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate r_gradeend, String r_gradecom,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_licdate, String r_sta, String[] r_licname,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_carstartdate,
                         @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate[] r_carenddate, String[] r_company,
                         String[] r_department, String[] r_position, String r_skill,int recar_idx[],int relic_idx[],Integer r_status) {



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
            dto.setR_skill(r_skill.substring(0, r_skill.length() - 1));
        if (r_status == null) {
            r_status = 0; // 기본값 설정
        }
            dto.setR_status(r_status);

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

            return "redirect:/mypage/detail?m_idx=" + m_idx;


        }
    @GetMapping("/relist")
    public String list1(@RequestParam(defaultValue = "1") int currentPage, Model model) {
        int totalCount = resumeservice.getTotalCount();
        int perPage = 20; // 한 페이지당 보여줄 글 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int no;

        // 각 페이지의 시작번호 (1페이지: 0, 2페이지 : 3, 3페이지 6 ....)
        startNum = (currentPage - 1) * perPage;

        // 각 글마다 출력할 글 번호 (예 : 10개일 경우 1페이지 10, 2페이지 7...)
        // no = totalCount - (currentPage - 1) * perPage;
        no = totalCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<ResumeDto> list = resumeservice.getPagingList(startNum, perPage);


        List<Map<String,Object>> fulllList =new ArrayList<>();

        for(ResumeDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            map.put("m_idx",dto.getM_idx());
            map.put("nickName",resumeservice.selectNickNameOfm_idx(dto.getM_idx()));

            String photo = resumeservice.selectPhotoOfm_idx(dto.getM_idx());

            if(photo.equals("no")) {
                photo = "/photo/profile.jpg";
            } else {
                photo = "http://kr.object.ncloudstorage.com/devster-bucket/member/"+resumeservice.selectPhotoOfm_idx(dto.getM_idx());
            }
            map.put("photo",photo);
            map.put("r_idx",dto.getR_idx());
            map.put("m_idx",dto.getM_idx());
            map.put("r_self",dto.getR_self());
            map.put("r_pos",dto.getR_pos());
            map.put("r_ldate",dto.getR_ldate());
            map.put("currentPage", currentPage);
            map.put("r_status",dto.getR_status());
            fulllList.add(map);
        }

        // 출력시 필요한 변수들 model에 전부 저장
        model.addAttribute("list1", fulllList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("no", no);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalCount",totalCount);



        return "/main/mypage/relist";
    }

   /* @GetMapping("/relistajax")
    @ResponseBody
    public List<Map<String,Object>> relistAjax(int currentPage)
    {
        int totalCount = resumeservice.getTotalCount();
        int perPage = 20; // 한 페이지당 보여줄 글 갯수
        int startNum; // 각 페이지에서 보여질 글의 시작번호
        int no;

        // 각 페이지의 시작번호 (1페이지: 0, 2페이지 : 3, 3페이지 6 ....)
        startNum = (currentPage - 1) * perPage;

        // 각 글마다 출력할 글 번호 (예 : 10개일 경우 1페이지 10, 2페이지 7...)
        // no = totalCount - (currentPage - 1) * perPage;
        no = totalCount - startNum;

        // 각 페이지에 필요한 게시글 db에서 가져오기
        List<ResumeDto> list = resumeservice.getPagingList(startNum, perPage);


        List<Map<String,Object>> fulllList =new ArrayList<>();

        for(ResumeDto dto : list) {
            Map<String,Object> map = new HashMap<>();
            map.put("m_idx",dto.getM_idx());
            map.put("nickName",resumeservice.selectNickNameOfm_idx(dto.getM_idx()));

            String photo = resumeservice.selectPhotoOfm_idx(dto.getM_idx());

            if(photo.equals("no")) {
                photo = "/photo/profile.jpg";
            } else {
                photo = "http://kr.object.ncloudstorage.com/devster-bucket/member/"+resumeservice.selectPhotoOfm_idx(dto.getM_idx());
            }
            map.put("photo",photo);
            map.put("r_self",dto.getR_self());
            map.put("r_pos",dto.getR_pos());
            map.put("r_ldate",dto.getR_ldate());
            map.put("currentPage", currentPage);
            map.put("r_status",dto.getR_status());
            fulllList.add(map);
        }

        return fulllList;

    }*/

    }
