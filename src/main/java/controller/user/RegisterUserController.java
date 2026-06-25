package controller.user;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.UserInfo;
import model.service.ExistingUserException;
import model.service.UserManager;

public class RegisterUserController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(RegisterUserController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HttpSession session = request.getSession();

       	if (request.getMethod().equals("GET")) {	
       		// GET request: 회원정보 등록 form 요청	
    		log.debug("RegisterForm Request");
    		//System.out.println("여기1");
			return "/user/register_person.jsp";   //  registerForm���� ����     	
	    }	

     // POST request (회원정보가 parameter로 전송됨)
       	log.debug("befor Create User : {}");

       	// 서버측 검증: 필수 입력값 확인
       	String loginId      = request.getParameter("loginId");
       	String loginPwd     = request.getParameter("loginPwd");
       	String userNickname = request.getParameter("userNickname");
       	String userBirth    = request.getParameter("userBirth");
       	String phone1Param  = request.getParameter("phone1");
       	String phone2       = request.getParameter("phone2");
       	String phone3       = request.getParameter("phone3");
       	String gender       = request.getParameter("gender");
       	String address      = request.getParameter("address");
       	String email        = request.getParameter("email");

       	if (isBlank(loginId) || isBlank(loginPwd) || isBlank(userNickname)
       			|| isBlank(userBirth) || isBlank(phone1Param) || isBlank(phone2)
       			|| isBlank(phone3) || isBlank(gender) || isBlank(address) || isBlank(email)) {
       		request.setAttribute("registerFailed", true);
       		request.setAttribute("errorMessage", "모든 필수 항목을 입력해 주세요.");
       		return "/user/register_person.jsp";
       	}

       	String phone1;
       	switch (phone1Param) {
       	case "0": phone1 = "010"; break;
       	case "1": phone1 = "080"; break;
       	case "2": phone1 = "070"; break;
       	case "3": phone1 = "02";  break;
       	default:  phone1 = "010";
       	}
       	String phoneNumber = phone1 + "-" + phone2 + "-" + phone3;

       	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
       	formatter.setLenient(false);
       	Date birth;
       	try {
       		birth = formatter.parse(userBirth);
       	} catch (java.text.ParseException e) {
       		request.setAttribute("registerFailed", true);
       		request.setAttribute("errorMessage", "생년월일 형식이 올바르지 않습니다.");
       		return "/user/register_person.jsp";
       	}

       	UserInfo user = new UserInfo(
			loginId,
			loginPwd,
			userNickname,
			birth,
			phoneNumber,
			gender,
			address,
			email
			);
		
        log.debug("Create User : {}", user);

		try {
			UserManager manager = UserManager.getInstance();
			manager.create(user);
			
			System.out.println("user 성공");
	       	session.setAttribute("logId", loginId);
	       	//return response.sendRedirect("/user/register_pet/form?loginId="+loginId);
	        return "redirect:/user/register_pet/form";	// ���� �� ����� ����Ʈ ȭ������ redirect
	        
		} catch (ExistingUserException e) {	// ���� �߻� �� ȸ������ form���� forwarding
            request.setAttribute("registerFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("user", user);
			
			return "/user/register_person.jsp";
		}
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}

