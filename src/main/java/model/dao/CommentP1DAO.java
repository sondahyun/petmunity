package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.CommentGroup;
import model.PostGroup;

public class CommentP1DAO {
	private JDBCUtil jdbcUtil = null;
	
	public CommentP1DAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}

	public int create(CommentGroup comment) throws SQLException {
		//
		String sql = "INSERT INTO commentGroup VALUES (c1_seq.nextval, SYSDATE,?,?,?)";
		Object[] param = new Object[] {comment.getCommentContent(), comment.getPostId(), comment.getUserId()};
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
	public int update(CommentGroup comment) throws SQLException {
		String sql = "UPDATE CommentGroup "
				+ "SET commentDate = SYSDATE, commentContent = ? " + "WHERE commentId=?";
		Object[] param = new Object[] {comment.getCommentContent(), comment.getCommentId() };
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
	public int removeByPostId(int postId) throws SQLException {
		String sql = "DELETE FROM commentGroup WHERE postId=?";
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

	public int removeByUserId(int userId) throws SQLException {
		String sql = "DELETE FROM commentGroup WHERE userId=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { userId });
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

	public int remove(int commentId) throws SQLException {
		String sql = "DELETE FROM commentGroup WHERE commentId=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { commentId }); // JDBCUtil에 delete문과 매개 변수 설정

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
	public CommentGroup findC1(int commentId) throws SQLException {
		String sql = "SELECT * " + "FROM commentGroup " + "WHERE commentId=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { commentId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			CommentGroup comment = null;
			if(rs.next()) {
				comment = new CommentGroup();
				comment.setCommentDate(rs.getDate("commentDate"));
				comment.setCommentContent(rs.getString("commentContent"));
				comment.setPostId(rs.getInt("postId"));
				comment.setUserId(rs.getInt("UserId"));
				return comment;
			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
	
	public List<CommentGroup> findC1List() throws SQLException {
		String sql = "SELECT * FROM CommentGroup ";

		jdbcUtil.setSqlAndParameters(sql, null);      // JDBCUtil에 query문 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
			List<CommentGroup> c1List = new ArrayList<CommentGroup>();   // PostGroup들의 리스트 생성
			while (rs.next()) {
				CommentGroup co = new CommentGroup(         // PostGroup 객체를 생성하여 현재 행의 정보를 저장
						rs.getInt("commentId"),
						rs.getDate("commentDate"),
						rs.getString("commentContent"),
						rs.getInt("postId"),
						rs.getInt("userId"));
				c1List.add(co);            // List에 PostGroup 객체 저장
			}      
			return c1List;               

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();      // resource 반환
		}
		return null;
	}
	
	public List<CommentGroup> findC1WithUser(int userId) throws SQLException {
		String sql = "SELECT * " + "FROM commentGroup " + "WHERE userId=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { userId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
			List<CommentGroup> c1List = new ArrayList<CommentGroup>();   // PostGroup들의 리스트 생성
			while (rs.next()) {
				CommentGroup co = new CommentGroup(         // PostGroup 객체를 생성하여 현재 행의 정보를 저장
						rs.getInt("commentId"),
						rs.getDate("commentDate"),
						rs.getString("commentContent"),
						rs.getInt("postId"),
						userId);
				c1List.add(co);            // List에 PostGroup 객체 저장
			}      
			return c1List;               

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();      // resource 반환
		}
		return null;
	}

}
