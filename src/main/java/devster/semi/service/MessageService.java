package devster.semi.service;

import devster.semi.dto.MessageDto;
import devster.semi.mapper.MessageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MessageService implements MessageServiceInter{

    @Autowired
    private MessageMapper messageMapper;

    //메세지 리스트
    @Override
    public ArrayList<MessageDto> getMessageList(MessageDto dto) {

        String nick = dto.getNick();

        //메세지 리스트에 나타낼 것들 가져오기 - 가장 최근 메세지, 보낸 사람 프로필사진, 보낸사람 닉네임
        ArrayList<MessageDto> list = (ArrayList) messageMapper.getMessageList(dto);

        for(MessageDto msgdto : list){
            msgdto.setNick(nick);

            int unread = messageMapper.getUnreadCount(msgdto);

            String profile = messageMapper.getOtherProfile(msgdto);

            msgdto.setUnread(unread);

            msgdto.setProfile(profile);

            if(nick.equals(msgdto.getSend_nick())){
                msgdto.setOther_nick(msgdto.getRecv_nick());
            }else {
                msgdto.setOther_nick(msgdto.getSend_nick());

                //System.out.println("Other_nick : " + msgdto.getOther_nick());
            }
        }



        return list;

        /*return messageMapper.getMessageList(dto);*/
    }

   /* @Override
    public String getOtherProfile(MessageDto dto) {
        return messageMapper.getOtherProfile(dto);
    }

    @Override
    public int getUnreadCount(MessageDto dto) {
        return messageMapper.getUnreadCount(dto);
    }*/

    // room 별 메세지 내용을 가져온다
    @Override
    public ArrayList<MessageDto> getRoomContentList(MessageDto dto) {

       // System.out.println("room : " + dto.getRoom());
       // System.out.println("recv_nick : " + dto.getRecv_nick());
        //System.out.println("nick : " + dto.getNick());

        //메세지 내역을 가져온다
        ArrayList<MessageDto> clist = (ArrayList) messageMapper.getRoomContentList(dto);

        //해당 방의 메세지들 중 받는 사람이 현재 사용자의 nick 인 메세지를 모두 읽음 처리한다
        messageMapper.MessageReadChk(dto);

        return clist;

        /*return messageMapper.getRoomContentList(dto);*/
    }




    //메세지 list 에서 메세지를 보낸다
  /*  @Override
    public void MessageReadChk(MessageDto dto) {


    }*/

    @Override
    public void MessageSendInList(MessageDto dto) {
        //메세지 리스트에서 보낸건지 프로필에서 보낸건지 구분하기 위함
       /* if(dto.getRoom() == 0){ // room이 0이라면 프로필에서 보낸것
            int exist_chat = messageMapper.getExistChat(dto);
            //프로필에서 보낸 것 중 메세지 내역이 없어서 첫 메세지가 될 경우를 구분하기 위함
            if(exist_chat ==0){ //메세지 내역이 없어서 0이면 message 테이블의 room 최댓값을 구해서 dto에 set한다
                int max_room = messageMapper.getMaxRoom(dto);
                dto.setRoom(max_room+1);
            }else{ // 메세지 내역이 있다면 해당 room 번호를 가져온다
                int room = Integer.parseInt(messageMapper.getSelectRoom(dto));
                dto.setRoom(room);
            }
        }*/
        messageMapper.MessageSendInList(dto);
    }

   /* @Override
    public int getMaxRoom(MessageDto dto) {
        return messageMapper.getMaxRoom(dto);
    }

    @Override
    public int getExistChat(MessageDto dto) {
        return messageMapper.getExistChat(dto);
    }

    @Override
    public String getSelectRoom(MessageDto dto) {
        return messageMapper.getSelectRoom(dto);
    }*/

    @Override
    public ArrayList<MessageDto> getMessagesWithOtherUser(MessageDto dto) {
        String nick = dto.getNick();
        String other_nick = dto.getOther_nick();

        ArrayList<MessageDto> list = (ArrayList) messageMapper.getMessagesWithOtherUser(dto);

        for(MessageDto msgdto : list){
            int unread = messageMapper.getUnreadCount(msgdto);
            String profile = messageMapper.getOtherProfile(msgdto);

            msgdto.setUnread(unread);
            msgdto.setProfile(profile);
            msgdto.setOther_nick(other_nick);
        }

        return list;
    }
}
