package dao;

import vo.*;
import java.sql.*;
import java.util.*;
import util.DBUtil;

public class CategoryDao {
	// ANSI CODE	
	final String RESET = "\u001B[0m"; 
	final String LIM = "\u001B[41m";
	final String KIM = "\u001B[42m";
	final String SONG = "\u001B[43m";
	final String YANG = "\u001B[44m";

	/* 카테고리 리스트 : categoryList */
	public ArrayList<Category> categoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();								// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();					// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement categoryListStmt = null;					// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet categoryListRs = null;							// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String categoryListSql = "SELECT category_name categoryName, createdate, updatedate FROM category";
		categoryListStmt = conn.prepareStatement(categoryListSql);
		// 쿼리 실행 및 결과 저장
		categoryListRs = categoryListStmt.executeQuery();
		// ResultSet에서 데이터를 순차적으로 읽어와 Category 객체에 저장하고, categoryList에 추가
		while(categoryListRs.next()) {
			// 카테고리 객체 생성
			Category category = new Category();
			// ResultSet에서 카테고리 정보 추출 + 카테고리 객체에 저장
			category.setCategoryName(categoryListRs.getString("categoryName"));
			category.setCreatedate(categoryListRs.getString("createdate"));
			category.setUpdatedate(categoryListRs.getString("updatedate"));
			
			// 카테고리 객체를 리스트에 추가
			categoryList.add(category);
		}
	// 카테고리 리스트 반환
	return categoryList;
	}
	
	
	/* 전체 카테고리의 개수 조회 : categoryCnt */
	public int categoryCnt() throws Exception {
		int categoryRow = 0;	
		DBUtil dbUtil = new DBUtil();								// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();					// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement categoryCntStmt = null;					// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet categoryCntRs = null;								// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String categoryCntSql = "SELECT COUNT(*) FROM category";
		categoryCntStmt = conn.prepareStatement(categoryCntSql);
		// 쿼리 실행 및 결과 저장
		categoryCntRs = categoryCntStmt.executeQuery();	
		if(categoryCntRs.next()) { 									// 결과가 존재하는 경우
			categoryRow = categoryCntRs.getInt("COUNT(*)");			// 결과에서 카테고리 개수 추출
		}
		return categoryRow;
	}
	
	
	/* 카테고리 하나 조회 : categoryOne */
	public Category CategoryOne(String categoryName) throws Exception {	// categoryName를 매개변수로 받아 해당 카테고리의 정보를 가져오는 메서드
	    Category categoryOne = null;
	    DBUtil dbUtil = new DBUtil();							// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();				// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement categoryOneStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		ResultSet categoryOneRs = null;							// 쿼리 실행 결과를 담을 ResultSet 객체 생성
		// SQL 쿼리문
		String categoryOneSql = "SELECT category_name categoryName, createdate, updatedate FROM category WHERE category_name = ?";
		categoryOneStmt = conn.prepareStatement(categoryOneSql);
		// ? 1개
		categoryOneStmt.setString(1, categoryName);
		// 쿼리 실행 및 결과 저장
		categoryOneRs = categoryOneStmt.executeQuery();
		if(categoryOneRs.next()) { 								// 결과가 존재하는 경우
			categoryOne = new Category(); 						// categoryOne 객체 생성
			// ResultSet에서 카테고리 정보 추출 + 카테고리 상세 객체에 저장
			categoryOne.setCategoryName(categoryOneRs.getString("categoryName"));
			categoryOne.setCreatedate(categoryOneRs.getString("createdate"));
			categoryOne.setUpdatedate(categoryOneRs.getString("updatedate"));
	    }
		 return categoryOne;
	}
	
	
	/* 카테고리 추가 : addCategory */
	public int addCategory(Category category) throws Exception {
		int addCategoryRow = 0;
		DBUtil dbUtil = new DBUtil();								// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();					// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement addCategoryStmt = null;					// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		// SQL 쿼리문
		String addCategorySql = "INSERT INTO category(category_name, createdate, updatedate) VALUES(?,now(),now())";
		addCategoryStmt = conn.prepareStatement(addCategorySql);
		// ? 1개
		addCategoryStmt.setString(1, category.getCategoryName());
		// 쿼리 실행 및 결과 저장
		addCategoryRow = addCategoryStmt.executeUpdate();
		// 영향받은 행값	
		if(addCategoryRow == 1) {  
			System.out.println(SONG + addCategoryRow + " <-- CategoryDao 카테고리추가성공" + RESET);
	    } else {
	    	System.out.println(SONG + addCategoryRow + " <-- CategoryDao 카테고리추가실패" + RESET);
	    } 	
	return addCategoryRow;
	}
	
	
	/* 카테고리 수정 : modifyCategory */
	public int modifyCategory(String crntCategoryName, String newCategoryName) throws Exception {
	    // 디버깅
		System.out.println(SONG + crntCategoryName + " <-- CategoryDao crntCategoryName" + RESET);
		System.out.println(SONG + newCategoryName + " <-- CategoryDao newCategoryName" + RESET);
		
		DBUtil dbUtil = new DBUtil();								// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();					// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement modifyCategoryStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		// SQL 쿼리문
		String modifyCategorySql = "UPDATE category SET category_name = ?, updatedate = NOW() WHERE category_name = ?";
		modifyCategoryStmt = conn.prepareStatement(modifyCategorySql);
		// ? 2개
		modifyCategoryStmt.setString(1, newCategoryName);	// 새로 수정할 카테고리 값
		modifyCategoryStmt.setString(2, crntCategoryName);	// 기존 카테고리 값
		// 쿼리 실행 및 결과 저장
		int modifyCategoryRow = modifyCategoryStmt.executeUpdate();
		// 영향받은 행값	
		if(modifyCategoryRow == 1) {
			System.out.println(SONG + modifyCategoryRow + " <-- CategoryDao 카테고리수정성공" + RESET);
		} else {
			System.out.println(SONG + modifyCategoryRow + " <-- CategoryDao 카테고리수정실패" + RESET);
			}
		return modifyCategoryRow;
	}
	
	
	/* 카테고리 삭제 : removeCategory */
	public int removeCategory(String removeCategoryName) throws Exception {
		DBUtil dbUtil = new DBUtil();								// DBUtil 객체 생성
		Connection conn = dbUtil.getConnection();					// 데이터베이스 연결을 위한 Connection 객체 생성
		PreparedStatement removeCategoryStmt = null;				// 쿼리를 전송하기 위해 PreparedStatement 객체 생성
		// SQL 쿼리문
		String removeCategorySql = "DELETE FROM category WHERE category_name = ?";
		removeCategoryStmt = conn.prepareStatement(removeCategorySql);
		// 1개
	    removeCategoryStmt.setString(1, removeCategoryName);
	    // 쿼리 실행 및 결과 저장
		int removeCategoryRow = removeCategoryStmt.executeUpdate();
		// 영향받은 행값	
		if (removeCategoryRow == 1){
			System.out.println(SONG + removeCategoryRow + " <-- CategoryDao 카테고리삭제성공" + RESET);
		} else {
			System.out.println(SONG + removeCategoryRow + " <-- CategoryDao 카테고리삭제실패" + RESET);
		}
		return removeCategoryRow;
	}
}
