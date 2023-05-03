package devster.semi.mapper;

import devster.semi.dto.AcademyInfoDto;
import devster.semi.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;

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
}
