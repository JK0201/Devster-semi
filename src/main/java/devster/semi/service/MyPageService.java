package devster.semi.service;

import devster.semi.dto.CompanyMemberDto;
import devster.semi.mapper.MypageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyPageService implements MyPageServiceInter {
    @Autowired
    MypageMapper mypageMapper;

    @Override
    public CompanyMemberDto getOneDatabyCm_idx(int cm_idx) {
        return mypageMapper.getOneDatabyCm_idx(cm_idx);
    }
}
