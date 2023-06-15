package dao;
import util.*;
import java.sql.*;
import java.util.*;
import vo.*;

public class AddressDao {
	// 1) 배송지 조회
	public ArrayList<Address> selectAddress(String loginId) throws Exception {
		ArrayList<Address> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String selectAddressSql = "select address_no, id, address_name, address, address_last_date, default_address, createdate, updatedate from address WHERE id = ? ORDER BY address_last_date DESC";
		PreparedStatement selectAddressStmt = conn.prepareStatement(selectAddressSql);
		selectAddressStmt.setString(1, loginId);
		System.out.println("AddressDao - selectAddressSql: " + selectAddressSql);
		ResultSet rs = selectAddressStmt.executeQuery();	
		//vo타입으로 변경
		while(rs.next()){
			Address a = new Address();
			a.setAddressNo(rs.getInt("address_no"));
			a.setId(rs.getString("id"));
			a.setAddressName(rs.getString("address_name"));
			a.setAddress(rs.getString("address"));
			a.setAddressLastDate(rs.getString("address_last_date"));
			a.setDefaultAddress(rs.getString("default_address"));
			a.setCreatedate(rs.getString("createdate"));
			a.setUpdatedate(rs.getString("updatedate"));
			list.add(a);
		}
		return list;
	}
	// 2) 기본 배송지 조회
	public ArrayList<Address> selectDefaultAddress(String loginId) throws Exception {
		ArrayList<Address> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String selectDefaultAddressSql = "select address_no, id, address_name, address, address_last_date, default_address, createdate, updatedate from address WHERE id = ? and default_address='Y' ORDER BY updatedate DESC limit 1";
		PreparedStatement selectDefaultAddressStmt = conn.prepareStatement(selectDefaultAddressSql);
		selectDefaultAddressStmt.setString(1, loginId);
		System.out.println("AddressDao - selectDefaultAddressSql: " + selectDefaultAddressSql);
		ResultSet rs = selectDefaultAddressStmt.executeQuery();	
		//vo타입으로 변경
		while(rs.next()){
			Address a = new Address();
			a.setAddressNo(rs.getInt("address_no"));
			a.setId(rs.getString("id"));
			a.setAddressName(rs.getString("address_name"));
			a.setAddress(rs.getString("address"));
			a.setAddressLastDate(rs.getString("address_last_date"));
			a.setDefaultAddress(rs.getString("default_address"));
			a.setCreatedate(rs.getString("createdate"));
			a.setUpdatedate(rs.getString("updatedate"));
			list.add(a);
		}
		return list;
	}
	// 3) 배송지 상세 조회
	public Address selectAddressOne(String id, int addressNo) throws Exception {
		Address address = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String addressOneSql = "select address_no, id, address_name, address, address_last_date, default_address, createdate, updatedate from address where id = ? and address_no=?";
		PreparedStatement addressOneStmt = conn.prepareStatement(addressOneSql);
		addressOneStmt.setString(1, id);
		addressOneStmt.setInt(2, addressNo);
		ResultSet selectAddressOneRs = addressOneStmt.executeQuery();
		if(selectAddressOneRs.next()){
			address = new Address();
			address.setAddressNo(selectAddressOneRs.getInt("address_no"));
			address.setId(selectAddressOneRs.getString("id"));
			address.setAddressName(selectAddressOneRs.getString("address_name"));
			address.setAddress(selectAddressOneRs.getString("address"));
			address.setAddressLastDate(selectAddressOneRs.getString("address_last_date"));
			address.setDefaultAddress(selectAddressOneRs.getString("default_address"));
			address.setCreatedate(selectAddressOneRs.getString("createdate"));
			address.setUpdatedate(selectAddressOneRs.getString("updatedate"));
		}
		return address;
	}
	// 4) 배송지 추가
		public int addAddress(Address address) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			// 기존의 기본 배송지를 'N'으로 업데이트
	        if (address.getDefaultAddress().equals("Y")) {
	            String modifyDefaultAddressSql = "UPDATE address SET default_address='N', updatedate=NOW() WHERE id=? AND default_address='Y'";
	            PreparedStatement modifyDefaultAddressStmt = conn.prepareStatement(modifyDefaultAddressSql);
	            modifyDefaultAddressStmt.setString(1, address.getId());
	            modifyDefaultAddressStmt.executeUpdate();
	        }

	        // 주소 추가
	        String addAddressSql = "INSERT INTO address(id, address_name, address, address_last_date, default_address, createdate, updatedate) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
	        PreparedStatement addAddressStmt = conn.prepareStatement(addAddressSql);
	        addAddressStmt.setString(1, address.getId());
	        addAddressStmt.setString(2, address.getAddressName());
	        addAddressStmt.setString(3, address.getAddress());
	        addAddressStmt.setString(4, address.getAddressLastDate());
	        addAddressStmt.setString(5, address.getDefaultAddress() != null ? address.getDefaultAddress() : "N");
	        int row = addAddressStmt.executeUpdate();

	        return row;
		}
	
	// 5) 배송지 수정
		public int modifyAddress(Address address) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String modifyAddressSql = "UPDATE address SET address_name=?, address=?, default_address=?, updatedate=NOW() WHERE address_no=?";
			PreparedStatement modifyAddressStmt = conn.prepareStatement(modifyAddressSql);
			modifyAddressStmt.setString(1, address.getAddressName());
			modifyAddressStmt.setString(2, address.getAddress());
			modifyAddressStmt.setString(3, address.getDefaultAddress());
			modifyAddressStmt.setInt(4, address.getAddressNo());
			int row = modifyAddressStmt.executeUpdate();
			System.out.println("AddressDao - modifyAddress: " + modifyAddressSql);
			return row;
		}
	// 5-1) 기본 배송지 수정
		public int modifyDefaultAddress(String id) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
            String deleteDefaultAddressSql = "UPDATE address SET default_address='N' WHERE id = ? AND default_address='Y'";
            PreparedStatement deleteDefaultAddressStmt = conn.prepareStatement(deleteDefaultAddressSql);
            deleteDefaultAddressStmt.setString(1, id);
            int row = deleteDefaultAddressStmt.executeUpdate();
            System.out.println("AddressDao - modifyAddress - deleteDefaultAddressSql: " + deleteDefaultAddressSql);
            return row;
		}
		
	// 6) 배송지 삭제
		public int removeAddress(int addressNo) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String removeAddressSql = "DELETE FROM address WHERE address_no = ?";
			PreparedStatement removeAddressStmt = conn.prepareStatement(removeAddressSql);
			removeAddressStmt.setInt(1, addressNo);
			int row = removeAddressStmt.executeUpdate();
			System.out.println("AddressDao - removeAddressSql: " + removeAddressSql);
			return row;
		}
		
}
