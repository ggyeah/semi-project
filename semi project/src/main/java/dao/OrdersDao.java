package dao;
import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class OrdersDao {
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
    final String RESET = "\u001B[0m"; 
    final String LIM = "\u001B[41m";
    final String KIM = "\u001B[42m";
    final String SONG = "\u001B[43m";
    final String YANG = "\u001B[44m";
	
/* 관리자2 */
// 모든 회원 주문 조회
	public ArrayList<Orders> selectECOrders(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Orders> ecList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String selectECOrdersSql = "select order_no, product_no, id, delivery_status, order_cnt, order_price, createdate, updatedate from orders ORDER BY order_no DESC limit ?, ?";
		PreparedStatement selectECOrdersStmt = conn.prepareStatement(selectECOrdersSql);
		selectECOrdersStmt.setInt(1, beginRow);
		selectECOrdersStmt.setInt(2, rowPerPage);
		System.out.println(KIM+"OrdersDao - selectECOrdersSql: " + selectECOrdersSql+RESET);
		ResultSet ecRs = selectECOrdersStmt.executeQuery();
		//vo타입으로 변경
		while(ecRs.next()){
			Orders o = new Orders();
			o.setOrderNo(ecRs.getInt("order_no"));
			o.setProductNo(ecRs.getInt("product_no"));
			o.setId(ecRs.getString("id"));
			o.setDeliveryStatus(ecRs.getString("delivery_status"));
			o.setOrderCnt(ecRs.getInt("order_cnt"));
			o.setOrderPrice(ecRs.getInt("order_price"));
			o.setCreatedate(ecRs.getString("createdate"));
			o.setUpdatedate(ecRs.getString("updatedate"));
			ecList.add(o);
		}
		return ecList;
	}
	// 고객 주문 조회 페이징	
		public int selectECOrdersCnt() throws Exception {
			int ecCntrow = 0;
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String empCntSql = "SELECT count(*) count FROM orders";
			PreparedStatement empCntStmt = conn.prepareStatement(empCntSql);
			System.out.println(KIM+"OrdersDao - selectECOrdersCnt: " + empCntSql+RESET);
			ResultSet empCntRs = empCntStmt.executeQuery();
			// count 값을 vo타입으로 변환
			if(empCntRs.next()) {
				ecCntrow = empCntRs.getInt("count");
			}
			return ecCntrow;
		}
	
	// 고객의 배송 상태 변경
		public int modifyECOrders(Orders orders) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String modifyECOrdersSql = "UPDATE orders SET delivery_status=?, updatedate=NOW() WHERE order_no=?";
			PreparedStatement modifyECOrdersStmt = conn.prepareStatement(modifyECOrdersSql);
			modifyECOrdersStmt.setString(1, orders.getDeliveryStatus());
			modifyECOrdersStmt.setInt(2, orders.getOrderNo());
			System.out.println(KIM+"OrdersDao - modifyECOrdersSql: " + modifyECOrdersSql+RESET);
			int row = modifyECOrdersStmt.executeUpdate();
			return row;
		}
		
