package com.portfolio.dao;

import com.portfolio.db.DBConnection;
import com.portfolio.model.Message;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {

    public boolean saveMessage(Message msg) throws SQLException {
        String sql = "INSERT INTO messages (sender_name, sender_email, subject, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, msg.getSenderName());
            ps.setString(2, msg.getSenderEmail());
            ps.setString(3, msg.getSubject() != null ? msg.getSubject() : "");
            ps.setString(4, msg.getMessage());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Message> getAllMessages() throws SQLException {
        List<Message> list = new ArrayList<>();
        String sql = "SELECT * FROM messages ORDER BY sent_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public int getUnreadCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM messages WHERE is_read = FALSE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private Message mapRow(ResultSet rs) throws SQLException {
        Message m = new Message();
        m.setMessageId(rs.getInt("message_id"));
        m.setSenderName(rs.getString("sender_name"));
        m.setSenderEmail(rs.getString("sender_email"));
        try {
            m.setSubject(rs.getString("subject"));
        } catch (SQLException ignored) {}
        m.setMessage(rs.getString("message"));
        m.setSentAt(rs.getTimestamp("sent_at"));
        m.setRead(rs.getBoolean("is_read"));
        return m;
    }
}
