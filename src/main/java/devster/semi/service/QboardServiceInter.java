package devster.semi.service;


import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.QboardDto;

import java.util.List;
import java.util.Map;

public interface QboardServiceInter {
    public List<QboardDto> getAllPosts();
    public void insertPost(QboardDto dto);
    public void deletePost(int qb_idx);
    public void updatePost(QboardDto dto);
    public QboardDto getOnePost(int qb_idx);

    public String selectNickNameOfQb_idx(int qb_idx);
    public String selectPhotoOfQb_idx(int qb_idx);
    public int getTotalCount();
    public List<QboardDto> getPagingList(int start,int perpage);
    public void updateReadCount(int qb_idx);
    public void increaseLikeCount(int qb_idx);
    public void increaseDislikeCount(int qb_idx);
    public List<FreeBoardDto> bestfreeboardPosts();
    public void increaseGoodRp(int qb_idx);
    public void increaseBadRp(int qb_idx);
    public void decreaseGoodRp(int qb_idx);
    public void decreaseBadRp(int qb_idx);
    public int getGoodRpCount(int qb_idx);
    public int getBadRpCount(int qb_idx);
    public void addIncreasingGoodRpInfo(int qb_idx, int m_idx);
    public void deleteGoodRpInfo(int qb_idx, int m_idx);
    public void addIncreasingBadRpInfo(int qb_idx, int m_idx);
    public void deleteBadRpInfo(int qb_idx, int m_idx);
    public boolean isAlreadyAddGoodRp(int qb_idx, int m_idx);
    public boolean isAlreadyAddBadRp(int qb_idx, int m_idx);
}
