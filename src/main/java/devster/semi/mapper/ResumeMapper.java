package devster.semi.mapper;



import devster.semi.dto.QboardDto;
import devster.semi.dto.Re_carDto;
import devster.semi.dto.Re_licDto;
import devster.semi.dto.ResumeDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ResumeMapper {
    public void insertresume(ResumeDto dto);
    public void insertlic(Re_licDto licdto);
    public void insertcar(Re_carDto cardto);

    public ResumeDto getDataresume(int m_idx);
   public List<Re_licDto> getDatare_lic(int m_idx);
   public List<Re_carDto> getDatare_car(int m_idx);
    public List<Map<String, Object>> getFullData(int m_idx);

    public void updateresume(ResumeDto dto);
    public void updatelic(Re_licDto ldto);
    public void updatecar(Re_carDto cdto);

    public void deletecar (int recar_idx);
    List<ResumeDto> selectall(ResumeDto dto);

    public String selectNickNameOfm_idx(int m_idx);
    public String selectPhotoOfm_idx(int m_idx);
    public int getTotalCount();
    public List<ResumeDto> getPagingList(Map<String,Integer> map);
}
