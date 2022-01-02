package stay.data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import stay.data.dto.JoinGuestDto;
import stay.data.dto.MemberDto;
import stay.data.service.JoinGuestService;
import stay.data.service.MemberService;

@Controller
@RequestMapping("/join")
public class JoinGuestController {
	@Autowired
	JoinGuestService joinService;
	
	@Autowired
	MemberService memService;
	
	@PostMapping("/search")
	@ResponseBody
	public Boolean searchMem(@RequestParam String id) {
		MemberDto memDto = memService.getMember(id);
		
		if(memDto == null)
			return false;
		
		return true;
	}
	
	@PostMapping("/insert")
	public void joinInsert(
			@ModelAttribute JoinGuestDto joinDto, @RequestParam String no, @RequestParam String id) {
		joinDto.setNo(no);
		joinDto.setId(id);
		
		joinService.insertJoinGuest(joinDto);
	}
	
	@PostMapping("/delete")
	public void joinDelete(@RequestParam String no, @RequestParam String id) {
		joinService.deleteJoinGuest(no, id);
	}
}