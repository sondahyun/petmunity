package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.UserInfo;
import model.service.UserManager;

public class DeleteUserController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeleteUserController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {

		UserManager manager = UserManager.getInstance();
		HttpSession session = request.getSession();
		if (!UserSessionUtils.hasLogined(session)) {
			return "redirect:/user/login/form";
		}
		String loginId = UserSessionUtils.getLoginId(session);
		log.debug("Withdraw User (soft delete) : {}", loginId);

		manager.withdrawUser(loginId);		// 소프트 삭제: 데이터는 보존하고 탈퇴 표시만
		session.removeAttribute(UserSessionUtils.USER_SESSION_KEY);
		session.invalidate();

		return "redirect:/main/main";		// 메인으로 redirect
	}
}
