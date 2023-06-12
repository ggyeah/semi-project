package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Id;
import vo.PwHistory;

public class IdDao {
	// 1) 로그인 
    public int selectId(String id, String lastPw) throws Exception {
    	// db연결
       DBUtil dbUtil = new DBUtil();
       Connection conn = dbUtil.getConnection();
       
       //로그인 폼에 입력한 아이디와 비밀번호가 id_list에 있는 아이디, 비밀번호와 일치하는지 확인
       int row = 0;
       String loginSql = "SELECT id, last_pw FROM id_list where id = ? AND last_pw = PASSWORD(?)";
       PreparedStatement loginStmt = conn.prepareStatement(loginSql);
       loginStmt.setString(1, id);
       loginStmt.setString(2, lastPw);
       System.out.println(loginStmt);
       ResultSet loginRs = loginStmt.executeQuery();
       
       if(loginRs.next()) {
    	   row = 1;
       }
       return row;
	}
		
	// 2) 활성화 여부 
		public int activeId(Id loginId) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// 활성화 여부(active) : N -> 휴면계정
			int row = 0;
			String activeSql = "SELECT id, active FROM id_list where id = ? AND active = 'N' ";
			PreparedStatement activeStmt = conn.prepareStatement(activeSql);
			activeStmt.setString(1, loginId.id);
			activeStmt.setString(2, loginId.lastPw);
			System.out.println(activeStmt);
			ResultSet activeRs = activeStmt.executeQuery();
			
			if(activeRs.next()) {
				row = 1;
			}
			return row;
		}
		
	// 3) id 중복체크
		public int ckId(String id) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// Id 중복 체크 SQL
			int row = 0;
			String ckIdSql = "SELECT count(*) FROM id_list WHERE id = ?";
			PreparedStatement ckIdStmt = conn.prepareStatement(ckIdSql);
			ckIdStmt.setString(1, id);
			System.out.println(ckIdStmt);
			ResultSet ckIdRs = ckIdStmt.executeQuery();
			
			if(ckIdRs.next()) {
				row = ckIdRs.getInt("count(*)");
			}
			return row;
		}
		
	// 4) 회원가입 / 직원 추가시 id_list 추가 
		public int insertId(Id addIdList) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// 추가(insert) SQL
			String insertIdSql = "INSERT INTO id_list(id, last_pw, createdate) VALUES(?, PASSWORD(?), now())";
			PreparedStatement insertIdStmt = conn.prepareStatement(insertIdSql);
			insertIdStmt.setString(1, addIdList.id);
			insertIdStmt.setString(2, addIdList.lastPw);
			System.out.println(insertIdSql);
			int row = insertIdStmt.executeUpdate();
			 
			return row;
		}
		
	// 5) 회원가입 / 직원 추가시 pw_hitory 추가 
		public int insertPw(PwHistory addPwHistory) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
					
			// 추가(insert) SQL
			String insertPwSql = "INSERT INTO pw_history(id, pw, createdate) VALUES(?, PASSWORD(?), now())";
			PreparedStatement insertPwStmt = conn.prepareStatement(insertPwSql);
			insertPwStmt.setString(1, addPwHistory.id);
			insertPwStmt.setString(2, addPwHistory.pw);
			System.out.println(insertPwSql);
			int row = insertPwStmt.executeUpdate();
					 
			return row;
		}

}
