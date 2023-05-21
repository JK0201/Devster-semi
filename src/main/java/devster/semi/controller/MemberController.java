package devster.semi.controller;

import devster.semi.dto.AcademyInfoDto;

import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.MemberDto;
import devster.semi.service.MailService;
import devster.semi.service.MemberService;
import devster.semi.service.SmsService;
import devster.semi.utilities.SHA256Util;
import naver.cloud.ObjectStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.*;

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
        return "/memmain/member/membersignin";
    }

    @GetMapping("/signup")
    public String memberSignUp(Model model) {
        List<AcademyInfoDto> list = memberService.listAcademyInfo();
        model.addAttribute("list", list);

        return "/memmain/member/membersignup";
    }

    @GetMapping("/searchai")
    @ResponseBody
    public List<AcademyInfoDto> searchAi(String ai_name) {
        List<AcademyInfoDto> list = memberService.searchAcaInfo(ai_name);
        return list;
    }

    @GetMapping("/compsignup")
    public String compSignUp() {
        return "/memmain/member/compsignup";
    }

    @GetMapping("/apisignup")
    public String apiSignUp(HttpSession session, Model m) {
//        String m_email = (String) session.getAttribute("m_email");
//        String m_pass = (String) session.getAttribute("m_pass");
//
//        session.removeAttribute("m_email");
//        session.removeAttribute("m_pass");
//
//        m.addAttribute("m_email", m_email);
//        m.addAttribute("m_pass", m_pass);

        return "/main/member/apisignup";
    }

    @GetMapping("/navercallback")
    public String naverCallBack() {
        return "/member/navercallback";
    }

    @GetMapping("/navercallbackacc")
    public String naverCallBackAcc() {
        return "/member/navercallbackacc";
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
    public Map<String, String> kanachk(String m_email, String m_pass, HttpSession session) {
        int chk = memberService.apichk(m_email);
        Map<String, String> map = new HashMap<>();

        if (chk == 1) {
            map.put("result", "yes");
            int memidx = memberService.getOneData(m_email).getM_idx();
            String memnick = memberService.getOneData(m_email).getM_nickname();
            int memstate = memberService.getOneData(m_email).getM_state();
            int acaidx = memberService.getOneData(m_email).getAi_idx();

            session.setMaxInactiveInterval(60 * 60 * 4);
            session.setAttribute("logstat", "yes");
            session.setAttribute("memidx", memidx);
            session.setAttribute("memnick", memnick);
            session.setAttribute("memstate", memstate);
            session.setAttribute("acaidx", acaidx);
        } else {
            map.put("result", "no");
            session.setMaxInactiveInterval(60);
            session.setAttribute("m_email", m_email);
            session.setAttribute("m_pass", m_pass);
        }

        return map;
    }

    @GetMapping("/accapichk")
    @ResponseBody
    public Map<String, String> acckanachk(String m_email) {
        int chk = memberService.apichk(m_email);
        Map<String, String> map = new HashMap<>();

        if (chk == 1) {
            map.put("result", "yes");
        } else {
            map.put("result", "no");
        }
        return map;
    }

    @GetMapping("/apiaccinfo")
    @ResponseBody
    public void apiAccInfo(String m_email, String m_pass, HttpSession session) {
        session.setMaxInactiveInterval(60);
        session.setAttribute("m_email", m_email);
        session.setAttribute("m_pass", m_pass);
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
            String memacademy = memberService.getOneData(m_email).getAi_name();

            session.setMaxInactiveInterval(60 * 60 * 4);
            session.setAttribute("logstat", "yes");
            session.setAttribute("memidx", memidx);
            session.setAttribute("memnick", memnick);
            session.setAttribute("memstate", memstate);
            session.setAttribute("acaidx", acaidx);
            session.setAttribute("state", state);
            session.setAttribute("memacademy", memacademy);


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

    @GetMapping("/csignincheck")
    @ResponseBody
    public String cSignInCheck(HttpSession session) {
        String signin = (String) session.getAttribute("csignin");
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

    @GetMapping("/cblocksignin")
    @ResponseBody
    public void cBlockSignIn(HttpSession session) {
        session.setAttribute("csignin", "block");
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

        String cm_photo = "";

        if (upload == null) {
            cm_photo = "no";
        } else {
            cm_photo = storageService.uploadFile(bucketName, "company_member", upload);
        } //업로드 어떻게 할지 생각하기


        dto.setSalt(salt);
        dto.setCm_pass(cm_pass);
        dto.setCm_tele(cm_tele);
        dto.setCm_cp(cm_cp);
        dto.setCm_filename(cm_photo);

        memberService.addNewCMemeber(dto);
        dto.setCm_idx(memberService.getCmOneData(dto.getCm_email()).getCm_idx());
        memberService.addDummyCMember(dto);
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
        session.removeAttribute("memacademy");

        return "redirect:/";
    }

    @GetMapping("/selmember")
    public String selMember() {
        return "/memmain/member/memberselect";
    }

    @GetMapping("/agreement")
    public String agreement() {
        return "/main/member/agreement";
    }

    @GetMapping("/grats")
    public String grats() {
        return "/memmain/member/grats";
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

    @GetMapping("/caccfinder")
    public String cAccFinder() {
        return "/main/member/caccountfinder";
    }

    @GetMapping("/cpassfinder")
    public String cPassFinder() {
        return "/main/member/cpassfinder";
    }

    @GetMapping("/npcheck") //name + phone check
    @ResponseBody
    public Map<String, String> NPCheck(String m_name, String m_tele) {
        String[] tokens = m_tele.split("-");
        String phoneNoHyphen = String.join("", tokens);
        tokens = phoneNoHyphen.split("\\s");
        m_tele = String.join("", tokens);

        int chk = memberService.NPCheck(m_name, m_tele);

        Map<String, String> map = new HashMap<>();
        map.put("result", chk > 0 ? "yes" : "no");

        return map;
    }

    @PostMapping("/paccinfo")
    @ResponseBody
    public void pAccInfo(String m_name, String m_tele, HttpSession session) {
        session.setAttribute("m_name", m_name);
        session.setAttribute("m_tele", m_tele);
    }

    @GetMapping("/paccfound")
    public String pAccFound(HttpSession session, Model model) {
        String m_name = (String) session.getAttribute("m_name");
        String m_tele = (String) session.getAttribute("m_tele");

        session.removeAttribute("m_name");
        session.removeAttribute("m_tele");

        List<MemberDto> list = memberService.NPGetList(m_name, m_tele);

        model.addAttribute("m_name", m_name);
        model.addAttribute("m_tele", m_tele);
        model.addAttribute("list", list);
        return "/main/member/accountfound";
    }

    @GetMapping("/cnpcheck") //name + phone check
    @ResponseBody
    public Map<String, String> cNPCheck(String cm_name, String cm_cp) {
        String[] tokens = cm_cp.split("-");
        String phoneNoHyphen = String.join("", tokens);
        tokens = phoneNoHyphen.split("\\s");
        cm_cp = String.join("", tokens);

        int chk = memberService.cNPCheck(cm_name, cm_cp);

        Map<String, String> map = new HashMap<>();
        map.put("result", chk > 0 ? "yes" : "no");

        return map;
    }

    @PostMapping("/cpaccinfo")
    @ResponseBody
    public void cPAccInfo(String cm_name, String cm_cp, HttpSession session) {
        session.setAttribute("cm_name", cm_name);
        session.setAttribute("cm_cp", cm_cp);
    }

    @GetMapping("/cpaccfound")
    public String cPAccFound(HttpSession session, Model model) {
        String cm_name = (String) session.getAttribute("cm_name");
        String cm_cp = (String) session.getAttribute("cm_cp");

        session.removeAttribute("cm_name");
        session.removeAttribute("cm_cp");

        List<CompanyMemberDto> list = memberService.cNPGetList(cm_name, cm_cp);

        model.addAttribute("cm_name", cm_name);
        model.addAttribute("cm_cp", cm_cp);
        model.addAttribute("list", list);
        return "/main/member/caccountfound";
    }

    @GetMapping("/pfindcheck")
    @ResponseBody
    public Map<String, String> pFindCheck(String m_email, String m_name, String m_tele) {
        String[] tokens = m_tele.split("-");
        String phoneNoHyphen = String.join("", tokens);
        tokens = phoneNoHyphen.split("\\s");
        m_tele = String.join("", tokens);

        int chk = memberService.pFindCheck(m_email, m_name, m_tele);

        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    @GetMapping("/findaccinfo")
    @ResponseBody
    public void pFindAccInfo(String m_email, String m_name, HttpSession session) {
        session.setMaxInactiveInterval(60);
        session.setAttribute("m_email", m_email);
        session.setAttribute("m_name", m_name);
    }

    @GetMapping("/update")
    public String pUpdate(HttpSession session, Model model) {
//        String m_email = (String) session.getAttribute("m_email");
//        String m_name = (String) session.getAttribute("m_name");
//
//        session.removeAttribute("m_email");
//        session.removeAttribute("m_name");
//
//        model.addAttribute("m_email", m_email);
//        model.addAttribute("m_name", m_name);
        return "/main/member/passupdate";
    }

    @GetMapping("/efindcheck")
    @ResponseBody
    public Map<String, String> eFindCheck(String m_email, String m_name) {
        int chk = memberService.eFindCheck(m_email, m_name);

        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    @GetMapping("/updatepass")
    @ResponseBody
    public void updatePass(String m_email, String m_name, String m_pass) {
        String salt = SHA256Util.generateSalt();
        String pass = m_pass;
        m_pass = SHA256Util.getEncrypt(pass, salt);

        memberService.updatePass(m_email, m_name, m_pass, salt);
    }

    @GetMapping("/cpfindcheck")
    @ResponseBody
    public Map<String, String> CPFindCheck(String cm_email, String cm_name, String cm_cp) {
        String[] tokens = cm_cp.split("-");
        String phoneNoHyphen = String.join("", tokens);
        tokens = phoneNoHyphen.split("\\s");
        cm_cp = String.join("", tokens);

        int chk = memberService.CPFindCheck(cm_email, cm_name, cm_cp);

        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    @GetMapping("/cfindaccinfo")
    @ResponseBody
    public void CPFindAccInfo(String cm_email, String cm_name, HttpSession session) {
        session.setMaxInactiveInterval(60);
        session.setAttribute("cm_email", cm_email);
        session.setAttribute("cm_name", cm_name);
    }

    @GetMapping("/cupdate")
    public String CUpdate(HttpSession session, Model model) {
//        String cm_email = (String) session.getAttribute("cm_email");
//        String cm_name = (String) session.getAttribute("cm_name");
//
//        session.removeAttribute("cm_email");
//        session.removeAttribute("cm_name");
//
//        model.addAttribute("cm_email", cm_email);
//        model.addAttribute("cm_name", cm_name);
        return "/main/member/cpassupdate";
    }

    @GetMapping("/cupdatepass")
    @ResponseBody
    public void CUpdatePass(String cm_email, String cm_name, String cm_pass) {
        System.out.println(cm_pass);
        String salt = SHA256Util.generateSalt();
        String pass = cm_pass;
        cm_pass = SHA256Util.getEncrypt(pass, salt);
        System.out.println(cm_pass);

        memberService.CUpdatePass(cm_email, cm_name, cm_pass, salt);
    }

    @GetMapping("/cefindcheck")
    @ResponseBody
    public Map<String, String> CEFindCheck(String cm_email, String cm_name) {
        int chk = memberService.CEFindCheck(cm_email, cm_name);

        Map<String, String> map = new HashMap<>();
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    @GetMapping("/compreg")
    public String compreg() {
        return "/main/member/compreg";
    }

    @GetMapping("/compregchk")
    @ResponseBody
    public Map<String, String> compRegChk(String cm_reg) {
        String[] tokens = cm_reg.split("-");
        String regNoHyphen = String.join("", tokens);
        tokens = regNoHyphen.split("\\s");
        cm_reg = String.join("", tokens);

        Map<String, String> map = new HashMap<>();
        int chk = memberService.compRegChk(cm_reg);
        map.put("result", chk == 1 ? "yes" : "no");

        return map;
    }

    @GetMapping("/dndupdate")
    public String dndupdate() {
        return "/main/member/dndupdate";
    }

    @PostMapping("/dndupdatetest")
    @ResponseBody
    public void dndtest(List<MultipartFile> upload) {
        String getphoto = memberService.getphoto(99);
        if (!getphoto.equals("no")) {
            String[] filename = getphoto.split(",");
            for (String photo : filename) {
                storageService.deleteFile(bucketName, "member", photo);
            }
        }

        String m_photo = "";
        StringBuilder m_photoBuiler = new StringBuilder();
        if (upload != null) {
            for (MultipartFile file : upload) {
                String photo = storageService.uploadFile(bucketName, "member", file) + ",";
                m_photoBuiler.append(photo);
            }
            m_photo = m_photoBuiler.toString();
            m_photo = m_photo.substring(0, m_photo.length() - 1);
            System.out.println(m_photo);
        } else {
            m_photo = "no";
        }
        //일단 테스트 계정이라 사진이 자동으로 삭제가 들어감, 업로드 안할시 sql 수정해야함

        memberService.testupdate(m_photo);
    }

}
