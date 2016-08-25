package shop.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import sun.net.www.content.text.plain;

public class BoardMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;

	// 페이징처리를위해
	private int tot; // 전체레코드
	private int pList = 8; // 페이지당 출력 행수
	private int pageSu;// 전체 페이지수

	public BoardMgr() {
		try {
			// 기존방법 - Class.forName("com.mysql.jdbc.Driver");
			// 커넥션 객체를 풀링기법으로 만들어줌
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");

		} catch (Exception e) {
			System.out.println("실패");
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
	}

	public int currentGetNum() {
		String sql = "select max(num) from board";
		int cnt = 0;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				cnt = rs.getInt(1);
		} catch (Exception e2) {
			// TODO: handle exception
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return cnt;
	}

	public void saveData(BoradBean bean) {
		String sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getPass());
			pstmt.setString(4, bean.getMail());
			pstmt.setString(5, bean.getTitle());
			pstmt.setString(6, bean.getCont());
			pstmt.setString(7, bean.getBip());
			pstmt.setString(8, bean.getBdate());
			pstmt.setInt(9, 0); // readcnt
			pstmt.setInt(10, bean.getGnum());
			pstmt.setInt(11, 0);// onum
			pstmt.setInt(12, 0);// nested
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("save에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
	}

	public void totalList() {
		String sql = "select count(*) from board";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			tot = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("tot에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
	}

	public int getPageSu() {// 총페이지수 구하기
		pageSu = tot / pList;
		if (tot % pList > 0)
			pageSu++;// 남는페이지가 있을경우 1페이지추가
		return pageSu;

	}

	public ArrayList<BoardDto> getDataAll(int page, String stype, String sword) {
		ArrayList<BoardDto> list = new ArrayList<>();
		String sql = "select * from board";
		try {
			conn = ds.getConnection();
			if (sword == null) {
				sql += " order by gnum desc,onum asc";
				pstmt = conn.prepareStatement(sql);
			} else {// 검색인경우
				sql += " where " + stype + " like ?";
				sql += " order by gnum desc,onum asc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + sword + "%");
			}

			rs = pstmt.executeQuery();

			for (int i = 0; i < (page - 1) * pList; i++) {
				rs.next(); // 포인터만 이동한다
			}
			// i <(page - 1) * pList ex)1페이지일때 포인터 0부터 2페이지일때 포인터는 8부터
			int k = 0;
			while (rs.next() && k < pList) {
				BoardDto dto = new BoardDto();
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setBdate(rs.getString("bdate"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setNested(rs.getInt("nested"));
				list.add(dto);
				k++;
			}
		} catch (Exception e) {
			System.out.println("all에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}

		return list;
	}

	public void updateReadcnt(String num) {// 글내용 보기하면 조회수 증가
		String sql = "update board set readcnt=readcnt + 1 where num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("all에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
	}

	public BoardDto getDate(String num) { //글상세보기
		String sql = "select * from board where num=?";
		BoardDto dto = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dto = new BoardDto();
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setMail(rs.getString("mail"));
				dto.setTitle(rs.getString("title"));
				dto.setCont(rs.getString("cont"));
				dto.setBip(rs.getString("bip"));
				dto.setBdate(rs.getString("bdate"));
				dto.setReadcnt(rs.getInt("readcnt"));
				
				
		
			}

		} catch (Exception e) {
			System.out.println("all에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
		return dto;
	}
	
	public BoardDto getReplyData(String num){//댓글용데이타
		String sql = "select * from board where num=?";
		BoardDto dto = null;

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dto = new BoardDto();
				dto.setTitle(rs.getString("title"));
				dto.setGnum(rs.getInt("gnum"));
				dto.setOnum(rs.getInt("onum"));
				dto.setNested(rs.getInt("nested"));
	
			}

		} catch (Exception e) {
			System.out.println("all에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
		return dto;
	}
	
		public void updateOnum(int gnum,int onum){//댓글용 onum 갱신용
			//같은 그룹의 레코드는 모두 작업에 참여(onum값을 바꿔줘야하기때문에)
			//댓글의 onum은 이미 db에 있는 onum보다 크거나 같은값을 변경
			String sql = "update board set onum=onum + 1 where onum >= ? and gnum=?";
			try{
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, onum);
				pstmt.setInt(2, gnum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("all에러" + e);
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
					System.out.println("asd");
				}
			}
		}
	
	public void saveReply(BoradBean bean){//댓글저장
		String sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getPass());
			pstmt.setString(4, bean.getMail());
			pstmt.setString(5, bean.getTitle());
			pstmt.setString(6, bean.getCont());
			pstmt.setString(7, bean.getBip());
			pstmt.setString(8, bean.getBdate());
			pstmt.setInt(9, 0); // readcnt
			pstmt.setInt(10, bean.getGnum());
			pstmt.setInt(11, bean.getOnum());// onum
			pstmt.setInt(12, bean.getNested());// nested
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("save에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
	
	}
	
	public boolean checkPass(int num,String new_pass){
		boolean b = false;
		String sql = "select pass from board where num=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(new_pass.equals(rs.getString("pass"))) b = true;
			}
		} catch (Exception e) {
			System.out.println("save에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
		return b;
	}
	
	public void saveEdit(BoradBean bean){
		String sql = "update board set name=?,mail=?,title=?,cont=? where num=?";
		try{
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getMail());
			pstmt.setString(3, bean.getTitle());
			pstmt.setString(4, bean.getCont());
			pstmt.setInt(5, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("save에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
	}
	
	public void delData(String 넘){
		String sql = "delete from board where num=?";
		try{
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, 넘);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("save에러" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("asd");
			}
		}
	}
	
	

}
