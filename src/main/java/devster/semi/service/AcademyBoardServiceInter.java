package devster.semi.service;

import devster.semi.dto.AcademyBoardDto;
import devster.semi.dto.FreeBoardDto;

import java.util.List;

public interface AcademyBoardServiceInter {

    public int getTotalCount();
    public List<AcademyBoardDto> getPagingList(int start, int perpage);
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
    public void addIncreasingGoodRpInfo(int ab_idx, int m_idx);
    public void deleteGoodRpInfo(int ab_idx, int m_idx);
    public void addIncreasingBadRpInfo(int ab_idx, int m_idx);
    public void deleteBadRpInfo(int ab_idx, int m_idx);
    public boolean isAlreadyAddGoodRp(int ab_idx, int m_idx);
    public boolean isAlreadyAddBadRp(int ab_idx, int m_idx);
    public String selectAcademyName(int ab_idx);

}
