package devster.semi.service;

import devster.semi.dto.AcademyInfoDto;
import devster.semi.dto.CompanyMemberDto;
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
    public CompanyMemberDto getCmOneData(String cm_email) {
        CompanyMemberDto dto = memberMapper.getCmOneData(cm_email);
        return dto;
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

    public String CmGetSaltById(String cm_email) {
        return memberMapper.CmGetSaltById(cm_email);
    }

    @Override
    public int cmEmailChk(String cm_email) {
        return memberMapper.cmEmailChk(cm_email);
    }

    @Override
    public int compNameChk(String cm_compname) {
        return memberMapper.compNameChk(cm_compname);
    }

    @Override
    public void addNewCMemeber(CompanyMemberDto dto) {
        memberMapper.addNewCMemeber(dto);
    }

    @Override
    public void addDummyCMember(CompanyMemberDto dto) {
        memberMapper.addDummyCMember(dto);
    }

    @Override
    public int cmEmailPassChk(String cm_email, String cm_pass) {
        Map<String, String> map = new HashMap<>();
        map.put("cm_email", cm_email);
        map.put("cm_pass", cm_pass);
        int chk = memberMapper.cmEmailPassChk(map);
        return chk;
    }

    @Override
    public MemberDto getOneDataByM_idx(int m_idx) {
        return memberMapper.getOneDataByM_idx(m_idx);
    }

    @Override
    public String getAcaNameByAi_idx(int ai_idx) {
        return memberMapper.getAcaNameByAi_idx(ai_idx);
    }
    @Override
    public int NPCheck(String m_name, String m_tele) {
        Map<String, String> map = new HashMap<>();
        map.put("m_name", m_name);
        map.put("m_tele", m_tele);
        int chk = memberMapper.NPCheck(map);

        return chk;
    }

    @Override
    public List<MemberDto> NPGetList(String m_name, String m_tele) {
        Map<String, String> map = new HashMap<>();
        map.put("m_name", m_name);
        map.put("m_tele", m_tele);
        List<MemberDto> list = memberMapper.NPGetList(map);

        return list;
    }

    @Override
    public int cNPCheck(String cm_name, String cm_cp, String cm_reg) {
        Map<String, String> map = new HashMap<>();
        map.put("cm_name", cm_name);
        map.put("cm_cp", cm_cp);
        map.put("cm_reg",cm_reg);
        int chk = memberMapper.cNPCheck(map);

        return chk;
    }

    @Override
    public List<CompanyMemberDto> cNPGetList(String cm_name, String cm_cp) {
        Map<String, String> map = new HashMap<>();
        map.put("cm_name", cm_name);
        map.put("cm_cp", cm_cp);
        List<CompanyMemberDto> list = memberMapper.cNPGetList(map);

        return list;
    }

    @Override
    public int pFindCheck(String m_email, String m_name, String m_tele) {
        Map<String, String> map = new HashMap<>();
        map.put("m_email", m_email);
        map.put("m_name", m_name);
        map.put("m_tele", m_tele);
        int chk = memberMapper.pFindCheck(map);

        return chk;
    }

    @Override
    public int eFindCheck(String m_email, String m_name) {
        Map<String, String> map = new HashMap<>();
        map.put("m_email", m_email);
        map.put("m_name", m_name);
        int chk = memberMapper.eFindCheck(map);

        return chk;
    }

    @Override
    public void updatePass(String m_email, String m_name, String m_pass, String salt) {
        Map<String, String> map = new HashMap<>();
        map.put("m_email", m_email);
        map.put("m_name", m_name);
        map.put("m_pass", m_pass);
        map.put("salt", salt);

        memberMapper.updatePass(map);
    }

    @Override
    public int CPFindCheck(String cm_email, String cm_name, String cm_cp) {
        Map<String, String> map = new HashMap<>();
        map.put("cm_email", cm_email);
        map.put("cm_name", cm_name);
        map.put("cm_cp", cm_cp);
        int chk = memberMapper.CPFindCheck(map);

        return chk;
    }

    @Override
    public void CUpdatePass(String cm_email, String cm_name, String cm_pass, String salt) {
        Map<String, String> map = new HashMap<>();
        map.put("cm_email", cm_email);
        map.put("cm_name", cm_name);
        map.put("cm_pass", cm_pass);
        map.put("salt", salt);
        System.out.println(map);

        memberMapper.CUpdatePass(map);
    }

    @Override
    public int CEFindCheck(String cm_email, String cm_name) {
        Map<String, String> map = new HashMap<>();
        map.put("cm_email", cm_email);
        map.put("cm_name", cm_name);

        int chk = memberMapper.CEFindCheck(map);

        return chk;
    }

    @Override
    public int compRegChk(String cm_reg) {
        return memberMapper.compRegChk(cm_reg);
    }

    @Override
    public void testupdate(String m_photo) {
        memberMapper.testupdate(m_photo);
    }

    @Override
    public String getphoto(int m_idx) {
        return memberMapper.getphoto(m_idx);
    }

    @Override
    public int chkAcademyIdx(String ai_name) {
        return memberMapper.chkAcademyIdx(ai_name);
    }
}
