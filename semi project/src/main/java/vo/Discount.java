package vo;

public class Discount {
	private int discountNo;
	private int productNo;
	private String discountStart;
	private String discountEnd;
	private double discountRate;
	private String createdate;
	private String updatedate;
	private String CategoryName;
	private String ProductName;
	private String ProductStatus;
	private int ProductStock;
	private int DiscountedPrice;
	public int getDiscountNo() {
		return discountNo;
	}
	public void setDiscountNo(int discountNo) {
		this.discountNo = discountNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getDiscountStart() {
		return discountStart;
	}
	public void setDiscountStart(String discountStart) {
		this.discountStart = discountStart;
	}
	public String getDiscountEnd() {
		return discountEnd;
	}
	public void setDiscountEnd(String discountEnd) {
		this.discountEnd = discountEnd;
	}
	public double getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(double discountRate) {
		this.discountRate = discountRate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCategoryName() {
		return CategoryName;
	}
	public void setCategoryName(String categoryName) {
		CategoryName = categoryName;
	}
	public String getProductName() {
		return ProductName;
	}
	public void setProductName(String productName) {
		ProductName = productName;
	}
	public String getProductStatus() {
		return ProductStatus;
	}
	public void setProductStatus(String productStatus) {
		ProductStatus = productStatus;
	}
	public int getProductStock() {
		return ProductStock;
	}
	public void setProductStock(int productStock) {
		ProductStock = productStock;
	}
	public int getDiscountedPrice() {
		return DiscountedPrice;
	}
	public void setDiscountedPrice(int discountedPrice) {
		DiscountedPrice = discountedPrice;
	}
	}

