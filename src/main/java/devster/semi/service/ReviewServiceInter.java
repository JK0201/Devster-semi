package devster.semi.service;

import devster.semi.dto.CompanyinfoDto;
import devster.semi.dto.ReviewDto;

import java.util.List;

public interface ReviewServiceInter {

    public void insertreview(ReviewDto dto);
    public List<ReviewDto>GetAllReview();
    public int getTotalcount();
    public String selectnicnameofmidx(int rb_idx);
    public List<ReviewDto> getPagingList(int start,int perPage);
    public void deletereview(int rb_idx);
    public void updatereview(ReviewDto dto);
    public ReviewDto getData(int rb_idx);
    public void increaseLikeCount(int rb_idx);
    public void increaseDislikeCount(int rb_idx);
    public List<CompanyinfoDto> selectciname ();
    public List<CompanyinfoDto> getDataciinfo(int ci_idx);
    public List<CompanyinfoDto> getciinfoData(int ci_idx);
    public List<CompanyinfoDto> insertselciname(String keyword);
}
