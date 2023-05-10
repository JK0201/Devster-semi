package devster.semi.controller;

import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.MemberDto;
import devster.semi.service.MemberService;
import devster.semi.service.MyPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    MemberService memberService;

    @Autowired
    MyPageService myPageService;

    @GetMapping("/")
    public String main(HttpSession session,Model model) {
        if(session.getAttribute("memidx") == null && session.getAttribute("cmidx") !=null) {
            CompanyMemberDto dto = myPageService.getOneDatabyCm_idx((int)session.getAttribute("cmidx"));
            model.addAttribute("dto",dto);
            return "/mypage/mypage/mpageprofilecompanyuser";

        }else if(session.getAttribute("memidx") != null && session.getAttribute("cmidx") ==null){
            if((int)session.getAttribute("memstate") == 1 || (int)session.getAttribute("memstate") == 0) {
                MemberDto dto = memberService.getOneDataByM_idx((int)session.getAttribute("memidx"));
                model.addAttribute("dto",dto);
                return "/mypage/mypage/mpageprofilenormaluser";
            } else {
                return "/mypage/mypage/mpageprofileadminuser";
            }
        } else {
            return "";
        }
    }
}
