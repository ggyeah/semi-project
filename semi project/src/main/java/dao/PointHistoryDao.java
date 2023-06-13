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
	public ArrayList<PointHistory> pointHistoryList(int beginRow, int rowPerPage, String id) throws Exception {
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
	 
	//2) 총합포인트
	/*SELECT (positive_points - negative_points) AS result
	FROM (
	  SELECT
	    (SELECT SUM(point)
	    FROM (SELECT o.id, o.order_no, p.point_pm, p.point
	          FROM orders o
	          JOIN point_history p ON o.order_no = p.order_no
	          WHERE o.id = ?) s1
	    WHERE point_pm = '+') AS positive_points,
	    
	    (SELECT SUM(point)
	    FROM (SELECT o.id, o.order_no, p.point_pm, p.point
	          FROM orders o
	          JOIN point_history p ON o.order_no = p.order_no
	          WHERE o.id = ?) s2
	    WHERE point_pm = '-') AS negative_points
	) AS subquery;*/

		public int sumPoint(String id) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
		    PreparedStatement sumPointStmt = conn.prepareStatement("SELECT (positive_points - negative_points) AS result\r\n"
		    		+ "	FROM (\r\n"
		    		+ "	  SELECT\r\n"
		    		+ "	    (SELECT SUM(point)\r\n"
		    		+ "	    FROM (SELECT o.id, o.order_no, p.point_pm, p.point\r\n"
		    		+ "	          FROM orders o\r\n"
		    		+ "	          JOIN point_history p ON o.order_no = p.order_no\r\n"
		    		+ "	          WHERE o.id = ?) s1\r\n"
		    		+ "	    WHERE point_pm = '+') AS positive_points,\r\n"
		    		+ "	    \r\n"
		    		+ "	    (SELECT SUM(point)\r\n"
		    		+ "	    FROM (SELECT o.id, o.order_no, p.point_pm, p.point\r\n"
		    		+ "	          FROM orders o\r\n"
		    		+ "	          JOIN point_history p ON o.order_no = p.order_no\r\n"
		    		+ "	          WHERE o.id = ?) s2\r\n"
		    		+ "	    WHERE point_pm = '-') AS negative_points\r\n"
		    		+ "	) AS subquery;");
		    sumPointStmt.setString(1, id);
		    sumPointStmt.setString(2, id);
		    
		    ResultSet sumPointRs = sumPointStmt.executeQuery();
		    
		    int pointSum = 0;
		    
		    if (sumPointRs.next()) {
		        pointSum = sumPointRs.getInt("result");
		    }
		    
		    return pointSum;
		}
		
		}

