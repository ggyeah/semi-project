package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Id;

public class IdDao {
	// 1) 로그인 
		public ResultSet selectId(Id loginId) throws Exception {
			// db연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			//로그인 폼에 입력한 아이디와 비밀번호가 id_list에 있는 아이디, 비밀번호와 일치하는지 확
			int row = 0;
			String loginSql = "SELECT id, last_pw FROM id_list where id = ? AND last_pw = PASSWORD(?)";
			PreparedStatement loginStmt = conn.prepareStatement(loginSql);
			loginStmt.setString(1, loginId.id);
			loginStmt.setString(2, loginId.lastPw);
			System.out.println(loginStmt);
			ResultSet loginRs = loginStmt.executeQuery();
			
			return loginRs;
			
		}

}