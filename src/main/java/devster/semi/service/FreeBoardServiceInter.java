package devster.semi.service;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.FreeCommentDto;

import java.util.List;
import java.util.Map;

public interface FreeBoardServiceInter {
    public int getTotalCount();
    public List<FreeBoardDto> getPagingList(int start, int perpage);
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

    public void increaseGoodRp(int fb_idx);
    public void increaseBadRp(int fb_idx);
    public void decreaseGoodRp(int fb_idx);
    public void decreaseBadRp(int fb_idx);
    public int getGoodRpCount(int fb_idx);
    public int getBadRpCount(int fb_idx);
    public void addIncreasingGoodRpInfo(int fb_idx, int m_idx);
    public void deleteGoodRpInfo(int fb_idx, int m_idx);
    public void addIncreasingBadRpInfo(int fb_idx, int m_idx);
    public void deleteBadRpInfo(int fb_idx, int m_idx);
    public boolean isAlreadyAddGoodRp(int fb_idx, int m_idx);
    public boolean isAlreadyAddBadRp(int fb_idx, int m_idx);

    public List<FreeBoardDto> bestfreeboardPosts();

    // 검색
    public List<FreeBoardDto> searchlist(String searchOption, String keyword, int start, int perpage);
    public int countsearch(String searchOption, String keyword);

}
