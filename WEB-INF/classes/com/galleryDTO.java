package com;

public class galleryDTO {
	
	private String seq;
	private String subject;
	private String name;
	private String pass;
	private String content;
	private String filename;
	private long filesize;
	private String hit;
	private String wip;
	private String wdate;
	private int wgap;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	public String getWip() {
		return wip;
	}
	public void setWip(String wip) {
		this.wip = wip;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public int getWgap() {
		return wgap;
	}
	public void setWgap(int wgap) {
		this.wgap = wgap;
	}
	
	@Override
	public String toString() {
		return "galleryDTO [seq=" + seq + ", subject=" + subject + ", name=" + name + ", pass=" + pass + ", content="
				+ content + ", filename=" + filename + ", filesize=" + filesize + ", hit=" + hit + ", wip=" + wip
				+ ", wdate=" + wdate + ", wgap=" + wgap + "]";
	}	

}
