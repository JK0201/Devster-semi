package devster.semi.mapper;

import devster.semi.dto.AcademyCommentDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AcademyCommentMapper {
    public int getTotalComment(int ab_idx);
    public int getMaxNum();
    public void updateStep(Map<String, Integer> map);
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
