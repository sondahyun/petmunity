package controller.comment;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.CommentInformation;
import model.PostInformation;
import model.service.UserManager;

public class CreateC0Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(CommentInformation.class);
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		 * if (request.getMethod().equals("GET")) { log.debug("info_community add");
		 * return "/community/info_community/add_content.jsp"; // registerForm���� ����
		 * }
		 */
    	HttpSession session = request.getSession();

       	System.out.println("commentP0");
       	
       	int userId = UserSessionUtils.getLoginUserId(session);
       	int postId = Integer.parseInt(request.getParameter("postId"));
       	String content = request.getParameter("commentContent");
       	
        // 서버측 검증: 빈 댓글은 저장하지 않고 원래 글로 돌아감
        if (content == null || content.trim().isEmpty()) {
            session.setAttribute("postId", String.valueOf(postId));
            return "redirect:/community/info_community/info_content";
        }
        content = content.trim();

       	System.out.println("userId, postId, content : "+ userId+" "+postId+" "+content);

    	session.setAttribute("postId", String.valueOf(postId));

       	
		CommentInformation ci = new CommentInformation(
			content,
			postId,
			userId
			);		
		
		try {
			UserManager manager = UserManager.getInstance();
			manager.createC0(ci);
			
	    	log.debug("Create CommentInformation : {}", ci);
	        return "redirect:/community/info_community/info_content";	// 성공 시 커뮤니티 화면으로 redirect
	        
		} catch (Exception e) {		// 예외 발생 시 입력 form으로 forwarding
            request.setAttribute("creationFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("ci", ci);
			return "/community/info_community/info_content.jsp";
		}
    }
}
