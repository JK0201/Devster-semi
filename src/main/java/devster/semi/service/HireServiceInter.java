package devster.semi.service;

import java.util.List;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.HireBoardDto;

public interface HireServiceInter {

    public List<HireBoardDto> getAllPosts();
    public void insertHireBoard(HireBoardDto dto);
    public HireBoardDto getData(int hb_idx);
    public void updateReadCount(int hb_idx);

    public void deleteHireBoard(int hb_idx);

}
