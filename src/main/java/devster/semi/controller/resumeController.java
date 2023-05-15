package devster.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/resume")
public class resumeController {


    @PostMapping("/search")
    @ResponseBody
    public String search(@RequestParam("q") String query) {
        // 결과 문자열을 생성합니다.
        String searchResult =  query;
        // 결과 문자열을 반환합니다.
        return searchResult;
    }

    @GetMapping("/writer")
    public String list() {

        return "/main/resume/resumewrite";
    }



}

