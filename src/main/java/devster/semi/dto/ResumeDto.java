package devster.semi.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import javax.print.attribute.standard.PrinterURI;
import java.sql.Date;
import java.sql.Timestamp;


@Data
@Alias("resumeDto")
public class ResumeDto {
    private int r_idx;
    private int m_idx;
    private String r_self;
    private String r_pos;
    private String r_skill;
    private String r_link;
    private String r_file;
    private String r_refile;
    private Timestamp r_ldate;
    private Timestamp r_gradestart;
    private Timestamp r_gradeend;
    private String r_gradecom;
    private String r_sta;
    private int r_status;



}