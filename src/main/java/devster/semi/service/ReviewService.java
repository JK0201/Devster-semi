package devster.semi.service;

import devster.semi.dto.ReviewDto;
import devster.semi.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService implements ReviewServiceInter{
    @Autowired
    ReviewMapper reviewMapper;

    @Override
    public void insertreview(ReviewDto dto){reviewMapper.insertreview(dto);}

    @Override
    public List<ReviewDto>GetAllReview(){return reviewMapper.GetAllReview();}

}
