package devster.semi.service;

import devster.semi.dto.ReviewDto;

import java.util.List;

public interface ReviewServiceInter {

    public void insertreview(ReviewDto dto);
    public List<ReviewDto>GetAllReview();
}
