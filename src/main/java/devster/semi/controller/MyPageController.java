package devster.semi.controller;

import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.HireBoardDto;
import devster.semi.dto.MemberDto;
import devster.semi.dto.NoticeBoardDto;
import devster.semi.service.HireService;
import devster.semi.service.MemberService;
import devster.semi.service.MyPageService;
import devster.semi.service.NoticeBoardService;
import devster.semi.utilities.SHA256Util;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    MemberService memberService;

    @Autowired
    MyPageService myPageService;

    @Autowired
    NoticeBoardService noticeBoardService;

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
                return "/mypage/mypage/mpageprofileadminuser";
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
    public String approvelist() {
        return "/mypage/mypage/mpageacademycheck";
    }

    @PostMapping("/academycheck")
    @ResponseBody
    public List<MemberDto> checkacaname() {
        return myPageService.getDatasStateZero();
    }

    @PostMapping("/upgradestate")
    @ResponseBody
    public void upgradestate(int m_idx) {
        myPageService.updateMstate(m_idx);
    }

    @PostMapping("/rejectupgrade")
    @ResponseBody
    public void rejectupgrade(int m_idx) {
        myPageService.rejectUpgrade(m_idx);
    }
}
