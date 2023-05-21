package devster.semi.service;

import devster.semi.dto.CompanyinfoDto;
import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.ReviewDto;
import devster.semi.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
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
       String nickName = reviewMapper.selectnicnameofmidx(rb_idx);
       return nickName != null ? nickName : null;

    }

    @Override
    public String selectPhotoOfMidx(int rb_idx) {
        return reviewMapper.selectPhotoOfMidx(rb_idx);
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
    @Override
    public void increaseLikeCount(int rb_idx) {
        reviewMapper.increaseLikeCount(rb_idx);
    }

    @Override
    public void increaseDislikeCount(int rb_idx) {
        reviewMapper.increaseDislikeCount(rb_idx);
    }

    @Override
    public List<CompanyinfoDto>selectciname(){return reviewMapper.selectciname();}
@Override
public List<CompanyinfoDto> getDataciinfo(int ci_idx) {
    return reviewMapper.getDataciinfo(ci_idx);
}

    @Override
    public List<CompanyinfoDto> getciinfoData(int ci_idx) {
        return reviewMapper.getciinfoData(ci_idx);
    }

    @Override
    public List<CompanyinfoDto> insertselciname(String keyword) {
        return reviewMapper.insertselciname(keyword);
    }


    @Override
    public void updateci_star(int ci_idx) {
        reviewMapper.updateci_star(ci_idx);
    }

    @Override
    public void insertReviewboard(ReviewDto Dto) {
     reviewMapper.insertReviewboard(Dto);
    }

    @Override
    public void updateCompanyinfoStar(CompanyinfoDto companyinfoDto) {
        reviewMapper.updateCompanyinfoStar(companyinfoDto);
    }

    @Override
    public CompanyinfoDto selectCompanyinfoByCiIdx(int ci_idx) {
        return reviewMapper.selectCompanyinfoByCiIdx(ci_idx);
    }

    @Override
    public void updateReadCount(int qb_idx) {

    }

    public void addReviewAndCalculateStar(ReviewDto reviewDto) {
        // 게시글에 해당하는 회사 정보를 가져옴
        CompanyinfoDto companyinfoDto = reviewMapper.selectCompanyinfoByCiIdx(reviewDto.getCi_idx());

        // reviewboard 테이블에 새로운 레코드 추가
        ReviewDto Dto = new ReviewDto();
        Dto.setCi_idx(reviewDto.getCi_idx());
        Dto.setRb_star(reviewDto.getRb_star());
        reviewMapper.insertReviewboard(Dto);

        // 해당 회사의 평균 별점을 계산하여 companyinfo 테이블에 업데이트
        reviewMapper.updateCompanyinfoStar(companyinfoDto);}




    //좋아요 / 싫어요 관련 메서드들


    @Override
    public void increaseGoodRp(int rb_idx) {
        reviewMapper.increaseGoodRp(rb_idx);
    }

    @Override
    public void increaseBadRp(int rb_idx) {
        reviewMapper.increaseBadRp(rb_idx);
    }

    @Override
    public void decreaseGoodRp(int rb_idx) {
        reviewMapper.decreaseGoodRp(rb_idx);
    }

    @Override
    public void decreaseBadRp(int rb_idx) {
        reviewMapper.decreaseBadRp(rb_idx);
    }

    @Override
    public int getGoodRpCount(int rb_idx) {
        return reviewMapper.getGoodRpCount(rb_idx);
    }

    @Override
    public int getBadRpCount(int rb_idx) {
        return reviewMapper.getBadRpCount(rb_idx);
    }

    @Override
    public void addIncreasingGoodRpInfo(int rb_idx, int m_idx) {
        // 현재 게시물이 소속된 게시판 id를 가져옴
        Map<String,Integer> map = new HashMap<>();
        map.put("rb_idx",rb_idx);
        map.put("m_idx",m_idx);
        reviewMapper.addIncreasingGoodRpInfo(map);
    }

    @Override
    public void deleteGoodRpInfo(int rb_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("rb_idx",rb_idx);
        map.put("m_idx",m_idx);
        reviewMapper.deleteGoodRpInfo(map);
    }

    @Override
    public void addIncreasingBadRpInfo(int rb_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("rb_idx",rb_idx);
        map.put("m_idx",m_idx);
        reviewMapper.addIncreasingBadRpInfo(map);
    }

    @Override
    public void deleteBadRpInfo(int rb_idx, int m_idx) {
        Map<String,Integer> map = new HashMap<>();
        map.put("rb_idx",rb_idx);
        map.put("m_idx",m_idx);
        reviewMapper.deleteBadRpInfo(map);
    }

    @Override
    public boolean isAlreadyAddGoodRp(int rb_idx, int m_idx) {
        // 좋아요 = 1, 싫어요 = 2, 취소 시 데이터 삭제
        // 현재 게시물에서, loginedm_idx의 pointTypeCode값이 1이면 좋아요 상태
        int getPointTypeCodeBym_idx = getRpInfoBym_idx(rb_idx, m_idx);

        if (getPointTypeCodeBym_idx == 1) {
            return true;
        }
        return false;
    }

    @Override
    public boolean isAlreadyAddBadRp(int rb_idx, int m_idx) {
        // 좋아요 = 1, 싫어요 = 2, 취소 시 데이터 삭제
        // 현재 게시물에서, loginedm_idx의 pointTypeCode값이 2면 좋아요 상태
        int getPointTypeCodeBym_idx = getRpInfoBym_idx(rb_idx,m_idx);

        if (getPointTypeCodeBym_idx == 2) {
            return true;
        }
        return false;
    }
// 검색
    @Override
    public List<ReviewDto> searchlist(String searchOption, String keyword, int start, int perpage) {
        Map<String,Object> map = new HashMap<>();

        map.put("searchOption", searchOption);
        map.put("keyword", keyword);
        map.put("start", start);
        map.put("perpage", perpage);

        return reviewMapper.searchlist(map);
    }

    @Override
    public int countsearch(String searchOption, String keyword) {
        Map<String,Object> map = new HashMap<>();

        map.put("searchOption", searchOption);
        map.put("keyword", keyword);
        return reviewMapper.countsearch(map);
    }

    private Integer getRpInfoBym_idx(int rb_idx, int m_idx) {
        // 현재 사용자 id와 게시물 id로 좋아요/싫어요 기록을 가져옴
        Map<String,Integer> map = new HashMap<>();
        map.put("rb_idx",rb_idx);
        map.put("m_idx",m_idx);
        Integer getPointTypeCodeBym_idx = reviewMapper.getRpInfoBym_idx(map);
        if(getPointTypeCodeBym_idx == null) {
            getPointTypeCodeBym_idx = 0;
        }
        return (int)getPointTypeCodeBym_idx;
    }

}
