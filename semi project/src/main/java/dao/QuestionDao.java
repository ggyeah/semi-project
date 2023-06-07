package dao;

import java.sql.*;

import java.util.ArrayList;

import util.DBUtil;
import vo.*;

public class QuestionDao {

	//1) 문의 리스트
	public ArrayList<Question> questionList(int qbeginRow, int qrowPerPage, int productNo) throws Exception {
		ArrayList<Question> qList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
        PreparedStatement questionListStmt = conn.prepareStatement("SELECT q_no, product_no, id, q_category, q_title, q_content, createdate, updatedate FROM question WHERE product_no = ? LIMIT ?, ?");
        questionListStmt.setInt(1, productNo);
        questionListStmt.setInt(2, qbeginRow);
        questionListStmt.setInt(3, qrowPerPage);
        
        ResultSet questionListRs = questionListStmt.executeQuery();
        
        while(questionListRs.next()) {
        	Question question = new Question();
        	question.setqNo(questionListRs.getInt("q_no"));;
        	question.setProductNo(questionListRs.getInt("product_no"));
        	question.setId(questionListRs.getString("id"));
        	question.setqCategory(questionListRs.getString("q_category"));
        	question.setqTitle(questionListRs.getString("q_title"));
        	question.setqContent(questionListRs.getString("q_content"));
        	question.setUpdatedate(questionListRs.getString("updatedate"));
        	question.setCreatedate(questionListRs.getString("createdate"));
        	qList.add(question);
    	}
        return qList;
    }
	
	//2) 문의수정
	public int modifyQuestion(Question question) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
	    PreparedStatement modifyQuestionStmt = conn.prepareStatement("UPDATE question SET q_category = ?, q_title = ?, q_content = ? , updatedate = now() WHERE q_no = ?");
	    modifyQuestionStmt.setString(1, question.getqCategory());
	    modifyQuestionStmt.setString(2, question.getqTitle());
	    modifyQuestionStmt.setString(3, question.getqContent());
	    modifyQuestionStmt.setInt(4, question.getqNo());
		
		//영향받은 행값
		int row = modifyQuestionStmt.executeUpdate();
			
		if(row == 1) {
			System.out.println(row + " <- 문의수정성공");
		} else {
			System.out.println(row + " <- 문의수정실패");
			}
		return row;
	}
	
	//3) 문의삭제 
	public int removeQuestion(int qNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
	    PreparedStatement  removeQuestionStmt = conn.prepareStatement("DELETE FROM question WHERE q_no = ?");
	    removeQuestionStmt.setInt(1, qNo);
	    
	    int questionrow = removeQuestionStmt.executeUpdate();
		
		if (questionrow == 1){
			System.out.println(questionrow + " <- 문의삭제성공");
		} else {
			System.out.println(questionrow + " <- 문의삭제실패");
		}
		return questionrow;
	}
	
	
	// 4) 문의추가
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
	// 5) 문의전체 cnt
	public int questionCnt() throws Exception{
		int qtotalrow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String totalrowsql = "SELECT COUNT(*) FROM question";
		PreparedStatement totalrowstmt = conn.prepareStatement(totalrowsql);
		ResultSet totalrowrs = totalrowstmt.executeQuery();
		
		if(totalrowrs.next()) {
			qtotalrow = totalrowrs.getInt("COUNT(*)");
		}
		return qtotalrow;
		}
		
	//6)  문의상세보기
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
		    
		    
		    
