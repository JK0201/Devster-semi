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
        int chk = memberMapper.emailChk(m_email);
        return chk;
    }

    @Override
    public int apichk(String m_email) {
        int chk=memberMapper.apichk(m_email);
        return chk;
    }

    @Override
    public int nickNameChk(String m_nickname) {
        int chk = memberMapper.nickNameChk(m_nickname);
        return chk;//eong
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
}
