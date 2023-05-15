package devster.semi.mapper;

import java.util.List;
import java.util.Map;

import devster.semi.dto.HireBoardDto;

import devster.semi.dto.QboardDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HireMapper {

    public List<HireBoardDto> getAllPosts();
    public void insertHireBoard(HireBoardDto dto);
    public HireBoardDto getData(int hb_idx);
    public void updateReadCount(int hb_idx);
    public void deleteHireBoard(int hb_idx);



    public void updateHireBoard(HireBoardDto dto);

    public int getHireTotalCount();
    public List<HireBoardDto> getHirePagingList(Map<String,Integer> map);

    // 검색
    public List<HireBoardDto> searchlist(Map<String, Object> map);
    public int countsearch(String keyword); // keyword만 파라미터로

}
