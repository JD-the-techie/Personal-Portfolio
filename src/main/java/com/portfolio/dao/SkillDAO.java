package com.portfolio.dao;

import com.portfolio.db.DBConnection;
import com.portfolio.model.Skill;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SkillDAO {

    public List<Skill> getSkillsByUser(int userId) throws SQLException {
        List<Skill> skills = new ArrayList<>();
        String sql = "SELECT * FROM skills WHERE user_id = ? ORDER BY category, skill_name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    skills.add(mapRow(rs));
                }
            }
        }
        return skills;
    }

    public Skill getSkillById(int skillId) throws SQLException {
        String sql = "SELECT * FROM skills WHERE skill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, skillId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean addSkill(Skill s) throws SQLException {
        String sql = "INSERT INTO skills (user_id, category, skill_name, proficiency_level, icon_class) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, s.getUserId());
            ps.setString(2, s.getCategory());
            ps.setString(3, s.getSkillName());
            ps.setInt(4, s.getProficiencyLevel());
            ps.setString(5, s.getIconClass());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateSkill(Skill s) throws SQLException {
        String sql = "UPDATE skills SET category=?, skill_name=?, proficiency_level=?, icon_class=? WHERE skill_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getCategory());
            ps.setString(2, s.getSkillName());
            ps.setInt(3, s.getProficiencyLevel());
            ps.setString(4, s.getIconClass());
            ps.setInt(5, s.getSkillId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteSkill(int skillId) throws SQLException {
        String sql = "DELETE FROM skills WHERE skill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, skillId);
            return ps.executeUpdate() > 0;
        }
    }

    public int getSkillCount(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM skills WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    private Skill mapRow(ResultSet rs) throws SQLException {
        Skill s = new Skill();
        s.setSkillId(rs.getInt("skill_id"));
        s.setUserId(rs.getInt("user_id"));
        s.setCategory(rs.getString("category"));
        s.setSkillName(rs.getString("skill_name"));
        s.setProficiencyLevel(rs.getInt("proficiency_level"));
        s.setIconClass(rs.getString("icon_class"));
        return s;
    }
}
