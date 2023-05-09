package devster.semi.service;

import devster.semi.dto.FreeBoardDto;
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

    @Override
    public int commentCnt(int fb_idx) {
        return freeBoardMapper.commentCnt(fb_idx);
    }

}
