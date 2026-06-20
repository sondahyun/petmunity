package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 업로드된 이미지를 앱이 직접 읽어 스트리밍한다.
 * Tomcat 기본 정적 서빙은 런타임에 업로드된 파일을 즉시 인식하지 못해
 * 방금 올린 이미지가 잠시 404가 되는 문제가 있어, 이를 우회한다.
 * 요청: /image?file=<UUID.ext>
 */
public class ImageController implements Controller {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String file = request.getParameter("file");

        // 경로 조작 방지: 파일명만 허용 (디렉터리 구분자/상위 경로 금지)
        if (file == null || file.isEmpty()
                || file.contains("..") || file.contains("/") || file.contains("\\")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return null;
        }

        ServletContext context = request.getServletContext();
        File target = new File((System.getProperty("user.home") + "/petmunity_upload"), file);
        if (!target.exists() || !target.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return null;
        }

        response.setContentType(contentType(file));
        response.setContentLengthLong(target.length());

        try (InputStream in = new FileInputStream(target);
             OutputStream out = response.getOutputStream()) {
            byte[] buf = new byte[8192];
            int n;
            while ((n = in.read(buf)) != -1) out.write(buf, 0, n);
            out.flush();
        }
        return null;   // 응답을 직접 처리했으므로 forward/redirect 없음
    }

    private String contentType(String name) {
        String n = name.toLowerCase();
        if (n.endsWith(".jpg") || n.endsWith(".jpeg")) return "image/jpeg";
        if (n.endsWith(".png")) return "image/png";
        if (n.endsWith(".gif")) return "image/gif";
        if (n.endsWith(".bmp")) return "image/bmp";
        if (n.endsWith(".webp")) return "image/webp";
        return "application/octet-stream";
    }
}
