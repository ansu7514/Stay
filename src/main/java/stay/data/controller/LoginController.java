package stay.data.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import stay.data.mapper.MemberMapper;
import stay.data.service.KakaoLogin;

@Controller
@RequestMapping("/member")
public class LoginController {

	@Autowired
	MemberMapper mapper;
	
	@Autowired
	private KakaoLogin kakao;
	

	@GetMapping("/login")
	public String loginForm(HttpSession session, 
							Model model
							//, 
							//HttpServletRequest request
							) {
		// 아이디 얻어오기
		String myid = (String) session.getAttribute("myid");

		// 로그인 상태인지 확인
		String loginok = (String) session.getAttribute("loginok");

		if (loginok == null) {

			return "/member/loginForm";

		} else {
			// 로그인중일때는 로그인한 이름 저장
			String name = mapper.getName(myid);

			model.addAttribute("name", name);
			
			//이전페이지...되는지 확인할것 
			//String referer = request.getHeader("Referer"); 
			//return "redirect:"+ referer;
			
			return "redirect:/";
		}

	}

	@PostMapping("/loginprocess")
	public String loginProcss(@RequestParam(required = false) String cbsave, @RequestParam String id,
			@RequestParam String pass, HttpSession session, @RequestParam("code") String code) {

		System.out.println("code : " + code);
		String access_Token = kakao.getAccessToken(code);
        System.out.println("controller access_token : " + access_Token);
		
		HashMap<String, String> map = new HashMap<String, String>();

		map.put("id", id);
		map.put("pass", pass);

		int check = mapper.login(map);

		if (check == 1) {
			session.setAttribute("myid", id);
			session.setAttribute("loginok", "yes");
			session.setAttribute("cbsave", cbsave);
			session.setAttribute("mode", "guest");
			
			// 체크했을때 on, 안하면 null
			return "redirect:/";
		} else {
			return "/member/passfail";
		}
	}

	@GetMapping("/logoutprocess")
	public String logout(HttpSession session) {

		session.removeAttribute("myid");
		session.removeAttribute("loginok");

		return "redirect:/";
	}

}
