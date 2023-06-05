package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Answer;
import vo.Question;
import vo.Review;

public class AnswerDao {
	// 1) 답변추가 (문의에 해당하는)
		public int addAnswer(Answer answer) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			PreparedStatement addAnswerStmt = conn.prepareStatement("INSERT INTO answer (q_no, id, a_content, createdate, updatedate) VALUES(?,?,?, NOW(), NOW())");
			addAnswerStmt.setInt(1, answer.getqNo());
			addAnswerStmt.setString(2, answer.getId());
			addAnswerStmt.setString(3, answer.getaContent());
			
			int row = addAnswerStmt.executeUpdate(); 
			if(row == 1) {  
				System.out.println("답변추가성공");
			} else {
				System.out.println("답변추가실패");
			}	
			return row;	
	}
		//2) 답변삭제 
		public int removeAnswer(int aNo) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
		    PreparedStatement  removeAnswerStmt = conn.prepareStatement("DELETE FROM answer WHERE a_no = ?");
		    removeAnswerStmt.setInt(1, aNo);
		    
		    int row = removeAnswerStmt.executeUpdate();
			
			if (row == 1){
				System.out.println(row + " <- 문의삭제성공");
			} else {
				System.out.println(row + " <- 문의삭제실패");
			}
			return row;
		}
		
		//3)  답변보기 (문의에 해당하는)
		public Answer answerOne(int qNo) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
		    PreparedStatement QuestionOneStmt = conn.prepareStatement("select a_no, q_no, id, a_content, createdate, updatedate from answer where q_no= ?");
		    QuestionOneStmt.setInt(1, qNo);
		    
		    ResultSet answerOneRs = QuestionOneStmt.executeQuery();
		    
		    Answer answer = null;
		    
		   if(answerOneRs.next()) {
			   answer = new Answer();
			   answer.setaNo(answerOneRs.getInt("a_no"));;
			   answer.setqNo(answerOneRs.getInt("q_no"));
			   answer.setId(answerOneRs.getString("id"));
		       	answer.setaContent(answerOneRs.getString("a_content"));
		       	answer.setUpdatedate(answerOneRs.getString("updatedate"));
		       	answer.setCreatedate(answerOneRs.getString("createdate"));
		
	    	}
		    return answer;
		}
		
		//4) 답변수정
		public int modifyAnswer(int aNo, String aContent) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
		    PreparedStatement modifyReviewStmt = conn.prepareStatement("UPDATE answer SET a_content = ?,updatedate = now() WHERE a_no= ?");
		    modifyReviewStmt.setString(1, aContent);
		    modifyReviewStmt.setInt(2, aNo);
			
			//영향받은 행값
			int row = modifyReviewStmt.executeUpdate();
				
			if(row == 1) {
				System.out.println(row + " <- 문의수정성공");
			} else {
				System.out.println(row + " <- 문의수정실패");
				}
			return row;
		}
}
