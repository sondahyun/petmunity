package util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * 비밀번호 단방향 해싱(BCrypt) 유틸.
 * - 저장 시: 평문이면 해싱, 이미 해시면 그대로 둠(중복 해싱 방지)
 * - 검증 시: 저장값이 해시면 BCrypt 비교, 평문이면 직접 비교(레거시 호환)
 */
public class PasswordUtil {

    /** BCrypt 해시 형식($2a$/$2b$/$2y$)인지 판별 */
    public static boolean isHashed(String s) {
        return s != null && (s.startsWith("$2a$") || s.startsWith("$2b$") || s.startsWith("$2y$"));
    }

    /** 평문이면 해싱해서 반환, 이미 해시면 그대로 반환 */
    public static String hashIfNeeded(String raw) {
        if (raw == null) return null;
        if (isHashed(raw)) return raw;
        return BCrypt.hashpw(raw, BCrypt.gensalt());
    }

    /** 입력 평문이 저장된 비밀번호(해시 또는 레거시 평문)와 일치하는지 검증 */
    public static boolean matches(String raw, String stored) {
        if (raw == null || stored == null) return false;
        if (isHashed(stored)) {
            try {
                return BCrypt.checkpw(raw, stored);
            } catch (IllegalArgumentException e) {
                return false;
            }
        }
        return stored.equals(raw); // 레거시 평문 호환
    }
}
