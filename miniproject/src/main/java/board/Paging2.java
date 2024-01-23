package board;

public class Paging2 {
	// 요청받은 페이지
	private int page;
	// 페이지 당 출력할 게시글의 수
	private int perPage;
	// 총 게시글의 개수 (삭제, 검색 반영)
	private int boardCount;
	// sql에서 사용할 건너뛸 개수의 값
	private int offset;
	// 건너 뛴 후 불러올 게시글의 수 
	private int fetch;
	
	
	// 전체 페이지 개수 
	private int pageCount;
	// 페이지를 n개씩 묶어 하나의 구역으로 설정 후 0부터 시작
	private int section;
	// 이전 구역이 있다면 true
	private boolean prev;
	// 다음 구역이 있다면 true
	private boolean next;
	// 구역의 시작 페이지
	private int begin;
	// 구역의 끝 페이지 (단, 끝 페이지가 pageCount보다 크면 안된다)
	private int end;
	
	
	public static Paging2 newInstance(int page, int boardCount) {
		return new Paging2(page, boardCount);
	}
	
	private Paging2(int page, int boardCount) {
		this.page = page;
		this.boardCount = boardCount;
		
		perPage = 5;
		offset = (page -1) * perPage;
		fetch = perPage;
		
		pageCount = boardCount /perPage;
		pageCount += (boardCount % perPage != 0) ? 1 : 0;
		section = (page -1) / 5;
		begin = section * 5 + 1;
		end = begin + 4;
		prev = section != 0;
		next = pageCount > end;
		
		if (end > pageCount) {
			end = pageCount;
			next = false;
		}
	}
	
	
	
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getFetch() {
		return fetch;
	}
	public void setFetch(int fetch) {
		this.fetch = fetch;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getSection() {
		return section;
	}
	public void setSection(int section) {
		this.section = section;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getBegin() {
		return begin;
	}
	public void setBegin(int begin) {
		this.begin = begin;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	
	
	
	
	
	
		
}
