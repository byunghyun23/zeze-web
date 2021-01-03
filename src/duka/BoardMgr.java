package duka;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardMgr {

	private DBConnectionMgr pool;
	private static final String  SAVEFOLDER = "C:/Jsp/myapp/WebContent/ch15/fileupload";
	private static final String ENCTYPE = "utf-8";
	private static int MAXSIZE = 5*1024*1024;

	private String boardName = "newsBoard";

	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean setGuide(String content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			con = pool.getConnection();
			sql = "insert guide (content) values (?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return true;
	}
	
	public String getGuide() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String content = null;
		
		try {
			con = pool.getConnection();
			sql = "select * from guide";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				content = rs.getString("content");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return content;
	}
	
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getBoardName() {
		return this.boardName;
	}

	public Vector<BoardBean> getBoardList(String keyField, String keyWord,
			int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select * from " + boardName + " order by ref desc, pos limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from " + boardName + " where " + keyField + " like ? ";
				sql += "order by ref desc, pos limit ? , ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setId(rs.getInt("id"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setFix(rs.getInt("fix"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(id) from " + boardName;
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "select count(id) from " + boardName + " where " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//////////////// test
	public boolean setLive(String name, String content, String ip) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		try {
			con = pool.getConnection();
			sql = "insert livechat (name, content, ip) values (?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, content);
			pstmt.setString(3, ip);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return true;
	}
	
	public Vector<LiveChatBean> getLive() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LiveChatBean> vlist = new Vector<LiveChatBean>();
		int count = 1;

		try {
			con = pool.getConnection();
			sql = "select count(*) from livechat";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.first()) {
				count = rs.getInt(1);
			}
			
			if(count <= 10) {
				sql = "select * from livechat";
				pstmt = con.prepareStatement(sql);
			}
			else {
				sql = "select * from livechat limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, count - 10);
				pstmt.setInt(2, 10);
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				LiveChatBean bean = new LiveChatBean();
				bean.setId(rs.getInt("id"));
				bean.setName(rs.getString("name"));
				bean.setContent(rs.getString("content"));
				bean.setRegTime(rs.getString("regtime"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return vlist;
	}

	public boolean insertBoard(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		BoardBean bean = null;
		ResultSet rs = null;

		try {
			boardName = multi.getParameter("boardName");
			bean = new BoardBean();
			bean.setName(multi.getParameter("name"));
			bean.setSubject(multi.getParameter("subject"));
			bean.setContent(multi.getParameter("content"));
			bean.setIp(multi.getParameter("ip"));

			con = pool.getConnection();
			sql = "select max(id) from " + boardName;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 1;
			if (rs.next())
				ref = rs.getInt(1) + 1;

			sql = "insert " + boardName + "(name,content,subject,ref,pos,depth,regdate,count,ip)";
			sql += "values(?, ?, ?, ?, 0, 0, now(), 0, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getContent());
			pstmt.setString(3, bean.getSubject());
			pstmt.setInt(4, ref);
			pstmt.setString(5, bean.getIp());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return true;
	}
	
	public BoardBean getBoard(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBean bean = new BoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from " + boardName + " where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setId(rs.getInt("id"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setPass(rs.getString("pass"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				bean.setIp(rs.getString("ip"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	public void upCount(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update " + boardName + " set count=count+1 where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public void deleteBoard(int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "select filename from " + boardName + " where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next() && rs.getString(1) != null) {
				if (!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if (file.exists())
						UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
				}
			}
			sql = "delete from " + boardName + " where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	public void updateBoard(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		BoardBean bean = null;

		try {
			boardName = multi.getParameter("boardName");
			bean = new BoardBean();
			bean.setId(Integer.parseInt(multi.getParameter("id")));
			bean.setName(multi.getParameter("name"));
			bean.setSubject(multi.getParameter("subject"));
			bean.setContent(multi.getParameter("content"));
			bean.setPass(multi.getParameter("pass"));
			bean.setIp(multi.getParameter("ip"));
			con = pool.getConnection();
			sql = "update " + boardName + " set name=?,subject=?,content=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}