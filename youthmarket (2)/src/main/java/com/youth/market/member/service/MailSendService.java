package com.youth.market.member.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailSendService {
	private JavaMailSender jms;
	private int authNumber;

	// 변수 인증번호 생성
	public void makeRandomNumber() {
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111; // 최소 111111부터 최대 999999까지
		authNumber = checkNum;
	}

	public String findIdPassEmail(String email, JavaMailSender jms) {
		makeRandomNumber();
		this.jms = jms;
		System.out.println("인증받을 이메일 : " + email);
		String from = "owt0103@naver.com"; // email-config에 설정한 자신의 이메일 주소를 입력
		String to = email;
		String subject = "청년마켓 인증번호 이메일 입니다."; // 이메일 제목
		String content = "청년마켓을 방문해주셔서 감사합니다." + // 이메일 내용 (html 형식으로 작성)
				"<br><br>" + "인증 번호는 " + authNumber + "입니다." + "<br>" + "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		mailSend(jms, from, to, subject, content);

		return Integer.toString(authNumber);
	}

	private void mailSend(JavaMailSender jms, String from, String to, String subject, String content) {
		MimeMessage mm = jms.createMimeMessage();
		try {
			MimeMessageHelper mmh = new MimeMessageHelper(mm, true, "utf-8");
			mmh.setFrom(from);
			mmh.setTo(to);
			mmh.setSubject(subject);
			mmh.setText(content, true);
			jms.send(mm);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}
