package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.AdoptionAnimal;

public class AdoptionAnimalDAO {
	private JDBCUtil jdbcUtil = null;

	public AdoptionAnimalDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}

	
	public int create(AdoptionAnimal animal) throws SQLException {
		String sql = "INSERT INTO AdoptionAnimal VALUES (animal_seq.nextval, ?, ?, ?, ?, ?, ?, p3_seq.currval)";
		Object[] param = new Object[] {animal.getGender(), animal.getAge(), animal.getHealth(), animal.getVaccination(), animal.getKind(), animal.getFilename()};
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

	public int update(AdoptionAnimal animal) throws SQLException {
		String sql = "UPDATE AdoptionAnimal SET gender=?, age=?, health=?, vaccination=?, kind=? WHERE petId=?";
		Object[] param = new Object[] { animal.getGender(), animal.getAge(), animal.getHealth(), animal.getVaccination(), animal.getKind(), animal.getPetId() };
		jdbcUtil.setSqlAndParameters(sql, param);
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

	public int updateWithFile(AdoptionAnimal animal) throws SQLException {
		String sql = "UPDATE AdoptionAnimal SET gender=?, age=?, health=?, vaccination=?, kind=?, fileName=? WHERE petId=?";
		Object[] param = new Object[] { animal.getGender(), animal.getAge(), animal.getHealth(), animal.getVaccination(), animal.getKind(), animal.getFilename(), animal.getPetId() };
		jdbcUtil.setSqlAndParameters(sql, param);
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

	public int removeByPostId(int postId) throws SQLException {
		String sql = "DELETE FROM AdoptionAnimal WHERE postId=?";
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

	/*
	public int update(AdoptionAnimal pet) throws SQLException {
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
	
	
	public int updateWithFile(AdoptionAnimal pet) throws SQLException {
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
*/
	@SuppressWarnings("unchecked")
	public AdoptionAnimal findAdoptionAnimal(int postId) throws SQLException {
		String sql = "SELECT * " + "FROM Pet " + "WHERE postId=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { postId });

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			AdoptionAnimal pet = null;
			if(rs.next()) {
				pet = new AdoptionAnimal();
				pet.setPetId(rs.getInt("petId"));
				pet.setGender(rs.getString("gender"));
				pet.setAge(rs.getInt("age"));
				pet.setHealth(rs.getString("health"));
				pet.setVaccination(rs.getString("vaccination"));
				pet.setKind(rs.getString("kind"));
				pet.setFilename(rs.getString("fileName"));
				pet.setPostId(rs.getInt("postId"));
				return pet;
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
	
	/*
	 * public List<Pet> findPetList() throws SQLException { String sql =
	 * "SELECT * FROM Pet ";
	 * 
	 * jdbcUtil.setSqlAndParameters(sql, null); // JDBCUtil에 query문 설정
	 * 
	 * try { ResultSet rs = jdbcUtil.executeQuery(); // query 실행 List<Pet> petList =
	 * new ArrayList<Pet>(); // PostInformation들의 리스트 생성 while (rs.next()) { Pet pet
	 * = new Pet( // PostInformation 객체를 생성하여 현재 행의 정보를 저장 rs.getInt("petId"),
	 * rs.getString("name"), rs.getString("gender"), rs.getInt("age"),
	 * rs.getString("health"), rs.getString("vaccination"), rs.getString("kind"),
	 * rs.getString("fileName"), rs.getString("loginId")); petList.add(pet); //
	 * List에 PostInformation 객체 저장 } return petList;
	 * 
	 * } catch (Exception ex) { ex.printStackTrace(); } finally { jdbcUtil.commit();
	 * jdbcUtil.close(); // resource 반환 } return null; }
	 */
}
