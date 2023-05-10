package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("NoticeBoardDto")
public class NoticeBoardDto {
    private int nb_idx; //pk
    private int m_state; //fk
    private String nb_subject;
    private String nb_content;
    private String nb_photo;
    private int nb_readcount;
    private Timestamp nb_writeday;
}
