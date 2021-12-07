package com.example.spring.demo.service;

import org.springframework.stereotype.Service;

import com.example.spring.demo.repository.MemberRepository;


@Service
public class MemberService {
	private MemberRepository memberRepository;
	
	public void join(String loginId, String loginPw, String name, String nickname, String cellphoneNo, String email) {
		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNo, email);
	}

}
