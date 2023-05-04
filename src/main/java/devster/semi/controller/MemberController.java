package devster.semi.controller;

import devster.semi.dto.AcademyInfoDto;

import devster.semi.service.MemberService;
import naver.cloud.ObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        System.out.println(m_email);
        int chk = memberService.emailChk(m_email);
        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 0 ? "yes" : "no");

        return map;
    }

    //kakao naver check
    @GetMapping("/apichk")
    @ResponseBody
    public Map<String, String> kanachk(String m_email, HttpSession session) {
        System.out.println(m_email);
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
        System.out.println(m_nickname);
        int chk = memberService.nickNameChk(m_nickname);
        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    @GetMapping("/emailpasschk")
    @ResponseBody
    public Map<String, String> emailPassChk(String m_email, String m_pass, HttpSession session, Model model) {
        System.out.println(m_email + "," + m_pass);
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
}
