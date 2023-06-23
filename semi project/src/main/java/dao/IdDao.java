package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Id;
import vo.PwHistory;

public class IdDao {
	// 1-1) 로그인
    public String login(Id loginId) throws Exception {
    	// db연결
       DBUtil dbUtil = new DBUtil();
       Connection conn = dbUtil.getConnection();
       
       // 로그인 폼에 입력한 아이디와 비밀번호가 id_list에 있는 아이디, 비밀번호와 일치하는지 확인
       String login= null;
       String loginYSql = "SELECT * FROM id_list WHERE id = ? AND last_pw = PASSWORD(?) AND active = 'Y'";
       PreparedStatement loginYStmt = conn.prepareStatement(loginYSql);
       loginYStmt.setString(1, loginId.id);
       loginYStmt.setString(2, loginId.lastPw);
       ResultSet loginYRs = loginYStmt.executeQuery();
       
       String loginDSql = "SELECT * FROM id_list WHERE id = ? AND last_pw = PASSWORD(?) AND active = 'D'";
       PreparedStatement loginDStmt = conn.prepareStatement(loginDSql);
       loginDStmt.setString(1, loginId.id);
       loginDStmt.setString(2, loginId.lastPw);
       ResultSet loginDRs = loginDStmt.executeQuery();
       
       String loginNSql = "SELECT * FROM id_list WHERE id = ? AND last_pw = PASSWORD(?) AND active = 'N'";
       PreparedStatement loginNStmt = conn.prepareStatement(loginNSql);
       loginNStmt.setString(1, loginId.id);
       loginNStmt.setString(2, loginId.lastPw);
       ResultSet loginNRs = loginNStmt.executeQuery();
       
       if(loginYRs.next()) {
    	   login = "정상계정";
       } else if(loginDRs.next()) {
    	   login = "탈퇴계정";
       } else if(loginNRs.next()) {
    	   login = "휴면계정";
       } else {
    	   login = "";
       }
       return login;
	}
    // 1-2) 비밀번호 확인
    public int selectId(Id loginId) throws Exception {
       // db연결
       DBUtil dbUtil = new DBUtil();
       Connection conn = dbUtil.getConnection();
       
       // 로그인 폼에 입력한 아이디와 비밀번호가 id_list에 있는 아이디, 비밀번호와 일치하는지 확인
       int row = 0;
       String loginSql = "SELECT id, last_pw, active FROM id_list WHERE id = ? AND last_pw = PASSWORD(?) AND active = 'Y'";
       PreparedStatement loginStmt = conn.prepareStatement(loginSql);
       loginStmt.setString(1, loginId.id);
       loginStmt.setString(2, loginId.lastPw);
       ResultSet loginRs = loginStmt.executeQuery();
       
       if(loginRs.next()) {
          row = 1;
       }
       return row;
    }
    // 1-3) 휴면계정 풀기
	public int updateDormantId(Id loginId) throws Exception {
		// db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// active D -> Y
		int updateDormant = 0;
		String updateDormantIdSql = "UPDATE id_list SET active = 'Y' WHERE id = ?"; // 활성화 여부 Y로 바꾸고 
		PreparedStatement updateDormantIdStmt = conn.prepareStatement(updateDormantIdSql);
		updateDormantIdStmt.setString(1, loginId.id);
		int row = updateDormantIdStmt.executeUpdate();
		if(row == 1) {
			String updateLastLoginSql = "UPDATE customer SET cstm_last_login = now() WHERE id = ?"; // 최근방문 시간 업데이트
			PreparedStatement updateLastLoginStmt = conn.prepareStatement(updateLastLoginSql);
			updateLastLoginStmt.setString(1, loginId.id);
			updateDormant = updateLastLoginStmt.executeUpdate();
		}
		return updateDormant;
	}
    
	// 2) 로그인시 직원 회원 구분
		public String selectEmpCstm(Id loginId) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// 직원테이블과 고객테이블에서 id조회 
			String empCstm = null;
			String empSql = "SELECT id FROM employees where id = ?";
			PreparedStatement empStmt = conn.prepareStatement(empSql);
			empStmt.setString(1, loginId.id);
			ResultSet empRs = empStmt.executeQuery();
			
