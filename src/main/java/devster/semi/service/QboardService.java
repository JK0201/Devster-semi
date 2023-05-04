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
    public String selectNickNameOfMidx(int qb_idx) {
        return qboardMapper.selectNickNameOfMidx(qb_idx);
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


}
