package devster.semi.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Date;
import java.sql.Timestamp;

@Data
@Alias("re_licDto")

public class Re_licDto {
    private int m_idx;
    private int relic_idx;
    private Timestamp r_licdate;
    private String   r_licname;
}
