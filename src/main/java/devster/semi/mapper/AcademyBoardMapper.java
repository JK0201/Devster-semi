package devster.semi.mapper;

import devster.semi.dto.AcademyBoardDto;
import devster.semi.dto.FreeBoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AcademyBoardMapper {
    public int getTotalCount();
    public int getCommentCnt(int ab_idx);
    public List<AcademyBoardDto> getPagingList(Map<String,Integer> map);
    public AcademyBoardDto getData(int ab_idx);
    public void updateReadCount(int ab_idx);
    public String selectNickName2OfMidx(int ab_idx);
    public String selectPhoto2OfMidx(int ab_idx);

    public void insertAcademyBoard(AcademyBoardDto dto);

    public String selectNickNameOfMidx(int ab_idx);
    public String selectPhotoOfMidx(int ab_idx);

    public void deleteAcademyBoard(int ab_idx);

    public void updateAcademyBoard(AcademyBoardDto dto);

    public void increaseGoodRp(int ab_idx);
    public void increaseBadRp(int ab_idx);
    public void decreaseGoodRp(int ab_idx);
    public void decreaseBadRp(int ab_idx);
    public int getGoodRpCount(int ab_idx);
    public int getBadRpCount(int ab_idx);


    public boolean isAlreadyAddGoodRp(int ab_idx, int m_idx);
    public boolean isAlreadyAddBadRp(int ab_idx, int m_idx);


    public void addIncreasingGoodRpInfo(Map<String,Integer> map);
    public void deleteGoodRpInfo(Map<String,Integer> map);
    public void addIncreasingBadRpInfo(Map<String,Integer> map);
    public void deleteBadRpInfo(Map<String,Integer> map);
    public Integer getRpInfoBym_idx(Map<String,Integer> map);

    public String selectAcademyName(int ab_idx);
    public int commentCnt(int ab_idx);

    // 검색
    public List<AcademyBoardDto> searchlist(Map<String, Object> map);
    public int countsearch(Map<String, Object> map);


}
