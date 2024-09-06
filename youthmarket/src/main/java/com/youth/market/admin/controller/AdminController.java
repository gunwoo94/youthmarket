package com.youth.market.admin.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.util.concurrent.MoreExecutors;
import com.youth.market.admin.dto.Admin;
import com.youth.market.admin.dto.Notice; // Notice DTO 추가
import com.youth.market.admin.dto.Qa;
import com.youth.market.admin.service.AdminService;
import com.youth.market.admin.service.NoticeService;
import com.youth.market.admin.service.PageBean;
import com.youth.market.admin.service.QaService;
import com.youth.market.member.dto.Member;
import com.youth.market.member.service.MemberService;

@Controller
public class AdminController {
   @Autowired
   private AdminService as;
   @Autowired
   private MemberService ms;
   @Autowired
   private NoticeService ns;
   @Autowired
   private QaService qs;
   

   @GetMapping("admin/adminLogout")
   public void adminLogout(HttpSession session) {
      session.invalidate();
   }

   @PostMapping("admin/adminLogin")
   public void adminLogin(String adminId, String adminPassword, Model model, HttpSession session) {
      int result = 0;
      Admin admin = as.loginChk(adminId);
      System.out.println("admin = " + admin);
      if (admin != null && adminPassword.equals(admin.getAdminPassword())) {
         session.setAttribute("adminId", adminId);
         result = 1;

      }
      model.addAttribute("result", result);
   }

   /*
    * ajax 기능 사용
    * 
    * @PostMapping , @ResponseBody, public int, model.addAttribute, return ~;
    */
   @PostMapping("admin/adminBlockAccept")
   @ResponseBody
   public int adminBlockAccept(@RequestParam("userNo") int userNo, Model model) {

      int result = 0;
      result = ms.adminBlockAccept(userNo);
      model.addAttribute("result", result);
      return result;

   }

   @PostMapping("admin/adminBlockCancel")
   @ResponseBody
   public int adminBlockCancel(@RequestParam("userNo") int userNo, Model model) {
      int result = 0;
      result = ms.adminBlockCancel(userNo);
      model.addAttribute("result", result);
      return result;
   }

   @PostMapping("admin/adminDelete")
   @ResponseBody
   public int adminDelete(@RequestParam("userNo") int userNo, Model model) {
      int result = 0;
      result = ms.deleteMember(userNo);
      model.addAttribute("result", result);
      return result;
   }

   @GetMapping("/admin/adminUser")
   public void adminUser(String pageNum, Model model) {
      int rowPerPage = 10;
      if (pageNum == null || pageNum.equals(""))
         pageNum = "1";
      int currentPage = Integer.parseInt(pageNum);
      int startRow = (currentPage - 1) * rowPerPage + 1;
      int endRow = startRow + rowPerPage - 1;
      List<Member> memberList = ms.memberList(startRow, endRow);
      int total = ms.count();
      int count = total - startRow + 1;
      PageBean pb = new PageBean(currentPage, rowPerPage, total);

      model.addAttribute("count", count);
      model.addAttribute("memberList", memberList);
      model.addAttribute("pageNum", pageNum);
      model.addAttribute("memberList", memberList);
      model.addAttribute("pb", pb);

   }

   @GetMapping("admin/adminLoginForm")
   public void adminLoginForm() {

   }

   // 새로운 공지사항 작성 폼으로 이동
   @GetMapping("admin/adminNoticeWriteForm")
   public void adminNoticeWriteForm() {
   }
//   // 수정 하기 
//  	@GetMapping("/admin/adminNoticeEdit.do")
//  	public String adminNoticeEdit(int noticeNo, Model model){
//  	//	int result= ns.editNotice(notice);
//  		Notice notice = ns.s
//  	//	model.addAttribute("result",result);
//  		
//		return "redirect:/admin/adminNotice";
//  		
//  	}
   // 공지사항 작성 후 저장하는 메서드 추가
   @PostMapping("admin/adminNoticeWrite")
   public String adminNoticeWrite(Notice notice, Model model) {
      // Notice 객체를 이용해 작성된 공지사항 데이터를 저장
      int result = ns.insert(notice); // NoticeService에서 insert 메서드 호출

      if (result > 0) {
         model.addAttribute("msg", "공지사항이 성공적으로 등록되었습니다.");
      } else {
         
         model.addAttribute("msg", "공지사항 등록에 실패했습니다.");
      }

      return "redirect:/admin/adminNotice"; // 공지사항 목록 페이지로 리다이렉트
   }



