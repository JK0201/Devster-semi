package devster.semi.service;

import devster.semi.dto.AboardDto;

import java.util.List;

public interface AboardServiceInter {
    public List<AboardDto> getAllAnswers(int qb_idx);
    public String selectNickNameOfAb_idx(int ab_idx);
    public String selectPhotoOfAb_idx(int ab_idx);

    public void insertAboard(AboardDto dto);
    public void deleteComment(int ab_idx);
    public AboardDto getOneAnswer(int ab_idx);
    public void updateAnswer(AboardDto dto);

}
