package devster.semi.service;

import java.util.List;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.HireBoardDto;

import devster.semi.dto.QboardDto;


public interface HireServiceInter {

    public List<HireBoardDto> getAllPosts();
    public void insertHireBoard(HireBoardDto dto);
    public String getCompName(int hb_idx);
    public HireBoardDto getData(int hb_idx);
    public void updateReadCount(int hb_idx);

    public void deleteHireBoard(int hb_idx);

    public void updateHireBoard(HireBoardDto dto);
    public int getHireTotalCount();
    public List<HireBoardDto> getHirePagingList(int start, int perpage);


//    public void bookmarkHireBoard(HireBookmarkDto dto);
//    public HireBookmarkDto getBookmarkData(int m_idx, int hb_idx);
    public void addIncreasingBkmkInfo(int m_idx, int hb_idx);
    public void deleteBkmkInfo(int m_idx, int hb_idx);
    public boolean isAlreadyAddBkmk(int m_idx, int hb_idx);

    public List<HireBoardDto> searchlist(String keyword, int start, int perpage);
    public int countsearch(String keyword);


    public List<HireBoardDto> bestfreeboardPosts();


}
