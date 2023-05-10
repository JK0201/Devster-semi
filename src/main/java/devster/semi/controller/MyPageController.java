package devster.semi.controller;

import devster.semi.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    MemberService memberService;

    @GetMapping("/main")
    public String main() {

        return "/main/mypage/mpagemain";
    }

}
