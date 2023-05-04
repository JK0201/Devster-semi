package devster.semi.service;

import devster.semi.dto.QboardDto;

import java.util.List;
import java.util.Map;

public interface QboardServiceInter {
    public List<QboardDto> getAllPosts();
    public void insertPost(QboardDto dto);
    public void deletePost(int qb_idx);
    public void updatePost(QboardDto dto);
    public QboardDto getOnePost(int qb_idx);
    public String selectNickNameOfMidx(int qb_idx);
    public int getTotalCount();
    public List<QboardDto> getPagingList(int start,int perpage);


}
