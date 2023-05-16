package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("AcademyBoardDto")
public class AcademyBoardDto {
    private int m_idx; //fk
    private int ab_idx; //pk
    private String ab_subject;
    private String ab_content;
    private String ab_photo;
    private int ab_readcount;
    private int ab_like;
    private int ab_dislike;
    private Timestamp ab_writeday;
    private int ai_idx;
}
