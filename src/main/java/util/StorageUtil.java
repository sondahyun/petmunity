package util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.dao.ConnectionManager;

/**
 * 업로드 파일 저장소.
 * 이미지를 Oracle DB의 BLOB 컬럼(UploadedFile 테이블)에 저장한다.
 * S3나 로컬 파일시스템에 의존하지 않으므로, DB만 있으면 이미지까지 그대로 따라온다.
 *
 *   CREATE TABLE UploadedFile (
 *     fileKey     VARCHAR2(255) NOT NULL PRIMARY KEY,
 *     contentType VARCHAR2(100),
 *     fileData    BLOB
 *   );
 *
 * 게시글/펫의 fileName 컬럼에는 기존처럼 key(UUID + 확장자)만 저장하고,
 * 실제 바이트는 이 테이블에 보관한다. 조회는 ImageController(/image?file=key)가 담당.
 */
public class StorageUtil {
    private static final ConnectionManager connMan = new ConnectionManager();

    /** 업로드 파일을 key 이름으로 DB(BLOB)에 저장 */
    public static void save(String key, InputStream in, long size, String contentType) throws IOException {
        byte[] data = readAll(in);
        String sql = "INSERT INTO UploadedFile (fileKey, contentType, fileData) VALUES (?, ?, ?)";
        try (Connection conn = connMan.getConnection()) {
            conn.setAutoCommit(true);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, key);
                ps.setString(2, contentType);
                ps.setBinaryStream(3, new ByteArrayInputStream(data), data.length);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            throw new IOException("이미지 저장 실패: " + key, e);
        }
    }

    /** key에 해당하는 파일 읽기 (없으면 null) */
    public static InputStream read(String key) {
        String sql = "SELECT fileData FROM UploadedFile WHERE fileKey=?";
        try (Connection conn = connMan.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, key);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    InputStream blobIn = rs.getBinaryStream(1);
                    if (blobIn == null) return null;
                    // 커넥션이 닫히기 전에 전부 읽어 메모리로 반환
                    return new ByteArrayInputStream(readAll(blobIn));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static byte[] readAll(InputStream in) throws IOException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        byte[] buf = new byte[8192];
        int n;
        while ((n = in.read(buf)) != -1) bos.write(buf, 0, n);
        return bos.toByteArray();
    }
}
