package devster.semi.mapper;

import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface MypageMapper {
    public CompanyMemberDto getOneDatabyCm_idx(int cm_idx);
    public void deleteNormalUser(String m_email);
    public void deleteCompUser(String cm_email);
    public void updateAcaPhoto(MemberDto dto);
    public String checkAcaPhoto(int m_idx);
    public void updateDeafualtPhoto(int m_idx);
    public void updateProfile(MemberDto dto);
    public void updateProfileCm(CompanyMemberDto dto);

}
