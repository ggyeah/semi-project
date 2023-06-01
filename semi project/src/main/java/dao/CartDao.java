package dao;
import vo.*;
import java.sql.*;
import java.util.*;
import util.DBUtil;

public class CartDao {
	//장바구니 조회
	public ArrayList<Cart> selectCart(String id) throws Exception {
		ArrayList<Cart> cartList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String selectCartSql = "select cart_no, product_no, id, createdate, cart_cnt, updatedate from cart WHERE id = ? ORDER BY cart_no";
		PreparedStatement selectCartStmt = conn.prepareStatement(selectCartSql);
		selectCartStmt.setString(1, id);
		System.out.println("CartDao - selsectCartSql: " + selectCartSql);
		ResultSet rs = selectCartStmt.executeQuery();
		//vo타입으로 변경
		while(rs.next()){
			Cart c = new Cart();
			c.setCartNo(rs.getInt("cart_no"));
			c.setProductNo(rs.getInt("product_no"));
			c.setCreatedate(rs.getString("createdate"));
			c.setCartCnt(rs.getInt("cart_cnt"));
			c.setUpdatedate(rs.getString("updatedate"));
			cartList.add(c);
		}
		return cartList;
	}
	//장바구니 추가(상품 리스트에서 버튼 클릭 시)
	public int addCart(Cart cart) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String addCartSql = "INSERT INTO cart(cart_no, product_no, id, createdate, cart_cnt, updatedate) values(?, ?, ?, NOW(), ?, NOW())";
		PreparedStatement addCartStmt = conn.prepareStatement(addCartSql);
		addCartStmt.setInt(1, cart.getCartNo());
		addCartStmt.setInt(2, cart.getProductNo());
		addCartStmt.setString(3, cart.getId());
		addCartStmt.setInt(4, cart.getCartCnt());
		int row = addCartStmt.executeUpdate();
		System.out.println("CartDao - addCartSql: " + addCartSql);
		return row;
	}
	
	//장바구니 수량 수정
	public int modifyCart(Cart cart) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String modifyCartSql = "UPDATE cart SET cart_cnt=?, updatedate=NOW() WHERE cart_no=?";
		PreparedStatement modifyCartStmt = conn.prepareStatement(modifyCartSql);
		modifyCartStmt.setInt(1, cart.getCartCnt());
		modifyCartStmt.setInt(2, cart.getCartNo());
		int row = modifyCartStmt.executeUpdate();
		System.out.println("CartDao - modifyCartSql: " + modifyCartSql);
		return row;
	}
	
	//장바구니 삭제
	public int removeCart(int cartNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String removeCartSql = "DELETE FROM cart WHERE cart_no = ?";
		PreparedStatement removeCartStmt = conn.prepareStatement(removeCartSql);
		removeCartStmt.setInt(1, cartNo);
		int row = removeCartStmt.executeUpdate();
		System.out.println("cartDao - removeCartSql: " + removeCartSql);
		return row;
	}
	
}
