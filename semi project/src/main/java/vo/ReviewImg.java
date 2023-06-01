package vo;

public class ReviewImg {
	private int orderNo;
    private String reviewOriFilename;
    private String reviewSaveFilename;
    private String reviewFiletype;
    private String createDate;
    private String updateDate;
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getReviewOriFilename() {
		return reviewOriFilename;
	}
	public void setReviewOriFilename(String reviewOriFilename) {
		this.reviewOriFilename = reviewOriFilename;
	}
	public String getReviewSaveFilename() {
		return reviewSaveFilename;
	}
	public void setReviewSaveFilename(String reviewSaveFilename) {
		this.reviewSaveFilename = reviewSaveFilename;
	}
	public String getReviewFiletype() {
		return reviewFiletype;
	}
	public void setReviewFiletype(String reviewFiletype) {
		this.reviewFiletype = reviewFiletype;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
}
