package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;
import org.springframework.stereotype.Component;

@Data
@Alias("companyinfoDto")
@Component
public class CompanyinfoDto {
   private int ci_idx;
   private String ci_name;
    private int ci_ppl;
    private int ci_sale;
    private String ci_photo;
    private int ci_sal;
    private int ci_star;
}
