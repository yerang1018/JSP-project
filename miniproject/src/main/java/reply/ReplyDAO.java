package reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ReplyDAO {

   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs;
   
   private Context init;
   private DataSource ds;
   
   private static ReplyDAO instance = new ReplyDAO();
   
   public static ReplyDAO getInstance() {
      return instance;
   }
   
   private ReplyDAO() {
      try {
         init = new InitialContext();
         ds = (DataSource) init.lookup("java:comp/env/jdbc/oracle");
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
   private void close() {
      try {
         if(rs != null)       rs.close();
         if(pstmt != null)    pstmt.close();
         if(conn != null)    conn.close();
      } catch (Exception e) {   }
      
   }

   private ReplyDTO mapping(ResultSet rs) throws SQLException {
      ReplyDTO dto = new ReplyDTO();
      
      dto.setIdx(rs.getInt("idx"));
      dto.setBoard_idx(rs.getInt("board_idx"));
      dto.setWriter(rs.getString("writer"));
      dto.setContent(rs.getString("content"));
      dto.setWriteDate(rs.getDate("writeDate"));
      
      return dto;
   }
   
   
   //   댓글 목록   : 원본 게시글 번호를 전달받아서 목록 반환
   public List<ReplyDTO> selectreplyList(int board_idx) {
      ArrayList<ReplyDTO> list = new ArrayList<>();
      
      String sql = "select * from reply "
      		+ "where board_idx = ?"
      		+ " start with parent_idx = 0"
      		+ " connect by prior idx = parent_idx"
      		+ " order SIBLINGS by idx";
      
      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, board_idx);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            ReplyDTO dto = new ReplyDTO();
            
            dto.setBoard_idx(rs.getInt("board_idx"));
            dto.setParent_idx(rs.getInt("parent_idx"));
            dto.setIdx(rs.getInt("idx"));
            dto.setReply_depth(rs.getInt("reply_depth"));
            dto.setWriter(rs.getString("writer"));
            dto.setContent(rs.getString("content"));
            dto.setWriteDate(rs.getDate("writeDate"));
            
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
   
   
   //   댓글 작성
   public int insert(ReplyDTO dto) {
      int row = 0;
      
      String sql = "insert into reply(parent_idx, reply_depth, board_idx, writer, content) "
      		+ "values (?, ?, ?, ?, ?)";
      
      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setInt(1, dto.getParent_idx());
         pstmt.setInt(2, dto.getReply_depth());
         pstmt.setInt(3, dto.getBoard_idx());
         pstmt.setString(4, dto.getWriter());
         pstmt.setString(5, dto.getContent());
         
         row = pstmt.executeUpdate();
         
      } catch (Exception e) {
         e.printStackTrace();
      }
      return row;
   }
   
   
   //   댓글 삭제
   public int delete(int idx) {
      int row = 0;
      
      String sql = "delete from reply where idx = ?";
      
      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, idx);
         row = pstmt.executeUpdate();
         
      } catch (Exception e) {
         e.printStackTrace();
      }
      finally {
         close();
      }
      return row;
   }
      
}