package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import model.AdoptionAnimal;
import model.Pet;
import model.PostAdoption;


/**
 * 사용자 관리를 위해 데이터베이스 작업을 전담하는 DAO 클래스
 * PostAdoption 테이블에 사용자 정보를 추가, 수정, 삭제, 검색 수행 
 */
public class PostAdoptionDAO {
	private static final Logger log = LoggerFactory.getLogger(PostAdoption.class);
    
   private JDBCUtil jdbcUtil = null;

   public PostAdoptionDAO() {
      jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
   }
  
   public int create(PostAdoption post) throws SQLException {
      String sql = "INSERT INTO PostAdoption VALUES (p3_seq.nextval,?,SYSDATE,?,?,?,?,?)";
      Object[] param = new Object[] { post.getPostTitle(), post.getaType(), post.getApproval(), null, post.getPostContent(), post.getLoginId() };
      
      
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
   public int update(PostAdoption post) throws SQLException {
      String sql = "UPDATE PostAdoption "
            + "SET postTitle=?, postContent=? " + "WHERE postId=?";
      Object[] param = new Object[] { post.getPostTitle(), post.getPostContent(), post.getPostId() };
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
   public int updateApproval(PostAdoption post) throws SQLException {
	   System.out.println("updateApproval: "+post.getPostId());
	      String sql = "update postAdoption "
	            + "SET approval=1, approvalDate=sysdate " + "WHERE postId=? ";
	      Object[] param = new Object[] { post.getPostId() };
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
   public int remove(int postId) throws SQLException {
      String sql = "DELETE FROM PostAdoption WHERE postId=?";
      jdbcUtil.setSqlAndParameters(sql, new Object[] { postId }); // JDBCUtil에 delete문과 매개 변수 설정

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
   /**
    * 주어진  ID에 해당하는 커뮤니티 정보를 데이터베이스에서 찾아 PostAdoption 도메인 클래스에 
    * 저장하여 반환.
    */
   //특정 포스트 띄우기
   
   @SuppressWarnings("unchecked")
   public PostAdoption findPost(int postId) throws SQLException {
      String sql = "SELECT * " + "FROM PostAdoption p, adoptionAnimal aa " + "WHERE p.postId = aa.postId and p.postId=? ";
      jdbcUtil.setSqlAndParameters(sql, new Object[] { postId }); // JDBCUtil에 query문과 매개 변수 설정

      try {
         ResultSet rs = jdbcUtil.executeQuery(); // query 실행
         PostAdoption post = null;
         if(rs.next()) {// 학생 정보 발견
        	 AdoptionAnimal aa = new AdoptionAnimal(
                     rs.getInt("petId"),
                     rs.getString("gender"),
                     rs.getInt("age"),
                     rs.getString("health"),
                     rs.getString("vaccination"),
                     rs.getString("kind"),
                     rs.getString("fileName"),
                     postId
             );
            
            post = new PostAdoption(
                  postId,
                  rs.getString("postTitle"),
                  rs.getDate("postDate"),
                  rs.getInt("aType"),
                  rs.getInt("approval"),
                  rs.getDate("approvalDate"),
                  rs.getString("postContent"),
                  rs.getString("loginId"),
                  aa
               );
         }
         return post;
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
    	  jdbcUtil.commit();
          jdbcUtil.close(); // resource 반환
      }
      return null;
   }
   
   //검색조건을 받아 찾음
   //수정 필요
   public List<PostAdoption> searchP3List(String word, Date start, Date end) throws SQLException {
        String sql= "SELECT * "
	                 + "FROM PostAdoption p, adoptionAnimal aa "
	                 + "WHERE p.postId=aa.postId and (postTitle like ? or postContent like ?) and (postDate between ?-1 and ?+1) ";              
	        jdbcUtil.setSqlAndParameters(sql, new Object[] {word, word, new java.sql.Date(start.getTime()), new java.sql.Date(end.getTime())});   // JDBCUtil에 query문과 매개 변수 설정
       
      PostAdoption postAdoption = null;
      
      try {
         ResultSet rs = jdbcUtil.executeQuery();      // query 실행
         List<PostAdoption> adoptionList = new ArrayList<PostAdoption>();
         //SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
         
         while (rs.next()) {                  // 학생 정보 발견
        	 AdoptionAnimal aa = new AdoptionAnimal(
                     rs.getInt("petId"),
                     rs.getString("gender"),
                     rs.getInt("age"),
                     rs.getString("health"),
                     rs.getString("vaccination"),
                     rs.getString("kind"),
                     rs.getString("fileName"),
                     rs.getInt("postId")                  
                     );
             postAdoption = new PostAdoption(      // PostAdoption 객체를 생성하여 커뮤니티 정보를 저장
               rs.getInt("postId"),
               rs.getString("postTitle"),
               rs.getDate("postDate"),
               rs.getInt("aType"),
               rs.getInt("approval"),
               rs.getDate("approvalDate"),
               rs.getString("postContent"),
               rs.getString("loginId"),
               aa
               );
            adoptionList.add(postAdoption);
         }
         return adoptionList;
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
    	  jdbcUtil.commit();
         jdbcUtil.close();      // resource 반환
      }
      return null;
   }

   /**
    * 전체 커뮤니티 정보를 검색하여 List에 저장 및 반환
    */
   public List<PostAdoption> findP3List() throws SQLException {
        String sql = "SELECT p.postId AS pId, postTitle, postDate, aType, approval, approvalDate, postContent, loginId, petId, gender, age, health, vaccination, kind, fileName, aa.postId AS aId "
                 + "FROM PostAdoption p, AdoptionAnimal aa "
                 + "WHERE p.postId = aa.postId ";
        
      jdbcUtil.setSqlAndParameters(sql, null);      // JDBCUtil에 query문 설정
               
      try {
         ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
         List<PostAdoption> adoptionList = new ArrayList<PostAdoption>();   // PostAdoption들의 리스트 생성
         while (rs.next()) {
            AdoptionAnimal aa = new AdoptionAnimal(
                  rs.getInt("petId"),
                  rs.getString("gender"),
                  rs.getInt("age"),
                  rs.getString("health"),
                  rs.getString("vaccination"),
                  rs.getString("kind"),
                  rs.getString("fileName"),
                  rs.getInt("aId")
                  );

       	 	log.debug("getList AdoptionAnimal : {}", aa);
       	 	
            PostAdoption pAdoption = new PostAdoption(         // PostAdoption 객체를 생성하여 현재 행의 정보를 저장
                  rs.getInt("pId"),
                  rs.getString("postTitle"),
                  rs.getDate("postDate"),
                  rs.getInt("aType"),
                  rs.getInt("approval"),
                  rs.getDate("approvalDate"),
                  rs.getString("postContent"),
                  rs.getString("loginId"),
                  aa
                  );
            //pAdoption.setAnimal(aa);
            log.debug("getList pAdoption : {}", pAdoption);
            adoptionList.add(pAdoption);            // List에 PostAdoption 객체 저장
         }
         System.out.println("p3List size : "+adoptionList.size());
         return adoptionList;               
         
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         jdbcUtil.commit();
         jdbcUtil.close();      // resource 반환
      }
      return null;
   }
   
   public List<PostAdoption> findP3WithUser(String loginId) throws SQLException {
       String sql = "SELECT p.postId AS pId, postTitle, postDate, aType, approval, approvalDate, postContent, loginId, petId, gender, age, health, vaccination, kind, fileName, aa.postId AS aId "
                + "FROM PostAdoption p, AdoptionAnimal aa "
                + "WHERE p.postId = aa.postId AND loginId = ? ";
       
       jdbcUtil.setSqlAndParameters(sql, new Object[] {loginId});      // JDBCUtil에 query문 설정
              
     try {
        ResultSet rs = jdbcUtil.executeQuery();         // query 실행         
        List<PostAdoption> adoptionList = new ArrayList<PostAdoption>();   // PostAdoption들의 리스트 생성
        while (rs.next()) {
           AdoptionAnimal aa = new AdoptionAnimal(
                 rs.getInt("petId"),
                 rs.getString("gender"),
                 rs.getInt("age"),
                 rs.getString("health"),
                 rs.getString("vaccination"),
                 rs.getString("kind"),
                 rs.getString("fileName"),
                 rs.getInt("aId")                  
                 );
           
           PostAdoption pAdoption = new PostAdoption(         // PostAdoption 객체를 생성하여 현재 행의 정보를 저장
                 rs.getInt("pId"),
                 rs.getString("postTitle"),
                 rs.getDate("postDate"),
                 rs.getInt("aType"),
                 rs.getInt("approval"),
                 rs.getDate("approvalDate"),
                 rs.getString("postContent"),
                 loginId,
                 aa
                 );
           //pAdoption.setAnimal(aa);
           adoptionList.add(pAdoption);            // List에 PostAdoption 객체 저장
        }
        return adoptionList;               
        
     } catch (Exception ex) {
        ex.printStackTrace();
     } finally {
        jdbcUtil.commit();
        jdbcUtil.close();      // resource 반환
     }
     return null;
  }
   
   public String findPostTitle(int postId) throws SQLException {
	      String sql = "SELECT POSTTITLE " + "FROM PostAdoption " + "WHERE postId = ? ";
	      jdbcUtil.setSqlAndParameters(sql, new Object[] { postId }); // JDBCUtil에 query문과 매개 변수 설정

	      try {
	         ResultSet rs = jdbcUtil.executeQuery(); // query 실행
	         String postTitle = null;
	         if(rs.next()) {// 학생 정보 발견
	        	 postTitle = rs.getString("postTitle");
	         }
	         return postTitle;
	      } catch (Exception ex) {
	         ex.printStackTrace();
	      } finally {
	    	  jdbcUtil.commit();
	          jdbcUtil.close(); // resource 반환
	      }
	      return null;
	   }
   
}