package kr.human.fileboard.vo;

import java.util.List;

public class PagingVO<T> {
	// 글 목록을 저장할 리스트
	private List<T> list;

	// 넘겨받을 매개변수 4개
	private int totalCount; // 전체 개수
	private int currentPage; // 현재 페이지
	private int sizeOfPage; // 페이지당 글수
	private int sizeOfBlock; // 페이지번호 표시 개수

	// 나머지는 계산할 변수
	private int totalPage; // 전체 페이지 수
	private int startNo; // 시작 글번호
	private int endNo; // 끝 글번호
	private int startPage; // 시작 페이지 번호
	private int endPage; // 끝 페이지 번호

	// 생성자에서 넘겨 받는다.
	public PagingVO(int totalCount, int currentPage, int sizeOfPage, int sizeOfBlock) {
		super();
		this.totalCount = totalCount;
		this.currentPage = currentPage;
		this.sizeOfPage = sizeOfPage;
		this.sizeOfBlock = sizeOfBlock;
		calc(); // 계산해주는 메서드
	}

	private void calc() {
		// 글이 잇어야 페이지 나누기를 한다.
		if (totalCount > 0) {
			// 받은 값 검증
			if (currentPage <= 0)
				currentPage = 1; // 페이지 번호는 1보다 적을 수 없다.
			if (sizeOfPage <= 1)
				sizeOfPage = 10; // 최소 1페이지에 글이 1개 이상은 있어야 한다.
			if (sizeOfBlock <= 1)
				sizeOfBlock = 10; // 최소 페이지 번호 리스트는 2개 이상은 있어야 한다.

			// 전체 페이지 수 = (전체개수 -1)/페이지당 글수 + 1
			totalPage = (totalCount - 1) / sizeOfPage + 1;
			
			// 현재 페이지가 전체페이지수보다 클 수 없다
			if(currentPage>totalPage) currentPage = 1;
			
			// 시작 글번호 = (현재페이지-1)*페이지당 글수 + 1
			startNo = (currentPage - 1) * sizeOfPage + 1; // 마리아의 경우는 인덱스가 0이므로 +1을 하지 않는다.
			// 끝 글번호 = 시작 글번호 + 페이지당 글수 - 1
			endNo = startNo + sizeOfPage - 1;

			// 마지막 글번호는 전체 개수를 넘을 수 없다
			if (endNo > totalCount)
				endNo = totalCount;

			// 시작 페이지 번호 = (현재페이지-1)/페이지번호 표시 개수 * 페이지번호 표시 개수 + 1
			startPage = (currentPage - 1) / sizeOfBlock * sizeOfBlock + 1;
			// 끝 페이지 번호 = 시작 페이지 번호 + 페이지번호 표시 개수 - 1
			endPage = startPage + sizeOfBlock - 1;

			// 마지막 페이지 번호는 전체 전체 페이지 수를 넘을 수 없다
			if (endPage > totalPage)
				endPage = totalPage;
		}
	}

	// list는 getter&setter를 나머지는 모두 Getter만 만든다.
	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getSizeOfPage() {
		return sizeOfPage;
	}

	public int getSizeOfBlock() {
		return sizeOfBlock;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getStartNo() {
		return startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	@Override
	public String toString() {
		return "PagingVO [list=" + list + ", totalCount=" + totalCount + ", currentPage=" + currentPage
				+ ", sizeOfPage=" + sizeOfPage + ", sizeOfBlock=" + sizeOfBlock + ", totalPage=" + totalPage
				+ ", startNo=" + startNo + ", endNo=" + endNo + ", startPage=" + startPage + ", endPage=" + endPage
				+ "]";
	}

	// 메서드 2개를 추가해 보자(선택)
	// 페이지 상단에 "전체 : ??개(현재페이지/전체페이지 Page)"을 출력해주는 메서드
	public String getPageInfo() {
		return "전체 : " + totalCount + "개" + (totalCount>0 ? "(" + currentPage + "/ " + totalPage + "Page)" : "");
	}

	// 목록 상/하단에 페이지 번호를 출력해주는 메서드
	public String getPageList() {
		StringBuffer sb = new StringBuffer();
		// 글이 1개라도 존재해야 페이지 목록이 있다.
		if(totalCount>0) {
			// 페이지 시작
			sb.append("<ul class='pagination pagination-sm justify-content-center'>");
			// 이전 : 시작페이지 번호가 1보다 클때만 이전을 표시한다.
			if(startPage>1) {
				sb.append("<li class='page-item'>");
				sb.append("<a class='page-link' href='?p=" + (startPage-1) + "&s=" + sizeOfPage + "&b=" + sizeOfBlock + "' aria-label='Previous'>");
				sb.append("<span aria-hidden='true'>&laquo;</span>");
				sb.append("</a>");
				sb.append("</li>");
			}
			// 페이지 목록 : 시작 페이지 번호 ~ 끝 페이지 번호까지 출력 하는데 현재 페이지는 링크를 걸지 않는다.
			for(int i=startPage;i<=endPage;i++) {
				if(i==currentPage) {
					sb.append("<li class='page-link page-item active' aria-current='page'>" + i + "</li>");
				}else {
					sb.append("<li class='page-item'><a class='page-link' href='?p=" + i + "&s=" + sizeOfPage + "&b=" + sizeOfBlock + "'>" + i + "</a></li>");
				}
			}
			// 이후 : 끝페이지 번호가 전체 페이지 번호보다 적을 때만 이후를 표시한다.
			if(endPage<totalPage) {
				sb.append("<li class='page-item'>");
				sb.append("<a class='page-link' href='?p=" + (endPage+1) + "&s=" + sizeOfPage + "&b=" + sizeOfBlock + "' aria-label='Next'>");
				sb.append("<span aria-hidden='true'>&raquo;</span>");
				sb.append("</a>");
				sb.append("</li>");
			}
			
			// 페이지 종료
			sb.append("</ul>");
		}
		return sb.toString();
	}

}
