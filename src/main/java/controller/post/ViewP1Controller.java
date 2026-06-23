package controller.post;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.service.UserManager;
import model.PostGroup;

public class ViewP1Controller implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {			
    	HttpSession session = request.getSession();

    	System.out.println("loginId : "+ session.getAttribute("loginId"));
    	
    	if (!UserSessionUtils.hasLogined(session)) {
            return "/user/loginForm.jsp";		
        }
    	
		UserManager manager = UserManager.getInstance();
		int postId=Integer.parseInt(request.getParameter("postId"));
		
    
		System.out.println("postId "+postId);
		
    	PostGroup post = null;
		post = manager.findP1Group(postId);	
		List<Integer> joinUser = manager.findUserWithGroup(post.getPostTitle());
		
		request.setAttribute("post", post);
		request.setAttribute("headCount", post.getHeadCount());
		request.setAttribute("joinUser", joinUser);
		request.setAttribute("c1List", manager.findC1List());		// 그룹 게시글 댓글 목록

		return "/community/group_community/group_content.jsp";				
    }
}
