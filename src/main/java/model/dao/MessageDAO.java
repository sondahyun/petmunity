package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Message;

public class MessageDAO {
	private JDBCUtil jdbcUtil = null;
	
	public MessageDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}

	public int create(Message message) throws SQLException {
		//
		String sql = "INSERT INTO MESSAGE VALUES (message_seq.nextval,?,?,?,SYSDATE,?)";
		Object[] param = new Object[] {message.getSender(), message.getReceiver(), message.getContent(), message.getmTitle()};
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
	public int removeByUser(int userId) throws SQLException {
		String sql = "DELETE FROM MESSAGE WHERE sender=? OR receiver=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { userId, userId });
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

	public int remove(int messageId) throws SQLException {
		String sql = "DELETE FROM MESSAGE WHERE messageId=?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { messageId }); // JDBCUtil에 delete문과 매개 변수 설정

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
	public Message findMessage(int messageId) throws SQLException {
		String sql = "SELECT * " + "FROM Message " + "WHERE messageId=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { messageId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			Message message= new Message();
			if(rs.next()) {
				message.setMessageId(rs.getInt("messageId"));
				message.setSender(rs.getInt("sender"));
				message.setReceiver(rs.getInt("receiver"));
				message.setContent(rs.getString("content"));
				message.setSendDate(rs.getDate("sendDate"));
				message.setmTitle(rs.getString("mTitle"));
			}
			return message;
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
	
	public List<Message> findMessageList() throws SQLException {
		String sql = "SELECT * FROM Message ";

		jdbcUtil.setSqlAndParameters(sql, null);      // JDBCUtil에 query문 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
			List<Message> messageList = new ArrayList<Message>();   // PostInformation들의 리스트 생성
			while (rs.next()) {
				Message message = new Message(         // PostInformation 객체를 생성하여 현재 행의 정보를 저장
						rs.getInt("messageId"),
						rs.getInt("sender"),
						rs.getInt("receiver"),
						rs.getString("content"),
						rs.getDate("sendDate"),
						rs.getString("mTitle")
				);
				messageList.add(message);            // List에 PostInformation 객체 저장
			}      
			return messageList;               

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();      // resource 반환
		}
		return null;
	}
	
	public List<Message> findMessageWithSender(int userId) throws SQLException {
		String sql = "SELECT * " + "FROM Message " + "WHERE sender=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { userId });

		try {
			ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
			List<Message> messageList = new ArrayList<Message>();   // PostInformation들의 리스트 생성
			while (rs.next()) {
				Message message = new Message(         // PostInformation 객체를 생성하여 현재 행의 정보를 저장
						rs.getInt("messageId"),
						rs.getInt("sender"),
						rs.getInt("receiver"),
						rs.getString("content"),
						rs.getDate("sendDate"),
						rs.getString("mTitle")
				);
				messageList.add(message);            // List에 PostInformation 객체 저장
			}      
			return messageList;               

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();      // resource 반환
		}
		return null;
	}
	
	public List<Message> findMessageWithReceiver(int userId) throws SQLException {
		String sql = "SELECT * " + "FROM Message " + "WHERE receiver=? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { userId });

		try {
			ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
			List<Message> messageList = new ArrayList<Message>();   // PostInformation들의 리스트 생성
			while (rs.next()) {
				Message message = new Message(         // PostInformation 객체를 생성하여 현재 행의 정보를 저장
						rs.getInt("messageId"),
						rs.getInt("sender"),
						rs.getInt("receiver"),
						rs.getString("content"),
						rs.getDate("sendDate"),
						rs.getString("mTitle")
				);
				messageList.add(message);            // List에 PostInformation 객체 저장
			}      
			return messageList;               

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();      // resource 반환
		}
		return null;
	}

}
