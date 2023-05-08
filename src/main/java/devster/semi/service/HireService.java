package devster.semi.service;

import devster.semi.dto.FreeBoardDto;
import devster.semi.dto.HireBoardDto;
import devster.semi.mapper.HireMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


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


    @Override
    public void updateHireBoard(HireBoardDto dto) {
        hireMapper.updateHireBoard(dto);
    }

    @Override
    public int getHireTotalCount() {
    return hireMapper.getHireTotalCount();
    }

    @Override
    public List<HireBoardDto> getHirePagingList(int start,int perpage) {
    Map<String,Integer> map = new HashMap<>();
    map.put("start",start);
    map.put("perpage",perpage);
    return hireMapper.getHirePagingList(map);
    }

}


