package devster.semi.mapper;

import devster.semi.dto.NoticeBoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface NoticeBoardMapper {
    public int getTotalCount();

    public List<NoticeBoardDto> getPagingList(Map<String, Integer> map); //map:start,perpage

    public NoticeBoardDto getData(int nb_idx);

    public void insertBoard(NoticeBoardDto dto);

    public void updateReadCount(int nb_idx);

    public void deleteBoard(int nb_idx);

    public void updateBoard(NoticeBoardDto dto);

    /*public String selectNickNameOfMstate(int nb_idx);*/


    public List<NoticeBoardDto> getTopThree();
}
