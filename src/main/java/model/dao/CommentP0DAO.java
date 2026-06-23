package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.CommentInformation;
import model.PostInformation;

public class CommentP0DAO {
	private JDBCUtil jdbcUtil = null;
	
	public CommentP0DAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}

	public int create(CommentInformation comment) throws SQLException {
		//
		String sql = "INSERT INTO commentInformation VALUES (c0_seq.nextval, SYSDATE,?,?,?)";
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
	public int update(CommentInformation comment) throws SQLException {
		String sql = "UPDATE CommentInformation "
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
		String sql = "DELETE FROM commentInformation WHERE postId=?";
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

	public int remove(int commentId) throws SQLException {
		String sql = "DELETE FROM commentInformation WHERE commentId=?";
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
	public CommentInformation findC0(int commentId) throws SQLException {
		String sql = "SELECT * " + "FROM commentinformation " + "WHERE commentId=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { commentId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			CommentInformation comment = null;
			if(rs.next()) {
				comment = new CommentInformation();
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
	
	public List<CommentInformation> findC0List() throws SQLException {
		String sql = "SELECT * FROM CommentInformation ";

		jdbcUtil.setSqlAndParameters(sql, null);      // JDBCUtil에 query문 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
			List<CommentInformation> c0List = new ArrayList<CommentInformation>();   // PostInformation들의 리스트 생성
			while (rs.next()) {
				CommentInformation co = new CommentInformation(         // PostInformation 객체를 생성하여 현재 행의 정보를 저장
						rs.getInt("commentId"),
						rs.getDate("commentDate"),
						rs.getString("commentContent"),
						rs.getInt("postId"),
						rs.getInt("userId"));
				c0List.add(co);            // List에 PostInformation 객체 저장
			}      
			return c0List;               

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();      // resource 반환
		}
		return null;
	}
	
	public List<CommentInformation> findC0WithUser(int userId) throws SQLException {
		String sql = "SELECT * " + "FROM CommentInformation " + "WHERE userId=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { userId });

		try {
			ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
			List<CommentInformation> c0List = new ArrayList<CommentInformation>();   // PostInformation들의 리스트 생성
			while (rs.next()) {
				CommentInformation co = new CommentInformation(         // PostInformation 객체를 생성하여 현재 행의 정보를 저장
						rs.getInt("commentId"),
						rs.getDate("commentDate"),
						rs.getString("commentContent"),
						rs.getInt("postId"),
						userId);
				c0List.add(co);            // List에 PostInformation 객체 저장
			}      
			return c0List;               

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();      // resource 반환
		}
		return null;
	}

}
