package board;

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


public class BoardDAO {
   
   private Context init;
   private DataSource ds;
   
   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs;
   
   private static BoardDAO instance = new BoardDAO();
   
   public static BoardDAO getInstance() {
      return instance;
   }
   
   
   private BoardDAO() {
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
   
   
   
   private BoardDTO mapping(ResultSet rs) throws SQLException {
      BoardDTO dto = new BoardDTO();
      
      dto.setIdx(rs.getInt("idx"));
      dto.setTitle(rs.getString("title"));
      dto.setImage(rs.getString("image"));
      dto.setCategory(rs.getString("category"));
      dto.setWriter(rs.getString("writer"));
      dto.setContent(rs.getString("content"));
      dto.setWriteDate(rs.getDate("writeDate"));
      dto.setDeleted(rs.getInt("deleted"));
      return dto;
      
      
   }
   
  
   
   // 게시글 목록 불러오기
   public List<BoardDTO> selectList() {
      ArrayList<BoardDTO> list = new ArrayList<>();
      String sql = "select * from board "
            + " where "
            + " deleted = 0"
            + " order by idx desc";
      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         while (rs.next()) {
            list.add(mapping(rs));
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {close();}
      return list;
   }
   
   
   // 검색 목록 리스트
   public List<BoardDTO> selectSearchList(String search) {
      ArrayList<BoardDTO> list = new ArrayList<>();
      String sql = "select * from board "
            + " where "
            + " deleted = 0 and "
            + " (title like '%' || ? || '%' or "
            + " writer like '%' || ? || '%' or "
            + "   content like '%' || ? || '%') "
            + " order by idx desc";

      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, search);
         pstmt.setString(2, search);
         pstmt.setString(3, search);
         rs = pstmt.executeQuery();
         while (rs.next()) {
            list.add(mapping(rs));
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {close();}
      return list;
   }
   
//   INSERT INTO board (title, writer, content, image, category) VALUES (
//           '한라산 백록담', 'jeju4', '제주 한라산 백록담 /
//   제주에 간다면 꼭 가보기를 추천하는 백록담 1년 중 운해가 없는 날이 손에 꼽기 때문에 3대가 덕을 쌓아야 볼 수 있다는 말이 있다 살면서 한번쯤 가본다면 자연의 경치에 매료될 수 있는 장소이다', '백록담.jpg','관광');
//   
   // 게시글 작성하기
   public int insert(BoardDTO dto) {
      int row = 0;
      String sql = "insert into board (title, writer, content, image, category)"
            + "values (?, ?, ?, ?, ?)";
      
      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getTitle());
         pstmt.setString(2, dto.getWriter());
         pstmt.setString(3, dto.getContent());
         pstmt.setString(4, dto.getImage());
         pstmt.setString(5, dto.getCategory());
         
         row = pstmt.executeUpdate();
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {close();}
      return row;
   }
   
   
   
   // 단일 게시글 보기 (view) / 게시글 읽기
   public BoardDTO selectOne(int idx) {
      BoardDTO dto = null;
      String sql = "select * from board where idx = ?";
      
      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, idx);
         rs = pstmt.executeQuery();
         while (rs.next()) {
            dto = mapping(rs);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {close();}
      return dto;
   }
   
   // 카테고리별로 게시글 불러오기
   public List<BoardDTO> selectListByCategory(String category){
      ArrayList<BoardDTO> list = new ArrayList<>();
      String sql = "select * from board where category = ?";
      
      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, category);
         rs = pstmt.executeQuery();
         while (rs.next()) {
            list.add(mapping(rs));
         }
      } catch (Exception e) {
         e.printStackTrace();
      }finally {close();}
      return list;
   }
   
   

   // 게시글 수정하기
   public int update(BoardDTO dto) {
	   System.out.println(dto.getIdx());
	   System.out.println(dto.getWriter());
      int row = 0;
      String sql ="update board set title = ?, content = ? , image = ? , category = ?"
              + " where idx = ? and writer = ?";
      System.out.println(dto.getIdx());      
   
      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getTitle());
         pstmt.setString(2, dto.getContent());
         pstmt.setString(3, dto.getImage());
         pstmt.setString(4, dto.getCategory());
         pstmt.setInt(5, dto.getIdx());
         pstmt.setString(6, dto.getWriter());
         row = pstmt.executeUpdate();
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {close();}
      return row;
   }
   
   
      // 삭제 : update 쿼리문 사용하기 
      public int delete(int idx) {
         int row = 0;
    
         String sql = "update board set "
          + "   deleted = 1 - deleted "
          + "   where idx = ?";
    
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
   
      
   // 내가 쓴 게시글
   public List<BoardDTO> selectListByWriter(String userid, Paging paging){
      ArrayList<BoardDTO> list = new ArrayList<>();
      String sql = "select * from board "
            + " where writer = ? "
            + "   order by idx desc "
            + "   offset ? rows "
            + "   fetch next ? rows only";
      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, userid);
         pstmt.setInt(2, paging.getOffset());
         pstmt.setInt(3, paging.getFetch());
         rs = pstmt.executeQuery();
         while (rs.next()) {
            list.add(mapping(rs));
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {close();}
      return list;
   }
   

   
   // 게시글 개수 불러오는 함수
   public int selectCount(String userid) {
      int count = 0;
      String sql = "select count(*) from board "
            + " where writer = ? "
            + "   order by idx desc ";

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
      }finally {close();}
      return count;
   }
   
   // 검색어에 따라 카운트 되는 카운트 함수
   public int selectSearchCount(String search) {
      int count = 0;
      String sql = "select count(*) from board "
            + " where "
            + "       deleted = 0 and"
            + "       (title like '%' || ? || '%' or "
            + "       writer like '%' || ? || '%' or "
            + "       content like '%' || ? || '%')   "
            + "   order by idx desc";


      try {
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, search);
         pstmt.setString(2, search);
         pstmt.setString(3, search);
         rs = pstmt.executeQuery();
         while (rs.next()) {
            count = rs.getInt(1);
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }finally {close();}
      return count;
   }
   
   
   
 
   
   
  
   
   
   
   
   
}