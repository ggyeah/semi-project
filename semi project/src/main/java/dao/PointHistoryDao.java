package dao;

import vo.*;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;

public class PointHistoryDao {
	/*
	SELECT o.order_no, o.product_no, o.id, ph.point_pm, ph.point, ph.createdate
	FROM orders o
	JOIN point_history ph ON o.order_no = ph.order_no
	WHERE o.id = ?
	ORDER BY ph.createdate DESC
	LIMIT ?, ?;
	*/

	//1) 포인트리스트
	public ArrayList<PointHistory> pointHIstoryList(int beginRow, int rowPerPage, String id) throws Exception {
		ArrayList<PointHistory> pList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement pointListStmt = conn.prepareStatement("SELECT o.order_no, o.product_no, o.id, ph.point_pm, ph.point, ph.createdate FROM orders o JOIN point_history ph ON o.order_no = ph.order_no WHERE o.id = ? ORDER BY ph.createdate DESC LIMIT ?, ?");
			pointListStmt.setString(1, id);
	        pointListStmt.setInt(2, beginRow);
	        pointListStmt.setInt(3, rowPerPage);
	        
	        ResultSet pointListRs = pointListStmt.executeQuery();
	        
        while(pointListRs.next()) {
        	PointHistory pointHistory = new PointHistory();
        	pointHistory.setOrderNo(pointListRs.getInt("order_no"));
        	pointHistory.setProductNo(pointListRs.getInt("product_no"));
        	pointHistory.setId(pointListRs.getString("id"));
        	pointHistory.setPointPm(pointListRs.getString("point_pm"));
        	pointHistory.setPoint(pointListRs.getString("point"));
        	pointHistory.setCreatedate(pointListRs.getString("createdate"));
        	pList.add(pointHistory);
    	}
        return pList;
	 }
}
	 
	//2) 총합포인트
