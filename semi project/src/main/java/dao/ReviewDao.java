package dao;

import java.sql.*;

import java.util.ArrayList;

import util.DBUtil;
import vo.*;

public class ReviewDao {

	//1) 리뷰리스트
	public ArrayList<Review> reviewList(int beginRow, int rowPerPage, int productNo) throws Exception {
		ArrayList<Review> rList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
        PreparedStatement reviewListStmt = conn.prepareStatement("SELECT order_no, product_no, review_title, review_content,createdate, updatedate FROM review  WHERE product_no = ? LIMIT ?, ?");
        reviewListStmt.setInt(1, productNo);
        reviewListStmt.setInt(2, beginRow);
        reviewListStmt.setInt(3, rowPerPage);
        
        ResultSet reviewListrs = reviewListStmt.executeQuery();
        
        while(reviewListrs.next()) {
        	Review review = new Review();
        	review.setOrderNo(reviewListrs.getInt("order_no"));
        	review.setProductNo(reviewListrs.getInt("product_no"));
        	review.setReviewTitle(reviewListrs.getString("review_title"));
        	review.setReviewContent(reviewListrs.getString("review_content"));
        	review.setUpdatedate(reviewListrs.getString("updatedate"));
        	review.setCreatedate(reviewListrs.getString("createdate"));
        	rList.add(review);
    	}
        return rList;
    }
	
	//2) 리뷰수정
	public int modifyReview(Review review) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
	    PreparedStatement modifyReviewStmt = conn.prepareStatement("UPDATE review SET review_title = ?,review_content = ?,updatedate = now() WHERE order_no = ?");
	    modifyReviewStmt.setString(1, review.getReviewTitle());
	    modifyReviewStmt.setString(2, review.getReviewContent());
	    modifyReviewStmt.setInt(3, review.getOrderNo());
		
		//영향받은 행값
		int row = modifyReviewStmt.executeUpdate();
			
		if(row == 1) {
			System.out.println(row + " <- 리뷰수정성공");
		} else {
			System.out.println(row + " <- 리뷰수정실패");
			}
		return row;
	}
	
	//3) 리뷰삭제 
	public int removeReview(int orderNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
	    PreparedStatement removeReviewStmt = conn.prepareStatement("DELETE FROM review WHERE orderNo = ?");
	    removeReviewStmt.setInt(1, orderNo);
	    
	    int row = removeReviewStmt.executeUpdate();
		
		if (row == 1){
			System.out.println(row + " <- 리뷰삭제성공");
		} else {
			System.out.println(row + " <- 리뷰삭제실패");
		}
		return row;
	}
	// 4) 리뷰추가
	public int addReview(Review review) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement addReviewStmt = conn.prepareStatement("INSERT INTO review (order_no, product_no, review_title, review_content,createdate, updatedate) VALUES(?,?,?,?, NOW(), NOW())");
		addReviewStmt.setInt(1, review.getOrderNo());
		addReviewStmt.setInt(2, review.getProductNo());
		addReviewStmt.setString(3, review.getReviewTitle());
		addReviewStmt.setString(4, review.getReviewContent());
		int row = addReviewStmt.executeUpdate(); 
		if(row == 1) {  
			System.out.println("지역추가성공");
		} else {
			System.out.println("지역추가실패");
		}	
		return row;
	
}
	// 5) 리뷰전체 cnt
		public int reviewCnt() throws Exception{
			int totalrow = 0;
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			String totalrowsql = "SELECT COUNT(*) FROM review";
			PreparedStatement totalrowstmt = conn.prepareStatement(totalrowsql);
			ResultSet totalrowrs = totalrowstmt.executeQuery();
			
			if(totalrowrs.next()) {
				totalrow = totalrowrs.getInt("COUNT(*)");
			}
			return totalrow;
			}
		
	//6)리뷰 상세보기
		public Review reviewListOne(int orderNo) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
		    PreparedStatement reviewOneStmt = conn.prepareStatement("select order_no, product_no, review_title, review_content,createdate, updatedate from review where order_no = ?");
		    reviewOneStmt.setInt(1, orderNo);
		    
		    ResultSet reviewOneRs = reviewOneStmt.executeQuery();
		    
		    Review review = null;
		    
		   if(reviewOneRs.next()) {
	        	review = new Review();
	        	review.setOrderNo(reviewOneRs.getInt("order_no"));
	        	review.setProductNo(reviewOneRs.getInt("product_no"));
	        	review.setReviewTitle(reviewOneRs.getString("review_title"));
	        	review.setReviewContent(reviewOneRs.getString("review_content"));
	        	review.setUpdatedate(reviewOneRs.getString("updatedate"));
	        	review.setCreatedate(reviewOneRs.getString("createdate"));
	    	}
		    return review;
		}
		
}
		    
		    
		    
