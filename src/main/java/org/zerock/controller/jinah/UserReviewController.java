package org.zerock.controller.jinah;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.ReviewCriteria;
import org.zerock.domain.ReviewPageDTO;
import org.zerock.domain.UserReviewVO;
import org.zerock.service.UserReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/review")
@AllArgsConstructor
@Log4j
public class UserReviewController {
	
	// 내가 해야 될 것 
	// view - reviewList, reviewDetail, reviewWrite, reviewModify(remove)
	// 모듈화(?) - 파일 업로드, SNS 연동, 리뷰게시물 검색, 위치 정보(게시물 내 - 원혁이랑 상의 필요)
	// userReviewController
	// userReviewService
	// userReviewServiceImpl
	// userReviewMapper.interface
	// userReviewMapper.xml
	
	// start
	
	private UserReviewService service;
	
	// 리뷰 목록 얻어오기 - userReviewList
	@GetMapping("/list")
	public void reviewList(@ModelAttribute("recri") ReviewCriteria recri, Model model) {
		log.info("userReviewList is working");
		
		int reviewTotal = service.getReviewTotal(recri);
		
		List<UserReviewVO> reList = service.getReviewList(recri);
		
		model.addAttribute("reList", reList);
		model.addAttribute("reviewPageMaker", new ReviewPageDTO(recri, reviewTotal));
	}
	
	// ************ 나의 리뷰 목록 얻어오기 - getMyReviewList
	
	// 리뷰 작성하기 (이미지 파일 포함) - userReviewWrite
	@PostMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public String reviewWrite(UserReviewVO review,
								@RequestParam("file") MultipartFile file,
								RedirectAttributes rttr) {
		
		log.info("userReviewWrite is working");
		
		review.setFileName(file.getOriginalFilename());
		
		service.reviewWrite(review, file);
		
		rttr.addFlashAttribute("result", review.getReBno());
		rttr.addFlashAttribute("messageTitle", "리뷰 등록 완료-!");
		rttr.addFlashAttribute("messageBody", review.getReBno() + "번 리뷰가 등록되었습니다.");
		
		return "redirect:/review/list";
	}
	
	// 리뷰 작성하기 - 이미지 파일 없이
	@GetMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public void reviewWrite(@ModelAttribute("recri") ReviewCriteria recri) {
		// Forwarding to /WEB-INF/views/review/write.jsp
	}
	
	// 리뷰 상세 얻어오기 - userReviewGet
	@GetMapping("/get")
	public void reviewGet(@RequestParam("reBno") int reBno,
						  @ModelAttribute("recri") ReviewCriteria recri,
						  Model model) {
		
		log.info("userReviewGet is working");
		
		UserReviewVO revo = service.reviewGet(reBno);
		
		model.addAttribute("review", revo);
		
	}
	
	// 리뷰 파일 수정하기 (이미지 파일 없이) - userReviewModify
	@GetMapping("/modify")
	@PreAuthorize("isAuthenticated()")
	public void reviewModify(@RequestParam("reBno") int reBno,
						  @ModelAttribute("recri") ReviewCriteria recri,
						  Model model) {
		
		reviewGet(reBno, recri, model);
		

	}
	
	// 리뷰 파일 수정하기 (이미지 파일 포함) - userReviewModify
	@PostMapping("/modify")
	@PreAuthorize("isAuthenticated()")
	public String reviewModify(UserReviewVO review,
							   ReviewCriteria recri,
							   MultipartFile file,
							   RedirectAttributes rttr) {
		
		log.info("userReviewModify is working");
		
		boolean success = service.reviewModify(review, file);
		
		if (success) {
			rttr.addFlashAttribute("result", success);
			rttr.addFlashAttribute("messageTitle", "수정 완료-!");
			rttr.addFlashAttribute("messageBody", "리뷰가 정상적으로 수정되었습니다.");
		}
		
		rttr.addAttribute("pageNum", recri.getPageNum());
		rttr.addAttribute("amount", recri.getAmount());
		rttr.addAttribute("type", recri.getType());
		rttr.addAttribute("keyword", recri.getKeyword());
		
		return "redirect:/review/list";
	}
	
	// 리뷰 삭제하기 - userReviewRemove
	@PostMapping("/remove")
	@PreAuthorize("isAuthenticated()")
	public String reviewRemove(@RequestParam("reBno") int reBno,
							   ReviewCriteria recri,
							   RedirectAttributes rttr,
							   String reWriterName
							   ) {
		
		log.info("userReviewRemove is working");
		
		boolean success = service.reviewRemove(reBno);
		
		if (success) {
		rttr.addFlashAttribute("result", success);
		rttr.addFlashAttribute("messageTitle", "삭제 완료-!");
		rttr.addFlashAttribute("messageBody", "리뷰가 정상적으로 삭제되었습니다.");
		
		}
	
		rttr.addAttribute("pageNum", recri.getPageNum());
		rttr.addAttribute("amount", recri.getAmount());
		rttr.addAttribute("type", recri.getType());
		rttr.addAttribute("keyword", recri.getKeyword());
		
		return "redirect:/review/list";
	}
	
	// 리뷰 좋아요 - userReviewLikeCount
	@PostMapping("/get")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public int reviewLikeCount(@RequestParam("reBno") int reBno) {
		
		log.info("userReviewLikeCount is working");
		
		int likecnt = service.reviewLikecount(reBno);
		
		return likecnt;
	}
	
	// 리뷰 조회수 - userReviewViewCount
	
	// 리뷰 평점 - userReviewStars
}
