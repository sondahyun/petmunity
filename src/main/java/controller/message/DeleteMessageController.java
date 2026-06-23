package controller.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.UserInfo;
import model.service.UserManager;

public class DeleteMessageController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeleteMessageController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
		int messageId = Integer.parseInt(request.getParameter("messageId"));
    	log.debug("Delete Message : {}", messageId);

    	UserManager manager = UserManager.getInstance();			
		manager.removeMessage(messageId);
		return "redirect:/message/message";	// 받은 쪽지함으로 redirect
	}
}
