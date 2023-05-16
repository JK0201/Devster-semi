package devster.semi.service;

import devster.semi.dto.MessageDto;

import java.util.ArrayList;
import java.util.List;

public interface MessageServiceInter {

    public ArrayList<MessageDto> getMessageList(MessageDto dto);

    public ArrayList<MessageDto> getRoomContentList(MessageDto dto);

    public void MessageSendInList(MessageDto dto);


   /* public String getOtherProfile(MessageDto dto);

    public int getUnreadCount(MessageDto dto);

    public void MessageReadChk(MessageDto dto);

    public int getMaxRoom(MessageDto dto);

    public int getExistChat(MessageDto dto);

    public String getSelectRoom(MessageDto dto);*/
}
