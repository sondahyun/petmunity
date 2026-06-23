package controller.comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.service.UserManager;

public class DeleteC3Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeleteC3Controller.class);
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	int commentId = Integer.parseInt(request.getParameter("commentId"));
    	int postId = Integer.parseInt(request.getParameter("postId"));
    	log.debug("Delete c3_Id : {}", commentId);

    	UserManager manager = UserManager.getInstance();
    	manager.removeC3(commentId);
    	return "redirect:/community/adopt_community/adopt_info?postId=" + postId;
    }
}
