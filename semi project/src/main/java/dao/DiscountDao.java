package dao;

import java.sql.*;

import java.util.ArrayList;

import util.DBUtil;
import vo.*;

public class DiscountDao {

	//1) 할인리스트
	public ArrayList<Discount> discountList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Discount> dList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		/*
		SELECT
		  p.product_no,
		  p.category_name,
		  p.product_name,
		  p.product_status,
		  p.product_stock,
		  d.discount_start,
		  d.discount_end,
		  d.discount_no,
		  CASE
		    WHEN (d.discount_start <= NOW() AND d.discount_end >= NOW()) THEN d.discount_rate
		    ELSE 0.0
		  END AS discount_rate,
		  CASE
		    WHEN (d.discount_start <= NOW() AND d.discount_end >= NOW()) THEN p.product_price * (1 - d.discount_rate)
		    ELSE p.product_price
		  END AS discounted_price
		FROM
		  product p
		LEFT JOIN
		  discount d ON p.product_no = d.product_no
		LIMIT ?, ?;
		*/
		
		PreparedStatement discountListStmt = conn.prepareStatement("SELECT p.product_no, p.category_name, p.product_name, p.product_status, p.product_stock, d.discount_start, d.discount_end, d.discount_no, CASE WHEN (d.discount_start <= NOW() AND d.discount_end >= NOW()) THEN d.discount_rate ELSE 0.0 END AS discount_rate, CASE WHEN (d.discount_start <= NOW() AND d.discount_end >= NOW()) THEN p.product_price * (1 - d.discount_rate) ELSE p.product_price END AS discounted_price FROM product p LEFT JOIN discount d ON p.product_no = d.product_no LIMIT ?, ?");
        discountListStmt.setInt(1, beginRow);
        discountListStmt.setInt(2, rowPerPage);
        
        ResultSet discountListRs = discountListStmt.executeQuery();
        
        while(discountListRs.next()) {
            Discount discount = new Discount();
            discount.setProductNo(discountListRs.getInt("product_no"));
            discount.setCategoryName(discountListRs.getString("category_name"));
            discount.setProductName(discountListRs.getString("product_name"));
            discount.setProductStatus(discountListRs.getString("product_status"));
            discount.setProductStock(discountListRs.getInt("product_stock"));
            discount.setDiscountStart(discountListRs.getString("discount_start"));
            discount.setDiscountEnd(discountListRs.getString("discount_end"));
            discount.setDiscountRate(discountListRs.getDouble("discount_rate"));
            discount.setDiscountedPrice(discountListRs.getInt("discounted_price"));
            discount.setDiscountNo(discountListRs.getInt("discount_no"));
            dList.add(discount);
    	}
        return dList;
    }
	
	//2) 할인품목수정
	public int modifyDiscount(Discount discount) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
	    PreparedStatement modifyDiscountStmt = conn.prepareStatement("UPDATE discount SET discount_start = ?, discount_end = ?, discount_rate=?, updatedate = now() WHERE product_no = ?");
	    modifyDiscountStmt.setString(1, discount.getDiscountStart());
	    modifyDiscountStmt.setString(2, discount.getDiscountEnd());
	    modifyDiscountStmt.setDouble(3, discount.getDiscountRate());
	    modifyDiscountStmt.setInt(4, discount.getProductNo());
	    
		
		//영향받은 행값
		int row = modifyDiscountStmt.executeUpdate();
			
		if(row == 1) {
			System.out.println(row + " <- 할인품목수정성공");
		} else {
			System.out.println(row + " <- 할인품목수정실패");
			}
		return row;
	}
	
	//3) 할인품목삭제
	public int removeDiscount(int discountNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
	    PreparedStatement removeDiscountStmt = conn.prepareStatement("DELETE FROM discount WHERE discount_no = ?");
	    removeDiscountStmt.setInt(1, discountNo);
	    
	    int discountRow = removeDiscountStmt.executeUpdate();
		
		if (discountRow == 1){
			System.out.println(discountRow + " <- 할인삭제성공");
		} else {
			System.out.println(discountRow + " <- 할인삭제실패");
		}
		return discountRow;
	}
	// 4) 할인품목추가
	public int addDiscount(Discount discount) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement addDiscountStmt = conn.prepareStatement("INSERT INTO discount (product_no, discount_start, discount_end, discount_rate, createdate, updatedate) VALUES(?,?,?,?, NOW(), NOW())");
		addDiscountStmt.setInt(1, discount.getProductNo());
		addDiscountStmt.setString(2, discount.getDiscountStart());
		addDiscountStmt.setString(3, discount.getDiscountEnd());
		addDiscountStmt.setDouble(4, discount.getDiscountRate());
		int row = addDiscountStmt.executeUpdate(); 
		if(row == 1) {  
			System.out.println("할인추가성공");
		} else {
			System.out.println("할인추가실패");
		}	
		return row;
	
	}	
	// 5) 할인품목전체 cnt
	public int discountCnt() throws Exception{
		int totalrow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String totalrowsql = "SELECT COUNT(*) FROM discount";
		PreparedStatement totalrowstmt = conn.prepareStatement(totalrowsql);
		ResultSet totalrowrs = totalrowstmt.executeQuery();
		
		if(totalrowrs.next()) {
			totalrow = totalrowrs.getInt("COUNT(*)");
		}
		return totalrow;
		}
	

		
	//6)할인품목 상세보기
		public Discount discountOne(int productNo) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
		    PreparedStatement discountOneStmt = conn.prepareStatement("select discount_no, product_no, discount_start, discount_end, discount_rate, createdate, updatedate from discount where product_no = ?");
		    discountOneStmt.setInt(1, productNo);
		    
		    ResultSet discountOneRs = discountOneStmt.executeQuery();
		    
		   Discount discount = null;
		    
		   if(discountOneRs.next()) {
	        	discount = new Discount();
	        	discount.setDiscountNo(discountOneRs.getInt("discount_no"));
	        	discount.setProductNo(discountOneRs.getInt("product_no"));
	        	discount.setDiscountStart(discountOneRs.getString("discount_start"));
	        	discount.setDiscountEnd(discountOneRs.getString("discount_end"));
	        	discount.setDiscountRate(discountOneRs.getDouble("discount_rate"));
	        	discount.setCreatedate(discountOneRs.getString("createdate"));
	        	discount.setUpdatedate(discountOneRs.getString("updatedate"));
	    	}
		    return discount;
		}

		
}
		    
		    
		    
