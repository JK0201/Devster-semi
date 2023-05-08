package devster.semi.service;

import devster.semi.dto.FreeCommentDto;

import java.util.List;
import java.util.Map;

public interface FreeCommentServiceInter {
    public int getMaxNum();
    public void updateStep(int fbc_ref, int fbc_step);
    public FreeCommentDto getFreeComment(int fbc_idx);
    public List<FreeCommentDto> getAllCommentList();
    public void insertFreeComment(FreeCommentDto dto);
    public void updateFreeComment(FreeCommentDto dto);
    public void deleteFreeComment(int fbc_idx);
    public List<FreeCommentDto> selectOfFbidx(int fb_idx);
}
