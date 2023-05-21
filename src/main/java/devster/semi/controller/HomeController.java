package devster.semi.controller;

import devster.semi.dto.*;
import devster.semi.mapper.HireMapper;
import devster.semi.service.*;
import naver.cloud.NcpObjectStorageService;
import net.nurigo.java_sdk.api.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class HomeController {

	@Autowired
	private MessageService messageService;

	@Autowired
	private FreeBoardService freeBoardService;

	@Autowired
	private QboardService qboardService;

	@Autowired
	private HireMapper hireMapper;

	@Autowired
	private HireService hireService;

	@Autowired
	private AcademyBoardService academyBoardService;

	@Autowired
	private NoticeBoardService noticeBoardService;

	@Autowired
	private ReviewService reviewService;

	@Autowired
	private NcpObjectStorageService storageService;

	private String bucketName="devster-bucket";

	@GetMapping({"/","/home"})
	public String fblist(@RequestParam(defaultValue = "1") int currentPage, Model model, HttpSession session)
	{
		//===========================일반게시판===============================//

		int totalCount = freeBoardService.getTotalCount();
		int totalPage; // 총 페이지 수
		int perPage = 5; // 한 페이지당 보여줄 글 갯수
		int perBlock = 10; // 한 블록당 보여질 페이지의 갯수
		int startNum; // 각 페이지에서 보여질 글의 시작번호
		int startPage; // 각 블록에서 보여질 시작 페이지 번호
		int endPage; // 각 블록에서 보여질 끝 페이지 번호
		int no; // 글 출력시 출력할 시작번호

		// 총 페이지 수
		totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);
		// 시작 페이지
		startPage = (currentPage - 1) / perBlock * perBlock + 1;
		// 끝 페이지
		endPage = startPage + perBlock - 1;

		// endPage가 totalPage 보다 큰 경우
		if (endPage > totalPage)
			endPage = totalPage;

		// 각 페이지의 시작번호 (1페이지: 0, 2페이지 : 3, 3페이지 6 ....)
		startNum = (currentPage - 1) * perPage;

		// 각 글마다 출력할 글 번호 (예 : 10개일 경우 1페이지 10, 2페이지 7...)
		// no = totalCount - (currentPage - 1) * perPage;
		no = totalCount - startNum;

		// 각 페이지에 필요한 게시글 db에서 가져오기
		List<FreeBoardDto> fblist = freeBoardService.getPagingList(startNum, perPage);

		// 출력시 필요한 변수들 model에 전부 저장
		model.addAttribute("fblist", fblist);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("no", no);
		model.addAttribute("currentPage", currentPage);


		model.addAttribute("totalCount",totalCount);

		//===========================질문게시판===============================//


		int qboardTotalCount = qboardService.getTotalCount();
		List<QboardDto> qblist = qboardService.getPagingList(startNum, perPage);

		// 출력시 필요한 변수들 model에 전부 저장
		model.addAttribute("qblist", qblist);
		model.addAttribute("qboardTotalCount", qboardTotalCount);

		//===========================채용정보 게시판===============================//

		int hireboardtotalCount = hireService.getHireTotalCount();
		List<HireBoardDto> hirelist=hireService.getHirePagingList(startNum, perPage);

		/*List<HireBoardDto> hirelist=hireMapper.getAllPosts();*/
		//model 에 저장
		model.addAttribute("hirelist", hirelist);
		model.addAttribute("currentPage",currentPage);

		model.addAttribute("hireboardtotalCount",hireboardtotalCount);

		//===========================공지사항===============================//

		int NoticeBoardTotalCount = noticeBoardService.getTotalCount();
		List<NoticeBoardDto> nblist = noticeBoardService.getPagingList(startNum, perPage);

		model.addAttribute("nblist", nblist);
		model.addAttribute("NoticeBoardTotalCount",NoticeBoardTotalCount);

		//===========================학원별 게시판===============================//

		int academyboardTotalCount = academyBoardService.getTotalCount((Integer)session.getAttribute("acaidx")==null?-1:(Integer) session.getAttribute("acaidx"));
		List<AcademyBoardDto> ablist = academyBoardService.getPagingList(startNum, perPage, (Integer)session.getAttribute("acaidx")==null?-1:(Integer) session.getAttribute("acaidx"));

		// 출력시 필요한 변수들 model에 전부 저장
		model.addAttribute("ablist", ablist);
		model.addAttribute("academyboardTotalCount", academyboardTotalCount);

		//===========================회사 후기 게시판===============================//

		int reviewboardTotalCount = reviewService.getTotalcount();
		List<ReviewDto> rblist = reviewService.getPagingList(startNum, perPage);

		// 출력시 필요한 변수들 model에 전부 저장
		model.addAttribute("rblist", rblist);
		model.addAttribute("reviewboardTotalCount", reviewboardTotalCount);


		return "/sub";//tiles.xml 에 이 이름으로 정의된 definition 이 적용됨


	}

	//실시간 인기글
	@PostMapping("/bestPostsForBanner")
	@ResponseBody
	public List<FreeBoardDto> bestPosts() {
		List<FreeBoardDto> list = freeBoardService.bestfreeboardPosts();
		return list;
	}

	@PostMapping("/messagecount")
	@ResponseBody
	public int messageCount(HttpSession session) {
		return messageService.getAllUnreadCount((String)session.getAttribute("memnick"));
	}





	
	/*@GetMapping("/home2")
	public String home2()
	{
		return "/sub";
	}*/
}