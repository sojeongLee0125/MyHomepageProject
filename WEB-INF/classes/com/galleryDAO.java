package com;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class galleryDAO {
	
		private DataSource dataSource;
		
		// DB연결
		public galleryDAO() {	
			try {
				Context initCtx = new InitialContext();
				Context envCtx = (Context)initCtx.lookup("java:comp/env");
				this.dataSource = (DataSource)envCtx.lookup("jdbc/mysqlDB");
			} catch (NamingException e) {
				System.out.println( "[error] : " + e.getMessage() );
			}
		}
		
		// 사진게시판 글쓰기
		public int boardWriteOk(galleryDTO gto) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			//정상처리 또는 비정상처리 변수
			int flag = 1;
			
			try {
				conn = dataSource.getConnection();
				
				// 데이터 넣기
				String sql = "insert into galleryboard_db values (0, ?, ?, ?, ?, ?, ?, 0, ?, now())";
				pstmt = conn.prepareStatement(sql);
			
				pstmt.setString(1, gto.getSubject());
				pstmt.setString(2, gto.getName());
				pstmt.setString(3, gto.getPass());
				pstmt.setString(4, gto.getContent());
				pstmt.setString(5, gto.getFilename());
				pstmt.setLong(6, gto.getFilesize());
				pstmt.setString(7, gto.getWip());
								
				int result = pstmt.executeUpdate();
				if ( result == 1 ) {
					// 글쓰기 성공
					flag = 0;
				}
				
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			
			return flag;
		}
		
		// 사진게시판 리스트 불러오기
		public ArrayList<galleryDTO> galleryList() {
		
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			ArrayList<galleryDTO> lists = new ArrayList<galleryDTO>();
			
			try {
				conn = dataSource.getConnection();	
				String sql = "select seq, subject, filename, name, date_format(wdate, '%Y-%m-%d') wdate, hit, datediff(now(), wdate) wgap from galleryboard_db order by seq desc";
				pstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
				rs = pstmt.executeQuery();
				
				//데이터베이스에서 글목록 가져와서 리스트 나타내기
				while( rs.next() ) {
					galleryDTO gto = new galleryDTO();
					String seq = rs.getString( "seq" );
					String subject = rs.getString( "subject" );
					String name = rs.getString( "name" );
					String filename = rs.getString( "filename" );
					String wdate = rs.getString( "wdate" );
					String hit = rs.getString( "hit" );
					int wgap = rs.getInt( "wgap" );
					
					gto.setSeq(seq);
					gto.setSubject(subject);
					gto.setName(name);
					gto.setFilename(filename);
					gto.setWdate(wdate);
					gto.setHit(hit);
					gto.setWgap(wgap);
					
					lists.add( gto );
				}
				
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( rs != null ) try { rs.close(); } catch ( SQLException e ) {}
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			return lists;
		}
		
		//페이징 처리된 갤러리 리스트 불러오기
		public galleryListDTO boardList( galleryListDTO listDTO ) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			// 페이지를 위한 기본 요소
			int cpage = listDTO.getCpage();
			int recordPerPage = listDTO.getRecordPerPage();	// 한페이지에 보이는 글의 개수 
			int BlockPerPage = listDTO.getBlockPerPage();	// 한 화면에 보일 페이지의 수 
			
			try {
				conn = dataSource.getConnection();
				
				String sql = "select seq, subject, filename, name, date_format(wdate, '%Y-%m-%d') wdate, hit, datediff(now(), wdate) wgap from galleryboard_db order by seq desc";
				pstmt = conn.prepareStatement( sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY );
				rs = pstmt.executeQuery();
				
				//총 글의 개수 얻기
				rs.last();
				listDTO.setTotalRecord( rs.getRow() );
				rs.beforeFirst();
				
				//총 페이지 수 얻기
				listDTO.setTotalPage( ( (listDTO.getTotalRecord() - 1) / recordPerPage ) + 1 );
				int skip = ( cpage * recordPerPage ) - recordPerPage;
				if (skip != 0) rs.absolute( skip );
				
				ArrayList<galleryDTO> lists = new ArrayList<galleryDTO>();
				
				for( int i=0; i<recordPerPage && rs.next(); i++) {
					galleryDTO gto = new galleryDTO();
					String seq = rs.getString( "seq" );
					String subject = rs.getString( "subject" );
					String name = rs.getString( "name" );
					String filename = rs.getString( "filename" );
					String wdate = rs.getString( "wdate" );
					String hit = rs.getString( "hit" );
					int wgap = rs.getInt( "wgap" );
					
					gto.setSeq(seq);
					gto.setSubject(subject);
					gto.setName(name);
					gto.setFilename(filename);
					gto.setWdate(wdate);
					gto.setHit(hit);
					gto.setWgap(wgap);
					
					lists.add( gto );
				}
				listDTO.setBoardLists( lists );
				
				// 페이징 처리 정보 입력
				listDTO.setStartBlock( ( (cpage-1)/BlockPerPage ) * BlockPerPage + 1 );
				listDTO.setEndBlock( ( (cpage-1)/BlockPerPage ) * BlockPerPage + BlockPerPage );
				if ( listDTO.getEndBlock() >= listDTO.getTotalPage() ) {
					listDTO.setEndBlock( listDTO.getTotalPage() );
				}
				
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( rs != null ) try { rs.close(); } catch ( SQLException e ) {}
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			return listDTO;
		}
		
		// 조회수 증가 후 글 보기
		public galleryDTO boardView( galleryDTO gto ) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = dataSource.getConnection();
				
				//조회수 증가시키기
				String sql = "update galleryboard_db set hit = hit+1 where seq = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString( 1, gto.getSeq() );
				rs = pstmt.executeQuery();
				
				//데이터베이스에서 해당 글 내용 가져오기
				sql = "select subject, name, content, filename, hit, wip, wdate from galleryboard_db where seq = ?";
				pstmt = conn.prepareStatement( sql );
				pstmt.setString( 1, gto.getSeq() );
				rs = pstmt.executeQuery();
				
				//데이터베이스에서 sql실행문의 각 컬럼을 가져와서 변수에 저장
				if ( rs.next() ) {
					String subject = rs.getString( "subject" );
					String name = rs.getString( "name" );
					String content = rs.getString( "content" );
					String filename = rs.getString( "filename" );
					String hit = rs.getString( "hit" );
					String wip = rs.getString( "wip" );
					String wdate = rs.getString( "wdate" );
					
					gto.setSubject(subject);
					gto.setName(name);
					gto.setContent(content);
					gto.setFilename(filename);
					gto.setHit(hit);
					gto.setWip(wip);
					gto.setWdate(wdate);
				}
				
			
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( rs != null ) try { rs.close(); } catch ( SQLException e ) {}
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			return gto;
		}
		
		//view_이전글
		public galleryDTO boardView_before( galleryDTO gto_before ) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = dataSource.getConnection();
				
				//데이터베이스에서 해당 글 내용 가져오기
				String sql = "select seq, subject from galleryboard_db where seq = ( select max(seq) from galleryboard_db where seq < ?)";
				pstmt = conn.prepareStatement( sql );
				pstmt.setString( 1, gto_before.getSeq() );
				rs = pstmt.executeQuery();
				
				if ( rs.next() ) {
					String subject = rs.getString( "subject" );
					String seq = rs.getString("seq");
					gto_before.setSubject(subject);
					gto_before.setSeq(seq);
				} else {
					gto_before.setSubject( "이전글이 없습니다." );
				}
			
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( rs != null ) try { rs.close(); } catch ( SQLException e ) {}
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			return gto_before;
		}
		
		//view_다음글
		public galleryDTO boardView_next( galleryDTO gto_next ) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = dataSource.getConnection();

				//데이터베이스에서 해당 글 내용 가져오기
				String sql = "select seq, subject from galleryboard_db where seq = ( select min(seq) from galleryboard_db where seq > ?)";
				pstmt = conn.prepareStatement( sql );
				pstmt.setString( 1, gto_next.getSeq() );
				rs = pstmt.executeQuery();
				
				if ( rs.next() ) {
					String subject = rs.getString( "subject" );
					String seq = rs.getString("seq");
					gto_next.setSubject(subject);
					gto_next.setSeq(seq);
				} else {
					gto_next.setSubject( "다음글이 없습니다." );
				}
			
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( rs != null ) try { rs.close(); } catch ( SQLException e ) {}
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			return gto_next;
		}
		
		// 삭제페이지 글 불러오기
		public galleryDTO boardDelete( galleryDTO gto ) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = dataSource.getConnection();
				
				//데이터베이스에서 해당 글 내용 가져오기
				String sql = "select subject, name from galleryboard_db where seq = ?";
				pstmt = conn.prepareStatement( sql );
				pstmt.setString( 1, gto.getSeq() );
				rs = pstmt.executeQuery();
				
				//데이터베이스에서 sql실행문의 각 컬럼을 가져와서 변수에 저장
				if ( rs.next() ) {
					String subject = rs.getString( "subject" );
					String name = rs.getString( "name" );
					
					gto.setSubject(subject);
					gto.setName(name);
				}
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( rs != null ) try { rs.close(); } catch ( SQLException e ) {}
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			return gto;
		}
		
		// 글 삭제하기
		public int boardDeleteOk( galleryDTO gto ) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int flag = 2;
			
			try {
				conn = dataSource.getConnection();
				
				String sql = "select filename from galleryboard_db where seq = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, gto.getSeq() );
				rs = pstmt.executeQuery();
				
				String filename = null;
				
				if ( rs.next() ) {
					filename = rs.getString( "filename" );
				}
				
				sql = "delete from galleryboard_db where seq = ? and password = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString( 1, gto.getSeq() );
				pstmt.setString( 2, gto.getPass() );
				
				int result = pstmt.executeUpdate();
				
				if ( result == 0 ) {
					// 삭제할 글이 없는 경우
					flag = 1;
				} else if ( result ==1 ) {
					// 삭제 성공
					flag = 0;
					if ( filename != null ) {
						File file = new File( "C:\\Users\\82104\\Desktop\\workspace_jsp\\Project__01\\src\\main\\webcontent\\upload"+ filename );
						
						file.delete();
					}
				}
			
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			return flag;
		}
		
		// 수정하기 페이지 글 가져오기
		public galleryDTO boardModify(galleryDTO gto) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = dataSource.getConnection();
				
				//데이터베이스에서 해당 글 내용 가져오기
				String sql = "select name, subject, content, filename from galleryboard_db where seq = ?";
				pstmt = conn.prepareStatement( sql );
				pstmt.setString( 1, gto.getSeq() );
				rs = pstmt.executeQuery();
				
				//데이터베이스에서 sql실행문의 각 컬럼을 가져와서 변수에 저장
				if ( rs.next() ) {
					String name = rs.getString( "name" );
					String subject = rs.getString( "subject" );
					String content = rs.getString( "content" );
					String filename = rs.getString( "filename" );
					
					gto.setName(name);
					gto.setSubject(subject);
					gto.setContent(content);
					gto.setFilename(filename);
				}
				
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( rs != null ) try { rs.close(); } catch ( SQLException e ) {}
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			return gto;
		}
		
		// 글 수정하기 처리
		public int boardModifyOk( galleryDTO gto ) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int flag = 2;
			
			try {
				conn = dataSource.getConnection();
				
				String sql = "select filename from galleryboard_db where seq = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, gto.getSeq());
				rs = pstmt.executeQuery();
				
				String oldFilename = null;
				
				if ( rs.next() ) {
					oldFilename = rs.getString( "filename" );
				}
				
				if ( gto.getFilename() != null ) {
					// 수정할 첨부파일이 있을 때
					sql = "update galleryboard_db set subject = ?, content = ?, filename = ? where seq = ? and pass = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString( 1, gto.getSubject() );
					pstmt.setString( 2, gto.getContent() );
					pstmt.setString( 3, gto.getFilename() );
					pstmt.setString( 5, gto.getSeq() );
					pstmt.setString( 6, gto.getPass() );
				} else {
					//수정할 첨부파일이 없을 때
					sql = "update galleryboard_db set subject = ?, content = ?, where seq = ? and pass = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString( 1, gto.getSubject() );
					pstmt.setString( 2, gto.getContent() );
					pstmt.setString( 3, gto.getSeq() );
					pstmt.setString( 4, gto.getPass() );
				}
				
				int result = pstmt.executeUpdate();
				
				if ( result == 0 ) {
					// 수정된 내용이 없을 경우
					flag = 1;
				} else if ( result ==1 ) {
					// 수정 성공
					flag = 0;
					if ( gto.getFilename() != null && oldFilename != null ) {
						//기존 첨부파일이 있고 추가된 첨부파일이 있을 경우 기존 파일은 삭제한다.
						File file = new File( "C:\\Users\\82104\\Desktop\\workspace_jsp\\Project__01\\src\\main\\webcontent\\upload"+ oldFilename );
						file.delete();
					}
				}
				
			} catch (SQLException e) {
				System.out.println( "error : " + e.getMessage() );
			} finally {
				if ( pstmt != null ) try { pstmt.close(); } catch ( SQLException e ) {}
				if ( conn != null ) try { conn.close(); } catch ( SQLException e ) {}
			}
			return flag;
		}
	}

