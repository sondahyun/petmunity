package controller.post;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
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
import model.Pet;
import model.PostAdoption;
import model.UserInfo;

public class UpdateP3Controller implements Controller {
    private static final Logger log = LoggerFactory.getLogger(UpdateP3Controller.class);
    HttpSession session;
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
    	session = request.getSession();
		if (request.getMethod().equals("GET")) {	
    		// GET request: 커뮤니티 수정 form 요청	
    		UserManager manager = UserManager.getInstance();
    		int postId = Integer.parseInt(request.getParameter("postId"));

			PostAdoption pA = manager.findP3Adoption(postId);	// 수정하려는 커뮤니티 정보 검색
			request.setAttribute("pA", pA);			
			
			return "/community/adopt_community/adopt_info_update.jsp";   // 검색한 정보를 update form으로 전송     
	    }	
    	
    	// POST request (커뮤니티 정보가 parameter로 전송됨)
		Object loginId = session.getAttribute("loginId");
		int userId = UserSessionUtils.getLoginUserId(session);	
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
		if(check) {    // 전송된 요청 메시지의 타입이 multipart 인지 여부를 체크한다. (multipart/form-data)

			// 아래와 같이 하면 Tomcat 내부에 복사된 프로젝트 밑에 upload 폴더가 생성됨 
			ServletContext context = request.getServletContext();
			String path = (System.getProperty("user.home") + "/petmunity_upload");
			File dir = new File(path);			

			// Tomcat 외부의 폴더에 저장하려면 아래와 같이 절대 경로로 폴더 이름을 지정함
			// File dir = new File("C:/Temp");

			if (!dir.exists()) dir.mkdir();  // 전송된 파일을 저장할 폴더 생성

			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				// 파일 전송에 대한 기본적인 설정 Factory 클래스를 생성한다.
				factory.setSizeThreshold(10 * 1024);
				// 메모리에 한번에 저장할 데이터의 크기를 10KB로 설정한다.
				factory.setRepository(dir);
				// 전송된 데이터의 내용을 저장할 폴더를 지정한다.                

				ServletFileUpload upload = new ServletFileUpload(factory);
				// Factory 클래스를 통해 실제 업로드 되는 내용을 처리할 객체를 선언한다.
				upload.setSizeMax(10 * 1024 * 1024);
				// 업로드 될 파일의 최대 용량을 10MB로 설정한다.
				upload.setHeaderEncoding("utf-8");
				// 업로드 되는 내용의 인코딩 방식을 설정한다.

				List<FileItem> items = (List<FileItem>)upload.parseRequest(request);                
				// upload 객체에 전송된 모든 데이터(요청 파라미터)를 Collection 객체에 담는다.

				for (int i = 0; i < items.size(); ++i) {
					FileItem item = (FileItem)items.get(i);            

					String value = item.getString("utf-8"); // 넘어온 값에 대한 한글 처리를 한다.               	

					if (item.isFormField()) {  // item이 일반 데이터인 경우     
						if(item.getFieldName().equals("postId")) postId = Integer.parseInt(value);
						else if(item.getFieldName().equals("petId")) petId = Integer.parseInt(value);
						else if(item.getFieldName().equals("postTitle")) postTitle = value;
						else if(item.getFieldName().equals("kind")) kind = value;
						else if(item.getFieldName().equals("gender")) gender = value;
						else if(item.getFieldName().equals("age")) age = Integer.parseInt(value);
						else if(item.getFieldName().equals("health")) health = value;
						else if(item.getFieldName().equals("vaccination")) vaccination = value;
						else if(item.getFieldName().equals("postContent")) postContent = value;
						// parameter 이름이 pw이면 pw 변수에 값을 저장한다.
					}
					else {  // item이 파일인 경우   
						if (item.getFieldName().equals("filename")) {
							// parameter 이름이 picture이면 파일 저장을 한다.
							String oriFilename = item.getName();	// 파일 이름 획득 (자동 한글 처리 됨)
							if (oriFilename == null || oriFilename.trim().length() == 0) continue;
							// 파일이 전송되어 오지 않았다면 건너뜀

							// filename = oriFileName.substring(oriFileName.lastIndexOf("\\") + 1);                        					 
							// 파일 이름이 파일의 전체 경로까지 포함하기 때문에 이름 부분만 추출해야 한다.
							// 실제 C:\Web_Java\aaa.gif라고 하면 aaa.gif만 추출하기 위한 코드임

							filename = UUID.randomUUID().toString() + (oriFilename.lastIndexOf(".") >= 0 ? oriFilename.substring(oriFilename.lastIndexOf(".")) : "");  
							// 파일 이름이 중복되지 않도록 UUID(Universally Unique IDentifier)를 생성해서 원래의 이름 앞에 붙임


							// 또는 아래와 같이 원래의 파일의 확장자만 추출해서 UUID와 함께 파일 이름 생성
							// filename = UUID.randomUUID().toString() 
							// 		+ oriFilename.substring(oriFilename.lastIndexOf("."));

							//System.out.println("uploaded file: " + postFile);

							util.StorageUtil.save(filename, item.getInputStream(), item.getSize(), item.getContentType());
							// 파일을 upload 경로에 실제로 저장한다.
							// FileItem 객체로부터 바로 출력 저장할 수 있다.
						}
					}
				}

			} catch(SizeLimitExceededException e) {
				// 업로드 되는 파일의 크기가 지정된 최대 크기를 초과할 때 발생하는 예외처리
				e.printStackTrace();           
			} catch(FileUploadException e) {
				// 파일 업로드와 관련되어 발생할 수 있는 예외 처리
				e.printStackTrace();
			} catch(Exception e) {            
				e.printStackTrace();
			}
		}
		
      
		/*AdoptionAnimal aa = new AdoptionAnimal(petId, gender, age, health, vaccination, kind, filename, postId);
		PostAdoption pA = new PostAdoption(postId, postTitle, postContent, String.valueOf(loginId), aa);

    	//log.debug("Update postAdoption : {}", pA);
		try {
			UserManager manager = UserManager.getInstance();
			if(filename == null)
				manager.updateP2Petstargram(pp);	
			else
				manager.updateWithFilePetstargram(pp);
	        return "redirect:/community/petstar_community/petstar_community";			
    	}
    	catch(Exception e) {	// ���� �߻� �� ȸ������ form���� forwarding
            request.setAttribute("registerFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("post2", pp);
			
			return "/community/petstar_community/petstar_content_update.jsp";   // 검색한 정보를 update form으로 전송     
		}	*/		
		return null;
    }
}
