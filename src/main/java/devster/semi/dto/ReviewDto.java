package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;
import org.springframework.stereotype.Component;

import java.sql.Timestamp;

@Data
@Alias("reviewDto")
@Component
public class ReviewDto {
    private int m_idx;
    private int ci_idx;
    private int rb_idx;
    private int rb_type;
    private String rb_content;
    private int rb_like;
    private int rb_dislike;
    private int rb_readcount;
    private int rb_star;
    private Timestamp rb_writeday;
/*    private String m_nickname;*/




}
