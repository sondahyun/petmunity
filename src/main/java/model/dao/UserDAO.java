package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Pet;
import model.UserInfo;

/**
 * 사용자 관리를 위해 데이터베이스 작업을 전담하는 DAO 클래스
 * USERINFO 테이블에 사용자 정보를 추가, 수정, 삭제, 검색 수행 
 */
public class UserDAO {
	private JDBCUtil jdbcUtil = null;

	public UserDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}

	/**
	 * 사용자 관리 테이블에 새로운 사용자 생성.
	 */
	public int create(UserInfo user) throws SQLException {
		//
		String sql = "INSERT INTO UserInfo (USERID, LOGINID, LOGINPWD, USERNICKNAME, USERBIRTH, PHONENUMBER, GENDER, ADDRESS, email) VALUES (user_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] param = new Object[] { user.getLoginId(), user.getLoginPwd(), user.getUserNickname(),
				new java.sql.Date( user.getUserBirth().getTime()), user.getPhoneNumber(), user.getGender(), user.getAddress(), user.getEmail() };
		jdbcUtil.setSqlAndParameters(sql, param); // JDBCUtil 에 insert문과 매개 변수 설정
		
		try {
			int result = jdbcUtil.executeUpdate(); // insert 문 실행
			return result;
		} catch (Exception ex) {
			System.out.println("catch");
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); // resource 반환
		}
		return 0;
	}

	/**
	 * 기존의 사용자 정보를 수정.
	 */
	public int update(UserInfo user) throws SQLException {
		String sql = "UPDATE UserInfo "
				+ "SET loginId= ?, loginPwd=?, userNickname=?, userBirth=?, phoneNumber=?, address=?, email=? " + "WHERE userId=?";
		Object[] param = new Object[] { user.getLoginId(), user.getLoginPwd(), user.getUserNickname(), new java.sql.Date(user.getUserBirth().getTime()),
				user.getPhoneNumber(), user.getAddress(), user.getEmail(), user.getUserId() };
		jdbcUtil.setSqlAndParameters(sql, param); // // JDBCUtil에 update문과 매개 변수 설정

		try {
			int result = jdbcUtil.executeUpdate(); // update 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); //  resource 반환
		}
		return 0;
	}

	/**
	 * 사용자 ID에 해당하는 사용자를 삭제.
	 */
	public int withdraw(String loginId) throws SQLException {		// 소프트 삭제: 탈퇴 표시만
		String sql = "UPDATE UserInfo SET status=1 WHERE loginId=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { loginId });
		try {
			return jdbcUtil.executeUpdate();
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();
		}
		return 0;
	}

	public int remove(String loginId) throws SQLException {
		String sql = "DELETE FROM UserInfo WHERE loginId=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { loginId }); // JDBCUtil에 delete문과 매개 변수 설정

		try {
			int result = jdbcUtil.executeUpdate(); // delete 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); // resource 반환
		}
		return 0;
	}
	
	public UserInfo findUser(int userId) throws SQLException {
		String sql = "SELECT * " + "FROM UserInfo " + "WHERE userId=? ";	//userinfo와 pet join해서..pet여럿이므로 while문으로 첫번째 레코드에서(null)만 user객체 pet객체 따로 생성, 아레쪽 while 추가 pet객체 llist에 add
		jdbcUtil.setSqlAndParameters(sql, new Object[] { userId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			UserInfo user = null;
			if(rs.next()) {// 학생 정보 발견
				user = new UserInfo();// User 객체를 생성하여 학생 정보를 저장
				user.setUserId(rs.getInt("userId"));
				user.setLoginId(rs.getString("loginId"));
				user.setLoginPwd(rs.getString("loginPwd"));
				user.setUserNickname(rs.getString("userNickname"));
				user.setUserBirth(rs.getDate("userBirth"));
				user.setPhoneNumber(rs.getString("phoneNumber"));
				user.setGender(rs.getString("gender"));
				user.setAddress(rs.getString("address"));
				user.setEmail(rs.getString("email"));
				user.setJoinGroup(rs.getString("joinGroup"));
				user.setStatus(rs.getInt("status"));
				//pet 객체들의 list를 준다
				return user;
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	public UserInfo findUser(String loginId) throws SQLException {
		String sql = "SELECT * " + "FROM UserInfo " + "WHERE loginId=? ";	//userinfo와 pet join해서..pet여럿이므로 while문으로 첫번째 레코드에서(null)만 user객체 pet객체 따로 생성, 아레쪽 while 추가 pet객체 llist에 add
		jdbcUtil.setSqlAndParameters(sql, new Object[] { loginId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			UserInfo user = null;
			if(rs.next()) {// 학생 정보 발견
				user = new UserInfo();// User 객체를 생성하여 학생 정보를 저장
				user.setUserId(rs.getInt("userId"));
				user.setLoginId(rs.getString("loginId"));
				user.setLoginPwd(rs.getString("loginPwd"));
				user.setUserNickname(rs.getString("userNickname"));
				user.setUserBirth(rs.getDate("userBirth"));
				user.setPhoneNumber(rs.getString("phoneNumber"));
				user.setGender(rs.getString("gender"));
				user.setAddress(rs.getString("address"));
				user.setEmail(rs.getString("email"));
				user.setStatus(rs.getInt("status"));
				//pet 객체들의 list를 준다
				return user;
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

	/**
	 * 전체 사용자 정보를 검색하여 List에 저장 및 반환
	 */
	public boolean existingUser(String loginId) throws SQLException {
		String sql = "SELECT count(*) FROM UserInfo WHERE loginId=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { loginId }); // JDBCUtil에 query문 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행	
			if (rs.next()) {
				int count = rs.getInt(1);
				return (count == 1 ? true : false);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource ��ȯ
		}
		return false;
	}
	
	public int findUserId(String loginId) throws SQLException{
		String sql = "SELECT userId FROM USERINFO WHERE loginId = ?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { loginId }); // JDBCUtil에 query문 설정
		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행	
			if (rs.next()) {
				int userId = rs.getInt("userId");
				return userId;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource ��ȯ
		}
		return 0;
	}
	
	public int updateJoinGroup(String joinGroup, int userId) throws SQLException {
		String sql = "UPDATE UserInfo "
				+ "SET joinGroup=? " + "WHERE userId=?";
		Object[] param = new Object[] {joinGroup, userId};
		jdbcUtil.setSqlAndParameters(sql, param); // // JDBCUtil에 update문과 매개 변수 설정

		try {
			int result = jdbcUtil.executeUpdate(); // update 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); //  resource 반환
		}
		return 0;
	}
	
	public List<Integer> findUserWithGroup(String joinGroup) throws SQLException {
		String sql = "SELECT userId " + "FROM UserInfo " + "WHERE joinGroup=? ";	//userinfo와 pet join해서..pet여럿이므로 while문으로 첫번째 레코드에서(null)만 user객체 pet객체 따로 생성, 아레쪽 while 추가 pet객체 llist에 add
		jdbcUtil.setSqlAndParameters(sql, new Object[] { joinGroup }); // JDBCUtil에 query문과 매개 변수 설정
		ArrayList<Integer> joinList = new ArrayList<Integer>();
		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			while(rs.next()) {// 학생 정보 발견
				joinList.add(rs.getInt("userId"));
			}
			return joinList;
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
	

}
