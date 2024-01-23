package board;

import java.sql.Date;

//IDX       NOT NULL NUMBER         
//TITLE     NOT NULL VARCHAR2(1000) 
//IMAGE              VARCHAR2(3000) 
//CATEGORY  NOT NULL VARCHAR2(100)  
//WRITER    NOT NULL VARCHAR2(100)  
//CONTENT   NOT NULL VARCHAR2(4000) 
//WRITEDATE          DATE   


public class BoardDTO {

	private int idx;
	private String title;
	private String image;
	private String category;
	private String writer;
	private String content;
	private Date writeDate;
	
	private int deleted;
	
	
	
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	
	
	
	
	
}
