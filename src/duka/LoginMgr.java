package duka;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import java.util.regex.Pattern;

public class LoginMgr {

	private DBConnectionMgr pool;

	public LoginMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getEmail(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String email = null;
		
		try {
			con = pool.getConnection();
			sql = "select email from accounts where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if(rs.first()) {
				email = rs.getString("email");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return email;
	}
	
	public String getPwd(String name, String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String pwd = null;

		try {
			con = pool.getConnection();
			sql = "select password from accounts where name = ? and email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if(rs.first()) {
				pwd = rs.getString("password");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pwd;
	}

	public String getIdName(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String idName = null;

		try {
			con = pool.getConnection();
			sql = "select name from accounts where email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.first()) {
				idName = rs.getString("name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return idName;
	}

	public Vector<CharBean> getRank(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CharBean> vlist = new Vector<CharBean>();

		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select name, job, level, exp, fame, rank from characters order by level desc, exp desc, rank_order asc";
				pstmt = con.prepareStatement(sql);
			}
			else {
				if(keyField.equals("job")) {
					UtilMgr uMgr = new UtilMgr();
					keyWord = Integer.toString(uMgr.getJobId(keyWord));
				}
				sql = "select name, job, level, exp, fame, rank from characters where " + keyField + " = ? order by level desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyWord);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CharBean bean = new CharBean();
				bean.setName(rs.getString("name"));
				bean.setJob(rs.getInt("job"));
				bean.setLevel(rs.getInt("level"));
				bean.setExp(rs.getInt("exp"));
				bean.setFame(rs.getInt("fame"));
				bean.setRank(rs.getInt("rank"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public int changeEmail(int accountId, String prePwd, String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			con = pool.getConnection();
			sql = "select password from accounts where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, accountId);
			rs = pstmt.executeQuery();
			if(rs.first()) {
				String pwd = rs.getString("password");
				if(!pwd.equals(prePwd))
					return 1;
			}

			con = pool.getConnection();
			sql = "select email from accounts where email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.first())
				return 2;
			
			con = pool.getConnection();
			sql = "update accounts set email=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, accountId);
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			return 3;
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return 0;	
	}
	
	public boolean changePwd(int accountId, String prePwd, String newPwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			con = pool.getConnection();
			sql = "select password from accounts where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, accountId);
			rs = pstmt.executeQuery();
			if(rs.first()) {
				String pwd = rs.getString("password");
				if(!pwd.equals(prePwd))
					return false;
			}

			con = pool.getConnection();
			sql = "update accounts set password=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setInt(2, accountId);
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return true;
	}

	public boolean setChar(int accountId, int charId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			con = pool.getConnection();
			sql = "update accounts set charid=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, charId);
			pstmt.setInt(2, accountId);
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return true;
	}
	
	public String getChar(int accountId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int charId = 0;
		String charName = null;

		try {
			con = pool.getConnection();
			sql = "select charid from accounts where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, accountId);
			rs = pstmt.executeQuery();
			if(rs.first()) {
				charId = rs.getInt("charid");
			}

			sql = "select name from characters where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, charId);
			rs = pstmt.executeQuery();
			if (rs.first()) {
				charName = rs.getString("name");
            }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return charName;
	}

	public Vector<CharBean> getCharList (int accountId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CharBean> vlist = new Vector<CharBean>();

		try {
			con = pool.getConnection();
			sql = "select id, level, name, job from characters where accountid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, accountId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CharBean bean = new CharBean();
				bean.setId(rs.getInt("id"));
				bean.setLevel(rs.getInt("level"));
				bean.setName(rs.getString("name"));
				bean.setJob(rs.getInt("job"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

    public boolean checkAccount(String name) {
        try {
            Connection con = pool.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM accounts WHERE name = ?");
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.first()) {
                return true;
            }
        } catch (Exception ex) {
            System.out.println(ex);
            return false;
        }
        return false;
    }

	public boolean checkEmail(String email) {
        try {
            Connection con = pool.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM accounts WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.first()) {
                return true;
            }
        } catch (Exception ex) {
            System.out.println(ex);
            return false;
        }
        return false;
    }
    
    public int login(String id, String pwd) {
		int result = -1;
        try {
            Connection con = pool.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM accounts WHERE name = ? and password = ?");
            ps.setString(1, id);
            ps.setString(2, pwd);
            ResultSet rs = ps.executeQuery();
            if (rs.first()) {
				result =  rs.getInt("id");
            }
        } catch (Exception ex) {
            System.out.println(ex);
            result = -1;
        }
        return result;
    }
	   
//    public static void createAccount(String id, String pwd, String ip, final MapleClient c) {
	public int createAccount(String id, String pwd, String mail, String code, String ip, String doco) {
		int ACCOUNTS_IP_COUNT = 1;
		
        // 특수문자 및 한글확인
        String pattern = "^[a-zA-Z0-9]*$";
        boolean result = Pattern.matches(pattern, id);
        if(!result) {
        	return -1;
        }
        
        // 중복
		if(checkAccount(id)) {  
			return -2;
		}
		// 중복
		if(checkEmail(mail)) {  
			return -3;
		}
		
        Connection con = null;
        PreparedStatement ipc = null;
        PreparedStatement ps = null;
        
        ResultSet rs = null;
		try {
            con = pool.getConnection();
            ipc = con.prepareStatement("SELECT SessionIP FROM accounts WHERE SessionIP = ?");
            ipc.setString(1, ip);
            rs = ipc.executeQuery();
            if (rs.first() == false || rs.last() == true && rs.getRow() < ACCOUNTS_IP_COUNT) {
                try {
                    Connection c = pool.getConnection();
        			PreparedStatement p = c.prepareStatement("INSERT INTO accounts (name, password, email, code, SessionIP, gender, doco) VALUES (?, ?, ?, ?, ?, ?, ?)"); //helios_wep
        			
        			p.setString(1, id);
        			p.setString(2, pwd);
        			p.setString(3, mail);
        			p.setString(4, code);
        			p.setString(5, ip);
        			p.setString(6, "0");
        			p.setString(7, doco);
        			p.executeUpdate();
                } catch (Exception ex) {
                    System.out.println(ex);
        			return -4;
                }
            }
            else {
            	return -5;
            }
		} catch (Exception ex) {
            System.out.println(ex);
		}

        
        return 1;
    }
     
}