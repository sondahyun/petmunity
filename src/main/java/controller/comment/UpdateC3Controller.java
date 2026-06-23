package controller.comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.CommentAdoption;
import model.service.UserManager;

public class UpdateC3Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(UpdateC3Controller.class);
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HttpSession session = request.getSession();
    	int commentId = Integer.parseInt(request.getParameter("commentId"));
    	int userId = UserSessionUtils.getLoginUserId(session);
    	int postId = Integer.parseInt(request.getParameter("postId"));
    	String content = request.getParameter("commentContent");
    	if (content == null || content.trim().isEmpty()) content = "댓글 작성 실패";

    	CommentAdoption ci = new CommentAdoption(commentId, null, content, postId, userId);
    	try {
    		UserManager manager = UserManager.getInstance();
    		manager.updateC3(ci);
    		log.debug("Update CommentAdoption : {}", ci);
    	} catch (Exception e) {
    		log.error("입양 댓글 수정 실패", e);
    	}
    	return "redirect:/community/adopt_community/adopt_info?postId=" + postId;
    }
}
