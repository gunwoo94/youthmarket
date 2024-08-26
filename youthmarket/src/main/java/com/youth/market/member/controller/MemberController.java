package com.youth.market.member.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youth.market.member.dto.Member;
import com.youth.market.member.service.MailSendService;
import com.youth.market.member.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private JavaMailSender jms;
	@Autowired
	private MemberService ms;
	@Autowired
	private BCryptPasswordEncoder bpe;

	private String emailChk;

	// 회원 가입 페이지 화면
	@GetMapping("member/joinForm")
	public void joinForm() {
	}

	// 회원가입
	@PostMapping("/member/join")
	public void join(Member member, Model model, HttpSession session) throws IOException {
		int result = 0;
		String encPass = bpe.encode(member.getUserPassword());
		member.setUserPassword(encPass);
		Member member2 = ms.select(member.getUserId());
		if (member2 == null) {
			String fileName1 = member.getFile().getOriginalFilename();
			UUID uuid = UUID.randomUUID(); // random 36자 이름 생성
			String fileName = uuid + fileName1.substring(fileName1.lastIndexOf("."));
			member.setFileName(fileName);
			String real = session.getServletContext().getRealPath("/resources/fileSave");
			FileOutputStream fos = new FileOutputStream(new File(real + "/" + fileName));
			fos.write(member.getFile().getBytes());
			fos.close();
			result = ms.insert(member);
		} else
			result = -1; // 중복된 데이터
		model.addAttribute("result", result);
	}

	// 아이디 중복검사
	@PostMapping(value = "member/idChk", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String idChk(String userId) {
		Member member = ms.select(userId);
		String data = "";
		if (member != null) {
			data = "이미 사용중인 아이디입니다";
		} else
			data = "사용 가능한 아이디입니다";
		return data;
	}

	// 로그인 페이지 화면
	@GetMapping("/member/loginForm")
	public void loginForm() {
	}

	// 로그인
	@PostMapping("/member/login")
	public void login(Member member, Model model, HttpSession session) {
		int result = 0;
		Member member2 = ms.select(member.getUserId());
		if (member2 != null && !member2.getStatus().equals("N")) {
			if (bpe.matches(member.getUserPassword(), member2.getUserPassword())) {
				result = 1; // 성공
				session.setAttribute("userId", member.getUserId());
				session.setAttribute("userName", member2.getUserName());
			} else
				result = 0;
		} else {
			result = -1;
		}
		model.addAttribute("result", result);
	}

	// 로그아웃
	@GetMapping("/member/logout")
	public void logout(HttpSession session) {
		session.invalidate();
	}

	// 메인페이지 화면
	@GetMapping("/member/main")
	public void main() {

	}

	// 마이페이지 화면 (로그인 상태일 때만 보여짐 )
	@GetMapping("/mypage/mypage")
	public void mypage(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");
		Member member = ms.select(userId);
		model.addAttribute("member", member);
	}

	// 회원 정보 수정 페이지 화면
	@GetMapping("/member/updateForm")
	public void updateForm(Model model, HttpSession session) {
		view(model, session);
	}

	// 회원 정보 수정할때 현재 회원 정보를 보여줌
	@GetMapping("view")
	public void view(Model model, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		Member member = ms.select(userId);
		model.addAttribute("member", member);
	}

	// 회원 정보 수정
	@PostMapping("/member/update")
	public void update(Member member, Model model, HttpSession session) throws IOException {
		int result = 0;
		String encPass = bpe.encode(member.getUserPassword());
		member.setUserPassword(encPass);
		String fileName1 = member.getFile().getOriginalFilename();
		if (fileName1 != null && !fileName1.equals("")) { // 사진이 수정
			UUID uuid = UUID.randomUUID(); // random 36자 이름 생성
			String fileName = uuid + fileName1.substring(fileName1.lastIndexOf("."));
			member.setFileName(fileName);
			String real = session.getServletContext().getRealPath("/resources/fileSave");
			FileOutputStream fos = new FileOutputStream(new File(real + "/" + fileName));
			fos.write(member.getFile().getBytes());
			fos.close();
		}
		result = ms.update(member);
		model.addAttribute("result", result);
	}

	// 회원 탈퇴
	@GetMapping("/member/delete")
	public void delete(Model model, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		int result = ms.delete(userId);
		if (result > 0) {
			session.invalidate();
		}
		model.addAttribute("result", result);
	}

	// 아이디 찾기 페이지 화면
	@GetMapping("/member/findIdForm")
	public void findIdForm() {

	}

	// 아이디 찾을 때 이메일로 인증번호 전송
	@RequestMapping(value = "/member/emailChkFindId", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String emailChkFindId(String email, Model model) {
		String msg = "";
		Member member = ms.selectEmail(email);
		if (member == null) {
			msg = "존재하지 않는 이메일 입니다";
		} else {
			MailSendService mailsend = new MailSendService();
			emailChk = mailsend.findIdPassEmail(email, jms);
			System.out.println("Controller에 넘어온 인증코드 : " + emailChk);
		}
		return msg;
	}

	// 이메일로 보낸 인증번호와 사용자가 입력한 인증번호 대조
	@RequestMapping(value = "/member/emailConfirm", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String emailConfirm(String emailConfirm, Model model) {
		System.out.println("적은 인증번호 : " + emailConfirm);
		System.out.println("메일로 보낸 인증번호 : " + emailChk);
		String msg = "";
		if (emailChk.equals(emailConfirm)) {
			msg = "y";
		} else {
			msg = "n";
		}
		return msg;
	}

	// 아이디 찾기
	@GetMapping("/member/findId")
	public void findId(Model model, String email, String userId) {
		Member member = ms.selectEmail(email);
		model.addAttribute("member", member);
	}

	// 암호 찾기 페이지1 화면
	@GetMapping("/member/findPasswordForm")
	public void findPasswordForm() {

	}

	// 암호 찾기 - id 있는지 확인
	@PostMapping("/member/findPassword")
	public void findPassword(String userId, Model model) {
		int result = 0;
		Member member = ms.select(userId);
		if (member == null || member.getStatus().equals("N")) {
			result = -1;
		}
		model.addAttribute("result", result);
		model.addAttribute("member", member);
	}

	// 암호 찾기 페이지2 화면
	@GetMapping("/member/findPasswordForm2")
	public void findPasswordForm2(String userId, Model model) {
		Member member = ms.select(userId);
		model.addAttribute("member", member);
	}

	// 이메일로 보낸 인증번호와 사용자가 입력한 인증번호 대조
	@RequestMapping(value = "/member/emailChkFindPass", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String emailChkFindPass(String email, String UserId, Model model) {
		String msg = "";
		Member member = ms.selectEmail(email);
		if (member != null) {
			if (member.getEmail().equals(email)) {
				MailSendService mailsend = new MailSendService();
				emailChk = mailsend.findIdPassEmail(email, jms);
				System.out.println("Controller에 넘어온 인증코드 : " + emailChk);
				msg = "y";
			} else if (!member.getUserId().equals(UserId)) {
				msg = "n";
			}
		} else
			msg = "null";
		model.addAttribute("member", member);
		return msg;
	}

	// 암호 변경 페이지 화면
	@GetMapping("/member/inputPasswordForm")
	public void inputPasswordForm(Member member, Model model) {
		model.addAttribute(member);
	}

	// 암호 변경
	@GetMapping("/member/inputPassword")
	public void inputPassword(Member member, Model model) {
		int result = 0;
		String encPass = bpe.encode(member.getUserPassword()); // 비밀번호 암호화
		member.setUserPassword(encPass);
		result = ms.updatePassword(member);
		model.addAttribute("result", result);
	}

	@GetMapping("/member/insertMember")
	public void insertmember() {
		for (int i = 1; i < 200; i++) {
			Member member = new Member();
			member.setAccount("1111-" + i);
			member.setBirth("2024-01-" + i);
			member.setBlackList("N");
			member.setEmail("1234" + i + "@naver.com");
			member.setPhone("010-1234-" + (1000 + i));
			member.setUserId("k" + i);
			member.setUserName("홍길동" + i);
			member.setUserPassword("1");
			String encPass = bpe.encode(member.getUserPassword());
			member.setUserPassword(encPass);
			ms.insert(member);
		}
	}

}
