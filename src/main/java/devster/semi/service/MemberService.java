package devster.semi.service;

import devster.semi.dto.AcademyInfoDto;
import devster.semi.dto.MemberDto;
import devster.semi.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MemberService implements MemberServiceInter {
    @Autowired
    private MemberMapper memberMapper;

    @Override
    public List<AcademyInfoDto> listAcademyInfo() {
        return memberMapper.listAcademyInfo();
    }

    @Override
    public int emailChk(String m_email) {
        return memberMapper.emailChk(m_email);
    }

    @Override
    public int apichk(String m_email) {
        return memberMapper.apichk(m_email);
    }

    @Override
    public int nickNameChk(String m_nickname) {
        return memberMapper.nickNameChk(m_nickname);
    }

    @Override
    public int emailpasschk(String m_email, String m_pass) {
        Map<String, String> map = new HashMap<>();
        map.put("m_email", m_email);
        map.put("m_pass", m_pass);
        int chk = memberMapper.emailpasschk(map);
        return chk;
    }

    @Override
    public MemberDto getOneData(String m_email) {
        MemberDto dto = memberMapper.getOneData(m_email);
        return dto;
    }

    @Override
    public void dailyPoint(String m_email) {
        memberMapper.dailyPoint(m_email);
    }

    @Override
    public List<AcademyInfoDto> searchAcaInfo(String ai_name) {
        return memberMapper.searchAcaInfo(ai_name);
    }

    @Override
    public int getAcademyIdx(String ai_name) {
        return memberMapper.getAcademyIdx(ai_name);
    }

    @Override
    public void addNewMember(MemberDto dto) {
        memberMapper.addNewMember(dto);
    }

    @Override
    public String getSaltById(String m_email) {
        return memberMapper.getSaltById(m_email);
    }
}
