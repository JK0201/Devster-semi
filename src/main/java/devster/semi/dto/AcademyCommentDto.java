package devster.semi.dto;

import lombok.Data;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("AcademyCommentDto")
@ToString
public class AcademyCommentDto {
    private int abc_idx; //pk
    private int ab_idx; //fk
    private int m_idx; //fk
    private String abc_content;
//    private int fbc_like;
    private int abc_ref;
    private int abc_step;
    private int abc_depth;
    private Timestamp abc_writeday;
}
