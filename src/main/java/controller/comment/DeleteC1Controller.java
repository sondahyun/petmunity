package controller.comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.service.UserManager;

public class DeleteC1Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeleteC1Controller.class);
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	int commentId = Integer.parseInt(request.getParameter("commentId"));
    	int postId = Integer.parseInt(request.getParameter("postId"));
    	log.debug("Delete c1_Id : {}", commentId);

    	UserManager manager = UserManager.getInstance();
    	manager.removeC1(commentId);
    	return "redirect:/community/group_community/group_content?postId=" + postId;
    }
}
