package com.example.spring.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.spring.demo.service.MemberService;
import com.example.spring.demo.util.Ut;
import com.example.spring.demo.vo.Member;
import com.example.spring.demo.vo.ResultData;
import com.example.spring.demo.vo.Rq;

@Controller
public class UsrMemberController {
	private MemberService memberService;
	private Rq rq;

	public UsrMemberController(MemberService memberService, Rq rq)  { 
		this.memberService = memberService;
		this.rq = rq;
	}
	 
	//회원가입
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public ResultData<Member> doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNo,
			String email) {
		if (Ut.empty(loginId)) {
			return ResultData.from("F-1", "로그인 아이디를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return ResultData.from("F-2", "로그인 비밀번호를 입력해주세요.");
		}

		if (Ut.empty(name)) {
			return ResultData.from("F-3", "이름을 입력해주세요.");
		}

		if (Ut.empty(nickname)) {
			return ResultData.from("F-4", "닉네임을 입력해주세요.");
		}

		if (Ut.empty(cellphoneNo)) {
			return ResultData.from("F-5", "전화번호를 입력해주세요.");
		}

		if (Ut.empty(email)) {
			return ResultData.from("F-6", "이메일을 입력해주세요.");
		}
		
		//S-1
		//회원가입이 완료되었습니다.
		//데이터번호
		ResultData<Integer> joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNo, email);
		
		if(joinRd.isFail()) {
			return (ResultData)joinRd;
		}
		
		Member member = memberService.getMemberById(joinRd.getData1());
		return ResultData.newData(joinRd, "member", member);
	}
	//로그인
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
		if (rq.isLogined()) {
			return rq.jsHistoryBack("이미 로그인되었습니다");
		}
		
		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("로그인 아이디를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("로그인 비밀번호를 입력해주세요.");
		}

		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member == null) {
			return rq.jsHistoryBack("존재하지 않은 로그인 아이디 입니다.");
		}
		
		if(member.getLoginPw().equals(loginPw) == false) {
			return rq.jsHistoryBack("비밀번호가 일치하지 않습니다.");
		}
		
		rq.login(member);
		
		return rq.jsReplace(Ut.f("%s님 환영합니다.", member.getNickname()), "/");
	}
	
	@RequestMapping("/usr/member/login")
	public String showLogin(HttpSession httpSession) {
		return "usr/member/login";
	}
	//로그아웃
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody 
	public String doLogout() {
		if (!rq.isLogined()) {
			return rq.jsHistoryBack( "이미 로그아웃 상태입니다.");
		}
		
		rq.logout();
		
		return rq.jsReplace("로그아웃 되었습니다.", "/");
	}
}
