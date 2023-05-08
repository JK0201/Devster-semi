package devster.semi.service;

import devster.semi.dto.AboardDto;
import devster.semi.mapper.AboardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AboardService implements AboardServiceInter {
    @Autowired
    AboardMapper aboardMapper;


    @Override
    public List<AboardDto> getAllAnswers(int qb_idx) {
        return aboardMapper.getAllAnswers(qb_idx);
    }

    @Override
    public String selectNickNameOfAb_idx(int ab_idx) {
        return aboardMapper.selectNickNameOfAb_idx(ab_idx);
    }

    @Override
    public String selectPhotoOfAb_idx(int ab_idx) {
        return aboardMapper.selectPhotoOfAb_idx(ab_idx);
    }

    @Override
    public void insertAboard(AboardDto dto) {
        aboardMapper.insertAboard(dto);
    }

    @Override
    public void deleteComment(int ab_idx) {
        aboardMapper.deleteComment(ab_idx);
    }

    @Override
    public AboardDto getOneAnswer(int ab_idx) {
        return aboardMapper.getOneAnswer(ab_idx);
    }

    @Override
    public void updateAnswer(AboardDto dto) {
        aboardMapper.updateAnswer(dto);
    }


}
