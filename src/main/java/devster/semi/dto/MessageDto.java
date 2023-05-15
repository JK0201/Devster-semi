package devster.semi.dto;

import lombok.Data;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

@Data
@Alias("MessageDto")
@ToString
public class MessageDto {
    private String mes_idx;
    private int room;
    private String send_nick;
    private String recv_nick;
    private String send_time;
    private String read_time;
    private String content;
    private String read_chk;

    //현재 사용자의 메세지 상대 닉네임을 담는다
    private String other_nick;
    //현재 사용자의 메세지 상대 프로필을 담는다
    private String profile;
    //현재 사용자 닉네임
    private String nick;
    //안읽은 메세지 갯수
    private int unread;

    private String m_photo;
}
