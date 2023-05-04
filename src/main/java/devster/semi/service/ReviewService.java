package devster.semi.service;

import devster.semi.dto.ReviewDto;
import devster.semi.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReviewService implements ReviewServiceInter{
    @Autowired
    ReviewMapper reviewMapper;



    @Override
    public void insertreview(ReviewDto dto){reviewMapper.insertreview(dto);}

    @Override
    public List<ReviewDto>GetAllReview(){return reviewMapper.GetAllReview();}
    @Override
    public int getTotalcount(){return reviewMapper.getTotalcount();}



   @Override
    public String selectnicnameofmidx(int rb_idx) {
        return reviewMapper.selectnicnameofmidx(rb_idx);
    }

    @Override
    public List<ReviewDto> getPagingList(int start,int perPage) {

        Map<String,Integer> map=new HashMap<>();
        map.put("start",start);
        map.put("perPage",perPage);
        return reviewMapper.getPagingList(map);
    }

    @Override
    public void deletereview(int rb_idx) {
        reviewMapper.deletereview(rb_idx);
    }

    @Override
    public void updatereview(ReviewDto dto) {
        reviewMapper.updatereview(dto);
    }

    @Override
    public ReviewDto getData(int rb_idx) {
        return reviewMapper.getData(rb_idx);
    }
}
