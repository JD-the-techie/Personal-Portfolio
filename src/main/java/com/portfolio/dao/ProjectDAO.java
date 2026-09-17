package com.portfolio.dao;

import com.portfolio.db.DBConnection;
import com.portfolio.model.Project;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    public List<Project> getProjectsByUser(int userId) throws SQLException {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM projects WHERE user_id = ? ORDER BY is_featured DESC, created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    projects.add(mapRow(rs));
                }
            }
        }
        return projects;
    }

    public Project getProjectById(int projectId) throws SQLException {
        String sql = "SELECT * FROM projects WHERE project_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean addProject(Project p) throws SQLException {
        String sql = "INSERT INTO projects (user_id, title, description, tech_stack, project_url, github_url, role, is_featured) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getUserId());
            ps.setString(2, p.getTitle());
            ps.setString(3, p.getDescription());
            ps.setString(4, p.getTechStack());
            ps.setString(5, p.getProjectUrl());
            ps.setString(6, p.getGithubUrl());
            ps.setString(7, p.getRole());
            ps.setBoolean(8, p.isFeatured());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateProject(Project p) throws SQLException {
        String sql = "UPDATE projects SET title=?, description=?, tech_stack=?, project_url=?, github_url=?, role=?, is_featured=? WHERE project_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getDescription());
            ps.setString(3, p.getTechStack());
            ps.setString(4, p.getProjectUrl());
            ps.setString(5, p.getGithubUrl());
            ps.setString(6, p.getRole());
            ps.setBoolean(7, p.isFeatured());
            ps.setInt(8, p.getProjectId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteProject(int projectId) throws SQLException {
        String sql = "DELETE FROM projects WHERE project_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            return ps.executeUpdate() > 0;
        }
    }

    public int getProjectCount(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM projects WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    private Project mapRow(ResultSet rs) throws SQLException {
        Project p = new Project();
        p.setProjectId(rs.getInt("project_id"));
        p.setUserId(rs.getInt("user_id"));
        p.setTitle(rs.getString("title"));
        p.setDescription(rs.getString("description"));
        p.setTechStack(rs.getString("tech_stack"));
        p.setProjectUrl(rs.getString("project_url"));
        p.setGithubUrl(rs.getString("github_url"));
        try {
            p.setRole(rs.getString("role"));
        } catch (SQLException ignored) {}
        p.setFeatured(rs.getBoolean("is_featured"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }
}
