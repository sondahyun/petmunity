package controller;

import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.StorageUtil;

/**
 * 업로드된 이미지를 스트리밍한다. StorageUtil이 S3 또는 로컬에서 읽어온다.
 * 요청: /image?file=<UUID.ext>
 */
public class ImageController implements Controller {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String file = request.getParameter("file");

        // 경로 조작 방지: 파일명만 허용
        if (file == null || file.isEmpty()
                || file.contains("..") || file.contains("/") || file.contains("\\")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return null;
        }

        InputStream in = StorageUtil.read(file);
        if (in == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return null;
        }

        response.setContentType(contentType(file));
        try (InputStream input = in; OutputStream out = response.getOutputStream()) {
            byte[] buf = new byte[8192];
            int n;
            while ((n = input.read(buf)) != -1) out.write(buf, 0, n);
            out.flush();
        }
        return null;
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
