package devster.semi.mapper;

import devster.semi.dto.AcademyInfoDto;
import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;
import java.lang.reflect.Member;
import java.util.List;
import java.util.Map;

@Mapper
public interface MemberMapper {
    //    public List<AcademyInfoDto> selectAcademyInfo();
    public List<AcademyInfoDto> listAcademyInfo();

    public int emailChk(String m_email);

    public int apichk(String m_email);

    public int nickNameChk(String m_nickname);

    public int emailpasschk(Map<String, String> map);

    public void dailyPoint(String m_email);

    public MemberDto getOneData(String m_email);
    public CompanyMemberDto getCmOneData(String cm_email);
    public List<AcademyInfoDto> searchAcaInfo(String ai_name);
    public int getAcademyIdx(String ai_name);
    public void addNewMember(MemberDto dto);
    public void addNewCMemeber(CompanyMemberDto dto);
    public String getSaltById(String m_email);
    public String CmGetSaltById(String cm_email);
    public int cmEmailChk(String cm_email);
    public int compNameChk(String cm_compname);
    public int cmEmailPassChk(Map<String,String> map);

}
