package dao;

import vo.*;
import java.sql.*;
import java.util.*;
import util.DBUtil;

public class ProductDao {
	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	/* 상품 리스트 : productList */
	public ArrayList<Product> productListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Product> productList = new ArrayList<>();		// 상품 리스트를 담을 ArrayList 객체 생성
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement productListStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet productListRs = null;							// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String productListSql = "SELECT product_no productNo, category_name categoryName, product_name productName, product_price productPrice, product_status productStatus, product_stock productStock, product_info productInfo, createdate, updatedate FROM product ORDER BY createdate DESC LIMIT ?, ?";
		productListStmt = conn.prepareStatement(productListSql);
		// ? 2개
		productListStmt.setInt(1, beginRow);
		productListStmt.setInt(2, rowPerPage);
		// 쿼리 실행 및 결과 저장
		productListRs = productListStmt.executeQuery();
		// ResultSet에서 데이터를 순차적으로 읽어와 Product 객체에 저장하고, productList에 추가
		while(productListRs.next()) {
			// 상품 객체 생성
			Product product = new Product();
			// ResultSet에서 상품 정보 추출 + 상품 객체에 저장
			product.setProductNo(productListRs.getInt("productNo"));
			product.setCategoryName(productListRs.getString("categoryName"));
			product.setProductName(productListRs.getString("productName"));
			product.setProductPrice(productListRs.getInt("productPrice"));
			product.setProductStatus(productListRs.getString("productStatus"));
			product.setProductStock(productListRs.getInt("productStock"));
			product.setProductInfo(productListRs.getString("productInfo"));
			product.setCreatedate(productListRs.getString("createdate"));
			product.setUpdatedate(productListRs.getString("updatedate"));

			// 상품 객체를 리스트에 추가
			productList.add(product);
		}
		// 상품 리스트 반환
		return productList;
	}
	
	
	/* 전체 상품의 개수 조회 : productCnt */
	public int productCnt() throws Exception {
		int productRow = 0;	
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement productCntStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet productCntRs = null;							// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String productCntSql = "SELECT COUNT(*) FROM product";
		productCntStmt = conn.prepareStatement(productCntSql);
		// 쿼리 실행 및 결과 저장
		productCntRs = productCntStmt.executeQuery();
		if(productCntRs.next()) { 								// 결과가 존재하는 경우
			productRow = productCntRs.getInt("COUNT(*)");		// 결과에서 상품 개수 추출
		}
		return productRow;
	}
	
	
	/* 카테고리별 상품리스트 조회 : productListCate */
	public ArrayList<Product> productListCateByPage(String categoryName, int beginRow, int rowPerPage) throws Exception {
		ArrayList<Product> productListCate = new ArrayList<>();		// 상품 리스트를 담을 ArrayList 객체 생성
		DBUtil dbUtil = new DBUtil();								// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();					// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement productListCateStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet productListCateRs = null;							// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		String productListCateSql = "";
		// SQL 쿼리문
		if(categoryName.equals("전체")) {
			productListCateSql = "SELECT product_no productNo, category_name categoryName, product_name productName, product_price productPrice, product_status productStatus, product_stock productStock, product_info productInfo, createdate, updatedate FROM product ORDER BY createdate DESC LIMIT ?, ?";
			productListCateStmt = conn.prepareStatement(productListCateSql);
			// ? 2개
			productListCateStmt.setInt(1, beginRow);
			productListCateStmt.setInt(2, rowPerPage);
		} else {
			productListCateSql = "SELECT product_no productNo, category_name categoryName, product_name productName, product_price productPrice, product_status productStatus, product_stock productStock, product_info productInfo, createdate, updatedate FROM product WHERE category_name = ? ORDER BY createdate DESC LIMIT ?, ?";
			productListCateStmt = conn.prepareStatement(productListCateSql);
			// ? 3개
			productListCateStmt.setString(1, categoryName);
			productListCateStmt.setInt(2, beginRow);
			productListCateStmt.setInt(3, rowPerPage);
		}		
		// 쿼리 실행 및 결과 저장
		productListCateRs = productListCateStmt.executeQuery();
		// ResultSet에서 데이터를 순차적으로 읽어와 Product 객체에 저장하고, productList에 추가
		while(productListCateRs.next()) {
			// 상품 객체 생성
			Product product = new Product();
			// ResultSet에서 상품 정보 추출 + 상품 객체에 저장
			product.setProductNo(productListCateRs.getInt("productNo"));
			product.setCategoryName(productListCateRs.getString("categoryName"));
			product.setProductName(productListCateRs.getString("productName"));
			product.setProductPrice(productListCateRs.getInt("productPrice"));
			product.setProductStatus(productListCateRs.getString("productStatus"));
			product.setProductStock(productListCateRs.getInt("productStock"));
			product.setProductInfo(productListCateRs.getString("productInfo"));
			product.setCreatedate(productListCateRs.getString("createdate"));
			product.setUpdatedate(productListCateRs.getString("updatedate"));

			// 상품 객체를 리스트에 추가
			productListCate.add(product);
		}
		// 상품 리스트 반환
		return productListCate;
	}
		
	
	/* 카테고리별 상품 개수 조회 : productCateCnt */
	public int productCateCnt(String categoryName) throws Exception {
		int productRow = 0;	
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement productCateCntStmt = null;			// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet productCateCntRs = null;						// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String productCateCntSql = "SELECT COUNT(*) FROM product WHERE category_name = ?";
		productCateCntStmt = conn.prepareStatement(productCateCntSql);
		// ? 1개
		productCateCntStmt.setString(1, categoryName);
		// 쿼리 실행 및 결과 저장
		productCateCntRs = productCateCntStmt.executeQuery();
		if(productCateCntRs.next()) { 							// 결과가 존재하는 경우
			productRow = productCateCntRs.getInt("COUNT(*)");	// 결과에서 상품 개수 추출
		}
		return productRow;
	}
	
	
	/* 상품이름 검색 : productSearchList */
	public ArrayList<Product> productListSearchByPage(String searchWord, int beginRow, int rowPerPage) throws Exception {
		ArrayList<Product> productListSearch = new ArrayList<>();		// 상품 리스트를 담을 ArrayList 객체 생성
		DBUtil dbUtil = new DBUtil();									// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();						// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement productListSearchStmt = null;					// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet productListSearchRs = null;							// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String productListSearchSql = "SELECT product_no productNo, category_name categoryName, product_name productName, product_price productPrice, product_status productStatus, product_stock productStock, product_info productInfo, createdate, updatedate FROM product WHERE product_name LIKE ? ORDER BY createdate DESC LIMIT ?, ?";
		productListSearchStmt = conn.prepareStatement(productListSearchSql);
		// ? 3개
		productListSearchStmt.setString(1, "%"+searchWord+"%");
		productListSearchStmt.setInt(2, beginRow);
		productListSearchStmt.setInt(3, rowPerPage);
		// 쿼리 실행 및 결과 저장
		productListSearchRs = productListSearchStmt.executeQuery();
		// ResultSet에서 데이터를 순차적으로 읽어와 Product 객체에 저장하고, productList에 추가
		while(productListSearchRs.next()) {
			// 상품 객체 생성
			Product product = new Product();
			// ResultSet에서 상품 정보 추출 + 상품 객체에 저장
			product.setProductNo(productListSearchRs.getInt("productNo"));
			product.setCategoryName(productListSearchRs.getString("categoryName"));
			product.setProductName(productListSearchRs.getString("productName"));
			product.setProductPrice(productListSearchRs.getInt("productPrice"));
			product.setProductStatus(productListSearchRs.getString("productStatus"));
			product.setProductStock(productListSearchRs.getInt("productStock"));
			product.setProductInfo(productListSearchRs.getString("productInfo"));
			product.setCreatedate(productListSearchRs.getString("createdate"));
			product.setUpdatedate(productListSearchRs.getString("updatedate"));

			// 상품 객체를 리스트에 추가
			productListSearch.add(product);
		}
		// 상품 리스트 반환
		return productListSearch;
	}
	
	
	/* 상품이름 검색결과 개수 조회 : productSearchCnt */ 
	public int productSearchCnt(String searchWord) throws Exception {
		int productRow = 0;	
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement productCateCntStmt = null;			// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet productCateCntRs = null;						// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String productCateCntSql = "SELECT COUNT(*) FROM product WHERE product_name LIKE ?";
		productCateCntStmt = conn.prepareStatement(productCateCntSql);
		// ? 1개
		productCateCntStmt.setString(1, "%"+searchWord+"%");
		// 쿼리 실행 및 결과 저장
		productCateCntRs = productCateCntStmt.executeQuery();
		if(productCateCntRs.next()) { 							// 결과가 존재하는 경우
			productRow = productCateCntRs.getInt("COUNT(*)");	// 결과에서 상품 개수 추출
		}
		return productRow;
	}
	
	
	/* 상품 하나 상세정보 조회 : productListOne */
	public Product ProductListOne(int productNo) throws Exception {	// productNo를 매개변수로 받아 해당 상품의 상세 정보를 가져오는 메서드
	    Product productOne = null;
	    DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement productOneStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet productOneRs = null;							// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String productOneSql = "SELECT product_no productNo, category_name categoryName, product_name productName, product_price productPrice, product_status productStatus, product_stock productStock, product_info productInfo, createdate, updatedate FROM product WHERE product_no = ?";
		productOneStmt = conn.prepareStatement(productOneSql);
		// ? 1개
		productOneStmt.setInt(1, productNo);
		// 쿼리 실행 및 결과 저장
		productOneRs = productOneStmt.executeQuery();
		if(productOneRs.next()) { 								// 결과가 존재하는 경우
			productOne = new Product(); 						// productOne 객체 생성
			// ResultSet에서 상품 상세 정보 추출 + 상품 상세 객체에 저장
			productOne.setProductNo(productOneRs.getInt("productNo"));
			productOne.setCategoryName(productOneRs.getString("categoryName"));
			productOne.setProductName(productOneRs.getString("productName"));
			productOne.setProductPrice(productOneRs.getInt("productPrice"));
			productOne.setProductStatus(productOneRs.getString("productStatus"));
			productOne.setProductStock(productOneRs.getInt("productStock"));
			productOne.setProductInfo(productOneRs.getString("productInfo"));
			productOne.setCreatedate(productOneRs.getString("createdate"));
			productOne.setUpdatedate(productOneRs.getString("updatedate"));
	    }
		return productOne;
	}
	
	
	/* 상품 추가 : addProduct */
	public int[] addProduct(Product product) throws Exception {
		int[] rowAndKey = new int[2];							// 리턴할 배열 생성
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement addProductStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		// SQL 쿼리문
		String addProductSql = "INSERT INTO product(category_name, product_name, product_price, product_status, product_stock, product_info, createdate, updatedate) VALUES(?,?,?,?,?,?,now(),now())";
		addProductStmt = conn.prepareStatement(addProductSql, PreparedStatement.RETURN_GENERATED_KEYS);
		// ? 6개
		addProductStmt.setString(1, product.getCategoryName());
		addProductStmt.setString(2, product.getProductName());
		addProductStmt.setInt(3, product.getProductPrice());
		addProductStmt.setString(4, product.getProductStatus());
		addProductStmt.setInt(5, product.getProductStock());
		addProductStmt.setString(6, product.getProductInfo());
		// 쿼리 실행 및 배열에 row값 먼저 저장
		rowAndKey[0] = addProductStmt.executeUpdate();
		// 영향받은 행값	
		if(rowAndKey[0] == 1) { 
	        System.out.println(SONG + rowAndKey[0] + " <-- ProductDao 상품추가성공" + RESET);
	        // 키 값(productNo) 받아오기
			ResultSet generatedKeys = addProductStmt.getGeneratedKeys();
			int productNo = 0;
			if(generatedKeys.next()) {
				productNo = generatedKeys.getInt(1);
	            // 첫 번째 열의 자동 생성된 키 값 가져오기
	            System.out.println(SONG + "자동 생성된 키 값: " + productNo + RESET);
	        }
			rowAndKey[1] = productNo;
		} else {
	    	System.out.println(SONG + rowAndKey[0] + " <-- ProductDao 상품추가실패" + RESET);
	    } 	
				
		return rowAndKey;
	}
	
	
	/* 상품 수정 : modifyProduct */
	public int modifyProduct(Product product) throws Exception {
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement modifyProductStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		// SQL 쿼리문
		String modifyProductSql = "UPDATE product SET category_name = ?, product_name = ?, product_price = ?, product_status = ?, product_stock = ?, product_info = ?, updatedate = NOW() WHERE product_no = ?";
		modifyProductStmt = conn.prepareStatement(modifyProductSql);
		// ? 7개
		modifyProductStmt.setString(1, product.getCategoryName());
		modifyProductStmt.setString(2, product.getProductName());
		modifyProductStmt.setInt(3, product.getProductPrice());
		modifyProductStmt.setString(4, product.getProductStatus());
		modifyProductStmt.setInt(5, product.getProductStock());
		modifyProductStmt.setString(6, product.getProductInfo());
		modifyProductStmt.setInt(7, product.getProductNo());
		// 쿼리 실행 및 결과 저장
		int modifyProductRow = modifyProductStmt.executeUpdate();
		// 영향받은 행값	
		if(modifyProductRow == 1) {
			System.out.println(SONG + modifyProductRow + " <-- ProductDao 상품수정성공" + RESET);
		} else {
			System.out.println(SONG + modifyProductRow + " <-- ProductDao 상품수정실패" + RESET);
		}
		return modifyProductRow;
	}
	
	
	/* 상품 삭제 : removeProduct */
	public int removeProduct(int productNo) throws Exception {
		DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement removeProductStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		// SQL 쿼리문
		String removeProductSql = "DELETE FROM product WHERE product_no = ?";
		removeProductStmt = conn.prepareStatement(removeProductSql);
		// 1개
	    removeProductStmt.setInt(1, productNo);
	    // 쿼리 실행 및 결과 저장
		int removeProductRow = removeProductStmt.executeUpdate();
		// 영향받은 행값	
		if(removeProductRow == 1){
			System.out.println(SONG + removeProductRow + " <-- ProductDao 상품삭제성공" + RESET);
		} else {
			System.out.println(SONG + removeProductRow + " <-- ProductDao 상품삭제실패" + RESET);
		}
		return removeProductRow;
	}
}
