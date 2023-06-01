package dao;

import java.sql.*;
import java.util.*;

import util.*;

import vo.*;
// 리뷰이미지를 추가할때
public class ReviewImgDao {
    public int addReviewImg(ReviewImg reviewImg) throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement("INSERT INTO review_img (order_no, review_ori_filename, review_save_filename, review_filetype, createdate, updatedate)VALUES (?, ?, ?, ?, NOW(), NOW())");
        stmt.setInt(1, reviewImg.getOrderNo());
        stmt.setString(2, reviewImg.getReviewOriFilename());
        stmt.setString(3, reviewImg.getReviewSaveFilename());
        stmt.setString(4, reviewImg.getReviewFiletype());

        int rowCount = stmt.executeUpdate();

        return rowCount;
    }
//리뷰이미지를 보여지게 할때
    public List<ReviewImg> getReviewImgsByOrderNo(int orderNo) throws Exception {
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


}