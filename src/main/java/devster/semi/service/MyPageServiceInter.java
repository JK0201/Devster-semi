package devster.semi.service;

import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.MemberDto;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface MyPageServiceInter {
    public CompanyMemberDto getOneDatabyCm_idx(int cm_idx);
    public void deleteNormalUser(String m_email);
    public void deleteCompUser(String cm_email);
    public void updateAcaPhoto(MemberDto dto);
    public String checkAcaPhoto(int m_idx);
    public void updateDeafualtPhoto(int m_idx);
    public void updateProfile(MemberDto dto);
    public void updateProfileCm(CompanyMemberDto dto);


}
