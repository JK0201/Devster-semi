package devster.semi.mapper;

import java.util.List;
import java.util.Map;

import devster.semi.dto.HireBoardDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HireMapper {

    public List<HireBoardDto> getAllPosts();
    public void insertHireBoard(HireBoardDto dto);
    public HireBoardDto getData(int hb_idx);
    public void updateReadCount(int hb_idx);
    public void deleteHireBoard(int hb_idx);
}
