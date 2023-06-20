package dao;
import vo.*;
import java.sql.*;
import java.util.*;
import util.DBUtil;

public class CartDao {
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
    final String RESET = "\u001B[0m"; 
    final String LIM = "\u001B[41m";
    final String KIM = "\u001B[42m";
    final String SONG = "\u001B[43m";
    final String YANG = "\u001B[44m";
    
/*-------------------- 로그인 사용자의 장바구니 조회/추가/수정/삭제 --------------------*/	
	//장바구니 조회
	public ArrayList<Cart> selectCart(String loginId) throws Exception {
		ArrayList<Cart> cartList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String selectCartSql = "select cart_no, product_no, id, createdate, cart_cnt, updatedate from cart WHERE id = ? ORDER BY cart_no";
		PreparedStatement selectCartStmt = conn.prepareStatement(selectCartSql);
		selectCartStmt.setString(1, loginId);
		System.out.println(KIM+"CartDao - selectCartSql: " + selectCartSql+RESET);
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
	// 상세 조회
		public Cart selectCartOne(String loginId) throws Exception{
			Cart cart = null;
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			if (loginId != null) {
			String cartOneSql = "select cart_no, product_no, id, createdate, cart_cnt, updatedate from cart WHERE id = ? ORDER BY cart_no";
			PreparedStatement cartOneStmt = conn.prepareStatement(cartOneSql);
			cartOneStmt.setString(1, loginId);
			System.out.println(KIM+"OrdersDao - cartOneSql: " + cartOneSql+RESET);
			ResultSet cartOneRs = cartOneStmt.executeQuery();
				if(cartOneRs.next()){
					cart = new Cart();
					cart.setCartNo(cartOneRs.getInt("cart_no"));
					cart.setProductNo(cartOneRs.getInt("product_no"));
					cart.setCreatedate(cartOneRs.getString("createdate"));
					cart.setCartCnt(cartOneRs.getInt("cart_cnt"));
					cart.setUpdatedate(cartOneRs.getString("updatedate"));
				}
			}
			return cart;
		}
		
	// 이미 장바구니에 담긴 상품의 개수
		public int checkCart(Cart cart, String loginId) throws Exception {
			int ckRow = 0;
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			if(cart != null) {
				String checkCartSql = "SELECT COUNT(product_no) count FROM cart WHERE product_no = ? AND id=?";
				PreparedStatement checkCartStmt = conn.prepareStatement(checkCartSql);
				checkCartStmt.setInt(1, cart.getProductNo());
				checkCartStmt.setString(2, loginId);
				ResultSet checkCartRs = checkCartStmt.executeQuery();
				if(checkCartRs.next()) {
					ckRow = checkCartRs.getInt("count");
					return ckRow;
				}
			}
			return ckRow;
		}
	
	// 장바구니 추가
		public int addCart(Cart cart) throws Exception{
			int row =0;
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String addCartSql = "INSERT INTO cart(cart_no, product_no, id, createdate, cart_cnt, updatedate) values(?, ?, ?, NOW(), 1, NOW())";
			PreparedStatement addCartStmt = conn.prepareStatement(addCartSql);
			addCartStmt.setInt(1, cart.getCartNo());
			addCartStmt.setInt(2, cart.getProductNo());
			addCartStmt.setString(3, cart.getId());
			row = addCartStmt.executeUpdate();
			System.out.println(KIM+"CartDao - addCartSql: " + addCartSql+RESET);
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
			System.out.println(KIM+"cartDao - removeCartSql: " + removeCartSql+RESET);
			return row;
		}
}
