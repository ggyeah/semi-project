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
	// 1-1) 기본 배송지 조회
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
	// 2) 배송지 추가
		public int addAddress(Address address) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String addAddressSql = "INSERT INTO address(id, address_name, address, address_last_date, default_address, createdate, updatedate) values(?, ?, ?, NOW(), ?, NOW(), NOW())";
			PreparedStatement addAddressStmt = conn.prepareStatement(addAddressSql);
			addAddressStmt.setString(1, address.getId());
			addAddressStmt.setString(2, address.getAddressName());
			addAddressStmt.setString(3, address.getAddress());
			addAddressStmt.setString(4, address.getDefaultAddress());
			int row = addAddressStmt.executeUpdate();
			System.out.println("AddressDao - addAddressSql: " + addAddressSql);
			return row;
		}
	
	// 3) 배송지 수정
		public int modifyAddress(Address address) throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String modifyAddressSql = "UPDATE address SET address_name=?, address=?, address_last_date=?, default_address=?, updatedate=NOW() WHERE subject_no=?";
			PreparedStatement modifyAddressStmt = conn.prepareStatement(modifyAddressSql);
			modifyAddressStmt.setString(1, address.getAddressName());
			modifyAddressStmt.setString(2, address.getAddress());
			modifyAddressStmt.setString(3, address.getAddressLastDate());
			modifyAddressStmt.setString(4, address.getDefaultAddress());
			modifyAddressStmt.setString(5, address.getId());
			int row = modifyAddressStmt.executeUpdate();
			System.out.println("AddressDao - modifyAddressSql: " + modifyAddressSql);
			return row;
		}
	// 4) 배송지 삭제
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
