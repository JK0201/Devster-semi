package devster.semi.controller;

import devster.semi.dto.MessageDto;
import devster.semi.service.MemberService;
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
import javax.xml.transform.sax.SAXResult;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private MemberService memberService;

    @Autowired
    private NcpObjectStorageService storageService;

    private String bucketName="devster-bucket";

    //메세지 목록
    @RequestMapping("/message/list")
    public String messagelist(HttpServletRequest request, HttpSession session, Model model){

        //System.out.println("현재 사용자 닉네임 : " + session.getAttribute("memnick"));
        String nick = "";

        if(session.getAttribute("memnick") !=null) {
            nick =(String)session.getAttribute("memnick");
        } else {
            nick = (String)session.getAttribute("cmname");
        }

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

        String nick = "";

        if(session.getAttribute("memnick") !=null) {
            nick =(String)session.getAttribute("memnick");
        } else {
            nick = (String)session.getAttribute("cmname");
        }

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
        String nick = "";

        if(session.getAttribute("memnick") !=null) {
            nick =(String)session.getAttribute("memnick");
        } else {
            nick = (String)session.getAttribute("cmname");
        }

        dto.setNick(nick);

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
        String nick = "";

        if(session.getAttribute("memnick") !=null) {
            nick =(String)session.getAttribute("memnick");
        } else {
            nick = (String)session.getAttribute("cmname");
        }

        dto.setSend_nick(nick);
        dto.setRecv_nick(other_nick);
        dto.setContent(content);

        messageService.MessageSendInList(dto);
    }

    @RequestMapping("/message/other_profile")
    public String getMessagesWithOtherUser(@RequestParam String other_nick, HttpSession session, Model model) {
        String nick = "";

        if(session.getAttribute("memnick") !=null) {
            nick =(String)session.getAttribute("memnick");
        } else {
            nick = (String)session.getAttribute("cmname");
        }



        MessageDto dto = new MessageDto();
        dto.setNick(nick);
        dto.setOther_nick(other_nick);

        Map<String,Object> map = messageService.getMessagesWithOtherUser(dto);

        model.addAttribute("list", map.get("list"));
        model.addAttribute("room",map.get("room"));
        model.addAttribute("other_nick",other_nick);

        return "message/message_ajax_list_other";
    }

}















