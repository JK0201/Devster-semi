package devster.semi.controller;

import devster.semi.dto.AcademyInfoDto;

import devster.semi.dto.MemberDto;
import devster.semi.service.MailService;
import devster.semi.service.MemberService;
import devster.semi.service.SmsService;
import devster.semi.utilities.SHA256Util;
import naver.cloud.ObjectStorageService;
import org.apache.jasper.tagplugins.jstl.core.Out;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.lang.reflect.Member;
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
    public Map<String, String> emailPassChk(String m_email, String m_pass, HttpSession session, Model model) {
        String salt=memberService.getSaltById(m_email);
        //DB에 저장되어있는 pass
        String pass=memberService.getOneData(m_email).getM_pass();

        //SHA256+salting
        m_pass=SHA256Util.getEncrypt(m_pass,salt);
        System.out.println(pass+" // "+m_pass);

        int chk = memberService.emailpasschk(m_email, m_pass);
        Map<String, String> map = new HashMap<>();

        if (chk == 1) {
            map.put("result", "yes");
            int memidx = memberService.getOneData(m_email).getM_idx();
            String memnick = memberService.getOneData(m_email).getM_nickname();
            int memstate = memberService.getOneData(m_email).getM_state();
            int acaidx = memberService.getOneData(m_email).getAi_idx();

            //포인트 증가 (1회증가로 나중에 로직짜기)
            memberService.dailyPoint(m_email);

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

    @GetMapping("/phonechk")
    @ResponseBody
    public String sendSMS(String phonenum, HttpSession session) {
        int randomnum = (int) ((Math.random() * (99999 - 10000 + 1) + 10000));
//        smsService.certified(phonenum, randomnum); //주석해제 해야 동작함

        return Integer.toString(randomnum);
    }

    @GetMapping("/sendemail")
    @ResponseBody
    public String sendEmail(String email, HttpSession session) throws Exception {
        String code = mailService.sendSimpleMessage(email);
        System.out.println("발송한 인증코드 : " + code);

        session.setAttribute("ecode", code);
        session.setMaxInactiveInterval(20);

        return code;
    }

    @GetMapping("eblockcheck")
    @ResponseBody
    public String eblockCheck(HttpSession session) {
        String espam = (String) session.getAttribute("espam");
        String cond="";
        if(espam==null) {
            cond="yes";
        }
        else{
            cond="no";
        }

        return cond;
    }

    @GetMapping("/eblockesend")
    @ResponseBody
    public void eblockSend(HttpSession session) {
        session.setAttribute("espam", "block");
        session.setMaxInactiveInterval(30);
    }

    @GetMapping("cblockcheck")
    @ResponseBody
    public String cblockCheck(HttpSession session) {
        String cspam = (String) session.getAttribute("cspam");
        String cond="";
        if(cspam==null) {
            cond="yes";
        }
        else{
            cond="no";
        }

        return cond;
    }

    @GetMapping("/cblocksend")
    @ResponseBody
    public void cblockSend(HttpSession session) {
        session.setAttribute("cspam", "block");
        session.setMaxInactiveInterval(30);
    }

    @PostMapping("/signupform")
    @ResponseBody
    public void signUpForm(MemberDto dto, String ai_name, MultipartFile upload) {

        String salt= SHA256Util.generateSalt();
        String m_pass=dto.getM_pass();
        m_pass=SHA256Util.getEncrypt(m_pass,salt);

        String m_photo = "";

        if (dto.getAi_name() == null) {
            dto.setAi_name("no");
        } //이건 보류

        if (upload == null) {
            m_photo = "no";
        } else {
            m_photo = storageService.uploadFile(bucketName, "member", upload);
        }

        dto.setSalt(salt);
        dto.setM_pass(m_pass);
        dto.setM_photo(m_photo);
        dto.setAi_idx(memberService.getAcademyIdx(dto.getAi_name()));
        memberService.addNewMember(dto);
    }

    @GetMapping("/grats")
    public String grats() {
        return "/main/member/membergrats";
    }
}
