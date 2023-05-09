package devster.semi.service;

import devster.semi.dto.FreeCommentDto;

import java.util.List;
import java.util.Map;

public interface FreeCommentServiceInter {
    public int getTotalComment(int fb_idx);
    public int getMaxNum();
    public void updateStep(int fbc_ref, int fbc_step);
    public FreeCommentDto getFreeComment(int fbc_idx);
    public List<FreeCommentDto> getAllCommentList(int fb_idx);
    public void insertFreeComment(FreeCommentDto dto);
    public void updateFreeComment(FreeCommentDto dto);
    public void deleteFreeComment(int fbc_idx);
    public String selectNickNameOfFbc_idx(int fbc_idx);
    public String selectPhotoOfFbc_idx(int fbc_idx);
}
