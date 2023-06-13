package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Customer;
import vo.Id;

public class CustomerDao {
	// 1) 회원 목록 조회(관리자용)
	public ArrayList<Customer> selectCustomerListByPage(int beginRow, int rowPerPage) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 리스트 불러오기
		String custonerListSql ="SELECT c.id id, c.cstm_name cstmName, c.cstm_last_login cstmLastLogin, c.createdate createdate, id.active active FROM customer c, id_list id WHERE c.id =id.id ORDER BY cstmName LIMIT ?, ?";
		PreparedStatement customerListStmt = conn.prepareStatement(custonerListSql);
		customerListStmt.setInt(1, beginRow);
		customerListStmt.setInt(2, rowPerPage);
		ResultSet customerListRs = customerListStmt.executeQuery();
		
		ArrayList<Customer> list = new ArrayList<>();
		while(customerListRs.next()) {
			Customer c = new Customer();
			c.setId(customerListRs.getString("id"));
			c.setCstmName(customerListRs.getString("cstmName"));
			c.setCstmLastLogin(customerListRs.getString("cstmLastLogin"));
			c.setCreatedate(customerListRs.getString("createdate"));
			c.setActive(customerListRs.getString("active"));
			
			list.add(c);
		}
		return list;
	}
	
	// 2) 회원 전체row
	public int selectCustomerCnt() throws Exception {
		// db 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
				
		// 전체 행수 구하기
		int row = 0;
		String totalRowSql ="SELECT count(*) FROM customer";
		PreparedStatement totalRowStmt = conn.prepareStatement(totalRowSql);
		ResultSet totalRowRs = totalRowStmt.executeQuery();
		if(totalRowRs.next()) {
			row = totalRowRs.getInt("count(*)");
		}
		return row;
	}
	
	// 3) 회원 정보 상세 보기(관리자: 모두, 회원: 본인것만)
	public Customer selectCustomerOne(String id) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 상세정보 불러오기
		Customer c = null;
		String customerOneSql = "SELECT c.id, c.cstm_name, c.cstm_address, c.cstm_email, c.cstm_birth, c.cstm_phone, c.cstm_gender, c.cstm_rank, nvl((plus.sum_point - minus.sum_point),0) point, c.cstm_last_login, c.createdate, c.updatedate\n"
				+ "FROM customer c,\n"
				+ "	(SELECT SUM(point) AS sum_point FROM point_history WHERE point_pm = '+') plus,\n"
				+ "	(SELECT SUM(point) AS sum_point FROM point_history WHERE point_pm = '-') minus\n"
				+ "WHERE c.id = ?";
		PreparedStatement customerOneStmt = conn.prepareStatement(customerOneSql);
		customerOneStmt.setString(1, id);
		ResultSet customerOneRs = customerOneStmt.executeQuery();
		
		if(customerOneRs.next()) {
			c = new Customer();
			c.setId(customerOneRs.getString("c.id"));
			c.setCstmName(customerOneRs.getString("c.cstm_name"));
			c.setCstmAddress(customerOneRs.getString("c.cstm_address"));
			c.setCstmEmail(customerOneRs.getString("c.cstm_email"));
			c.setCstmBirth(customerOneRs.getString("c.cstm_birth"));
			c.setCstmPhone(customerOneRs.getString("c.cstm_phone"));
			c.setCstmGender(customerOneRs.getString("c.cstm_gender"));
			c.setCstmRank(customerOneRs.getString("c.cstm_rank"));
			c.setCstmPoint(customerOneRs.getInt("point"));
			c.setCstmLastLogin(customerOneRs.getString("c.cstm_last_login"));
			c.setCreatedate(customerOneRs.getString("c.createdate"));
			c.setUpdatedate(customerOneRs.getString("c.updatedate"));
		}
		return c;
	}
	
	// 4) 회원 정보 수정
		public int updateCustomer(Customer customer) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			// 수정(update) SQL
			String updateSql = "UPDATE customer SET cstm_name = ?, cstm_address = ?, cstm_email = ?, cstm_birth = ?, cstm_phone = ?, cstm_gender = ?, updatedate = now() WHERE id = ?";
			PreparedStatement updateStmt = conn.prepareStatement(updateSql);
			updateStmt.setString(1, customer.getCstmName());
			updateStmt.setString(2, customer.getCstmAddress());
			updateStmt.setString(3, customer.getCstmEmail());
			updateStmt.setString(4, customer.getCstmBirth());
			updateStmt.setString(5, customer.getCstmPhone());
			updateStmt.setString(6, customer.getCstmGender());
			updateStmt.setString(7, customer.getId());
			int row = updateStmt.executeUpdate();
						
			return row;
		}
		
	// 5) 회원 탈퇴(활성화 여부 D로 바꿔서 탈퇴 처리)
		public int updateCstmActive(Id idList) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// 수정(update) SQL
			String updateCstmActiveSql = "UPDATE id_list SET active = 'D' WHERE id = ? AND last_pw = password(?)";				
			PreparedStatement updateCstmActiveStmt = conn.prepareStatement(updateCstmActiveSql);
			updateCstmActiveStmt.setString(1, idList.getId());
			updateCstmActiveStmt.setString(2, idList.getLastPw());
			int row = updateCstmActiveStmt.executeUpdate();
											
			return row;
		}
		
	// 6) 회원 가입
		public int insertCustomer(Customer addCustomer) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// 추가(insert) SQL
			String insertCstmSql = "INSERT INTO customer(id, cstm_name, cstm_address, cstm_email, cstm_birth, cstm_phone, cstm_gender, cstm_agree, createdate, updatedate) VALUES(?, ?, ?, ?, ?, ?, ?, ?, now(), now())";
			PreparedStatement insertCstmStmt = conn.prepareStatement(insertCstmSql);
			insertCstmStmt.setString(1, addCustomer.id);
			insertCstmStmt.setString(2, addCustomer.cstmName);
			insertCstmStmt.setString(3, addCustomer.cstmAddress);
			insertCstmStmt.setString(4, addCustomer.cstmEmail);
			insertCstmStmt.setString(5, addCustomer.cstmBirth);
			insertCstmStmt.setString(6, addCustomer.cstmPhone);
			insertCstmStmt.setString(7, addCustomer.cstmGender);
			insertCstmStmt.setString(8, addCustomer.cstmAgree);
			System.out.println(insertCstmSql);
			int row = insertCstmStmt.executeUpdate();
			 
			return row;
		}
		
}
