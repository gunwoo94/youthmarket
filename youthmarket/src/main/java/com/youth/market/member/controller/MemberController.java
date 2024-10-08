package com.youth.market.member.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
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

import com.youth.market.admin.dto.Notice;
import com.youth.market.admin.service.NoticeService;
import com.youth.market.heart.dto.Heart;
import com.youth.market.member.dto.Member;
import com.youth.market.member.service.MailSendService;
import com.youth.market.member.service.MemberService;
import com.youth.market.sell.dto.Sell;

@Controller
public class MemberController {
	@Autowired
	private JavaMailSender jms;
	@Autowired
	private MemberService ms;
	@Autowired
	private BCryptPasswordEncoder bpe;
	@Autowired
	private NoticeService ns;

	private String emailChk;

	// 회원 가입 페이지 화면
	@GetMapping("/nolay/joinForm")
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
			String real = session.getServletContext().getRealPath("/resources/images/fileSave");
			FileOutputStream fos = new FileOutputStream(new File(real + "/" + fileName));
			fos.write(member.getFile().getBytes());
			fos.close();
			result = ms.insert(member);

			// 회원가입이 성공하면 세션에 userNo 저장
			if (result > 0) {
				Member newMember = ms.select(member.getUserId());
				session.setAttribute("userNo", newMember.getUserNo());
			}
		} else {
			result = -1; // 중복된 데이터
		}
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

		// 회원 정보 조회
		Member member2 = ms.select(member.getUserId());

		if (member2 != null && !member2.getStatus().equals("N")) {
			// 비밀번호 일치 확인
			if (bpe.matches(member.getUserPassword(), member2.getUserPassword())) {
				result = 1; // 로그인 성공

				// 세션에 사용자 정보 저장
				session.setAttribute("userId", member2.getUserId()); // member.getUserId() 대신 member2.getUserId()를 사용하는
				session.setAttribute("loginUser", member2); // 것이 더 명확합니다.
				session.setAttribute("userName", member2.getUserName());
				session.setAttribute("userNo", member2.getUserNo()); // userNo 추가

			} else {
				result = 0; // 비밀번호 불일치
			}
		} else {
			result = -1; // 사용자 없음 또는 비활성화된 계정
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
		Member loginUser = (Member) session.getAttribute("loginUser");

		// 상품판매 조회
		int sellCount = ms.sellCount(loginUser.getUserNo());

		// 팔로워 수 조회
		int followCount = ms.followCount(loginUser.getUserNo());
		// 신고 수 조회
		int reportCount = ms.reportCount(loginUser.getUserNo());

		// 상점 오픈일
		int marketOpen = ms.marketOpen(loginUser.getUserNo());

		// 판매상품 리스트
		List<Sell> sellList = ms.mypageSellList(loginUser.getUserNo());
		for (Sell sell : sellList) {
			sell.setTimeago(sell.getCreateDate());
		}

		List<Sell> sellList2 = ms.mypageSellList2(loginUser.getUserNo());

		List<Sell> sellList3 = ms.mypageSellList3(loginUser.getUserNo());

		model.addAttribute("sellCount", sellCount);
		model.addAttribute("followCount", followCount);
		model.addAttribute("reportCount", reportCount);
		model.addAttribute("marketOpen", marketOpen);
		model.addAttribute("sellList", sellList);
		model.addAttribute("sellList2", sellList2);
		model.addAttribute("sellList3", sellList3);
		model.addAttribute("member", member);

		System.out.println("Sell List Size: " + sellList.size());
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
			String real = session.getServletContext().getRealPath("/resources/images/fileSave");
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
		for (int i = 1; i < 50; i++) {
			Member member = new Member();
			member.setAccount("1111-" + i);
			member.setBirth("2024-01-" + i);
			member.setBlackList("N");
			member.setEmail("1234" + i + "@naver.com");
			member.setPhone("010-1234-" + (1000 + i));
			member.setUserId("k" + i);
			member.setUserName("김주오" + i);
			member.setUserPassword("1");
			String encPass = bpe.encode(member.getUserPassword());
			member.setUserPassword(encPass);
			ms.insert(member);
		}
	}

	
	//찜리스트로 이동
	@GetMapping("/mypage/heartList.do")
	public void heartList(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");
		Member member = ms.select(userId);
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		List<Heart> heartList = ms.mypageHeartList(loginUser.getUserNo());
		
		
		model.addAttribute("member", member);
		model.addAttribute("heartList", heartList);
	}
}
