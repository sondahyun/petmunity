package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Pet;
import model.PostInformation;
import model.Pet;

public class PetDAO {
	private JDBCUtil jdbcUtil = null;

	public PetDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}

	/**
	 * 사용자 관리 테이블에 새로운 사용자 생성.
	 */
	public int create(Pet pet) throws SQLException {
		//
		String sql = "INSERT INTO Pet VALUES (pet_seq.nextval, ?, ?, ?, ?, ?, ?, ?,?)";
		Object[] param = new Object[] {pet.getName(), pet.getGender(), pet.getAge(), pet.getHealth(), pet.getVaccination(), pet.getKind(), pet.getFilename(), pet.getLoginId()};
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
	 * 기존의 사용자 정보를 수정.
	 */
	public int update(Pet pet) throws SQLException {
		String sql = "UPDATE Pet "
				+ "SET name=?, gender=?, age=?, health=?, vaccination=?, kind=?, loginId=? " + "WHERE petId=?";
		Object[] param = new Object[] { pet.getName(), pet.getGender(), pet.getAge(), pet.getHealth(), pet.getVaccination(), pet.getKind(), pet.getLoginId(),pet.getPetId() };
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
	
	public int updateWithFile(Pet pet) throws SQLException {
		String sql = "UPDATE Pet "
				+ "SET name=?, gender=?, age=?, health=?, vaccination=?, kind=?,fileName=?,loginId=? " + "WHERE petId=?";
		Object[] param = new Object[] { pet.getName(), pet.getGender(), pet.getAge(), pet.getHealth(), pet.getVaccination(), pet.getKind(),pet.getFilename(),pet.getLoginId(),pet.getPetId() };
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
	public int removeByLoginId(String loginId) throws SQLException {
		String sql = "DELETE FROM Pet WHERE loginId=?";
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

	public int remove(int petId) throws SQLException {
		String sql = "DELETE FROM Pet WHERE petId=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { petId }); // JDBCUtil에 delete문과 매개 변수 설정

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

	@SuppressWarnings("unchecked")
	public Pet findPet(String loginId) throws SQLException {
		String sql = "SELECT * " + "FROM Pet " + "WHERE loginId=? ";	//Pet와 pet join해서..pet여럿이므로 while문으로 첫번째 레코드에서(null)만 user객체 pet객체 따로 생성, 아레쪽 while 추가 pet객체 llist에 add
		jdbcUtil.setSqlAndParameters(sql, new Object[] { loginId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			Pet pet = null;
			if(rs.next()) {
				pet = new Pet();
				pet.setPetId(rs.getInt("petId"));
				pet.setName(rs.getString("name"));
				pet.setGender(rs.getString("gender"));
				pet.setAge(rs.getInt("age"));
				pet.setHealth(rs.getString("health"));
				pet.setVaccination(rs.getString("vaccination"));
				pet.setKind(rs.getString("kind"));
				pet.setFilename(rs.getString("fileName"));
				pet.setLoginId(rs.getString("loginId"));
				return pet;
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
	
	public List<Pet> findPetList() throws SQLException {
		String sql = "SELECT * FROM Pet ";

		jdbcUtil.setSqlAndParameters(sql, null);      // JDBCUtil에 query문 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
			List<Pet> petList = new ArrayList<Pet>();   // PostInformation들의 리스트 생성
			while (rs.next()) {
				Pet pet = new Pet(         // PostInformation 객체를 생성하여 현재 행의 정보를 저장
						rs.getInt("petId"),
						rs.getString("name"),
						rs.getString("gender"),
						rs.getInt("age"),
						rs.getString("health"),
						rs.getString("vaccination"),
						rs.getString("kind"),
						rs.getString("fileName"),
						rs.getString("loginId"));
				petList.add(pet);            // List에 PostInformation 객체 저장
			}      
			return petList;               

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();      // resource 반환
		}
		return null;
	}

}
