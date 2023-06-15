package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Id;
import vo.PwHistory;

public class IdDao {
	// 1) 로그인
    public int selectId(Id loginId) throws Exception {
    	// db연결
       DBUtil dbUtil = new DBUtil();
       Connection conn = dbUtil.getConnection();
       
       //로그인 폼에 입력한 아이디와 비밀번호가 id_list에 있는 아이디, 비밀번호와 일치하는지 확인
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
		
	// 2) 로그인시 직원 회원 구분
		public String selectEmpCstm(Id loginId) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// 활성화 여부(active) : N -> 휴면계정 / D -> 탈퇴회원
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
				empCstm = "회원";
			}
			return empCstm;
			
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
