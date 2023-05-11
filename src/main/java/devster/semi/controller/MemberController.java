package devster.semi.controller;

import devster.semi.dto.AcademyInfoDto;

import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.MemberDto;
import devster.semi.service.MailService;
import devster.semi.service.MemberService;
import devster.semi.service.SmsService;
import devster.semi.utilities.SHA256Util;
import naver.cloud.ObjectStorageService;
import org.apache.ibatis.jdbc.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private SmsService smsService;

    @Autowired
    MailService mailService;

    @Autowired
    private ObjectStorageService storageService;

    private String bucketName = "devster-bucket";

    @GetMapping("/signin")
    public String memberSignIn() {
        return "/main/member/membersignin";
    }

    @GetMapping("/signup")
    public String memberSignUp(Model model) {
        List<AcademyInfoDto> list = memberService.listAcademyInfo();
        model.addAttribute("list", list);

        return "/main/member/membersignup";
    }

    @GetMapping("/searchai")
    @ResponseBody
    public List<AcademyInfoDto> searchAi(String ai_name) {
        List<AcademyInfoDto> list = memberService.searchAcaInfo(ai_name);
        return list;
    }

    @GetMapping("/compsignup")
    public String compSignUp() {
        return "/main/member/compsignup";
    }

    @GetMapping("/apisignup")
    public String apiSignUp() {
        return "/main/member/apisignup";
    }

    @GetMapping("/navercallback")
    public String naverCallBack() {
        return "/member/navercallback";
    }

    @GetMapping("/emailchk")
    @ResponseBody
    public Map<String, String> emailChk(String m_email) {
        int chk = memberService.emailChk(m_email);
        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 0 ? "yes" : "no");

        return map;
    }

    @GetMapping("/cmemailchk")
    @ResponseBody
    public Map<String, String> cmEmailChk(String cm_email) {
        int chk = memberService.cmEmailChk(cm_email);
        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 0 ? "yes" : "no");

        return map;
    }

    //kakao naver check
    @GetMapping("/apichk")
    @ResponseBody
    public Map<String, String> kanachk(String m_email, HttpSession session) {
        int chk = memberService.apichk(m_email);
        Map<String, String> map = new HashMap<>();

        if (chk == 1) {
            map.put("result", "yes");
            int memidx = memberService.getOneData(m_email).getM_idx();
            String memnick = memberService.getOneData(m_email).getM_nickname();
            int memstate = memberService.getOneData(m_email).getM_state();
            int acaidx = memberService.getOneData(m_email).getAi_idx();

            //포인트 증가 (1회증가로 나중에 로직짜기)
            memberService.dailyPoint(m_email);

            session.setMaxInactiveInterval(60 * 60 * 4);
            session.setAttribute("logstat", "yes");
            session.setAttribute("memidx", memidx);
            session.setAttribute("memnick", memnick);
            session.setAttribute("memstate", memstate);
            session.setAttribute("acaidx", acaidx);
        } else {
            map.put("result", "no");
        }

        return map;
    }

    @GetMapping("/nicknamechk")
    @ResponseBody
    public Map<String, String> nickNameChk(String m_nickname) {
        int chk = memberService.nickNameChk(m_nickname);
        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    @GetMapping("/emailpasschk")
    @ResponseBody
    public Map<String, String> emailPassChk(String m_email, String m_pass, HttpSession session) {
        String salt = memberService.getSaltById(m_email);
        int chk;
        Map<String, String> map = new HashMap<>();

        try {
            //SHA256+salting
            m_pass = SHA256Util.getEncrypt(m_pass, salt);
            chk = memberService.emailpasschk(m_email, m_pass);
        } catch (NullPointerException e) {
            chk = 0;
        }

        if (chk == 1) {
            map.put("result", "yes");
            int memidx = memberService.getOneData(m_email).getM_idx();
            String memnick = memberService.getOneData(m_email).getM_nickname();
            int memstate = memberService.getOneData(m_email).getM_state();
            int acaidx = memberService.getOneData(m_email).getAi_idx();
            int state = memberService.getOneData(m_email).getM_state();
            //포인트 증가 (1회증가로 나중에 로직짜기)
            memberService.dailyPoint(m_email);

            session.setMaxInactiveInterval(60 * 60 * 4);
            session.setAttribute("logstat", "yes");
            session.setAttribute("memidx", memidx);
            session.setAttribute("memnick", memnick);
            session.setAttribute("memstate", memstate);
            session.setAttribute("acaidx", acaidx);
            session.setAttribute("state",state);
        } else {
            map.put("result", "no");
        }

        return map;
    }

    @GetMapping("/cemailpasschk")
    @ResponseBody
    public Map<String, String> cEmailPassChk(String cm_email, String cm_pass, HttpSession session) {
        String salt = memberService.CmGetSaltById(cm_email);
        int chk;
        Map<String, String> map = new HashMap<>();
        try {
            //SHA256+salting
            cm_pass = SHA256Util.getEncrypt(cm_pass, salt);
            chk = memberService.cmEmailPassChk(cm_email, cm_pass);
        } catch (NullPointerException e) {
            chk = 0;
        }

        if (chk == 1) {
            map.put("result", "yes");
            int cmidx = memberService.getCmOneData(cm_email).getCm_idx();
            String cmname = memberService.getCmOneData(cm_email).getCm_compname();

            session.setMaxInactiveInterval(60 * 60 * 4);
            session.setAttribute("logstat", "yes");
            session.setAttribute("cmidx", cmidx);
            session.setAttribute("cmname", cmname);
        } else {
            map.put("result", "no");
        }

        return map;
    }

    @GetMapping("/phonechk")
    @ResponseBody
    public String sendSMS(String phonenum, HttpSession session) {
//        int code = (int) ((Math.random() * (99999 - 10000 + 1) + 10000));
//        smsService.certified(phonenum, code); //주석해제 해야 동작함
        int code = 1234;

        return Integer.toString(code);
    }

    @GetMapping("/sendemail")
    @ResponseBody
    public String sendEmail(String email, HttpSession session) throws Exception {
        String code = mailService.sendSimpleMessage(email);
        System.out.println("발송한 인증코드 : " + code);

        return code;
    }

    @GetMapping("/blockcheck")
    @ResponseBody
    public String eblockCheck(HttpSession session) {
        String spam = (String) session.getAttribute("spam");
        String cond = "";
        if (spam == null) {
            cond = "yes";
        } else {
            cond = "no";
        }

        return cond;
    }

    @GetMapping("/resetcheck")
    @ResponseBody
    public String resetCheck(HttpSession session) {
        String reset = (String) session.getAttribute("reset");
        String cond = "";
        if (reset == null) {
            cond = "yes";
        } else {
            cond = "no";
        }

        return cond;
    }

    @GetMapping("/signincheck")
    @ResponseBody
    public String signInCheck(HttpSession session) {
        String signin = (String) session.getAttribute("signin");
        String cond = "";
        if (signin == null) {
            cond = "yes";
        } else {
            cond = "no";
        }

        return cond;
    }

    @GetMapping("/blocksend")
    @ResponseBody
    public void blockSend(HttpSession session) {
        session.setAttribute("spam", "block");
        session.setMaxInactiveInterval(30);
    }

    @GetMapping("/blockreset")
    @ResponseBody
    public void blockReset(HttpSession session) {
        session.setAttribute("reset", "block");
        session.setMaxInactiveInterval(30);
    }

    @GetMapping("/blocksignin")
    @ResponseBody
    public void blockSignIn(HttpSession session) {
        session.setAttribute("signin", "block");
        session.setMaxInactiveInterval(30);
    }

    @PostMapping("/signupform")
    @ResponseBody
    public void signUpForm(MemberDto dto, String ai_name, MultipartFile upload) {
        String salt = SHA256Util.generateSalt();
        String m_pass = dto.getM_pass();
        m_pass = SHA256Util.getEncrypt(m_pass, salt);

        String[] tokens = dto.getM_tele().split("-");
        String phoneNoHyphen = String.join("", tokens);
        tokens = phoneNoHyphen.split("\\s");
        String m_tele = String.join("", tokens);

        if (dto.getAi_name() == null) {
            dto.setAi_name("no");
        } //학원 보류

        String m_photo = "";

        if (upload == null) {
            m_photo = "no";
        } else {
            m_photo = storageService.uploadFile(bucketName, "member", upload);
        } //업로드 어떻게 할지 생각하기


        dto.setAi_name(ai_name); // 학원 보류

        dto.setSalt(salt);
        dto.setM_pass(m_pass);
        dto.setM_photo(m_photo);
        dto.setM_tele(m_tele);
        dto.setAi_idx(memberService.getAcademyIdx(dto.getAi_name()));

        memberService.addNewMember(dto);
    }

    @PostMapping("cmsignupform")
    @ResponseBody
    public void cmSignUpForm(CompanyMemberDto dto, MultipartFile upload) {
        String salt = SHA256Util.generateSalt();
        String cm_pass = dto.getCm_pass();
        cm_pass = SHA256Util.getEncrypt(cm_pass, salt);

        String[] tokensTele = dto.getCm_tele().split("-");
        String teleNoHyphen = String.join("", tokensTele);
        tokensTele = teleNoHyphen.split("\\s");
        String cm_tele = String.join("", tokensTele);

        String[] tokensCp = dto.getCm_cp().split("-");
        String cpNoHyphen = String.join("", tokensCp);
        tokensCp = cpNoHyphen.split("\\s");
        String cm_cp = String.join("", tokensCp);

        //업로드 어떻게 할건지 생각하기

        dto.setSalt(salt);
        dto.setCm_pass(cm_pass);
        dto.setCm_tele(cm_tele);
        dto.setCm_cp(cm_cp);

        memberService.addNewCMemeber(dto);
    }

    @PostMapping("/apisignupform")
    @ResponseBody
    public void apiSignUpForm(MemberDto dto, String ai_name, MultipartFile upload) {
        String salt = SHA256Util.generateSalt();
        String m_pass = dto.getM_pass();
        m_pass = SHA256Util.getEncrypt(m_pass, salt);

        String[] tokens = dto.getM_tele().split("-");
        String phoneNoHyphen = String.join("", tokens);
        tokens = phoneNoHyphen.split("\\s");
        String m_tele = String.join("", tokens);

        if (dto.getAi_name() == null) {
            dto.setAi_name("no");
        } //학원 보류

        String m_photo = "";
        if (upload == null) {
            m_photo = "no";
        } else {
            m_photo = storageService.uploadFile(bucketName, "member", upload);
        }

        dto.setAi_name(ai_name);

        dto.setSalt(salt);
        dto.setM_pass(m_pass);
        dto.setM_photo(m_photo);
        dto.setM_tele(m_tele);
        dto.setAi_idx(memberService.getAcademyIdx(dto.getAi_name()));

        memberService.addNewMember(dto);
    }

    @GetMapping("/compnamechk")
    @ResponseBody
    public Map<String, String> compNameChk(String cm_compname) {
        int chk = memberService.compNameChk(cm_compname);
        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    //out
    @GetMapping("/outtest")
    public String outTest(HttpSession session) {
        session.removeAttribute("logstat");
        session.removeAttribute("memidx");
        session.removeAttribute("memnick");
        session.removeAttribute("memstate");
        session.removeAttribute("acaidx");
        session.removeAttribute("cmidx");
        session.removeAttribute("cmname");

        return "redirect:/";
    }

    @GetMapping("/selmember")
    public String selMember() {
        return "/main/member/memberselect";
    }

    @GetMapping("/agreement")
    public String agreement() {
        return "/main/member/agreement";
    }

    @GetMapping("/grats")
    public String grats() {
        return "/main/member/grats";
    }

    @GetMapping("/finder")
    public String finder() {
        return "/main/member/finderselect";
    }

    @GetMapping("/accfinder")
    public String accFinder() {
        return "/main/member/accountfinder";
    }

    @GetMapping("/passfinder")
    public String passFinder() {
        return "/main/member/passfinder";
    }

}
