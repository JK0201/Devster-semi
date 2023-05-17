package devster.semi.service;

import devster.semi.dto.Re_carDto;
import devster.semi.dto.Re_licDto;
import devster.semi.dto.ResumeDto;

import java.util.List;
import java.util.Map;


public interface Resumserviceinter {
    public void insertresume(ResumeDto dto);
    public void insertlic(Re_licDto licdto);
    public void insertcar(Re_carDto cardto);
    public ResumeDto getDataresume(int m_idx);
    public List<Re_licDto> getDatare_lic(int m_idx);
    public List<Re_carDto> getDatare_car(int m_idx);
    public List<Map<String, Object>> getFullData(int m_idx);
    public void updateresume(ResumeDto dto);
   public void updatelic(Re_licDto licdto);
    public void updatecar(Re_carDto cardto);
    public void deletecar (int recar_idx);
}