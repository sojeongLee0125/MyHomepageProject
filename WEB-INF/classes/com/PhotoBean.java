package com;

public class PhotoBean {

	private int ptno; 
	private String name; 
	private String pass; 
	private String subject; 
	private String regdate; 
	private int readcount; 
	private String filename; 
	private long filesize;
	
	public int getPtno() {
		return ptno;
	}
	public void setPtno(int ptno) {
		this.ptno = ptno;
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
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
	@Override
	public String toString() {
		return "PhotoBean [ptno=" + ptno + ", name=" + name + ", pass=" + pass + ", subject=" + subject + ", regdate="
				+ regdate + ", readcount=" + readcount + ", filename=" + filename + ", filesize=" + filesize + "]";
	}
	
	
	
}
