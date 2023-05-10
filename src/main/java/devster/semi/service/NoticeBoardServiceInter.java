package devster.semi.service;

import devster.semi.dto.NoticeBoardDto;

import java.util.List;
import java.util.Map;

public interface NoticeBoardServiceInter {

    public int getTotalCount();

    public List<NoticeBoardDto> getPagingList(int start, int perpage); //map:start,perpage

    public NoticeBoardDto getData(int nb_idx);

    public void insertBoard(NoticeBoardDto dto);

    public void updateReadCount(int nb_idx);

    public void deleteBoard(int nb_idx);

    public void updateBoard(NoticeBoardDto dto);

    public String selectNickNameOfMstate(int nb_idx);

    public List<NoticeBoardDto> getTopThree();
}
