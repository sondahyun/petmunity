package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import model.Apply;
import model.Pet;
import model.PostAdoption;

/**
 * 사용자 관리를 위해 데이터베이스 작업을 전담하는 DAO 클래스
 * PostInformation 테이블에 사용자 정보를 추가, 수정, 삭제, 검색 수행 
 */
public class ApplyDAO {
	private JDBCUtil jdbcUtil = null;

	public ApplyDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}

	/**
	 * 사용자 관리 테이블에 새로운 사용자 생성.
	 */
	public int create(Apply apply) throws SQLException {
		String sql = "INSERT INTO APPLYFORADOPTION VALUES (apply_seq.nextval,?,?,?,?,?,?,?,?,?,?,?)";
		Object[] param = new Object[] { apply.getName(), apply.getaType(), new java.sql.Date( apply.getBirth().getTime()), apply.getPhoneNumber(), apply.getHopeConditions(), 
										apply.getAllergy(), apply.getAddress(), apply.getHousingType(), apply.getResolution(), apply.getEtc(), apply.getPetId()};
		jdbcUtil.setSqlAndParameters(sql, param); // JDBCUtil 에 insert문과 매개 변수 설정

		try {
			int result = jdbcUtil.executeUpdate(); // insert 문 실행
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

	/**
	 * 사용자 ID에 해당하는 사용자를 삭제.
	 */
	public int removeByPostId(int postId) throws SQLException {
		String sql = "DELETE FROM APPLYFORADOPTION WHERE petId IN (SELECT petId FROM AdoptionAnimal WHERE postId=?)";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { postId });
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

	public int remove(int applyId) throws SQLException {
		String sql = "DELETE FROM APPLYFORADOPTION WHERE applyId=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { applyId }); // JDBCUtil에 delete문과 매개 변수 설정

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

	public Apply findApply(int applyId) throws SQLException {
		String sql = "SELECT * " + "FROM APPLYFORADOPTION " + "WHERE applyId=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { applyId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			Apply apply = null;
			if(rs.next()) {// 학생 정보 발견
				apply = new Apply();// post 객체를 생성하여 정보를 저장
				apply.setApplyId(applyId);
				apply.setName(rs.getString("name"));
				apply.setaType(rs.getInt("aType"));
				apply.setBirth(rs.getDate("birth"));
				apply.setPhoneNumber(rs.getString("phoneNumber"));
				apply.setHopeConditions(rs.getString("hopeConditions"));
				apply.setAllergy(rs.getString("allergy"));
				apply.setAddress(rs.getString("address"));
				apply.setHousingType(rs.getString("housingType"));
				apply.setResolution(rs.getString("resolution"));
				apply.setEtc(rs.getString("etc"));
				apply.setPetId(rs.getInt("petId"));
			}
						
			return apply;
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

	/**
	 * 전체 커뮤니티 정보를 검색하여 List에 저장 및 반환
	 */
	public List<Apply> findApplyList() throws SQLException {
        String sql = "SELECT * "
        		   + "FROM ApplyForAdoption";
        
		jdbcUtil.setSqlAndParameters(sql, null);		// JDBCUtil에 query문 설정
					
		try {
			ResultSet rs = jdbcUtil.executeQuery();			// query 실행			
			List<Apply> adoptionList = new ArrayList<Apply>();	// PostInformation들의 리스트 생성
			while (rs.next()) {
				Apply apply = new Apply(
						rs.getInt("applyId"),
						rs.getString("name"),
						rs.getInt("aType"),
						rs.getDate("birth"),
						rs.getString("phoneNumber"),
						rs.getString("hopeConditions"),
						rs.getString("allergy"),
						rs.getString("address"),
						rs.getString("housingType"),
						rs.getString("resolution"),
						rs.getString("etc"),
						rs.getInt("petId")
				);
				adoptionList.add(apply);				// List에 PostInformation 객체 저장
			}
			return adoptionList;					
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}
	
}
