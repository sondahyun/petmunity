package controller.pet;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Pet;
import model.service.UserManager;

public class UpdatePetController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(UpdatePetController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	HttpSession session = request.getSession();
    	if (!UserSessionUtils.hasLogined(session)) {
    		return "redirect:/user/login/form";
    	}
    	String loginId = (String) session.getAttribute("loginId");

    	if (request.getMethod().equals("GET")) {
    		// GET: 내 펫 정보를 불러와 수정 form 으로 이동
    		UserManager manager = UserManager.getInstance();
    		Pet pet = manager.findPet(loginId);
    		if (pet == null) return "redirect:/myPage/myPage";
    		request.setAttribute("pet", pet);
    		return "/myPage/pet_update.jsp";
    	}

    	// POST: 수정 내용 저장
    	int petId = -1;
    	int age = -1;
    	String name = null, gender = null, health = null, vaccination = null, kind = null, filename = null;

    	boolean check = ServletFileUpload.isMultipartContent(request);
    	if (check) {
    		String path = (System.getProperty("user.home") + "/petmunity_upload");
    		File dir = new File(path);
    		if (!dir.exists()) dir.mkdir();
    		try {
    			DiskFileItemFactory factory = new DiskFileItemFactory();
    			factory.setSizeThreshold(10 * 1024);
    			factory.setRepository(dir);
    			ServletFileUpload upload = new ServletFileUpload(factory);
    			upload.setSizeMax(10 * 1024 * 1024);
    			upload.setHeaderEncoding("utf-8");
    			List<FileItem> items = (List<FileItem>) upload.parseRequest(request);
    			for (int i = 0; i < items.size(); ++i) {
    				FileItem item = (FileItem) items.get(i);
    				String value = item.getString("utf-8");
    				if (item.isFormField()) {
    					if (item.getFieldName().equals("petId")) petId = Integer.parseInt(value);
    					else if (item.getFieldName().equals("name")) name = value;
    					else if (item.getFieldName().equals("age")) age = Integer.parseInt(value);
    					else if (item.getFieldName().equals("kind")) kind = value;
    					else if (item.getFieldName().equals("gender")) gender = value;
    					else if (item.getFieldName().equals("vaccination")) vaccination = value;
    					else if (item.getFieldName().equals("health")) health = value;
    				} else {
    					if (item.getFieldName().equals("filename")) {
    						String oriFilename = item.getName();
    						if (oriFilename == null || oriFilename.trim().length() == 0) continue;
    						filename = UUID.randomUUID().toString() + (oriFilename.lastIndexOf(".") >= 0 ? oriFilename.substring(oriFilename.lastIndexOf(".")) : "");
    						util.StorageUtil.save(filename, item.getInputStream(), item.getSize(), item.getContentType());
    					}
    				}
    			}
    		} catch (SizeLimitExceededException e) {
    			e.printStackTrace();
    		} catch (FileUploadException e) {
    			e.printStackTrace();
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    	}

    	Pet updatePet = new Pet(petId, name, gender, age, health, vaccination, kind, filename, loginId);
    	log.debug("Update Pet : {}", updatePet);

    	try {
    		UserManager manager = UserManager.getInstance();
    		if (filename == null) manager.updatePet(updatePet);				// 사진 유지
    		else manager.updatePetWithFile(updatePet);						// 사진 변경
    		return "redirect:/myPage/myPage";
    	} catch (Exception e) {
    		log.error("펫 수정 실패", e);
    		request.setAttribute("updateFailed", true);
    		request.setAttribute("exception", e);
    		request.setAttribute("pet", updatePet);
    		return "/myPage/pet_update.jsp";
    	}
    }
}
