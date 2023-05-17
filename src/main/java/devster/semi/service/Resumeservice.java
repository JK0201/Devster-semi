package devster.semi.service;

import devster.semi.dto.Re_carDto;
import devster.semi.dto.Re_licDto;
import devster.semi.dto.ResumeDto;
import devster.semi.mapper.ResumeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class Resumeservice implements Resumserviceinter {

    @Autowired
    ResumeMapper resumeMapper;

    @Override
    public void insertresume(ResumeDto dto) {
         resumeMapper.insertresume(dto);
    }

    @Override
    public void insertlic(Re_licDto licdto) {
    resumeMapper.insertlic(licdto);
    }

    @Override
    public void insertcar(Re_carDto cardto) {
    resumeMapper.insertcar(cardto);
    }


    @Override
    public ResumeDto getDataresume(int m_idx) {
        return resumeMapper.getDataresume(m_idx);
    }

    @Override
    public List<Re_licDto> getDatare_lic(int m_idx) {
        return resumeMapper.getDatare_lic(m_idx);
    }

    @Override
    public List<Re_carDto> getDatare_car(int m_idx) {
        return resumeMapper.getDatare_car(m_idx);
    }

    @Override
    public List<Map<String, Object>> getFullData(int m_idx) {
        return resumeMapper.getFullData(m_idx);
    }

    @Override
    public void updateresume(ResumeDto dto) {
       resumeMapper.updateresume(dto);
    }
    @Override
    public void updatelic(Re_licDto licdto) {
       resumeMapper.updatelic(licdto);
    }

    @Override
    public void updatecar(Re_carDto cardto) {
  resumeMapper.updatecar(cardto);
    }

    @Override
    public void deletecar(int recar_idx) {
        resumeMapper.deletecar(recar_idx);
    }
}
