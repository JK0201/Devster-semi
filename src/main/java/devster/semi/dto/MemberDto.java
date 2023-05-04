package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;
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
    private boolean m_new;
    private int ai_idx;
    private String ai_name;
}
