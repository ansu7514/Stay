package stay.data.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import stay.data.dto.GuestCommentDto;
import stay.data.service.GuestCommentService;
import stay.data.service.ReservationService;

@Controller
@RequestMapping("/comment")
public class GuestCommentController {
	@Autowired
	GuestCommentService gCommentService;
	
	@Autowired
	ReservationService reservationService;
	
	@PostMapping("/insert")
	@ResponseBody
	public GuestCommentDto commentInsert(
			@RequestParam String reserNo, @RequestParam String rate, @RequestParam String content,
			HttpSession session) {
		
		String myid = (String)session.getAttribute("myid");
		
		double rating = Double.parseDouble(rate);
		
		GuestCommentDto gCommentDto = new GuestCommentDto();
		gCommentDto.setNo(reserNo);
		gCommentDto.setGuest_id(myid);
		gCommentDto.setContent(content);
		gCommentDto.setRating(rating);
		
		gCommentService.insertGuestComment(gCommentDto);
		return gCommentService.getOneComment(reserNo, myid);
	}
	
	@PostMapping("/update")
	@ResponseBody
	public GuestCommentDto commentUpdate(
			@RequestParam String reserNo, @RequestParam String content, @RequestParam String rate) {
		double rating = Double.parseDouble(rate);
		
		GuestCommentDto gCommentDto = new GuestCommentDto();
		gCommentDto.setNo(reserNo);
		gCommentDto.setContent(content);
		gCommentDto.setRating(rating);
		
		gCommentService.updateGuestComment(gCommentDto);

		return gCommentDto;
	}
	
	@PostMapping("/delete")
	public void commentDelete(@RequestParam String no) {
		gCommentService.deleteGuestComment(no);
	}
}