   @GetMapping("admin/adminBoard")
   public void adminBoard(String pageNum, Model model) {
      int rowPerPage = 10;
      if (pageNum == null || pageNum.equals(""))
         pageNum = "1";
      int currentPage = Integer.parseInt(pageNum);
      int startRow = (currentPage - 1) * rowPerPage + 1;
      int endRow = startRow + rowPerPage - 1;
      List<Notice> noticeList = ns.noticeList(startRow, endRow);
      int total = ns.count();
      int count = total - startRow + 1;
      PageBean pb = new PageBean(currentPage, rowPerPage, total);

      model.addAttribute("count", count);
      model.addAttribute("pageNum", pageNum);
      model.addAttribute("noticeList", noticeList);
      model.addAttribute("pb", pb);
   }

   @GetMapping("admin/adminNotice")
   public void adminNotice(String pageNum, Model model) {
      int rowPerPage = 10; // 한블록당 보여줄 페이지
      // pageNum : 현재 페이지
      if (pageNum == null || pageNum.equals(""))
         pageNum = "1";
      int currentPage = Integer.parseInt(pageNum); // 현재페이지 String to integer
      int startRow = (currentPage - 1) * rowPerPage + 1; // 보여줄 시작 번호
      int endRow = startRow + rowPerPage - 1; // 보여줄 끝 번호
      List<Notice> noticeList = ns.noticeList(startRow, endRow);
      int total = ns.count(); // 게시글 총 갯수
      int count = total - startRow + 1;
      PageBean pb = new PageBean(currentPage, rowPerPage, total);

      model.addAttribute("count", count);
      model.addAttribute("pageNum", pageNum);
      model.addAttribute("noticeList", noticeList);
      model.addAttribute("pb", pb);
   }

   @PostMapping("admin/adminBoardDelete")
   @ResponseBody
   public int adminBoardDelete(@RequestParam("noticeNo") int noticeNo, Model model) {
      int result = 0;
      result = ns.boardDeleteMember(noticeNo);
      model.addAttribute("result", result);
      return result;
   }

   @PostMapping("admin/adminNoticeDelete")
   @ResponseBody
   public int adminNoticeDelete(@RequestParam("noticeNo") int noticeNo, Model model) {
      int result = 0;
      result = ns.noticeDeleteMember(noticeNo);
      model.addAttribute("result", result);
      return result;
   }

   @GetMapping("admin/adminBlockList")
   public void adminBlockList(String pageNum, Model model) {

      int rowPerPage = 10;
      if (pageNum == null || pageNum.equals(""))
         pageNum = "1";
      int currentPage = Integer.parseInt(pageNum);
      int startRow = (currentPage - 1) * rowPerPage + 1;
      int endRow = startRow + rowPerPage - 1;
      List<Member> blocklist = ms.blockList(startRow, endRow);
      int total = ms.block_count();
      int count = total - startRow + 1;
      PageBean pb = new PageBean(currentPage, rowPerPage, total);

      model.addAttribute("count", count);
      model.addAttribute("pageNum", pageNum);
      model.addAttribute("blocklist", blocklist);
      model.addAttribute("pb", pb);
   }
   
   @GetMapping("/qa/QaBoardForm")
   public void qaBoardForm() {

   }

   @PostMapping("/qa/QaBoardForm")
   public String qaBoardForm(Qa qa, Model model) {
      int result = qs.insert(qa);

      if (result > 0) {
         model.addAttribute("msg", "공지사항이 성공적으로 등록되었습니다.");
      } else {
         model.addAttribute("msg", "공지사항 등록에 실패했습니다.");
      }

      return "redirect:/qa/QaBoard"; // 리다이렉트 URL 확인 필요 }
   }

   /*
    * @PostMapping("admin/QaBoard") public void QaBoard(Qa a, String pageNum, Model
    * model, HttpSession session) throws IOException {
    * 
    * Integer userNo = (Integer) session.getAttribute("userNo");
    * 
    * String webPath = "/resources/images/qa/"; String serverFolderPath =
    * session.getServletContext().getRealPath(webPath);
    * 
    * String upfile1 = a.getUpfile().getOriginalFilename(); UUID uuid =
    * UUID.randomUUID(); String upfile = uuid +
    * upfile1.substring(upfile1.lastIndexOf(".")); FileOutputStream fos = new
    * FileOutputStream(new File(serverFolderPath + upfile));
    * fos.write(a.getUpfile().getBytes()); fos.close(); a.setQaImg(upfile);
    * 
    * int rowPerPage = 10; // 한블록당 보여줄 페이지 // pageNum : 현재 페이지 if (pageNum == null
    * || pageNum.equals("")) pageNum = "1"; int currentPage =
    * Integer.parseInt(pageNum); // 현재 페이지 번호 int startRow = (currentPage - 1) *
    * rowPerPage + 1; // 시작하는 행 번호 int endRow = startRow + rowPerPage - 1; // 끝나는 행
    * 번호
    * 
    * // QA 리스트를 가져오는 로직으로 수정 List<Qa> qaList = qs.selectQaList(startRow, endRow);
    * // QaService를 통해 QA리스트 가져오기 int total = qs.count(); // QA 게시글 총 갯수 int count
    * = total - startRow + 1; PageBean pb = new PageBean(currentPage, rowPerPage,
    * total);
    * 
    * model.addAttribute("count", count); model.addAttribute("pageNum", pageNum);
    * model.addAttribute("qaList", qaList); model.addAttribute("pb", pb); // 페이징 정보
    * 추가 }
    */
   
