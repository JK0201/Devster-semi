package devster.semi.mapper;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.ReviewDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReviewMapper {
    public void insertreview(ReviewDto dto);
    public List<ReviewDto> GetAllReview();
}
