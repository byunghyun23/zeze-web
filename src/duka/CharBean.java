package duka;

public class CharBean {
	
	private int id;
    private int accountId;
    private int level;
    private int job;   
	private int rank;
	private int exp;
	private int fame;
	private String name;   
     
	public int getId() {
		return id;
	}
    public int getAccountId() {
		return accountId;
	}
    public int getLevel() {
		return level;
	}
    public int getJob() {
		return job;
	}
	public int getRank() {
		return rank;
	}
	public int getExp() {
		return exp;
	}
	public int getFame() {
		return fame;
	}
	public String getName() {
		return name;
	}

    public void setId(int id) {
		this.id = id;
	}
    public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
    public void setLevel(int level) {
        this.level = level;
	}
    public void setJob(int job) {
        this.job = job;
	}
	public void setRank(int rank) {
        this.rank = rank;
	}
	public void setExp(int exp) {
        this.exp = exp;
	}
	public void setFame(int fame) {
        this.fame = fame;
	}
	public void setName(String name) {
        this.name = name;
	}
}