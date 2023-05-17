package devster.semi.service;

import devster.semi.dto.AcademyInfoDto;
import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.MemberDto;
import devster.semi.dto.MessageDto;

import java.util.ArrayList;
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

    public CompanyMemberDto getCmOneData(String cm_email);

    public List<AcademyInfoDto> searchAcaInfo(String ai_name);

    public int getAcademyIdx(String ai_name);

    public void addNewMember(MemberDto dto);

    public void addNewCMemeber(CompanyMemberDto dto);

    public String getSaltById(String m_email);

    public String CmGetSaltById(String cm_email);

    public int cmEmailChk(String cm_email);

    public int compNameChk(String cm_compname);

    public int cmEmailPassChk(String cm_email, String cm_pass);
    public MemberDto getOneDataByM_idx(int m_idx);
    public String getAcaNameByAi_idx(int ai_idx);

    public int NPCheck(String m_name, String m_tele);

    public List<MemberDto> NPGetList(String m_name, String m_tele);

    public int cNPCheck(String cm_name, String cm_cp);

    public List<CompanyMemberDto> cNPGetList(String cm_name, String cm_cp);

    public int pFindCheck(String m_email, String m_name, String m_tele);

    public int eFindCheck(String m_email, String m_name);

    public void updatePass(String m_email, String m_name, String m_pass, String salt);

    public int CPFindCheck(String cm_email, String cm_name, String cm_cp);

    public void CUpdatePass(String cm_email, String cm_name, String cm_pass, String salt);

    public int CEFindCheck(String cm_email, String cm_name);
    public int compRegChk(String cm_reg);

    public void testupdate(String m_photo);

    public String getphoto(int m_idx);

}
