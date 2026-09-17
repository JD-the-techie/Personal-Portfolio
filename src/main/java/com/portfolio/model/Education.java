package com.portfolio.model;

public class Education {
    private int eduId;
    private int userId;
    private String institution;
    private String degree;
    private String scoreText;
    private double cgpa;
    private int startYear;
    private int endYear;

    public Education() {}

    public int getEduId() { return eduId; }
    public void setEduId(int eduId) { this.eduId = eduId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getInstitution() { return institution; }
    public void setInstitution(String institution) { this.institution = institution; }

    public String getDegree() { return degree; }
    public void setDegree(String degree) { this.degree = degree; }

    public String getScoreText() { return scoreText; }
    public void setScoreText(String scoreText) { this.scoreText = scoreText; }

    public double getCgpa() { return cgpa; }
    public void setCgpa(double cgpa) { this.cgpa = cgpa; }

    public int getStartYear() { return startYear; }
    public void setStartYear(int startYear) { this.startYear = startYear; }

    public int getEndYear() { return endYear; }
    public void setEndYear(int endYear) { this.endYear = endYear; }
}
