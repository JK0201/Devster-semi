package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("CompanyMemberDto")
public class CompanyMemberDto {
    private int cm_idx;
    private String cm_email;
    private String cm_pass;
    private String cm_tele;
    private String cm_addr;
    private String cm_compname;
    private String cm_filename;
    private int cm_new; //가입완료 + 요청:0, 완료:1
}
