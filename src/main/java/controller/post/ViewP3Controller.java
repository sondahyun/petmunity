package controller.post;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.service.UserManager;
import model.PostAdoption;
import model.PostInformation;
import model.UserInfo;

public class ViewP3Controller implements Controller {
	private static final Logger log = LoggerFactory.getLogger(PostAdoption.class);
    
	
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {			
    	if (!UserSessionUtils.hasLogined(request.getSession())) {
    		return "/user/loginForm.jsp"; 
    	}
    	log.debug("여긴 p3 controller : {}");
    	HttpSession session = request.getSession();
		UserManager manager = UserManager.getInstance();
		
		int postId = -1;
		if(request.getParameter("postId") != null)
			postId = Integer.parseInt(request.getParameter("postId"));
		else if(request.getParameter("adoptId")!=null)
			postId = Integer.parseInt(request.getParameter("adoptId"));
		else
			postId = Integer.parseInt((String)session.getAttribute("postId"));
				
    	PostAdoption pA = null;
		pA = manager.findP3Adoption(postId);
		log.debug("findP3 : {}", pA);
		
		if(request.getParameter("applyId")!=null) {
			manager.updateP3Approval(pA);
		}
		request.setAttribute("pA", pA);
		request.setAttribute("c3List", manager.findC3List());			// 입양 게시글 댓글 목록
		return "/community/adopt_community/adopt_info.jsp";				// ����� ���� ȭ������ �̵�
 	
    }

}
