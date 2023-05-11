package devster.semi.service;

import devster.semi.dto.CompanyMemberDto;
import devster.semi.dto.MemberDto;
import devster.semi.mapper.MypageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Service
public class MyPageService implements MyPageServiceInter {
    @Autowired
    MypageMapper mypageMapper;

    @Override
    public CompanyMemberDto getOneDatabyCm_idx(int cm_idx) {
        return mypageMapper.getOneDatabyCm_idx(cm_idx);
    }

    @Override
    public void deleteNormalUser(String m_email) {
        mypageMapper.deleteNormalUser(m_email);
    }

    @Override
    public void deleteCompUser(String cm_email) {
        mypageMapper.deleteCompUser(cm_email);
    }

    @Override
    public void updateAcaPhoto(MemberDto dto) {
        mypageMapper.updateAcaPhoto(dto);
    }

    @Override
    public String checkAcaPhoto(int m_idx) {
        return mypageMapper.checkAcaPhoto(m_idx);
    }

    @Override
    public void updateDeafualtPhoto(int m_idx) {
        mypageMapper.updateDeafualtPhoto(m_idx);
    }

    @Override
    public void updateProfile(MemberDto dto) {
        mypageMapper.updateProfile(dto);
    }

    @Override
    public void updateProfileCm(CompanyMemberDto dto) {
        mypageMapper.updateProfileCm(dto);
    }


}
