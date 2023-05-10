package devster.semi.mapper;

import devster.semi.dto.CompanyMemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MypageMapper {
    public CompanyMemberDto getOneDatabyCm_idx(int cm_idx);

}
