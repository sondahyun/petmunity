package util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

/**
 * 업로드 파일 저장소.
 * classpath의 aws.properties에 S3 설정(버킷/리전/키)이 채워져 있으면 S3에 저장하고,
 * 없으면(또는 키가 placeholder면) 자동으로 로컬 폴더(~/petmunity_upload)에 저장한다.
 * → 키를 넣기 전까지는 로컬 모드로 그대로 동작하고, 키만 채우면 S3로 전환됨.
 */
public class StorageUtil {
    private static final String LOCAL_DIR = System.getProperty("user.home") + File.separator + "petmunity_upload";

    private static AmazonS3 s3;
    private static String bucket;
    private static boolean s3Enabled = false;

    static {
        try (InputStream in = StorageUtil.class.getResourceAsStream("/aws.properties")) {
            if (in != null) {
                Properties p = new Properties();
                p.load(in);
                bucket = trim(p.getProperty("aws.s3.bucket"));
                String region = trim(p.getProperty("aws.s3.region"));
                String ak = trim(p.getProperty("aws.accessKeyId"));
                String sk = trim(p.getProperty("aws.secretAccessKey"));
                if (notBlank(bucket) && notBlank(region) && notBlank(ak) && notBlank(sk)
                        && !ak.startsWith("YOUR_")) {
                    s3 = AmazonS3ClientBuilder.standard()
                            .withRegion(region)
                            .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(ak, sk)))
                            .build();
                    s3Enabled = true;
                    System.out.println("[StorageUtil] S3 모드 (bucket=" + bucket + ", region=" + region + ")");
                }
            }
        } catch (Throwable e) {
            e.printStackTrace();
        }
        if (!s3Enabled) System.out.println("[StorageUtil] 로컬 모드 (" + LOCAL_DIR + ")");
    }

    public static boolean isS3() { return s3Enabled; }

    /** 업로드 파일을 key 이름으로 저장 */
    public static void save(String key, InputStream in, long size, String contentType) throws IOException {
        if (s3Enabled) {
            ObjectMetadata meta = new ObjectMetadata();
            if (size > 0) meta.setContentLength(size);
            if (contentType != null && !contentType.isEmpty()) meta.setContentType(contentType);
            s3.putObject(new PutObjectRequest(bucket, key, in, meta));
        } else {
            File dir = new File(LOCAL_DIR);
            if (!dir.exists()) dir.mkdirs();
            try (OutputStream out = new FileOutputStream(new File(dir, key))) {
                copy(in, out);
            }
        }
    }

    /** key에 해당하는 파일 읽기 (없으면 null) */
    public static InputStream read(String key) {
        try {
            if (s3Enabled) {
                return s3.getObject(bucket, key).getObjectContent();
            } else {
                File f = new File(LOCAL_DIR, key);
                if (!f.exists() || !f.isFile()) return null;
                return new FileInputStream(f);
            }
        } catch (Exception e) {
            return null;
        }
    }

    private static void copy(InputStream in, OutputStream out) throws IOException {
        byte[] buf = new byte[8192];
        int n;
        while ((n = in.read(buf)) != -1) out.write(buf, 0, n);
        out.flush();
    }

    private static String trim(String s) { return s == null ? null : s.trim(); }
    private static boolean notBlank(String s) { return s != null && !s.isEmpty(); }
}
