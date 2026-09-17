package com.portfolio.dao;

import com.portfolio.db.DBConnection;
import com.portfolio.model.Education;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EducationDAO {

    public List<Education> getEducationByUser(int userId) throws SQLException {
        List<Education> list = new ArrayList<>();
        String sql = "SELECT * FROM education WHERE user_id = ? ORDER BY end_year DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        }
        return list;
    }

    private Education mapRow(ResultSet rs) throws SQLException {
        Education e = new Education();
        e.setEduId(rs.getInt("edu_id"));
        e.setUserId(rs.getInt("user_id"));
        e.setInstitution(rs.getString("institution"));
        e.setDegree(rs.getString("degree"));
        try {
            e.setScoreText(rs.getString("score_text"));
        } catch (SQLException ignored) {}
        try {
            e.setCgpa(rs.getDouble("cgpa"));
        } catch (SQLException ignored) {}
        e.setStartYear(rs.getInt("start_year"));
        e.setEndYear(rs.getInt("end_year"));
        return e;
    }
}
