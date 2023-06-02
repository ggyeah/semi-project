package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Question;

public class AnswerDao {
	// 1) 답변추가 (문의에 해당하는)
		public int addQuestion(Question question) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			PreparedStatement addQuestionStmt = conn.prepareStatement("INSERT INTO question (q_no, product_no, id, q_category, q_title, q_content, createdate, updatedate) VALUES(?,?,?,?,?,?, NOW(), NOW())");
			addQuestionStmt.setInt(1, question.getqNo());
			addQuestionStmt.setInt(2, question.getProductNo());
			addQuestionStmt.setString(3, question.getId());
			addQuestionStmt.setString(4, question.getqCategory());
			addQuestionStmt.setString(5, question.getqTitle());
			addQuestionStmt.setString(6, question.getqContent());
			
			int row = addQuestionStmt.executeUpdate(); 
			if(row == 1) {  
				System.out.println("문의추가성공");
			} else {
				System.out.println("문의추가실패");
			}	
			return row;	
	}
		//2) 답변삭제 (문의에 해당하는)
		public int removeQuestion(int qNo) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
		    PreparedStatement  removeQuestionStmt = conn.prepareStatement("DELETE FROM question WHERE q_no = ?");
		    removeQuestionStmt.setInt(1, qNo);
		    
		    int row = removeQuestionStmt.executeUpdate();
			
			if (row == 1){
				System.out.println(row + " <- 문의삭제성공");
			} else {
				System.out.println(row + " <- 문의삭제실패");
			}
			return row;
		}
		
		//3)  답변보기 (문의에 해당하는)
		public Question questionOne(int qNo) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
		    PreparedStatement QuestionOneStmt = conn.prepareStatement("select q_no, product_no, id, q_category, q_title, q_content, createdate, updatedate from question where q_no= ?");
		    QuestionOneStmt.setInt(1, qNo);
		    
		    ResultSet QuestionOneRs = QuestionOneStmt.executeQuery();
		    
		    Question question = null;
		    
		   if(QuestionOneRs.next()) {
			    question = new Question();
			    question.setqNo(QuestionOneRs.getInt("q_no"));;
		       	question.setProductNo(QuestionOneRs.getInt("product_no"));
		       	question.setId(QuestionOneRs.getString("id"));
		       	question.setqCategory(QuestionOneRs.getString("q_category"));
		       	question.setqTitle(QuestionOneRs.getString("q_title"));
		       	question.setqContent(QuestionOneRs.getString("q_content"));
		       	question.setUpdatedate(QuestionOneRs.getString("updatedate"));
		       	question.setCreatedate(QuestionOneRs.getString("createdate"));
		
	    	}
		    return question;
		}
		
}
