package devster.semi.service;

import devster.semi.dto.AcademyCommentDto;

import java.util.List;

public interface AcademyCommentServiceInter {
    public int getTotalComment(int ab_idx);
    public int getMaxNum();
    public void updateStep(int abc_ref, int abc_step);
    public AcademyCommentDto getAcademyComment(int abc_idx);
    public List<AcademyCommentDto> getAllCommentList(int ab_idx);
    public void insertAcademyComment(AcademyCommentDto dto);
    public void insertAcademyReply(AcademyCommentDto dto);
    public List<AcademyCommentDto> getReplyOfRef(int abc_idx);
    public void updateAcademyComment(AcademyCommentDto dto);
    public void deleteAcademyComment(int abc_idx);
    public int countReply(int abc_idx);
    public String selectNickNameOfAbc_idx(int abc_idx);
    public String selectPhotoOfAbc_idx(int abc_idx);

}
