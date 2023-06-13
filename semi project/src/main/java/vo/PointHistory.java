package vo;

public class PointHistory {
	public String id;  
	public int cstmPoint; 
	private int pointNo;
	private int orderNo;
	private String pointPm;
	private String point;
	private String createdate;
	private int productNo;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCstmPoint() {
		return cstmPoint;
	}
	public void setCstmPoint(int cstmPoint) {
		this.cstmPoint = cstmPoint;
	}
	public int getPointNo() {
		return pointNo;
	}
	public void setPointNo(int pointNo) {
		this.pointNo = pointNo;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getPointPm() {
		return pointPm;
	}
	public void setPointPm(String pointPm) {
		this.pointPm = pointPm;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
}
