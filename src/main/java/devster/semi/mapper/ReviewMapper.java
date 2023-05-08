package devster.semi.mapper;

import devster.semi.dto.CompanyinfoDto;
import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.QboardDto;
import devster.semi.dto.ReviewDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewMapper {
    public void insertreview(ReviewDto dto);
    public List<ReviewDto> GetAllReview();
    public int getTotalcount();
    public ReviewDto Getmidx (int rb_idx);
    public String selectnicnameofmidx(int rb_idx);
    public List<ReviewDto> getPagingList(Map<String,Integer> map);
    public void deletereview(int rb_idx);
    public void updatereview(ReviewDto dto);
    public ReviewDto getData(int rb_idx);
    public void increaseLikeCount(int rb_idx);
    public void increaseDislikeCount(int rb_idx);
    public List<CompanyinfoDto> selectciname ();
}
