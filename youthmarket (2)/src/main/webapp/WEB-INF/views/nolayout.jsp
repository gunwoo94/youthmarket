<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="UTF-8">
<title>header</title>
<style type="text/css">@import url("/chch/resources/css/header.css");</style>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<c:set var="ipAdd" value="//172.30.1.10:8080"></c:set>
<c:set var="ip" value="http:${ipAdd}/chch"></c:set>
<link rel="stylesheet" type="text/css"href="${path }/resources/bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="${path}/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript" src="${path}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${path}/resources/bootstrap/js/sockjs.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<style type="text/css">@import url("/chch/resources/css/font.css");</style>

<script type="text/javascript">
	function openCloseMenu(){
	    let status = $('.hideBookMenu').css('display');
	    if (status =='block') {
	        $('.hideBookMenu').hide();
	    } else {
	        $('.hideBookMenu').show();
	    }
	}

	var socket  = null;
	var id = '${id}';
	
	$(document).ready(function(){
		
	    // 웹소켓 연결
	    sock = new SockJS("<c:url value='/echo.do'/>");
	    socket = sock;
	    
	    sock.onopen = function() {
		    console.log('open ws')
	    };
		
	    // 데이터를 전달 받았을때 
	    sock.onmessage = onMessage; // toast 생성
	    
	    loadUnread();
	    
	});
	    
	$(function() {
	    $('#loadStatus').click(function() { loadStatus(); });
	    $('#sendBtn1').click(function() { sendNotice(); });
	    $('#sendBtn2').click(function() { sendChat(); });
	    $('#sendBtn3').click(function() { inquiryReply(); });
	    
	    
	    $('#notice').keypress(function() { // enter키를 누르면 메세지 전송
			//  누른 key값(asscii)  IE ?      IE의 값         IE아닌 모든 web값
			var keycode = event.keyCode ? event.keyCode : event.which;
			if (keycode == 13) { // 13이 enter(assii값)
				sendNotice();
			}
		});
	    $('#message').keypress(function() { // enter키를 누르면 메세지 전송
			//  누른 key값(asscii)  IE ?      IE의 값         IE아닌 모든 web값
			var keycode = event.keyCode ? event.keyCode : event.which;
			if (keycode == 13) { // 13이 enter(assii값)
				sendChat();
			}
		});
	}); 
		
	function onMessage(evt){
		
		var msg = evt.data;
	
		console.log("header47 메세지 받음 : "+msg);
		
		appendMessage(msg);
	}	
		
	function appendMessage(msg) {
		var split1 = msg.split(',');
		var cmd = split1[0];
		var room_no = split1[2];
		
		console.log("header55 : "+msg);
		console.log("header56 : "+split1);
		
		if (msg != null && msg.trim() != '' && cmd == 'chat') {
			var check1;
			var check2;
			if (document.location.href.includes('?')) {
				check1 = document.location.href.split("?");
				check11 = check1[0].substr(-7);		// 해당 페이지의 주소 확인
				if (check1[1].includes('&')) {
					check2 = check1[1].split("&");
					check22 = check2[0];// 해당 페이지의 파라미터 값을 가져옴
					console.log(check2);
				} else {
					check22=0;
				}
			} else {
				check11=0;
				check22=0;;
			}
			
			console.log("check11 : "+check11);
			console.log('check22 : '+check22);
			console.log('room_no : ${room_no}');
			console.log('room_no=${room_no}');
			
			var check3 = document.location.href.split("/");
			console.log(check3[4]);
			
			if (check11=='chat.do' && check22=='room_no='+room_no) {	//'chat.do'에 해당하는 주소이고 room_no가 동일할 때 메세지를 append
				console.log("header60 chat으로 시작하는 메세지 : "+msg);
				
				var sender = split1[1];
				var room_no = split1[2];
				var msg = split1[3]
				var send_time = split1[4];
				
				checkRoom(id, room_no);
				
				
				var s_time = timeChange(send_time);
				
				if (split1[0] == "chat" && room_no == "${room_no}") {
					if (sender == "${id}") {
						$('#chatMessage').append(
								"<div class='to'>"
									+ "<div class='sendTime'>" + s_time + "</div>"
									+ "<div class='content2'>" + msg + "</div>"
								+ "</div>");
						var objDiv = document.getElementById("chatMessage");
						objDiv.scrollTop = objDiv.scrollHeight;
						
					} else {
						$('#chatMessage').append(
								"<div class='from'>"
									+ "<div class='sendTime'>" + sender + "</div><br>"
									+ "<div class='content1'>" + msg + "</div>"
									+ "<div class='sendTime'>" + s_time + "</div><br>"
								+ "</div>");
					}
				}
			} else if (check11 == 'chat.do' && check22 != 'room_no='+room_no) {
				
				console.log("chat.do는 맞지만 방번호가 다를 때");
				
				var sender = split1[1];
				var room_no = split1[2];
				var msg = split1[3]
				// var send_time = split1[4];
			    var loadUnread = split1[5];

			    
				var view =sender+"님의 메세지 : "+msg;
			    				
				$("#noticePopUp").children().remove();
			    $("#noticePopUp").val(view);
				
				$("#unreadNotice").children().remove();
				$("#unreadNotice").val(loadUnread);
				
			} else if (check3[4] == 'noticeMain.do') {
				
				console.log("noticeMain 화면에 있을 때");
				
				var sender = split1[1];
				var room_no = split1[2];
				var msg = split1[3]
				// var send_time = split1[4];
			    var loadUnread = split1[5];

			    
				var view =sender+"님의 메세지 : "+msg;
			    				
				$("#noticePopUp").children().remove();
			    $("#noticePopUp").val(view);
				
				$("#unreadNotice").children().remove();
				$("#unreadNotice").val(loadUnread);
				
				$("#unreadChat").children().remove();
				$("#unreadChat").val(loadUnreadChat);
				
			} else {						// 해당 채팅방 안에 있지 않을 때는 notice에 알림
				
				var sender = split1[1];
				var room_no = split1[2];
				var msg = split1[3]
				// var send_time = split1[4];
			    var loadUnread = split1[5];

			    var roomUnread = split1[6];
			    
				var view =sender+"님의 메세지 : "+msg;
			    				
				$("#noticePopUp").children().remove();
			    $("#noticePopUp").val(view);
				
				$("#unreadNotice").children().remove();
				$("#unreadNotice").val(loadUnread);
				
				if (check3[4] == 'chatMemberList.do') {
					document.querySelector('#room_no'+room_no).innerText=roomUnread;
					document.querySelector('#msgRoom_no'+room_no).innerText=msg;
					
					var content = document.querySelector('#room'+room_no);
					var parent = content.parentNode;
					parent.insertBefore(content, parent.firstChild);
				}
				
				
			}
			
		} else if (msg != null && msg.trim() != '' && split1[0] == 'notice'){
			
			console.log("header122 notice으로 시작하는 메세지 : "+msg);
			
		    var view = split1[2];
	    	$("#noticePopUp").children().remove();
		    $("#noticePopUp").val(view);
	    	
	    } else if (msg != null && msg.trim() != '' && split1[0] == 'inquiryReply'){
			
			console.log("header133 inquiryReply으로 시작하는 메세지 : "+msg);
			
		    var view = "문의 "+split1[2]+"에 대한 답변이 완료되었습니다.";
	    	$("#noticePopUp").children().remove();
		    $("#noticePopUp").val(view);
	    	
	    } else if (msg != null && msg.trim() != '' && split1[0] == 'joinRoom'){
			
			console.log("header141 joinRoom으로 시작하는 메세지 : "+msg);
			
		    var view = split1[1]+"님이 "+split1[3]+" 대화방에 참여하였습니다.";
	    	$("#noticePopUp").children().remove();
		    $("#noticePopUp").val(view);
	    	
	    } else if (msg != null && msg.trim() != '' && split1[0] == 'status') {
	    	
	    	console.log("header149 notice으로 시작하는 메세지 : "+msg);
	    	
	    	var view="";
	    	console.log(split1.length);
	    	
			for (var i = 1; i < split1.length; i++) {
				view = view+"<div>"+split1[i]+"</div>";
			}
		    
			view = "<div>현재 접속자</div>"+view;
			
			
		    $("#PopUp").children().remove();
		    $("#PopUp").append(view);
	    }
	};
		
	function loadStatus() {
		var status = "status,${id}";
		sock.send(status);
	}
	
	function sendNotice() {
		var userId = $('#userId').val();
		var notice = $('#notice').val();
		
		var notice = "notice,"+userId+","+notice;
		sock.send(notice);
		$('#notice').val("");
	}
			
	function inquiryReply() {
		var userId = $('#userId').val();
		var inquirySubject = $('#inquiry_subject').val();
		
		var inquiryReply = "inquiryReply,"+userId+","+inquirySubject;
		sock.send(inquiryReply);
	}
	
	function sendChat() {
		var msg = $('#message').val(); // 입력한 메세지 글 읽기
		
		if (msg==null || msg=="") {
			alert("메세지를 입력하세요!");
			return false;
		}
		
		var date = new Date();
	
		// ajax로 채팅 내용 저장
		$(function() {
			$.ajax({
				url : "saveMessage.do?id=${id}&msg="+msg+"&room_no=${room_no}",
				async : true,
				type : "POST",
				dataType : "html",
				cache : false
			});
		});
		
		var chatMsg = $('#message').val();
		var chat = "chat,${id},${room_no},"+chatMsg+","+date;
		sock.send(chat);
		
		$('#message').val(""); // 메세지로 입력한 글 지우기
	}
	
	function timeChange(time) {
		
		var hour1 = time.substr(16, 2);
		var minutes = time.substr(19, 2);
		var ampm;
		if (hour1 <12) {
			ampm = '오전';
		} else {
			ampm = '오후'
			hour2 = String(hour1 -12);
		}
		
		var changedTime = ampm+" "+hour2+" "+minutes;
		
		return changedTime;
	}
	
	function loadUnread() {
		
		var id = '${id}';
		
		$.post('loadUnread.do', 'id='+id, function(data) {
			$("#unreadNotice").val(data);
		});
		
	}
	
	
	function checkRoom(id, room_no) {
		$(function() {
			$.ajax({
				url : "checkRoom.do?id="+id+"&room_no="+room_no,
				async : true,
				type : "POST",
				dataType : "html",
				cache : false
			});
		});
	}
	
</script>
</head>
<body>
<tiles:insertAttribute name="body"></tiles:insertAttribute>
</body>
</html>