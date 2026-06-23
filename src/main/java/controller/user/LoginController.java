package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.pet.RegisterPetController;
import model.UserInfo;
import model.service.UserManager;

public class LoginController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(LoginController.class);
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HttpSession session = request.getSession();

    	if (request.getMethod().equals("GET")) {
    		String logId = null;
    		logId = (String)session.getAttribute("logId");
    		if(logId != null) {
    			session.removeAttribute("logId");
    		}
       		// GET request: 회원정보 등록 form 요청	
    		log.debug("LoginController Request");
    		//System.out.println("여기1");
			return "redirect:/user/login/form";   //  registerForm���� ����     	
	    }	
    	String loginId = request.getParameter("loginId");
		String loginPwd = request.getParameter("password");
		
		
		try {
			// �𵨿� �α��� ó���� ����
			UserManager manager = UserManager.getInstance();
			manager.login(loginId, loginPwd);
			UserInfo loginUser = manager.findUser(loginId);
			if (loginUser != null && loginUser.getStatus() == 1) {	// 탈퇴(소프트 삭제)한 계정은 로그인 거부
				request.setAttribute("loginFailed", true);
				request.setAttribute("withdrawn", true);
				return "/user/loginForm.jsp";
			}
			int userId = manager.findUserId(loginId);
			System.out.println(userId);
			
			// ���ǿ� ����� ���̵� ����
            session.setAttribute("loginId", loginId);
            session.setAttribute(UserSessionUtils.USER_SESSION_KEY, String.valueOf(userId));
            
            return "redirect:/";			
		} catch (Exception e) {
			/* UserNotFoundException�̳� PasswordMismatchException �߻� ��
			 * �ٽ� login form�� ����ڿ��� �����ϰ� ���� �޼����� ���
			 */
			System.out.println("로그인실패");
            request.setAttribute("loginFailed", true);
			request.setAttribute("exception", e);
            return "/user/loginForm.jsp";			
		}	
    }
}
