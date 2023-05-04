package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("FreeBoardDto")
public class FreeBoardDto {
    private int fb_idx; //pk
    private int m_idx; //fk
    private String fb_subject;
    private String fb_content;
    private String fb_photo;
    private int fb_readcount;
    private int fb_like;
    private int fb_dislike;
    private Timestamp fb_writeday;
}
