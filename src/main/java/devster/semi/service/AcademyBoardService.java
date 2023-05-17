package devster.semi.service;

import devster.semi.dto.AcademyBoardDto;
import devster.semi.dto.FreeBoardDto;
import devster.semi.mapper.AcademyBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AcademyBoardService implements AcademyBoardServiceInter{

    @Autowired
    private AcademyBoardMapper academyBoardMapper;

    @Override
    public int getTotalCount() {
        return academyBoardMapper.getTotalCount();
    }

    @Override
    public int getCommentCnt(int ab_idx) { return academyBoardMapper.getCommentCnt(ab_idx); }

    @Override
    public List<AcademyBoardDto> getPagingList(int start, int perpage) {

        Map<String, Integer> map = new HashMap<>();
        map.put("start", start);
        map.put("perpage", perpage);

        return academyBoardMapper.getPagingList(map);
    }

    @Override
    public AcademyBoardDto getData(int ab_idx) {
        return academyBoardMapper.getData(ab_idx);
    }

    @Override
    public void updateReadCount(int ab_idx) {
        academyBoardMapper.updateReadCount(ab_idx);
        }


    @Override
    public String selectNickName2OfMidx(int ab_idx) {
        return academyBoardMapper.selectNickName2OfMidx(ab_idx);
        }


    @Override
    public String selectPhoto2OfMidx(int ab_idx) {
        return academyBoardMapper.selectPhoto2OfMidx(ab_idx);
        }


    @Override
    public void insertAcademyBoard(AcademyBoardDto dto) {

        academyBoardMapper.insertAcademyBoard(dto);
    }


    @Override
    public String selectNickNameOfMidx(int ab_idx) {
        return academyBoardMapper.selectNickNameOfMidx(ab_idx);
    }

    @Override
    public String selectPhotoOfMidx(int ab_idx) {
        return academyBoardMapper.selectPhotoOfMidx(ab_idx);
    }


    @Override
    public void deleteAcademyBoard(int ab_idx) {
        academyBoardMapper.deleteAcademyBoard(ab_idx);
    }

    @Override
    public void updateAcademyBoard(AcademyBoardDto dto) {

        academyBoardMapper.updateAcademyBoard(dto);
    }

//    @Override
//    public void increaseLikeCount(int ab_idx) {
//        academyBoardMapper.increaseLikeCount(ab_idx);
//    }
//
//    @Override
//    public void increaseDislikeCount(int ab_idx) {
//        academyBoardMapper.increaseDislikeCount(ab_idx);
//    }

    //좋아요 / 싫어요 관련 메서드들
    @Override
    public void increaseGoodRp(int ab_idx) {
        academyBoardMapper.increaseGoodRp(ab_idx);
    }

    @Override
    public void increaseBadRp(int ab_idx) {
        academyBoardMapper.increaseBadRp(ab_idx);
    }

    @Override
    public void decreaseGoodRp(int ab_idx) {
        academyBoardMapper.decreaseGoodRp(ab_idx);
    }

    @Override
    public void decreaseBadRp(int ab_idx) {
        academyBoardMapper.decreaseBadRp(ab_idx);
    }

    @Override
    public int getGoodRpCount(int ab_idx) {
        return academyBoardMapper.getGoodRpCount(ab_idx);
    }

    @Override
    public int getBadRpCount(int ab_idx) {
        return academyBoardMapper.getBadRpCount(ab_idx);
    }

    @Override
    public void addIncreasingGoodRpInfo(int ab_idx, int m_idx) {
        // 현재 게시물이 소속된 게시판 id를 가져옴
        Map<String,Integer> map = new HashMap<>();
        map.put("ab_idx",ab_idx);
        map.put("m_idx",m_idx);
        academyBoardMapper.addIncreasingGoodRpInfo(map);

    }

    @Override
    public void deleteGoodRpInfo(int ab_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("ab_idx",ab_idx);
        map.put("m_idx",m_idx);
        academyBoardMapper.deleteGoodRpInfo(map);

    }

    @Override
    public void addIncreasingBadRpInfo(int ab_idx, int m_idx) {

        Map<String,Integer> map = new HashMap<>();
        map.put("ab_idx",ab_idx);
        map.put("m_idx",m_idx);
        academyBoardMapper.addIncreasingBadRpInfo(map);
    }

    @Override
    public void deleteBadRpInfo(int ab_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("ab_idx",ab_idx);
        map.put("m_idx",m_idx);
        academyBoardMapper.deleteBadRpInfo(map);

    }

    @Override
    public boolean isAlreadyAddGoodRp(int ab_idx, int m_idx) {
        // 좋아요 = 1, 싫어요 = 2, 취소 시 데이터 삭제
        // 현재 게시물에서, loginedm_idx의 pointTypeCode값이 1이면 좋아요 상태
        int getPointTypeCodeBym_idx = getRpInfoBym_idx(ab_idx, m_idx);

        if (getPointTypeCodeBym_idx == 1) {
            return true;
        }
        return false;
    }

    @Override
    public boolean isAlreadyAddBadRp(int ab_idx, int m_idx) {
        // 좋아요 = 1, 싫어요 = 2, 취소 시 데이터 삭제
        // 현재 게시물에서, loginedm_idx의 pointTypeCode값이 2면 좋아요 상태
        int getPointTypeCodeBym_idx = getRpInfoBym_idx(ab_idx,m_idx);

        if (getPointTypeCodeBym_idx == 2) {
            return true;
        }
        return false;
    }

    private Integer getRpInfoBym_idx(int ab_idx, int m_idx) {
        // 현재 사용자 id와 게시물 id로 좋아요/싫어요 기록을 가져옴
        Map<String,Integer> map = new HashMap<>();
        map.put("ab_idx",ab_idx);
        map.put("m_idx",m_idx);
        Integer getPointTypeCodeBym_idx = academyBoardMapper.getRpInfoBym_idx(map);
        if(getPointTypeCodeBym_idx == null) {
            getPointTypeCodeBym_idx = 0;
        }
        return (int)getPointTypeCodeBym_idx;
    }

    @Override
    public String selectAcademyName(int ab_idx) {return academyBoardMapper.selectAcademyName(ab_idx);}

    @Override
    public int commentCnt(int ab_idx) {
        return academyBoardMapper.commentCnt(ab_idx);
    }


    //    검색
    @Override
    public List<AcademyBoardDto> searchlist(String searchOption, String keyword, int start, int perpage) {
        Map<String,Object> map = new HashMap<>();

        map.put("searchOption", searchOption);
        map.put("keyword", keyword);
        map.put("start", start);
        map.put("perpage", perpage);

        return academyBoardMapper.searchlist(map);
    }

    @Override
    public int countsearch(String searchOption, String keyword) {
        Map<String,Object> map = new HashMap<>();

        map.put("searchOption", searchOption);
        map.put("keyword", keyword);

        return academyBoardMapper.countsearch(map);
    }

}



