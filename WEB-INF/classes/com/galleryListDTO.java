package com;

import java.util.ArrayList;

public class galleryListDTO {
	
	private int cpage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalRecord;
	private int startBlock;
	private int endBlock;
	private int blockRecord;
	private ArrayList<galleryDTO> galleryLists;
	
	public galleryListDTO() {
		this.cpage = 1;
		this.recordPerPage = 5;	//한 페이지에 보일 글의 수
		this.blockPerPage = 3;	//페이지 보일 개수 3개씩
		this.totalPage = 1;
		this.totalRecord = 0;
		this.blockRecord = 0;
	}

	public int getCpage() {
		return cpage;
	}
	public int getRecordPerPage() {
		return recordPerPage;
	}
	public int getBlockPerPage() {
		return blockPerPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public int getStartBlock() {
		return startBlock;
	}
	public int getEndBlock() {
		return endBlock;
	}
	public int getBlockRecord() {
		return blockRecord;
	}
	public ArrayList<galleryDTO> getBoardLists() {
		return galleryLists;
	}
	
	public void setCpage(int cpage) {
		this.cpage = cpage;
	}
	public void setRecordPerPage(int recordPerPage) {
		this.recordPerPage = recordPerPage;
	}
	public void setBlockPerPage(int blockPerPage) {
		this.blockPerPage = blockPerPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}
	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}
	public void setBlockRecord(int blockRecord) {
		this.blockRecord = blockRecord;
	}
	public void setBoardLists(ArrayList<galleryDTO> boardLists) {
		this.galleryLists = boardLists;
	}
	
	

}
