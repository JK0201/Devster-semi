package devster.semi.service;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.FreeCommentDto;
import devster.semi.mapper.FreeBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FreeBoardService implements FreeBoardServiceInter{

    @Autowired
    private FreeBoardMapper freeBoardMapper;

    @Override
    public int getTotalCount() {
        return freeBoardMapper.getTotalCount();
    }

    @Override
    public List<FreeBoardDto> getPagingList(int start, int perpage) {

        Map<String, Integer> map = new HashMap<>();
        map.put("start", start);
        map.put("perpage", perpage);

        return freeBoardMapper.getPagingList(map);
    }

    @Override
    public FreeBoardDto getData(int fb_idx) {
        return freeBoardMapper.getData(fb_idx);
    }

    @Override
    public void insertFreeBoard(FreeBoardDto dto) {

        freeBoardMapper.insertFreeBoard(dto);
    }

    @Override
    public void updateReadCount(int fb_idx) {
        freeBoardMapper.updateReadCount(fb_idx);
    }
    public void notUpdateReadCount(int fb_idx) {freeBoardMapper.notUpdateReadCount(fb_idx);}

    @Override
    public void deleteBoard(int fb_idx) {
        freeBoardMapper.deleteBoard(fb_idx);
    }

    @Override
    public void updateBoard(FreeBoardDto dto) {

        freeBoardMapper.updateBoard(dto);
    }

    @Override
    public String selectNickNameOfMidx(int fb_idx) {
        return freeBoardMapper.selectNickNameOfMidx(fb_idx);
    }

    @Override
    public String selectPhotoOfMidx(int fb_idx) {
        return freeBoardMapper.selectPhotoOfMidx(fb_idx);
    }

    @Override
    public void increaseLikeCount(int fb_idx) {
        freeBoardMapper.increaseLikeCount(fb_idx);
    }

    @Override
    public void increaseDislikeCount(int fb_idx) {
        freeBoardMapper.increaseDislikeCount(fb_idx);
    }

    //좋아요 / 싫어요 관련 메서드들
    @Override
    public void increaseGoodRp(int fb_idx) {
        freeBoardMapper.increaseGoodRp(fb_idx);
    }

    @Override
    public void increaseBadRp(int fb_idx) {
        freeBoardMapper.increaseBadRp(fb_idx);
    }

    @Override
    public void decreaseGoodRp(int fb_idx) {
        freeBoardMapper.decreaseGoodRp(fb_idx);
    }

    @Override
    public void decreaseBadRp(int fb_idx) {
        freeBoardMapper.decreaseBadRp(fb_idx);
    }

    @Override
    public int getGoodRpCount(int fb_idx) {
        return freeBoardMapper.getGoodRpCount(fb_idx);
    }

    @Override
    public int getBadRpCount(int fb_idx) {
        return freeBoardMapper.getBadRpCount(fb_idx);
    }

    @Override
    public void addIncreasingGoodRpInfo(int fb_idx, int m_idx) {
        // 현재 게시물이 소속된 게시판 id를 가져옴
        Map<String,Integer> map = new HashMap<>();
        map.put("fb_idx",fb_idx);
        map.put("m_idx",m_idx);
        freeBoardMapper.addIncreasingGoodRpInfo(map);

    }

    @Override
    public void deleteGoodRpInfo(int fb_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("fb_idx",fb_idx);
        map.put("m_idx",m_idx);
        freeBoardMapper.deleteGoodRpInfo(map);

    }

    @Override
    public void addIncreasingBadRpInfo(int fb_idx, int m_idx) {

        Map<String,Integer> map = new HashMap<>();
        map.put("fb_idx",fb_idx);
        map.put("m_idx",m_idx);
        freeBoardMapper.addIncreasingBadRpInfo(map);
    }

    @Override
    public void deleteBadRpInfo(int fb_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("fb_idx",fb_idx);
        map.put("m_idx",m_idx);
        freeBoardMapper.deleteBadRpInfo(map);

    }

    @Override
    public boolean isAlreadyAddGoodRp(int fb_idx, int m_idx) {
        // 좋아요 = 1, 싫어요 = 2, 취소 시 데이터 삭제
        // 현재 게시물에서, loginedm_idx의 pointTypeCode값이 1이면 좋아요 상태
        int getPointTypeCodeBym_idx = getRpInfoBym_idx(fb_idx, m_idx);

        if (getPointTypeCodeBym_idx == 1) {
            return true;
        }
        return false;
    }

    @Override
    public boolean isAlreadyAddBadRp(int fb_idx, int m_idx) {
        // 좋아요 = 1, 싫어요 = 2, 취소 시 데이터 삭제
        // 현재 게시물에서, loginedm_idx의 pointTypeCode값이 2면 좋아요 상태
        int getPointTypeCodeBym_idx = getRpInfoBym_idx(fb_idx,m_idx);

        if (getPointTypeCodeBym_idx == 2) {
            return true;
        }
        return false;
    }

    @Override
    public List<FreeBoardDto> bestfreeboardPosts() {
        return freeBoardMapper.bestfreeboardPosts();
    }

    private Integer getRpInfoBym_idx(int fb_idx, int m_idx) {
        // 현재 사용자 id와 게시물 id로 좋아요/싫어요 기록을 가져옴
        Map<String,Integer> map = new HashMap<>();
        map.put("fb_idx",fb_idx);
        map.put("m_idx",m_idx);
        Integer getPointTypeCodeBym_idx = freeBoardMapper.getRpInfoBym_idx(map);
        if(getPointTypeCodeBym_idx == null) {
            getPointTypeCodeBym_idx = 0;
        }
        return (int)getPointTypeCodeBym_idx;
    }
    
    @Override
    public int commentCnt(int fb_idx) {
        return freeBoardMapper.commentCnt(fb_idx);
    }

}
