package controller.comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.CommentGroup;
import model.service.UserManager;

public class CreateC1Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(CreateC1Controller.class);
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HttpSession session = request.getSession();
    	int userId = UserSessionUtils.getLoginUserId(session);
    	int postId = Integer.parseInt(request.getParameter("postId"));
    	String content = request.getParameter("commentContent");
    	if (content == null || content.trim().isEmpty()) content = "댓글 작성 실패";

    	CommentGroup ci = new CommentGroup(content, postId, userId);
    	try {
    		UserManager manager = UserManager.getInstance();
    		manager.createC1(ci);
    		log.debug("Create CommentGroup : {}", ci);
    	} catch (Exception e) {
    		log.error("그룹 댓글 작성 실패", e);
    	}
    	return "redirect:/community/group_community/group_content?postId=" + postId;
    }
}
