package devster.semi.service;

import devster.semi.dto.FreeCommentDto;
import devster.semi.mapper.FreeCommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FreeCommentService implements FreeCommentServiceInter{

    @Autowired
    private FreeCommentMapper freeCommentMapper;

    @Override
    public int getMaxNum() {
        return freeCommentMapper.getMaxNum();
    }

    @Override
    public void updateStep(int fbc_ref, int fbc_step) {

        Map<String, Integer> map = new HashMap<>();
        map.put("fbc_ref", fbc_ref);
        map.put("fbc_step",fbc_step);

        freeCommentMapper.updateStep(map);
    }

    @Override
    public FreeCommentDto getFreeComment(int fbc_idx) {
        return freeCommentMapper.getFreeComment(fbc_idx);
    }

    @Override
    public List<FreeCommentDto> getAllCommentList(int fb_idx) {
        return freeCommentMapper.getAllCommentList(fb_idx);
    }

    @Override
    public void insertFreeComment(FreeCommentDto dto) {
        int fbc_ref = dto.getFbc_ref();
        int fbc_step = dto.getFbc_step();
        int fbc_depth = dto.getFbc_depth();

        if(dto.getFb_idx()==0){
            // 댓글
            fbc_step = 0;
            fbc_depth = 0;
            fbc_ref = freeCommentMapper.getMaxNum() + 1; // 새 그룹번호

        } else {
            // 대댓글

            // 전달받은그룹 중 step보다 큰 값 있으면 +1
            this.updateStep(fbc_ref, fbc_step);
            fbc_step++;
            fbc_depth++;
        }
        dto.setFbc_ref(fbc_ref);
        dto.setFbc_step(fbc_step);
        dto.setFbc_depth(fbc_depth);

        freeCommentMapper.insertFreeComment(dto);
    }

    @Override
    public void updateFreeComment(FreeCommentDto dto) {
        freeCommentMapper.updateFreeComment(dto);
    }

    @Override
    public void deleteFreeComment(int fbc_idx) {
        freeCommentMapper.deleteFreeComment(fbc_idx);
    }

    @Override
    public String selectNickNameOfFbc_idx(int fbc_idx) {
        return freeCommentMapper.selectNickNameOfFbc_idx(fbc_idx);
    }

    @Override
    public String selectPhotoOfFbc_idx(int fbc_idx) {
        return freeCommentMapper.selectPhotoOfFbc_idx(fbc_idx);
    }


}
