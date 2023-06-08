package dao;
import vo.*;
import java.sql.*;
import java.util.*;
import javax.servlet.http.*;
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
	
	// 장바구니 추가 (장바구니에 같은 상품 번호가 없을 경우)
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
	
	//장바구니 수량 수정
	public int modifyCart(Cart cart) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String modifyCartSql = "UPDATE cart SET cart_cnt=?, updatedate=NOW() WHERE cart_no=?";
		PreparedStatement modifyCartStmt = conn.prepareStatement(modifyCartSql);
		modifyCartStmt.setInt(1, cart.getCartCnt());
		modifyCartStmt.setInt(2, cart.getCartNo());
		int row = modifyCartStmt.executeUpdate();
		System.out.println(KIM+"CartDao - modifyCartSql: " + modifyCartSql+RESET);
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
	
/*-------------------- 비로그인 사용자의 장바구니 조회/추가/수정/삭제 --------------------*/
	
	//비로그인자 장바구니 조회
	public ArrayList<Cart> selectSessionCart(HttpServletRequest request) throws Exception{ //HttpServletRequest를 통해 현재 세션을 가져옴
	    HttpSession session = request.getSession();
	    // 세션에서 받은 장바구니 목록 cartList를 호출
	    ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cartList");//가변적으로 공간이 변하는 ArrayList를 이용해 세션 장바구니 목록을 저장
	   
	    if (cartList == null) { //cartList가 null인 경우 (장바구니가 생성되지 않을 시)
	        cartList = new ArrayList<>(); //새로운 ArrayList를 생성하여 빈 장바구니 목록을 만듦 -> cartList에서 "장바구니가 없습니다" 메세지 출력
	    }
	    return cartList; // 장바구니 목록을 반환
	}
	//비로그인자 장바구니 중복 상품 개수 조회
	public int cartCnt(HttpServletRequest request, int productNo) {
	    int row = 0;
		HttpSession session = request.getSession();
	    ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cartList");
	    
	    if (cartList != null) {
	        for (Cart cart : cartList) {
	            if (cart.getProductNo() == productNo) {
	                row++;
	                return row;
	            }
	        }
	    }
	    
	    return row;
	}
	
	//비로그인자 장바구니 추가
	public ArrayList<Cart> addSessionCart(HttpServletRequest request, ArrayList<Cart> cartList, Cart cart) throws Exception{
	    HttpSession session = request.getSession();
	    cartList = (ArrayList<Cart>) session.getAttribute("cartList"); //세션에서 장바구니 목록인 cartList를 가져옴
	    
	    if (cartList == null) { //cartList가 null인 경우 (장바구니가 생성되지 않을 시)
	        cartList = new ArrayList<>(); //새로운 ArrayList를 생성하여 빈 장바구니 목록을 만듦 -> cartList에서 "장바구니가 없습니다" 메세지 출력
	    }
	    cartList.add(cart); //장바구니 목록에 상품(cart)을 추가
	    session.setAttribute("cartList", cartList); //업데이트된 장바구니 목록을 세션에 다시 저장
	    
	    return cartList; //업데이트된 장바구니 목록을 반환
	}
	
	//비로그인자 장바구니 수정
	public ArrayList<Cart> modifySessionCart(HttpServletRequest request, ArrayList<Cart> cartList, Cart updatedCart) throws Exception {
	    HttpSession session = request.getSession();
	    cartList = (ArrayList<Cart>) session.getAttribute("cartList"); // 세션에서 장바구니 목록인 cartList를 가져옴

	    if (cartList != null) { // cartList가 null이 아닌 경우 (장바구니가 생성되어 있는 경우)
	        for (Cart cart : cartList) {
	            if (cart.getCartNo() == updatedCart.getCartNo()) { // 수정할 상품의 카트 번호를 확인
	                // 해당 상품을 업데이트된 정보로 수정
	                cart.setProductNo(updatedCart.getProductNo());
	                cart.setId(updatedCart.getId());
	                cart.setCartCnt(updatedCart.getCartCnt());
	                break;
	            }
	        }
	        session.setAttribute("cartList", cartList); // 업데이트된 장바구니 목록을 세션에 다시 저장
	    }
	    return cartList; // 업데이트된 장바구니 목록을 반환
	}
	
	//비로그인자 장바구니 삭제
	public void removeSessionCart(HttpServletRequest request, int cartNo) {
	    HttpSession session = request.getSession();
	    //세션에서 cartList라는 이름으로 저장된 장바구니 목록을 가져옴
	    ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cartList");
	    
	    if (cartList != null) {
	        for (Iterator<Cart> iterator = cartList.iterator(); iterator.hasNext(); ) { //장바구니 목록을 순회하기 위해 반복자 Iterator 선언
	            Cart cart = iterator.next();
	            if (cart.getCartNo() == cartNo) { //cartNo와, 세션에 저장된 Cart 객체의 cartNo가 일치할 때
	                iterator.remove(); //cartNo에 해당하는 상품을 삭제
	                break; //iterator의 반복을 종료
	            }
	        }
	        //장바구니 목록을 세션에 바로 업데이트
	        session.setAttribute("cartList", cartList);
	    }
	}
}
