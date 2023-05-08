package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("QboardDto")
public class QboardDto {
    private int m_idx;
    private int qb_idx;
    private String qb_subject;
    private String qb_content;
    private String qb_photo;
    private int qb_readcount;
    private int qb_like;
    private int qb_dislike;
    private Timestamp qb_writeday;
}
