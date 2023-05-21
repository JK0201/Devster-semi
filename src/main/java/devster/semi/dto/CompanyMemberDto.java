package devster.semi.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

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
    private String cm_post;
    private String cm_name;
    private String cm_cp;
    private String salt;
    private int cm_new; //가입완료 + 요청:0, 완료:1
    private Timestamp cm_date;
    private String cm_reg;
}

