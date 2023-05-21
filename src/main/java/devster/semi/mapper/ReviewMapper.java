package devster.semi.mapper;

import devster.semi.dto.CompanyinfoDto;
import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.QboardDto;
import devster.semi.dto.ReviewDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewMapper {
    public void insertreview(ReviewDto dto);
    public List<ReviewDto> GetAllReview();
    public int getTotalcount();
    public ReviewDto Getmidx (int rb_idx);
    public String selectnicnameofmidx(int rb_idx);
    public String selectPhotoOfMidx(int rb_idx);
    public List<ReviewDto> getPagingList(Map<String,Integer> map);
    public void deletereview(int rb_idx);
    public void updatereview(ReviewDto dto);
    public ReviewDto getData(int rb_idx);
    public void increaseLikeCount(int rb_idx);
    public void increaseDislikeCount(int rb_idx);
    public List<CompanyinfoDto> selectciname ();
    public List<CompanyinfoDto> getDataciinfo(int ci_idx);
    public List<CompanyinfoDto> getciinfoData(int ci_idx);
    public List<CompanyinfoDto> insertselciname(String keyword);

    public void updateci_star(int ci_idx);

    void insertReviewboard(ReviewDto Dto);

    // 해당 회사의 평균 별점 계산 후 companyinfo 테이블에 업데이트
    void updateCompanyinfoStar(CompanyinfoDto companyinfoDto);

    // ci_idx를 기준으로 companyinfo 테이블에서 회사 정보 가져오기
    CompanyinfoDto selectCompanyinfoByCiIdx(int ci_idx);


    //좋아요 / 싫어요 관련 메서드들
    public void increaseGoodRp(int rb_idx);
    public void increaseBadRp(int rb_idx);
    public void decreaseGoodRp(int rb_idx);
    public void decreaseBadRp(int rb_idx);
    public int getGoodRpCount(int rb_idx);
    public int getBadRpCount(int rb_idx);
    public void addIncreasingGoodRpInfo(Map<String,Integer> map);
    public void deleteGoodRpInfo(Map<String,Integer> map);
    public void addIncreasingBadRpInfo(Map<String,Integer> map);
    public void deleteBadRpInfo(Map<String,Integer> map);
    public Integer getRpInfoBym_idx(Map<String,Integer> map);
    // 검색
    public List<ReviewDto> searchlist(Map<String, Object> map);
    public int countsearch(Map<String, Object> map);

}
