package devster.semi.service;

import devster.semi.dto.AcademyCommentDto;
import devster.semi.mapper.AcademyCommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AcademyCommentService implements AcademyCommentServiceInter{

    @Autowired
    private AcademyCommentMapper academyCommentMapper;

    @Override
    public int getTotalComment(int ab_idx) {
        return academyCommentMapper.getTotalComment(ab_idx);
    }

    @Override
    public int getMaxNum() {
        return academyCommentMapper.getMaxNum();
    }

    @Override
    public void updateStep(int abc_ref, int abc_step) {

        Map<String, Integer> map = new HashMap<>();
        map.put("abc_ref", abc_ref);
        map.put("abc_step",abc_step);

        academyCommentMapper.updateStep(map);
    }

    @Override
    public AcademyCommentDto getAcademyComment(int abc_idx) {
        return academyCommentMapper.getAcademyComment(abc_idx);
    }

    @Override
    public List<AcademyCommentDto> getAllCommentList(int ab_idx) {
        return academyCommentMapper.getAllCommentList(ab_idx);
    }

    @Override
    public void insertAcademyComment(AcademyCommentDto dto) {

        // 부모댓글 insert
        int abc_ref = dto.getAbc_idx();
        int abc_step = dto.getAbc_step();

        abc_step++;

        dto.setAbc_ref(abc_ref);
        dto.setAbc_step(abc_step);

        academyCommentMapper.insertAcademyComment(dto);


    }

    @Override
    public void insertAcademyReply(AcademyCommentDto dto) {

        // 자식댓글
        int abc_step = dto.getAbc_step();

        abc_step++;

        dto.setAbc_step(abc_step);

        academyCommentMapper.insertAcademyReply(dto);
    }

    @Override
    public List<AcademyCommentDto> getReplyOfRef(int abc_idx) {
        return academyCommentMapper.getReplyOfRef(abc_idx);
    }

    @Override
    public void updateAcademyComment(AcademyCommentDto dto) {
        academyCommentMapper.updateAcademyComment(dto);
    }

    @Override
    public void deleteAcademyComment(int abc_idx) {
        academyCommentMapper.deleteAcademyComment(abc_idx);
    }

    @Override
    public int countReply(int abc_idx) {
        return academyCommentMapper.countReply(abc_idx);
    }

    @Override
    public String selectNickNameOfAbc_idx(int abc_idx) {
        return academyCommentMapper.selectNickNameOfAbc_idx(abc_idx);
    }

    @Override
    public String selectPhotoOfAbc_idx(int abc_idx) {
        return academyCommentMapper.selectPhotoOfAbc_idx(abc_idx);
    }

}