			String cstmSql = "SELECT id FROM customer where id = ?";
			PreparedStatement cstmStmt = conn.prepareStatement(cstmSql);
			cstmStmt.setString(1, loginId.id);
			ResultSet cstmRs = cstmStmt.executeQuery();
			
			if(empRs.next()) {
				empCstm = "직원";
			} else if(cstmRs.next()) {
				empCstm = "고객";
			}
			return empCstm;
			
		}
		
	// 3) 고객 최근 방문 시간 체크	
		public String selectCstmLastLogin(Id loginId) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			
			int row = 0;
			String cstmLastLogin = null;
			String cstmSql = "SELECT id FROM customer WHERE id= ? and cstm_last_login <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)";
			PreparedStatement cstmStmt = conn.prepareStatement(cstmSql);
			cstmStmt.setString(1, loginId.id);
			ResultSet cstmRs = cstmStmt.executeQuery();
			if(cstmRs.next()) {
				row = 1;
			}
			if(row == 1) { // 고객의 마지막 방문일이 6개월 이상 이면 휴면처리
				String updateLastLoginSql = "UPDATE id_list SET active = 'N' WHERE id = ?"; 
				PreparedStatement updateLastLoginStmt = conn.prepareStatement(updateLastLoginSql);
				updateLastLoginStmt.setString(1, loginId.id);
				int cstmRow = updateLastLoginStmt.executeUpdate();
				cstmLastLogin = "휴면계정";
			} else { // 고객의 마지막 방문일이 6개월 미만이면 마지막 방문일 업데이트
				String updateLastLoginSql = "UPDATE customer SET cstm_last_login = now() WHERE id = ?"; 
				PreparedStatement updateLastLoginStmt = conn.prepareStatement(updateLastLoginSql);
				updateLastLoginStmt.setString(1, loginId.id);
				int cstmRow = updateLastLoginStmt.executeUpdate();
				cstmLastLogin = "정상계정";
			}
			return cstmLastLogin;
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
			int row = insertIdStmt.executeUpdate();
			 
			return row;
		}
		
	// 5) 회원가입 / 직원 추가 / 비밀번호 변경시 pw_hitory 추가 
		public int insertPw(PwHistory addPwHistory) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
					
			// 추가(insert) SQL
			String insertPwSql = "INSERT INTO pw_history(id, pw, createdate) VALUES(?, PASSWORD(?), now())";
			PreparedStatement insertPwStmt = conn.prepareStatement(insertPwSql);
			insertPwStmt.setString(1, addPwHistory.id);
			insertPwStmt.setString(2, addPwHistory.pw);
			int row = insertPwStmt.executeUpdate();
					 
			return row;
		}
		
	// 6) 비밀번호 갯수 세기
		public int cntPw(String id) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// select SQL
			int row = 0;
			String cntPwSql = "SELECT COUNT(*) FROM pw_history WHERE id = ?";
			PreparedStatement cntPwStmt = conn.prepareStatement(cntPwSql);
			cntPwStmt.setString(1, id);
			ResultSet cntPwRs = cntPwStmt.executeQuery();
	
			if(cntPwRs.next()) {
				row = cntPwRs.getInt("count(*)");
			}
			return row;
		}
		
	// 7) 비밀번호 삭제
		public int deletePw(String id) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();	
			
			// 삭제(delete) SQL
			String deletePwSql = "DELETE FROM pw_history WHERE id = ? AND createdate = (SELECT createdate  FROM pw_history WHERE id = ? ORDER BY createdate DESC LIMIT 1)";
			PreparedStatement deletePwStmt = conn.prepareStatement(deletePwSql);
			deletePwStmt.setString(1, id);
			deletePwStmt.setString(2, id);
			int row = deletePwStmt.executeUpdate();
			
			return row;
		}
		
	// 8) id_list에 last_pw 업데이트
		public int updatePw(Id modifyIdList) throws Exception{
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();	
			
			// update SQL
			String updatePwSql = "UPDATE id_list SET last_pw = PASSWORD(?) WHERE id = ?";
			PreparedStatement updatePwStmt = conn.prepareStatement(updatePwSql);
			updatePwStmt.setString(1, modifyIdList.lastPw);
			updatePwStmt.setString(2, modifyIdList.id);
			int row = updatePwStmt.executeUpdate();
			
			return row;
		}
		
}
