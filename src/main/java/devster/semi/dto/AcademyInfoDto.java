package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("AcademyInfoDto")
public class AcademyInfoDto {
    private int ai_idx;
    private String ai_name;
}
