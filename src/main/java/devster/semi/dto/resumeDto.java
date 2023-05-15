package devster.semi.dto;

import java.sql.Timestamp;

public class resumeDto {
    private int r_idx;
    private int m_idx;
    private String r_self;
    private String r_pos;
    private String r_skill;
    private String r_link;
    private Timestamp r_gradestart;
    private Timestamp r_gradeend;
    private String r_gradecom;
    private String r_sta;
//자격증
private Timestamp  r_licdate;
    private String   r_licname;
    //경력
    private Timestamp r_carstartdate;
    private Timestamp r_carenddate;
    private String r_company;
    private String r_department;
    private String r_position;

}