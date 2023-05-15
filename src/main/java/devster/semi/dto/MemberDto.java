package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("MemberDto")
public class MemberDto {
    private int m_idx;
    private String m_email;
    private String m_pass;
    private int m_state;
    private String m_tele;
    private String m_name;
    private String m_nickname;
    private String m_photo;
    private int m_point;
    private String m_filename;
    private int m_new; //가입 완료후:0, 요청:1 ,완료:2
    private int ai_idx;
    private String ai_name;
    private String salt;
    private int m_type;
    private Timestamp m_date;
}
