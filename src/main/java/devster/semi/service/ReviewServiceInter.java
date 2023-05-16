package devster.semi.service;

import devster.semi.dto.CompanyinfoDto;
import devster.semi.dto.FreeBoardDto;
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

/*
    *//*좋아요 싫어요 관련 *//*
    int countLikeDislike(int m_idx, int rb_idx, int likeStatus);

    void insertLikeDislike(int m_idx, int rb_idx, int likeStatus);

    void updateLikeDislike(int m_idx, int rb_idx, int likeStatus);

    void updateLikeCount(int rb_idx, int value);

    void updateDislikeCount(int rb_idx, int value);*/

    public void updateReadCount(int qb_idx);
    public void increaseLikeCount(int qb_idx);
    public void increaseDislikeCount(int qb_idx);
    public void increaseGoodRp(int rb_idx);
    public void increaseBadRp(int rb_idx);
    public void decreaseGoodRp(int rb_idx);
    public void decreaseBadRp(int rb_idx);
    public int getGoodRpCount(int rb_idx);
    public int getBadRpCount(int rb_idx);
    public void addIncreasingGoodRpInfo(int rb_idx, int m_idx);
    public void deleteGoodRpInfo(int rb_idx, int m_idx);
    public void addIncreasingBadRpInfo(int rb_idx, int m_idx);
    public void deleteBadRpInfo(int rb_idx, int m_idx);
    public boolean isAlreadyAddGoodRp(int rb_idx, int m_idx);
    public boolean isAlreadyAddBadRp(int rb_idx, int m_idx);

    // 검색
    public List<ReviewDto> searchlist(String searchOption, String keyword, int start, int perpage);
    public int countsearch(String searchOption, String keyword);
}
