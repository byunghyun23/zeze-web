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

public class CommentMgr {

	private DBConnectionMgr pool;

    String boardName;

	public CommentMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
    
    public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getBoardName() {
		return this.boardName;
	}

	public Vector<CommentBean> getCommentList(String boardName, int id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommentBean> vlist = new Vector<CommentBean>();
        this.boardName = boardName;
		try {
			con = pool.getConnection();

            sql = "select * from comment where boardname = ? and ref = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, boardName);
            pstmt.setInt(2, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setId(rs.getInt("id"));
                bean.setBoardName(rs.getString("boardname"));
                bean.setRef(rs.getInt("ref"));
				bean.setName(rs.getString("name"));
				bean.setContent(rs.getString("content"));
				bean.setRegdate(rs.getString("regdate"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

    public void insertComment(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String filename = null;

        this.boardName = req.getParameter("boardName");
		try {
			con = pool.getConnection();
			sql = "insert comment(boardname, ref, name, content, regdate, ip)";
			sql += "values(?, ?, ?, ?, now(), ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("boardName"));
			pstmt.setInt(2, Integer.parseInt(req.getParameter("id")));
            pstmt.setString(3, req.getParameter("name"));
			pstmt.setString(4, req.getParameter("content"));
            pstmt.setString(5, req.getParameter("ip"));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// public BoardBean getBoard(int id) {
		// Connection con = null;
		// PreparedStatement pstmt = null;
		// ResultSet rs = null;
		// String sql = null;
		// BoardBean bean = new BoardBean();
		// try {
		// 	con = pool.getConnection();
		// 	sql = "select * from " + boardName + " where id=?";
		// 	pstmt = con.prepareStatement(sql);
		// 	pstmt.setInt(1, id);
		// 	rs = pstmt.executeQuery();
		// 	if (rs.next()) {
		// 		bean.setId(rs.getInt("id"));
		// 		bean.setName(rs.getString("name"));
		// 		bean.setSubject(rs.getString("subject"));
		// 		bean.setContent(rs.getString("content"));
		// 		bean.setPos(rs.getInt("pos"));
		// 		bean.setRef(rs.getInt("ref"));
		// 		bean.setDepth(rs.getInt("depth"));
		// 		bean.setRegdate(rs.getString("regdate"));
		// 		bean.setPass(rs.getString("pass"));
		// 		bean.setCount(rs.getInt("count"));
		// 		bean.setFilename(rs.getString("filename"));
		// 		bean.setFilesize(rs.getInt("filesize"));
		// 		bean.setIp(rs.getString("ip"));
		// 	}
		// } catch (Exception e) {
		// 	e.printStackTrace();
		// } finally {
		// 	pool.freeConnection(con, pstmt, rs);
		// }
		// return bean;
	// }

	// public void deleteBoard(int id) {
		// Connection con = null;
		// PreparedStatement pstmt = null;
		// String sql = null;
		// ResultSet rs = null;
		// try {
		// 	con = pool.getConnection();
		// 	sql = "select filename from " + boardName + " where id = ?";
		// 	pstmt = con.prepareStatement(sql);
		// 	pstmt.setInt(1, id);
		// 	rs = pstmt.executeQuery();
		// 	if (rs.next() && rs.getString(1) != null) {
		// 		if (!rs.getString(1).equals("")) {
		// 			File file = new File(SAVEFOLDER + "/" + rs.getString(1));
		// 			if (file.exists())
		// 				UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
		// 		}
		// 	}
		// 	sql = "delete from " + boardName + " where id=?";
		// 	pstmt = con.prepareStatement(sql);
		// 	pstmt.setInt(1, id);
		// 	pstmt.executeUpdate();
		// } catch (Exception e) {
		// 	e.printStackTrace();
		// } finally {
		// 	pool.freeConnection(con, pstmt, rs);
		// }
	// }

	// public void updateBoard(MultipartRequest multi) {
	// 	Connection con = null;
	// 	PreparedStatement pstmt = null;
	// 	String sql = null;
	// 	BoardBean bean = null;

	// 	try {
	// 		boardName = multi.getParameter("boardName");
	// 		bean = new BoardBean();
	// 		bean.setId(Integer.parseInt(multi.getParameter("id")));
	// 		bean.setName(multi.getParameter("name"));
	// 		bean.setSubject(multi.getParameter("subject"));
	// 		bean.setContent(multi.getParameter("content"));
	// 		bean.setPass(multi.getParameter("pass"));
	// 		bean.setIp(multi.getParameter("ip"));
	// 		con = pool.getConnection();
	// 		sql = "update " + boardName + " set name=?,subject=?,content=? where id=?";
	// 		pstmt = con.prepareStatement(sql);
	// 		pstmt.setString(1, bean.getName());
	// 		pstmt.setString(2, bean.getSubject());
	// 		pstmt.setString(3, bean.getContent());
	// 		pstmt.setInt(4, bean.getId());
	// 		pstmt.executeUpdate();
	// 	} catch (Exception e) {
	// 		e.printStackTrace();
	// 	} finally {
	// 		pool.freeConnection(con, pstmt);
	// 	}
	// }
}