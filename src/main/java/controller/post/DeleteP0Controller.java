package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.service.UserManager;

public class DeleteP0Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeleteP0Controller.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
		int postId = Integer.parseInt(request.getParameter("postId"));
    	log.debug("Delete post0_Id : {}", postId);

		UserManager manager = UserManager.getInstance();
		manager.removeC0ByPostId(postId);		// 게시글의 댓글 먼저 정리
		manager.removePostInformation(postId);
		return "redirect:/community/info_community/info_community";
	}
}
