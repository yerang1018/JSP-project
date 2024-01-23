package saved;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import board.Paging;


public class SavedDAO {

	   private Context init;
	   private DataSource ds;
	   
	   private Connection conn;
	   private PreparedStatement pstmt;
	   private ResultSet rs;
	   
	   private static SavedDAO instance = new SavedDAO();
	   
	   public static SavedDAO getInstance() {
	      return instance;
	   }
	   
	   
	   private SavedDAO() {
	      try {
	         init = new InitialContext();
	         ds = (DataSource) init.lookup("java:comp/env/jdbc/oracle");
	      } catch (NamingException e) {
	         e.printStackTrace();
	      }
	   }
	   
	   private void close() {
	      try {
	         if(rs != null) rs.close();
	         if(pstmt != null) pstmt.close();
	         if(conn != null) conn.close();
	      } catch (SQLException e) {}
	   }
	   
	   
	   
	   private SavedDTO mapping(ResultSet rs) throws SQLException {
		   SavedDTO dto = new SavedDTO();
	      
	      dto.setIdx(rs.getInt("idx"));
	      dto.setBoard_idx(rs.getInt("board_idx"));
	      dto.setMemberId(rs.getString("memberId"));
	      
	      return dto;
	   }
	   
	   
	   
	 
	   
	   
	   //	게시글 별로 liked 를 0으로 만들어서 생성하기
	   public int likeInsert(int board_idx, String userid) {
		   int row = 0;
		   
		   String sql = "insert into saved(board_idx , memberId) values (?,?)";
		   
		   try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_idx);
			pstmt.setString(2, userid);
			row = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		   finally {
			close();
		}
		   return row;
		   
	   }
	   
	   
	   
	   //	좋아요가 있는지
	   public SavedDTO checkLike(int board_idx, String userid) {
		   SavedDTO dto = null;
		   
		   String sql = "select * from saved where board_idx = ? and memberId = ?";
		   
		   try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, board_idx);
			pstmt.setString(2, userid);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				dto = mapping(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		   finally {
			close();
		}
		   return dto;
	   }
	   
	   
//		저장한 게시글 목록 
	   public List<SavedDTO> savedList(String userid, savedPaging paging) {
		   ArrayList<SavedDTO> list = new ArrayList<>();
		   
		   String sql = "select b.idx as board_idx, b.title, b.writer, c.idx"
		   		+ "    from board b"
		   		+ "    join saved c"
		   		+ "        on b.idx = c.board_idx"
		   		+ "    where c.memberId = ?"
		   		+ "        order by idx desc"
		   		+ "   offset ? rows "
	            + "   fetch next ? rows only";
		   
		   try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
	        pstmt.setInt(2, paging.getOffset());
	        pstmt.setInt(3, paging.getFetch());
			rs = pstmt.executeQuery();
			
			  while(rs.next()) {
				SavedDTO dto = new SavedDTO();
				dto.setIdx(rs.getInt("idx"));
				dto.setBoard_idx(rs.getInt("board_idx"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				
				list.add(dto);
			  }
		} catch (Exception e) {
				e.printStackTrace();
		}
		  finally {
			close();
		}
		   return list;
	   }
	   
	   
	   
	   // 내가 즐겨찾기한 게시글 개수 불러오는 함수
	   public int SavedCount(String userid) {
	      int count = 0;
	      String sql = "select count(*) from saved"
	      		+ " where memberId = ?"
	      		+ " order by idx desc";

	      try {
	         conn = ds.getConnection();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         rs = pstmt.executeQuery();
	         while (rs.next()) {
	            count = rs.getInt(1);
	         }
	      } catch (SQLException e) {
	         e.printStackTrace();
	      } finally {close();}
	      return count;
	   }
}
