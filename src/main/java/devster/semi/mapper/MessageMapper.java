package devster.semi.mapper;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.MessageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface MessageMapper {
    public ArrayList<MessageDto> getMessageList(MessageDto dto);

    public ArrayList<MessageDto> getRoomContentList(MessageDto dto);

    public int MessageSendInList(MessageDto dto);

    public String getOtherProfile(MessageDto dto);

    public int getUnreadCount(MessageDto dto);

    public void MessageReadChk(MessageDto dto);

    public int getMaxRoom(MessageDto dto);

    public int getExistChat(MessageDto dto);

    public String getSelectRoom(MessageDto dto);

    public List<MessageDto> getMessageByOtherOtherNick(String other_nick);

}
