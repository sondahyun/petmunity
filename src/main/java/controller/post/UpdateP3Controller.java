package controller.post;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
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
import model.service.UserManager;
import model.AdoptionAnimal;
import model.PostAdoption;

public class UpdateP3Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(UpdateP3Controller.class);
    HttpSession session;

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	session = request.getSession();
		if (request.getMethod().equals("GET")) {
    		// GET request: 수정 form 요청
    		UserManager manager = UserManager.getInstance();
    		int postId = Integer.parseInt(request.getParameter("postId"));
			PostAdoption pA = manager.findP3Adoption(postId);
			request.setAttribute("pA", pA);
			return "/community/adopt_community/adopt_info_update.jsp";
	    }

    	// POST request
		Object loginId = session.getAttribute("loginId");
		int postId = -1;
		int petId = -1;
    	String postTitle = null;
    	String postContent = null;
    	String kind = null;
    	String gender = null;
    	int age = -1;
    	String health = null;
    	String vaccination = null;
    	String filename = null;

		boolean check = ServletFileUpload.isMultipartContent(request);
		if(check) {
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

				List<FileItem> items = (List<FileItem>)upload.parseRequest(request);

				for (int i = 0; i < items.size(); ++i) {
					FileItem item = (FileItem)items.get(i);
					String value = item.getString("utf-8");

					if (item.isFormField()) {
						if(item.getFieldName().equals("postId")) postId = Integer.parseInt(value);
						else if(item.getFieldName().equals("petId")) petId = Integer.parseInt(value);
						else if(item.getFieldName().equals("postTitle")) postTitle = value;
						else if(item.getFieldName().equals("kind")) kind = value;
						else if(item.getFieldName().equals("gender")) gender = value;
						else if(item.getFieldName().equals("age")) age = Integer.parseInt(value);
						else if(item.getFieldName().equals("health")) health = value;
						else if(item.getFieldName().equals("vaccination")) vaccination = value;
						else if(item.getFieldName().equals("postContent")) postContent = value;
					}
					else {
						if (item.getFieldName().equals("filename")) {
							String oriFilename = item.getName();
							if (oriFilename == null || oriFilename.trim().length() == 0) continue;
							filename = UUID.randomUUID().toString() + (oriFilename.lastIndexOf(".") >= 0 ? oriFilename.substring(oriFilename.lastIndexOf(".")) : "");
							util.StorageUtil.save(filename, item.getInputStream(), item.getSize(), item.getContentType());
						}
					}
				}
			} catch(SizeLimitExceededException e) {
				e.printStackTrace();
			} catch(FileUploadException e) {
				e.printStackTrace();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		AdoptionAnimal aa = new AdoptionAnimal(petId, gender, age, health, vaccination, kind, filename, postId);
		PostAdoption pA = new PostAdoption(postId, postTitle, postContent, String.valueOf(loginId), aa);
		log.debug("Update PostAdoption : {}", pA);

		try {
			UserManager manager = UserManager.getInstance();
			manager.updateP3Adoption(pA);				// 글 제목/내용 수정
			if (filename == null) manager.updateAdoptionAnimal(aa);			// 동물 정보 수정(사진 유지)
			else manager.updateAdoptionAnimalWithFile(aa);					// 동물 정보 + 사진 수정
			return "redirect:/community/adopt_community/adopt_info?postId=" + postId;
		} catch (Exception e) {
			log.error("입양 수정 실패", e);
			request.setAttribute("registerFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("pA", pA);
			return "/community/adopt_community/adopt_info_update.jsp";
		}
    }
}
