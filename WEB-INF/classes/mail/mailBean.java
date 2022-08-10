package mail;

public class mailBean {
	String name;
	String email;
	String phone;
	String message;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getmessage() {
		return message;
	}
	public void setmessage(String message) {
		this.message = message;
	}
	
	@Override
	public String toString() {
		return "mailBean [name=" + name + ", email=" + email + ", phone=" + phone + ", message=" + message + "]";
	}

	
}
