package dao;

import java.sql.*;

import java.util.*;

import util.*;

import vo.*;

import java.io.*;
	// 1) 리뷰이미지를 추가할때
	public class ReviewImgDao {
	    public int addReviewImg(ReviewImg reviewImg) throws Exception {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();
	        PreparedStatement stmt = conn.prepareStatement("INSERT INTO review_img (order_no, review_ori_filename, review_save_filename, review_filetype, createdate, updatedate)VALUES (?, ?, ?, ?, NOW(), NOW())");
	        stmt.setInt(1, reviewImg.getOrderNo());
	        stmt.setString(2, reviewImg.getReviewOriFilename());
	        stmt.setString(3, reviewImg.getReviewSaveFilename());
	        stmt.setString(4, reviewImg.getReviewFiletype());
	
	        int row = stmt.executeUpdate();
	
	        return row;
	    }
	// 2) 리뷰이미지를 보여지게 할때
	    public List<ReviewImg> getReviewImages(int orderNo) throws Exception {
	        List<ReviewImg> reviewImgs = new ArrayList<>();
	
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();
	        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM review_img WHERE order_no = ?");
	        stmt.setInt(1, orderNo);
	
	        ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            ReviewImg reviewImg = new ReviewImg();
	            reviewImg.setOrderNo(rs.getInt("order_no"));
	            reviewImg.setReviewOriFilename(rs.getString("review_ori_filename"));
	            reviewImg.setReviewSaveFilename(rs.getString("review_save_filename"));
	            reviewImg.setReviewFiletype(rs.getString("review_filetype"));
	            reviewImg.setCreateDate(rs.getString("createdate"));
	            reviewImg.setUpdateDate(rs.getString("updatedate"));
	
	            reviewImgs.add(reviewImg);
	        }
	
	        return reviewImgs;
	    }
	    // 3) 리뷰 이미지 삭제
	    public int deleteReviewImgFile(int orderNo, String dir) throws Exception {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();
	        PreparedStatement stmt = conn.prepareStatement("SELECT review_save_filename FROM review_img WHERE order_no = ?");
	        stmt.setInt(1, orderNo);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            String saveFilename = rs.getString("review_save_filename");
	            File file = new File(dir, saveFilename);
	            if (file.exists()) {
	                file.delete();
	            }
	        }
	        return 1;
	    }

	    // 4) 리뷰 이미지를 데이터베이스에서 업데이트
	    public int updateReviewImg(ReviewImg reviewImg) throws Exception {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();
	        PreparedStatement stmt = conn.prepareStatement("UPDATE review_img SET review_ori_filename=?, review_save_filename=?, review_filetype=?, updatedate=NOW() WHERE order_no=?");
	        stmt.setString(1, reviewImg.getReviewOriFilename());
	        stmt.setString(2, reviewImg.getReviewSaveFilename());
	        stmt.setString(3, reviewImg.getReviewFiletype());
	        stmt.setInt(4, reviewImg.getOrderNo());

	        int row= stmt.executeUpdate();

	        return row;
	    }
	
	    
	}
