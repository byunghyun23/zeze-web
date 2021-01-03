package duka;

public class LiveChatBean {
	
	private int id;
	private String name;   
    private String content;   
    private String regtime;   
     
	public int getId() {
		return id;
	}
	public String getName() {
		return name;
	}
    public String getContent() {
		return content;
	}
    public String getRegTime() {
		return regtime;
	}

    public void setId(int id) {
		this.id = id;
	}
	public void setName(String name) {
        this.name = name;
	}
    public void setContent(String content) {
        this.content = content;
	}
    public void setRegTime(String regtime) {
        this.regtime = regtime;
	}
}