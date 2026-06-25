package controller.user;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import model.UserInfo;
import model.service.UserManager;

public class UserSessionUtils {
    public static final String USER_SESSION_KEY = "userId";
    /* 현재 로그인한 사용자의 ID를 구함 */
    public static String getLoginId(HttpSession session) {
        String loginId = (String)session.getAttribute("loginId");
        return loginId;
    }
    
    public static int getLoginUserId(HttpSession session) {
        int userId = Integer.parseInt((String)session.getAttribute(USER_SESSION_KEY));
        return userId;
    }
    
    public static String getUserNickName(int userId) {
    	UserManager manager = UserManager.getInstance();
    	try {
			UserInfo user = manager.findUser(userId);
			if (user == null) return "(알 수 없음)";
			if (user.getStatus() == 1) return "탈퇴한 회원";
			return user.getUserNickname();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return null;
    }
    
    public static String getUserNickName(String loginId) {
    	UserManager manager = UserManager.getInstance();
    	try {
			UserInfo user = manager.findUser(loginId);
			if (user == null) return "(알 수 없음)";
			if (user.getStatus() == 1) return "탈퇴한 회원";
			return user.getUserNickname();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    	return null;
    }

    /* 로그인한 상태인지를 검사 */
    public static boolean hasLogined(HttpSession session) {
        if (getLoginId(session) != null) {
            return true;
        }
        return false;
    }

    /* 현재 로그인한 사용자의 ID가 userId인지 검사 */
    public static boolean isLoginUser(String userId, HttpSession session) {
        String loginUser = getLoginId(session);
        if (loginUser == null) {
            return false;
        }
        return loginUser.equals(userId);
    }
}
