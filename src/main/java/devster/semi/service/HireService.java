package devster.semi.service;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.HireBoardDto;
import devster.semi.mapper.HireMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HireService implements HireServiceInter{

    @Autowired
    HireMapper hireMapper;



    @Autowired
    public List<HireBoardDto> getAllPosts(){
        return hireMapper.getAllPosts();
    }

    @Override
    public void insertHireBoard(HireBoardDto dto) {
        // TODO Auto-generated method stub


        hireMapper.insertHireBoard(dto);
    }

    @Override
    public HireBoardDto getData(int hb_idx) {
        return hireMapper.getData(hb_idx);
    }

    @Override
    public void updateReadCount(int hb_idx) {
        hireMapper.updateReadCount(hb_idx);
    }

    @Override
    public void deleteHireBoard(int hb_idx) {
        hireMapper.deleteHireBoard(hb_idx);
    }
}
