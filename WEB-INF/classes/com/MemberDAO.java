package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.catalina.mbeans.NamingResourcesMBean;
import org.apache.jasper.tagplugins.jstl.core.Out;

import com.mysql.cj.Session;

public class MemberDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// DB연결 메소드
	private Connection getCon() throws Exception {
	
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqlDB");
		con = ds.getConnection();
		System.out.println("DAO : 디비연결 성공! " + con);

		return con;
	}
	
	// 자원 종료
	public void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 로그인 메서드 - loginMember()
	public int loginMember(String id, String pass) {
		
			int check = 0;

			try {
				Connection con = getCon();
				System.out.println("디비연결성공");

				String sql ="select pass from member_db where id = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);

				ResultSet rs = pstmt.executeQuery();
				System.out.println("sql실행");
				 
				if(rs.next()){
					if(pass.equals(rs.getString("pass"))){
						System.out.println("로그인 성공");
						check = 1;
					}else{
						System.out.println("비밀번호 오류");
						check = 0;
					}
				}else{
					System.out.println("회원정보 없음");
					check = -1;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
			return check;
	}
	// 로그인 메서드 - loginMember()
	
	// 회원가입 메서드 - join Member()
	public void joinMember(MemberBean mb) {
			
			try {
				Connection con = getCon();
				System.out.println("디비연결성공");
				
				String sql = "insert into member_db values(?,?,?,?,?,?,?)";
				PreparedStatement pstmt = con.prepareStatement(sql);
					
				pstmt.setString(1, mb.getId());
				pstmt.setString(2, mb.getPass());
				pstmt.setString(3, mb.getName());
				pstmt.setInt(4, mb.getAge());
				pstmt.setString(5, mb.getGender());
				pstmt.setString(6, mb.getEmail());
				pstmt.setString(7, mb.getAddress());
					
				pstmt.executeUpdate();
					
				System.out.println("회원정보 입력 완료");
					
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}	
				
	}
	// 회원가입 메서드 - join Member()
	
	// 아이디 중복체크 메서드 - duplicateIdcheck()
	public int joinIdCheck(String id) {
			
		int result = -1;
		
		try {
			Connection con = getCon();
			System.out.println("디비연결성공");

			String sql = "select * from member_db where id=?";
			PreparedStatement pstmt = con.prepareStatement(sql);			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result = 0;
		    	} else {
		    		result = 1;
		   	}
			System.out.println("아이디 중복 체크 완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		return result;	 
    	}
	// 아이디 중복체크 메서드 - duplicateIdcheck()
	
	// 회원정보 조회 메서드 - select Member()
	public MemberBean selectMember(String id) {
		
		MemberBean smb = new MemberBean();
	
		try {
			Connection con = getCon();
			String sql = "select * from member_db where id=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			System.out.println("회원정보 조회 완료");
			
			if(rs.next()){
				smb.setName(rs.getString("name"));
				smb.setAge(rs.getInt("age"));
				smb.setGender(rs.getString("gender"));
				smb.setEmail(rs.getString("email"));
				smb.setAddress(rs.getString("address"));
		    	}
		    
		    	System.out.println(" 회원정보 조회 성공! (select)");
		    
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}	
		return smb;
	}
	// 회원정보 조회 메서드 - selectMember()
	
	// 회원탈퇴 메서드 - deleteMember()
	public int deleteMember(String id, String pass) {
			
		int check = 0;
		
		try {
			Connection con = getCon();
			System.out.println("디비연결성공");

			String sql =  "select pass from member_db where id=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					sql = "delete from member_db where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					System.out.println("회원 삭제 완료");
					check=1;
				}else {
					// 비밀번호 오류
					check=-1;
			    	}
			} else {
				// 회원정보 없음
				check = 0;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}			
		return check;
		
	}
	// 회원탈퇴 메서드 - deleteMember()
	
	// 회원정보 수정 전 정보가져오기 - updateInfoMember()
	public MemberBean updateInfoMember(String id) {
				
	        MemberBean mb = new MemberBean();
			
		try {
			Connection con = getCon();

			String sql = "select * from member_db where id=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
				
			if(rs.next()){
				mb.setName(rs.getString("name"));
				mb.setAge(rs.getInt("age"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
			}
					
			// 성별의 정보가 없을경우 기본값 설정
			if(mb.getGender() == null){
				mb.setGender("남자");
			}
													
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}	
				
		return mb;				
	} 
	// 회원정보 수정 전 정보가져오기 - updateInfoMember()
	
	// 회원정보 수정 - updateMember()
	public int updateMember(MemberBean mb) {
		
		int ck = 0;
							
		try {
			Connection con = getCon();
			String sql = "select pass from member_db where id=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			ResultSet rs = pstmt.executeQuery();
					
			if(rs.next()){
				if(mb.getPass().equals(rs.getString("pass"))) {
					 sql = "update member_db set name=?, age=?, gender=?, email=?, address=? where id=?";
					 pstmt = con.prepareStatement(sql);						 
					 pstmt.setString(1, mb.getName());
					 pstmt.setInt(2, mb.getAge());
					 pstmt.setString(3, mb.getGender());
					 pstmt.setString(4, mb.getEmail());
					 pstmt.setString(5, mb.getAddress());
					 pstmt.setString(6, mb.getId());
					 pstmt.executeUpdate();

					 System.out.println("회원정보 수정완료");
					 ck=1;
							 
				}else {
					ck=-1;
					System.out.println("비밀번호 오류");
				}
			}else {
				ck=0;
				System.out.println("회원정보 없음");
			}
								
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}	
		return ck;								
	} 
	// 회원정보 수정 - updateMember()
	
	// 회원정보 조회 메서드 - listMember()
	public ArrayList<MemberBean> listMember(String id) {
		
		ArrayList<MemberBean> memberlist = new ArrayList<MemberBean>();
	
		try {
			Connection con = getCon();
			String sql =  "select * from member_db where id != ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberBean lmb = new MemberBean();
				lmb.setId(rs.getString("id"));
				lmb.setName(rs.getString("name"));
				lmb.setAge(rs.getInt("age"));
				lmb.setGender(rs.getString("gender"));
				lmb.setEmail(rs.getString("email"));
				lmb.setAddress(rs.getString("address"));
				
				memberlist.add(lmb);
		 	}
		    
		    System.out.println(" 회원정보 조회 성공! (select)");
		    
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}	
		return memberlist;
	}
	// 회원정보 조회 메서드 - listMember()
	
	// 비밀번호 찾기 메서드 - passSearch()
	public String passSearch(String id, String email) {
		
		String pass = null;
	
		try {
			Connection con = getCon();
			System.out.println("디비연결성공");

			String sql = "select pass from member_db where id=? and email=?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()){
				pass = rs.getString("pass");
		    }
		    
		    System.out.println(" 비밀번호 조회 성공");
		    
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}	
		return pass;
	}
	// 비밀번호 찾기 메서드 - passSearch()
}
