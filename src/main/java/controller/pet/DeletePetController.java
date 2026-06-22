package controller.pet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.UserInfo;
import model.service.UserManager;

public class DeletePetController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(DeletePetController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
		int petId = Integer.parseInt(request.getParameter("petId"));
    	log.debug("Delete Pet : {}", petId);

    	UserManager manager = UserManager.getInstance();			
		manager.removePet(petId);
		return "redirect:/myPage/myPage";	// 마이페이지로 redirect
	}
}
