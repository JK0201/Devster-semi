package devster.semi.mapper;

import devster.semi.dto.FreeBoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface FreeBoardMapper {
    public int getTotalCount();
    public List<FreeBoardDto> getPagingList(Map<String,Integer> map);
    public FreeBoardDto getData(int fb_idx);
    public void insertFreeBoard(FreeBoardDto dto);
    public void updateReadCount(int fb_idx);
    public void notUpdateReadCount(int fb_idx);
    public void deleteBoard(int fb_idx);
    public void updateBoard(FreeBoardDto dto);
    public String selectNickNameOfMidx(int fb_idx);
    public String selectPhotoOfMidx(int fb_idx);
    public int commentCnt(int fb_idx);
    public void increaseLikeCount(int fb_idx);
    public void increaseDislikeCount(int fb_idx);
    public List<FreeBoardDto> bestfreeboardPosts();

    //좋아요 / 싫어요 관련 메서드들
    public void increaseGoodRp(int fb_idx);
    public void increaseBadRp(int fb_idx);
    public void decreaseGoodRp(int fb_idx);
    public void decreaseBadRp(int fb_idx);
    public int getGoodRpCount(int fb_idx);
    public int getBadRpCount(int fb_idx);
    public void addIncreasingGoodRpInfo(Map<String,Integer> map);
    public void deleteGoodRpInfo(Map<String,Integer> map);
    public void addIncreasingBadRpInfo(Map<String,Integer> map);
    public void deleteBadRpInfo(Map<String,Integer> map);
    public Integer getRpInfoBym_idx(Map<String,Integer> map);

    // 검색
    public List<FreeBoardDto> searchlist(Map<String, Object> map);
    public int countsearch(Map<String, Object> map);

}