   @GetMapping("qa/QaBoard")
   public void QaBoard(String pageNum, Model model) {
      int rowPerPage = 10; // 한블록당 보여줄 페이지
      // pageNum : 현재 페이지
      if (pageNum == null || pageNum.equals(""))
         pageNum = "1";
      int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호
      int startRow = (currentPage - 1) * rowPerPage + 1; // 시작하는 행 번호
      int endRow = startRow + rowPerPage - 1; // 끝나는 행 번호
      
      //QA 리스트를 가져오는 로직으로 수정
      List<Qa> qaList = qs.selectQaList(startRow, endRow); //QaService를 통해 QA리스트 가져오기
      int total = qs.count(); // QA 게시글 총 갯수
      int count = total - startRow + 1;
      PageBean pb = new PageBean(currentPage, rowPerPage, total);

      model.addAttribute("count", count);
      model.addAttribute("pageNum", pageNum);
      model.addAttribute("qaList", qaList);
      model.addAttribute("pb", pb); // 페이징 정보 추가
}
   
   /* 파일 업로드 */
    @PostMapping("qa/qaImgUpload")
       public void uploadQa(Qa qa,
//               @RequestParam("upfile") MultipartFile upfile,
//               @RequestParam("title") String title,
//               @RequestParam("content") String content,
               HttpSession session,Model model
               /*RedirectAttributes redirectAttributes*/) throws IOException {

           // 세션에서 사용자 정보 가져오기 (필요에 따라 수정)
           Integer userNo = (Integer) session.getAttribute("userNo");

           // 서버의 파일 저장 경로 설정
           String webPath = "/resources/images/qa/";
           String serverFolderPath = session.getServletContext().getRealPath(webPath);

           // 파일 이름 생성
           String originalFilename = qa.getUpfile().getOriginalFilename();
           UUID uuid = UUID.randomUUID();
           String newFilename = uuid + originalFilename.substring(originalFilename.lastIndexOf("."));

           // 파일 저장
           File file = new File(serverFolderPath + newFilename);
           try (FileOutputStream fos = new FileOutputStream(file)) {
               fos.write(qa.getUpfile().getBytes());
           }
           qa.setQaImg(newFilename);
           int result = qs.insert(qa);
           model.addAttribute("result", result);
           // DB에 업로드된 파일 정보와 함께 제목, 내용 저장 (여기서는 예제 생략)
           // 예를 들어, QaService를 호출하여 DB에 저장할 수 있습니다.

           // 성공 메시지와 함께 리디렉션
//           redirectAttributes.addFlashAttribute("message", "파일 업로드 성공");
//           return "redirect:/qaBoard.do"; // 업로드 후 이동할 페이지
       }
   
   @PostMapping("qa/qaBoardDelete")
   @ResponseBody
   public int qaBoardDelete(@RequestParam("qaNo") int qaNo, Model model) {
      int result = 0;
      result = qs.qaDeleteMember(qaNo);
      model.addAttribute("result", result);
      return result;
   }
   
   @GetMapping("notice/notice")
      public void notice(String pageNum, Model model) {
         int rowPerPage = 10; // 한블록당 보여줄 페이지
         // pageNum : 현재 페이지
         if (pageNum == null || pageNum.equals(""))
            pageNum = "1";
         int currentPage = Integer.parseInt(pageNum); // 현재페이지 String to integer
         int startRow = (currentPage - 1) * rowPerPage + 1; // 보여줄 시작 번호
         int endRow = startRow + rowPerPage - 1; // 보여줄 끝 번호
         List<Notice> noticeList = ns.noticeList(startRow, endRow);
         int total = ns.count(); // 게시글 총 갯수
         int count = total - startRow + 1;
         PageBean pb = new PageBean(currentPage, rowPerPage, total);

         model.addAttribute("count", count);
         model.addAttribute("pageNum", pageNum);
         model.addAttribute("noticeList", noticeList);
         model.addAttribute("pb", pb);
   }
}