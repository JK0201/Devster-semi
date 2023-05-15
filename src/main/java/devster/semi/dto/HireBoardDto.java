package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;
import java.sql.Timestamp;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;

@Data
@Alias("HireBoardDto")
public class HireBoardDto {
    private int cm_idx;
    private int hb_idx;
    private String hb_subject;
    private String hb_content;
    private String hb_photo;
    private int hb_readcount;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "Asia/Seoul")
    private Timestamp fb_writeday;


}
