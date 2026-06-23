package controller.post;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.service.UserManager;

public class DeleteP2Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeleteP2Controller.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
		int postId = Integer.parseInt(request.getParameter("postId"));
    	log.debug("Delete post2_Id : {}", postId);

		UserManager manager = UserManager.getInstance();
		manager.removeC2ByPostId(postId);		// 게시글의 댓글 먼저 정리
		manager.removeP2Petstargram(postId);
		return "redirect:/community/petstar_community/petstar_community";
	}
}
