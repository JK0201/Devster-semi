package devster.semi.service;

import devster.semi.dto.NoticeBoardDto;
import devster.semi.mapper.NoticeBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NoticeBoardService implements NoticeBoardServiceInter{

    @Autowired
    private NoticeBoardMapper noticeBoardMapper;

    @Override
    public int getTotalCount() {
        return noticeBoardMapper.getTotalCount();
    }

    @Override
    public List<NoticeBoardDto> getPagingList(int start, int perpage) {

        Map<String, Integer> map = new HashMap<>();
        map.put("start", start);
        map.put("perpage", perpage);

        return noticeBoardMapper.getPagingList(map);
    }

    @Override
    public NoticeBoardDto getData(int nb_idx) {
        return noticeBoardMapper.getData(nb_idx);
    }

    @Override
    public void insertBoard(NoticeBoardDto dto) {

        noticeBoardMapper.insertBoard(dto);

    }

    @Override
    public void updateReadCount(int nb_idx) {
        noticeBoardMapper.updateReadCount(nb_idx);
    }

    @Override
    public void deleteBoard(int nb_idx) {
        noticeBoardMapper.deleteBoard(nb_idx);
    }

    @Override
    public void updateBoard(NoticeBoardDto dto) {
        noticeBoardMapper.updateBoard(dto);
    }

/*
    @Override
    public String selectNickNameOfMstate(int nb_idx) {
        return noticeBoardMapper.selectNickNameOfMstate(nb_idx);
    }
*/

    @Override
    public List<NoticeBoardDto> getTopThree() {
        return noticeBoardMapper.getTopThree();
    }
}
