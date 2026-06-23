package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.service.UserManager;

public class DeleteP1Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeleteP1Controller.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
		int postId = Integer.parseInt(request.getParameter("postId"));
    	log.debug("Delete post1_Id : {}", postId);

		UserManager manager = UserManager.getInstance();
		manager.removeC1ByPostId(postId);		// 게시글의 댓글 먼저 정리
		manager.removePostGroup(postId);
		return "redirect:/community/group_community/group_community";
	}
}
