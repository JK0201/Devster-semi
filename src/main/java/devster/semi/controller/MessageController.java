package devster.semi.controller;

import devster.semi.dto.MessageDto;
import devster.semi.service.MessageService;
import naver.cloud.NcpObjectStorageService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName="devster-bucket";

    //메세지 목록
    @RequestMapping("/message/list")
    public String messagelist(HttpServletRequest request, HttpSession session, Model model){

        //System.out.println("현재 사용자 닉네임 : " + session.getAttribute("memnick"));

        String nick =(String) session.getAttribute("memnick");

        MessageDto dto = new MessageDto();
        dto.setNick(nick);

        ArrayList<MessageDto> list = messageService.getMessageList(dto);

        model.addAttribute("list",list);


        return "/sub/message/message_list";
    }

    //메세지 목록
    @RequestMapping("/message/message_ajax_list.do")
    public String message_ajax_list(HttpServletRequest request, HttpSession session, Model model){

        //System.out.println("현재 사용자 닉네임 : " + session.getAttribute("memnick"));

        String nick =(String) session.getAttribute("memnick");

        MessageDto dto = new MessageDto();
        dto.setNick(nick);

        ArrayList<MessageDto> list = messageService.getMessageList(dto);

        //System.out.println(list);

        model.addAttribute("list",list);

        return "message/message_ajax_list";
    }

    @RequestMapping("/message/message_content_list.do")
    public String message_content_list(HttpServletRequest request, HttpSession session, Model model){

        int room = Integer.parseInt(request.getParameter("room"));

        MessageDto dto = new MessageDto();

        dto.setRoom(room);
        dto.setNick((String) session.getAttribute("memnick"));

        System.out.println(dto.toString());


        //메세지 내용을 가져온다
        ArrayList<MessageDto> clist = messageService.getRoomContentList(dto);

        //System.out.println("clist: " + clist);


        model.addAttribute("clist", clist);

        return "message/message_content_list";
    }

    //메세지 리스트에서 메세지 보내기
    @ResponseBody
    @RequestMapping("/message/message_send_inlist.do")
    public void message_send_inlist(@RequestParam int room, @RequestParam String other_nick,
                                   @RequestParam String content, HttpSession session) {

        MessageDto dto = new MessageDto();
        dto.setRoom(room);
        dto.setSend_nick((String) session.getAttribute("memnick"));
        dto.setRecv_nick(other_nick);
        dto.setContent(content);

        messageService.MessageSendInList(dto);
    }

}















