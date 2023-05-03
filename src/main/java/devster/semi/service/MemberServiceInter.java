package devster.semi.service;

import devster.semi.dto.AcademyInfoDto;
import devster.semi.dto.MemberDto;

import java.util.List;
import java.util.Map;

public interface MemberServiceInter {
    public List<AcademyInfoDto> listAcademyInfo();

    public int emailChk(String m_email);

    public int apichk(String m_email);

    public int nickNameChk(String m_nickname);

    public int emailpasschk(String m_email, String m_pass);

    public void dailyPoint(String m_email);

    public MemberDto getOneData(String m_email);

}
