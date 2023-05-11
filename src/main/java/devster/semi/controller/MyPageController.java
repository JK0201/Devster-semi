package devster.semi.controller;

import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.MemberDto;
import devster.semi.service.MemberService;
import devster.semi.service.MyPageService;
import devster.semi.utilities.SHA256Util;
import naver.cloud.NcpObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    MemberService memberService;

    @Autowired
    MyPageService myPageService;

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
}
