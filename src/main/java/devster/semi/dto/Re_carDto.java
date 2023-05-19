package devster.semi.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.ToString;
import org.apache.ibatis.type.Alias;

import java.sql.Date;
import java.sql.Timestamp;

@Data
@Alias("re_carDto")
@ToString
public class Re_carDto {
    private Timestamp r_carstartdate;
    private Timestamp r_carenddate;
    private String r_company;
    private String r_department;
    private String r_position;
    private int m_idx;
    private int recar_idx;
}
