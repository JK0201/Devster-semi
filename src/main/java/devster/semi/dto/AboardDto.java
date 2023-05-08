package devster.semi.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;


@Data
@Alias("AboardDto")
@NoArgsConstructor
@AllArgsConstructor
public class AboardDto {
    private int m_idx;
    private int qb_idx;
    private int ab_idx;
    private String ab_content;
    private String ab_photo;
    private Timestamp ab_writeday;
}
