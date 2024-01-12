package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Context init;
	private DataSource ds;
	
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}
	
	private MemberDAO() {
		try {
			init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	private void close() {
		try {
			if(rs != null)    rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null)  conn.close();
		} catch (Exception e) {	}
		
	}
	
	private MemberDTO mapping(ResultSet rs) throws SQLException {
		MemberDTO dto = new MemberDTO();
		
		dto.setIdx(rs.getInt("idx"));
		dto.setUserid(rs.getString("userid"));
		dto.setUserpw(rs.getString("userpw"));
		dto.setUsername(rs.getString("username"));
		dto.setEmail(rs.getString("email"));
		
		return dto;
	}
	
	
	//	join
	public int insert(MemberDTO dto) {
		int row = 0;
		
		String sql = "insert into member (userid, userpw, username, email) values (?,?,?,?)";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			pstmt.setString(3, dto.getUsername());
			pstmt.setString(4, dto.getEmail());
			
			row = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		return row;
	}
	
	
	//	login
	public MemberDTO login(MemberDTO dto) {
		MemberDTO login = null;
		
		String sql = "select * from member where userid = ? and userpw = ?";
		
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserid());
			pstmt.setString(2, dto.getUserpw());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				login = mapping(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			close();
		}
		return login;
	}
	
	
	//	회원탈퇴
	   public int delete(MemberDTO dto) {
		      int row = 0;
		      
		      String sql = "delete from member where userid = ? userpw = ?";
		      
		      try {
		         conn = ds.getConnection();
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setString(1, dto.getUserid());
		         pstmt.setString(2, dto.getUserpw());
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
