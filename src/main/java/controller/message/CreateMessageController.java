package controller.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Message;
import model.UserInfo;
import model.service.UserManager;

public class CreateMessageController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(CreateMessageController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
       	if (request.getMethod().equals("GET")) {
    		log.debug("CreateMessageForm Request");
			return "/message/message_write.jsp";
	    }

    	HttpSession session = request.getSession();
		UserManager manager = UserManager.getInstance();

    	int userId = UserSessionUtils.getLoginUserId(session);
    	boolean toSelf = "on".equals(request.getParameter("toSelf"));
    	String loginId = request.getParameter("loginId");
    	String content = request.getParameter("content");
    	String mTitle = request.getParameter("mTitle");

    	int receiver;
    	if (toSelf) {
    		receiver = userId;					// '나에게 보내기'
    	} else {
    		UserInfo target = manager.findUser(loginId);
    		if (target == null) {				// 존재하지 않는 사용자에게는 보낼 수 없음
    			request.setAttribute("sendFailed", true);
    			request.setAttribute("sendError", "존재하지 않는 사용자입니다. 아이디를 확인해 주세요.");
    			request.setAttribute("mTitle", mTitle);
    			request.setAttribute("content", content);
    			return "/message/message_write.jsp";
    		}
    		receiver = target.getUserId();
    	}

       	Message message = new Message(userId, receiver, content, mTitle);
        log.debug("Create Message : {}", message);

		try {
			manager.createMessage(message);
	        return "redirect:/message/message2";	// 전송 후 보낸 쪽지함으로
		} catch (Exception e) {
            request.setAttribute("sendFailed", true);
			request.setAttribute("sendError", "쪽지 전송에 실패했습니다.");
			request.setAttribute("mTitle", mTitle);
			request.setAttribute("content", content);
			return "/message/message_write.jsp";
		}
    }
}
