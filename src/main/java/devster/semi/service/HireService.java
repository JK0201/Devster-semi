package devster.semi.service;

import devster.semi.dto.HireBoardDto;
import devster.semi.mapper.HireMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class HireService implements HireServiceInter{

    @Autowired
    HireMapper hireMapper;



    @Autowired
    public List<HireBoardDto> getAllPosts(){
        return hireMapper.getAllPosts();
    }

    @Override
    public void insertHireBoard(HireBoardDto dto) {
        // TODO Auto-generated method stub


        hireMapper.insertHireBoard(dto);
    }

    @Override
    public HireBoardDto getData(int hb_idx) {
        return hireMapper.getData(hb_idx);
    }

    @Override
    public void updateReadCount(int hb_idx) {
        hireMapper.updateReadCount(hb_idx);
    }

    @Override
    public void deleteHireBoard(int hb_idx) {
        hireMapper.deleteHireBoard(hb_idx);
    }


    @Override
    public void updateHireBoard(HireBoardDto dto) {
        hireMapper.updateHireBoard(dto);
    }

    @Override
    public int getHireTotalCount() {
    return hireMapper.getHireTotalCount();
    }

    @Override
    public List<HireBoardDto> getHirePagingList(int start,int perpage) {
    Map<String,Integer> map = new HashMap<>();
    map.put("start",start);
    map.put("perpage",perpage);
    return hireMapper.getHirePagingList(map);
    }


//    @Override
//    public void bookmarkHireBoard(HireBookmarkDto dto) {hireMapper.bookmarkHireBoard(dto);}
//
//    @Override
//    public HireBookmarkDto getBookmarkData(int m_idx, int hb_idx) { return hireMapper.getBookmarkData(m_idx, hb_idx);}

    public void addIncreasingBkmkInfo(int m_idx, int hb_idx) {
        // 현재 게시물이 소속된 게시판 id를 가져옴
        Map<String,Integer> map = new HashMap<>();
        map.put("m_idx",m_idx);
        map.put("hb_idx",hb_idx);
        hireMapper.addIncreasingBkmkInfo(map);
    }

    public void deleteBkmkInfo(int m_idx, int hb_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("m_idx",m_idx);
        map.put("hb_idx",hb_idx);
        hireMapper.deleteBkmkInfo(map);
    }

    public boolean isAlreadyAddBkmk(int m_idx,int hb_idx) {
        int getBkmkPointTypeCodeBym_idx = getBkmkInfoBym_idx(m_idx, hb_idx);

        if (getBkmkPointTypeCodeBym_idx == 1) {
            return true;
        }
        return false;
    }

    private Integer getBkmkInfoBym_idx(int m_idx, int hb_idx) {
        Map<String, Integer> map = new HashMap<>();
        map.put("m_idx", m_idx);
        map.put("hb_idx", hb_idx);
        Integer getBkmkPointTypeCodeBym_idx = hireMapper.getBkmkInfoBym_idx(map);
        if (getBkmkPointTypeCodeBym_idx == null) {
            getBkmkPointTypeCodeBym_idx = 0;
        }
        return (int) getBkmkPointTypeCodeBym_idx;
    }
    // 검색
    @Override
    public List<HireBoardDto> searchlist(String keyword, int start, int perpage) {
        Map<String,Object> map = new HashMap<>();

        map.put("keyword", keyword);
        map.put("start", start);
        map.put("perpage", perpage);

        return hireMapper.searchlist(map);
    }

    @Override
    public int countsearch(String keyword) {
        return hireMapper.countsearch(keyword);

    }

}


