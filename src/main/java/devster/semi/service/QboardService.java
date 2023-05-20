package devster.semi.service;


import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.QboardDto;
import devster.semi.mapper.QboardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class QboardService implements QboardServiceInter{
    @Autowired
    QboardMapper qboardMapper;
    @Override
    public List<QboardDto> getAllPosts() {
        return qboardMapper.getAllPosts();
    }

    @Override
    public void insertPost(QboardDto dto) {
        qboardMapper.insertPost(dto);
    }

    @Override
    public void deletePost(int qb_idx) {
        qboardMapper.deletePost(qb_idx);
    }

    @Override
    public void updatePost(QboardDto dto) {
        qboardMapper.updatePost(dto);
    }

    @Override
    public QboardDto getOnePost(int qb_idx) {
        return qboardMapper.getOnePost(qb_idx);
    }

    @Override

    public String selectNickNameOfQb_idx(int qb_idx) {
        return qboardMapper.selectNickNameOfQb_idx(qb_idx);
    }

    @Override
    public String selectPhotoOfQb_idx(int qb_idx) {
        return qboardMapper.selectPhotoOfQb_idx(qb_idx);

    }

    @Override
    public int getTotalCount() {
        return qboardMapper.getTotalCount();
    }

    @Override
    public List<QboardDto> getPagingList(int start,int perpage) {
        Map<String,Integer> map = new HashMap<>();
        map.put("start",start);
        map.put("perpage",perpage);
        return qboardMapper.getPagingList(map);
    }

    @Override
    public void updateReadCount(int qb_idx) {
        qboardMapper.updateReadCount(qb_idx);
    }

    @Override
    public void increaseLikeCount(int qb_idx) {
        qboardMapper.increaseLikeCount(qb_idx);
    }

    @Override
    public void increaseDislikeCount(int qb_idx) {
        qboardMapper.increaseDislikeCount(qb_idx);
    }

    @Override
    public List<FreeBoardDto> bestfreeboardPosts() {
        return qboardMapper.bestfreeboardPosts();
    }


    //좋아요 / 싫어요 관련 메서드들


    public void increaseGoodRp(int qb_idx) {
        qboardMapper.increaseGoodRp(qb_idx);
    }

    public void increaseBadRp(int qb_idx) {
        qboardMapper.increaseBadRp(qb_idx);
    }

    public void decreaseGoodRp(int qb_idx) {
        qboardMapper.decreaseGoodRp(qb_idx);
    }

    public void decreaseBadRp(int qb_idx) {
        qboardMapper.decreaseBadRp(qb_idx);
    }

    public int getGoodRpCount(int qb_idx) {
        return qboardMapper.getGoodRpCount(qb_idx);
    }

    public int getBadRpCount(int qb_idx) {
        return qboardMapper.getBadRpCount(qb_idx);
    }

    // reactionPoint 테이블에 좋아요/싫어요 로그 기록 관련 메서드
    public void addIncreasingGoodRpInfo(int qb_idx, int m_idx) {
        // 현재 게시물이 소속된 게시판 id를 가져옴
        Map<String,Integer> map = new HashMap<>();
        map.put("qb_idx",qb_idx);
        map.put("m_idx",m_idx);
        qboardMapper.addIncreasingGoodRpInfo(map);
    }

    public void deleteGoodRpInfo(int qb_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("qb_idx",qb_idx);
        map.put("m_idx",m_idx);
        qboardMapper.deleteGoodRpInfo(map);
    }

    public void addIncreasingBadRpInfo(int qb_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("qb_idx",qb_idx);
        map.put("m_idx",m_idx);
        qboardMapper.addIncreasingBadRpInfo(map);
    }

    public void deleteBadRpInfo(int qb_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("qb_idx",qb_idx);
        map.put("m_idx",m_idx);
        qboardMapper.deleteBadRpInfo(map);
    }

    public boolean isAlreadyAddGoodRp(int qb_idx,int m_idx) {
        // 좋아요 = 1, 싫어요 = 2, 취소 시 데이터 삭제
        // 현재 게시물에서, loginedm_idx의 pointTypeCode값이 1이면 좋아요 상태
        int getPointTypeCodeBym_idx = getRpInfoBym_idx(qb_idx, m_idx);

        if (getPointTypeCodeBym_idx == 1) {
            return true;
        }
        return false;
    }

    public boolean isAlreadyAddBadRp(int qb_idx,int m_idx) {
        // 좋아요 = 1, 싫어요 = 2, 취소 시 데이터 삭제
        // 현재 게시물에서, loginedm_idx의 pointTypeCode값이 2면 좋아요 상태
        int getPointTypeCodeBym_idx = getRpInfoBym_idx(qb_idx,m_idx);

        if (getPointTypeCodeBym_idx == 2) {
            return true;
        }
        return false;
    }

    @Override
    public int countComment(int qb_idx) {
        return qboardMapper.countComment(qb_idx);
    }

    @Override
    public List<QboardDto> bestQboardPosts() {
        return qboardMapper.bestQboardPosts();
    }

    // 검색
    @Override
    public List<QboardDto> searchlist(String searchOption, String keyword, int start, int perpage) {
        Map<String,Object> map = new HashMap<>();

        map.put("searchOption", searchOption);
        map.put("keyword", keyword);
        map.put("start", start);
        map.put("perpage", perpage);

        return qboardMapper.searchlist(map);
    }

    @Override
    public int countsearch(String searchOption, String keyword) {
        Map<String,Object> map = new HashMap<>();

        map.put("searchOption", searchOption);
        map.put("keyword", keyword);

        return qboardMapper.countsearch(map);
    }

    private Integer getRpInfoBym_idx(int qb_idx, int m_idx) {
        // 현재 사용자 id와 게시물 id로 좋아요/싫어요 기록을 가져옴
        Map<String,Integer> map = new HashMap<>();
        map.put("qb_idx",qb_idx);
        map.put("m_idx",m_idx);
        Integer getPointTypeCodeBym_idx = qboardMapper.getRpInfoBym_idx(map);
        if(getPointTypeCodeBym_idx == null) {
            getPointTypeCodeBym_idx = 0;
        }
        return (int)getPointTypeCodeBym_idx;
    }

}