//일반 고객
	//고객 모든 주문 조회
	public ArrayList<Orders> selectCustomerOrders(int beginRow, int rowPerPage, String loginId) throws Exception {
		ArrayList<Orders> customerOrdersList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		if (loginId != null) {
		String selectCustomerOrdersSql = "select order_no, product_no, id, delivery_status, order_cnt, order_price, createdate, updatedate from orders WHERE id = ? ORDER BY order_no DESC limit ? , ?";
		PreparedStatement selectCustomerOrdersStmt = conn.prepareStatement(selectCustomerOrdersSql);
		selectCustomerOrdersStmt.setString(1, loginId);
		selectCustomerOrdersStmt.setInt(2, beginRow);
		selectCustomerOrdersStmt.setInt(3, rowPerPage);
		System.out.println(KIM+"OrdersDao - selectCustomerOrdersSql: " + selectCustomerOrdersSql+RESET);
		ResultSet myRs = selectCustomerOrdersStmt.executeQuery();
		//vo타입으로 변경
			while(myRs.next()){
				Orders o = new Orders();
				o.setOrderNo(myRs.getInt("order_no"));
				o.setProductNo(myRs.getInt("product_no"));
				o.setId(myRs.getString("id"));
				o.setDeliveryStatus(myRs.getString("delivery_status"));
				o.setOrderCnt(myRs.getInt("order_cnt"));
				o.setOrderPrice(myRs.getInt("order_price"));
				o.setCreatedate(myRs.getString("createdate"));
				o.setUpdatedate(myRs.getString("updatedate"));
				customerOrdersList.add(o);
			}
		} 
		return customerOrdersList;
	}
	// 고객 주문 상세 정보 조회
	public Orders selectCustomerOrdersOne(String loginId) throws Exception{
		Orders orders = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		if (loginId != null) {
		String customerOrdersOneSql = "select order_no, product_no, id, delivery_status, order_cnt, order_price, createdate, updatedate from orders WHERE id = ? ORDER BY order_no";
		PreparedStatement customerOrdersOneStmt = conn.prepareStatement(customerOrdersOneSql);
		customerOrdersOneStmt.setString(1, loginId);
		System.out.println(KIM+"OrdersDao - customerOrdersOneSql: " + customerOrdersOneSql+RESET);
		ResultSet customerOrdersRs = customerOrdersOneStmt.executeQuery();
			if(customerOrdersRs.next()){
				orders = new Orders();
				orders.setOrderNo(customerOrdersRs.getInt("order_no"));
				orders.setProductNo(customerOrdersRs.getInt("product_no"));
				orders.setId(customerOrdersRs.getString("id"));
				orders.setDeliveryStatus(customerOrdersRs.getString("delivery_status"));
				orders.setOrderCnt(customerOrdersRs.getInt("order_cnt"));
				orders.setOrderPrice(customerOrdersRs.getInt("order_price"));
				orders.setCreatedate(customerOrdersRs.getString("createdate"));
				orders.setUpdatedate(customerOrdersRs.getString("updatedate"));
			}
		}
		return orders;
	}
    // 주문 상품 이름 조회
	public String selectProductName(int productNo) throws Exception{
		String productName = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String productNameSql = "SELECT p.product_name productName FROM product p INNER JOIN cart c ON p.product_no = c.product_no WHERE c.product_no = ?";
		PreparedStatement productNameStmt = conn.prepareStatement(productNameSql);
		productNameStmt.setInt(1, productNo);
		System.out.println("OrdersDao - productNameSql: " + productNameSql);
		ResultSet productNameRs = productNameStmt.executeQuery();
		if(productNameRs.next()) {
			productName = productNameRs.getString("productName");
		}
		return productName;
	}
		
	// 고객 주문 리스트 페이징	
	public int selectCustomerOrdersCnt(String loginId) throws Exception {
		int customerOrdersCntRow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String customerOrdersCntSql = "SELECT count(order_no) count FROM orders WHERE id = ?";
		PreparedStatement customerOrdersCntStmt = conn.prepareStatement(customerOrdersCntSql);
		customerOrdersCntStmt.setString(1, loginId);
		System.out.println(KIM+"OrdersDao - customerOrdersCntSql: " + customerOrdersCntSql+RESET);
		ResultSet customerOrdersCntRs = customerOrdersCntStmt.executeQuery();
		// count 값을 vo타입으로 변환
		if(customerOrdersCntRs.next()) {
			customerOrdersCntRow = customerOrdersCntRs.getInt("count");
		}
		return customerOrdersCntRow;
	}
	// 고객 주문 추가
	public int addCustomerOrders(Orders orders) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//주문 추가 시 결제완료(기본값)으로 변경됨
		String addCustomerOrdersSql = "INSERT INTO orders(product_no, id, delivery_status, order_cnt, order_price, createdate, updatedate) values(?, ?, '결제완료', ?, ?, NOW(), NOW())";
		PreparedStatement addCustomerOrdersStmt = conn.prepareStatement(addCustomerOrdersSql);
		addCustomerOrdersStmt.setInt(1, orders.getProductNo());
		addCustomerOrdersStmt.setString(2, orders.getId());
		addCustomerOrdersStmt.setInt(3, orders.getOrderCnt());
		addCustomerOrdersStmt.setInt(4, orders.getOrderPrice());
		System.out.println("OrdersDao - addCustomerOrdersSql: " + addCustomerOrdersSql);
		row = addCustomerOrdersStmt.executeUpdate();
		// 주문 추가 시 address_last_date = NOW()
		if (row == 1) {
		    String updateAddressLastDateSql = "UPDATE address SET address_last_date = NOW() WHERE address_no IN (SELECT address_no FROM orders WHERE product_no = ? AND id = ? AND order_no = ?)";
		    PreparedStatement updateAddressLastDateStmt = conn.prepareStatement(updateAddressLastDateSql);
		    updateAddressLastDateStmt.setInt(1, orders.getProductNo());
		    updateAddressLastDateStmt.setString(2, orders.getId());
		    updateAddressLastDateStmt.setInt(3, orders.getOrderNo());
		    updateAddressLastDateStmt.executeUpdate();
		}
		// 주문 추가 시 cart에 있던 목록 삭제
		if(row == 1) {
			String removeCartSql = "DELETE FROM cart WHERE product_no = ?";
			PreparedStatement removeCartStmt = conn.prepareStatement(removeCartSql);
			removeCartStmt.setInt(1, orders.getProductNo());
			removeCartStmt.executeUpdate();
		}
		
		return row;
	}
	
	// 고객 주문 수정 ("구매확정"으로 변경) (구매확정시 포인트 1000씩 증가)
	public int modifyCustomerOrders(String loginId, int orderNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String modifyCustomerOrdersSql = "UPDATE orders SET delivery_status='구매확정', updatedate=NOW() WHERE id=? AND order_no=?";
		PreparedStatement modifyCustomerOrdersStmt = conn.prepareStatement(modifyCustomerOrdersSql);
		modifyCustomerOrdersStmt.setString(1, loginId);
		modifyCustomerOrdersStmt.setInt(2, orderNo);
		System.out.println(KIM+"OrdersDao - modifyCustomerOrdersSql: " + modifyCustomerOrdersSql+RESET);
		int row = modifyCustomerOrdersStmt.executeUpdate();
		return row;
	}
	// 고객 포인트 이력 추가 (포인트 이력 테이블에 새로운 이력을 추가)
	public int addCustomerPoint(int orderNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String addCustomerPointSql = "INSERT INTO point_history(order_no, point_pm, point, createdate) values(?, '+', 1000, NOW())";
		PreparedStatement addCustomerPointStmt = conn.prepareStatement(addCustomerPointSql);
		addCustomerPointStmt.setInt(1, orderNo);
		System.out.println("OrdersDao - addCustomerPointSql: " + addCustomerPointSql);
		int row = addCustomerPointStmt.executeUpdate();
		return row;
		
	}
	
	// 고객 주문 삭제 ("주문취소"로 변경)
	public int removeCustomerOrders(int orderNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String removeCustomerOrdersSql = "UPDATE orders SET delivery_status='주문취소', updatedate=NOW() WHERE order_no=?";
		PreparedStatement removeCustomerOrdersStmt = conn.prepareStatement(removeCustomerOrdersSql);
		removeCustomerOrdersStmt.setInt(1, orderNo);
		System.out.println(KIM+"OrdersDao - removeCustomerOrdersSql: " + removeCustomerOrdersSql+RESET);
		int row = removeCustomerOrdersStmt.executeUpdate();
		return row;
	}
	
}
