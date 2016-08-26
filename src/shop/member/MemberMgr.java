package shop.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import shop.board.BoradBean;

public class MemberMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public MemberMgr() {

		try {
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
	
	//우편번호검색
	public ArrayList<ZiptapBean> zipcodeRead(String area3){
		ArrayList<ZiptapBean> list = new ArrayList<>();
		try {
				conn = ds.getConnection();
				//String sql = "select * from ziptab where area3 like '" + area3 + "%'";
				String sql = "select * from ziptab where area3 like ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, area3 + "%");
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ZiptapBean bean = new ZiptapBean();
					bean.setZipcode(rs.getString("zipcode"));
					bean.setArea1(rs.getString("area1"));
					bean.setArea2(rs.getString("area2"));
					bean.setArea3(rs.getString("area3"));
					bean.setArea4(rs.getString("area4"));
					list.add(bean);
					
				}
			
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
		return list;
	}
	
	//아디 중복체크
	public boolean checkId(String id){
		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "select id from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			b = rs.next();
		}  catch (Exception e) {
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
		return b;
	}
	
	//회원추가
	public boolean memberInsert(MemberBean bean){
		boolean b = false;
		try {
			conn =ds.getConnection();
			String sql = "insert into member values(?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPassed());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getPhone());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			pstmt.setString(8, bean.getJob());
			if(pstmt.executeUpdate() > 0) b = true;
			
		}  catch (Exception e) {
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
		return b;
	}
	
	public boolean loginCheck(String id,String passwd){
		boolean b = false;
		
		try {
			conn =ds.getConnection();
			String sql = "select id,passwd from member where id=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			b = rs.next();
		}  catch (Exception e) {
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
		return b;
	}
	
	public MemberBean getMember(String id){
		MemberBean bean = null;
		try {
			conn = ds.getConnection();
			String sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPassed(rs.getString("passwd"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				bean.setPhone(rs.getString("phone"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				bean.setJob(rs.getString("job"));
				
			}
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
		return bean;
	}
	
	public boolean saveMember(MemberBean bean){
		boolean b = false;
		String sql = "update member set passwd=?,name=?,email=?,phone=?,zipcode=?,address=?,job=? where id=?";
		try{
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getPassed());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getEmail());
			pstmt.setString(4, bean.getPhone());
			pstmt.setString(5, bean.getZipcode());
			pstmt.setString(6, bean.getAddress());
			pstmt.setString(7, bean.getJob());
			pstmt.setString(8, bean.getId());		
			pstmt.executeUpdate();
			if(pstmt.executeUpdate() > 0) b = true;
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
	
	
	
}
