package devster.semi.mapper;

import devster.semi.dto.FreeBoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface FreeBoardMapper {
    public int getTotalCount();
    public List<FreeBoardDto> getPagingList(Map<String,Integer> map);
    public FreeBoardDto getData(int fb_idx);
    public void insertFreeBoard(FreeBoardDto dto);
    public void updateReadCount(int fb_idx);
    public void notUpdateReadCount(int fb_idx);
    public void deleteBoard(int fb_idx);
    public void updateBoard(FreeBoardDto dto);
    public String selectNickNameOfMidx(int fb_idx);
    public String selectPhotoOfMidx(int fb_idx);
    public void increaseLikeCount(int fb_idx);
    public void increaseDislikeCount(int fb_idx);
    public int commentCnt(int fb_idx);

}
