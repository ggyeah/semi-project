package dao;

import vo.*;
import java.sql.*;
import java.util.*;
import util.DBUtil;

public class ProductImgDao {
	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";
	
	
	/* 상품이미지 조회 : getProductImages */
	public ArrayList<ProductImg> getProductImages(int productNo) throws Exception {
		ArrayList<ProductImg> productImages = new ArrayList<>();	// 상품이미지들을 담을 ArrayList 객체 생성
		DBUtil dbUtil = new DBUtil();								// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();					// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement productImageStmt = null;					// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet productImageRs = null;							// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String productImageSql = "SELECT product_no productNo, product_ori_filename productOriFilename, product_save_filename productSaveFilename, product_filetype productFiletype, createdate, updatedate FROM product_img WHERE product_no = ?";
		productImageStmt = conn.prepareStatement(productImageSql);
		// ? 1개
		productImageStmt.setInt(1, productNo);
		// 쿼리 실행 및 결과 저장
		productImageRs = productImageStmt.executeQuery();
		// ResultSet에서 데이터를 순차적으로 읽어와 ProductImg 객체에 저장하고, productImages에 추가
		while(productImageRs.next()) {
			// 상품이미지 객체 생성
			ProductImg productImg = new ProductImg();
			// ResultSet에서 상품이미지 정보 추출 + 상품이미지 객체에 저장
			productImg.setProductNo(productImageRs.getInt("productNo"));
			productImg.setProductOriFilename(productImageRs.getString("productOriFilename"));
			productImg.setProductSaveFilename(productImageRs.getString("productSaveFilename"));
			productImg.setProductFiletype(productImageRs.getString("productFiletype"));
			productImg.setCreatedate(productImageRs.getString("createdate"));
			productImg.setUpdatedate(productImageRs.getString("updatedate"));

			// 상품이미지를 productImages에 추가
			productImages.add(productImg);
		}
		// productImages 반환
		return productImages;
	}
	
	
	/* 상품이미지 추가 : addProductImg */
	public int addProductImg(ProductImg productImg) throws Exception {
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement addProductImgStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		// SQL 쿼리문
		String addProductImgSql = "INSERT INTO product_img(product_ori_filename, product_save_filename, product_filetype, createdate, updatedate) VALUES(?,?,?,now(),now())";
		addProductImgStmt = conn.prepareStatement(addProductImgSql);
		// ? 3개
		addProductImgStmt.setString(1, productImg.getProductOriFilename());
		addProductImgStmt.setString(2, productImg.getProductSaveFilename());
		addProductImgStmt.setString(3, productImg.getProductFiletype());
		
		// 쿼리 실행 및 결과 저장
		int addProductImgRow = addProductImgStmt.executeUpdate();
		// 영향받은 행값	
		if(addProductImgRow == 1) {  
			System.out.println(SONG + addProductImgRow + " <-- ProductImgDao 상품이미지 추가성공" + RESET);
	    } else {
	    	System.out.println(SONG + addProductImgRow + " <-- ProductImgDao 상품이미지 추가실패" + RESET);
	    } 	
		return addProductImgRow;
	}
	
	
	/* 상품이미지 수정 : modifyProductImg -> 폴더에서도 삭제되고 새로 저장되도록 해야함*/
	public int modifyProductImg(ProductImg productImg) throws Exception {
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement modifyProductImgStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		// SQL 쿼리문
		String modifyProductImgSql = "UPDATE product_img SET product_ori_filename = ?, product_save_filename = ?, product_filetype = ?, updatedate = NOW() WHERE product_no = ?";
		modifyProductImgStmt = conn.prepareStatement(modifyProductImgSql);
		// ? 3개
		modifyProductImgStmt.setString(1, productImg.getProductOriFilename());
		modifyProductImgStmt.setString(2, productImg.getProductSaveFilename());
		modifyProductImgStmt.setString(3, productImg.getProductFiletype());
		
		// 쿼리 실행 및 결과 저장
		int modifyProductImgRow = modifyProductImgStmt.executeUpdate();
		// 영향받은 행값	
		if(modifyProductImgRow == 1) {
			System.out.println(SONG + modifyProductImgRow + " <-- ProductImgDao 상품이미지 수정성공" + RESET);
		} else {
			System.out.println(SONG + modifyProductImgRow + " <-- ProductImgDao 상품이미지 수정실패" + RESET);
		}
		return modifyProductImgRow;
	}
	
	
	/* 상품이미지 삭제 : removeProductImg -> 폴더에서도 삭제되도록 해야함 */
	public int removeProduct(int productNo) throws Exception {
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement removeProductImgStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		// SQL 쿼리문
		String removeProductImgSql = "DELETE FROM product_img WHERE product_no = ?";
		removeProductImgStmt = conn.prepareStatement(removeProductImgSql);
		// 1개
	    removeProductImgStmt.setInt(1, productNo);
	    // 쿼리 실행 및 결과 저장
		int removeProductImgRow = removeProductImgStmt.executeUpdate();
		// 영향받은 행값	
		if(removeProductImgRow == 1){
			System.out.println(SONG + removeProductImgRow + " <-- ProductImgDao 상품이미지 삭제성공" + RESET);
		} else {
			System.out.println(SONG + removeProductImgRow + " <-- ProductImgDao 상품이미지 삭제실패" + RESET);
		}
		return removeProductImgRow;
	}
	
	
}
