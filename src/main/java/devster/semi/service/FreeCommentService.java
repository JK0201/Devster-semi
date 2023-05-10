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
    public int getTotalComment(int fb_idx) {
        return freeCommentMapper.getTotalComment(fb_idx);
    }

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

        // 부모댓글 insert
        int fbc_ref = dto.getFbc_idx();
        int fbc_step = dto.getFbc_step();

        fbc_step++;

        dto.setFbc_ref(fbc_ref);
        dto.setFbc_step(fbc_step);

        freeCommentMapper.insertFreeComment(dto);


    }

    @Override
    public void insertFreeReply(FreeCommentDto dto) {

        // 자식댓글
        int fbc_step = dto.getFbc_step();

        fbc_step++;

        dto.setFbc_step(fbc_step);

        freeCommentMapper.insertFreeReply(dto);
    }

    @Override
    public List<FreeCommentDto> getReplyOfRef(int fbc_idx) {
        return freeCommentMapper.getReplyOfRef(fbc_idx);
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
    public int countReply(int fbc_idx) {
        return freeCommentMapper.countReply(fbc_idx);
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
