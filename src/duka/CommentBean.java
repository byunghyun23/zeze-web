package duka;

public class CommentBean {
	
	private int id;
    private String boardName;
    private int ref;
	private String name;         
	private String content;      
	private String regdate;     
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
    public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
    public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}