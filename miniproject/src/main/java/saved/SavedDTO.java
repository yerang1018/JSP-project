package saved;

public class SavedDTO {
	
//		IDX       	NOT NULL 	NUMBER        
//		BOARD_IDX 	NOT NULL 	NUMBER        
//		MEMBERID  	NOT NULL 	VARCHAR2(100) 
 
	
	private int idx;
	private int board_idx;
	private String memberId;
	
	
	private String title;
	private String writer;
	
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	
}
