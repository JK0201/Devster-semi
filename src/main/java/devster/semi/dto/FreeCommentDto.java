package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("FreeCommentDto")
public class FreeCommentDto {
    private int fbc_idx; //pk
    private int fb_idx; //fk
    private int m_idx; //fk
    private String fbc_content;
    private int fbc_like;
    private int fbc_ref;
    private int fbc_step;
    private int fbc_depth;
    private Timestamp fbc_writeday;
}
