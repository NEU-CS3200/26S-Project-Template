DROP DATABASE IF EXISTS `OfferWatchDB`;
CREATE DATABASE IF NOT EXISTS `OfferWatchDB`;
USE `OfferWatchDB`;

CREATE TABLE Institution (
   InstitutionID INT AUTO_INCREMENT PRIMARY KEY,
   InstitutionName VARCHAR(100) NOT NULL,
   InstitutionType VARCHAR(50) NOT NULL,
   Status VARCHAR(20) NOT NULL
);

CREATE TABLE Role (
   RoleID INT AUTO_INCREMENT PRIMARY KEY,
   RoleName VARCHAR(75) NOT NULL UNIQUE,
   RoleDescription TEXT
);

CREATE TABLE Permission (
   PermissionID INT AUTO_INCREMENT PRIMARY KEY,
   PermissionName VARCHAR(100) NOT NULL UNIQUE,
   PermissionDescription TEXT
);

CREATE TABLE Role_Permission (
   RoleID INT NOT NULL,
   PermissionID INT NOT NULL,
   PRIMARY KEY (RoleID, PermissionID),
   CONSTRAINT fk_rp_role
       FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
   CONSTRAINT fk_rp_permission
       FOREIGN KEY (PermissionID) REFERENCES Permission(PermissionID)
);

CREATE TABLE Major (
   MajorID INT AUTO_INCREMENT PRIMARY KEY,
   MajorName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Industry (
   IndustryID INT AUTO_INCREMENT PRIMARY KEY,
   Title VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE `User` (
   UserID INT AUTO_INCREMENT PRIMARY KEY,
   FirstName VARCHAR(50) NOT NULL,
   LastName VARCHAR(50) NOT NULL,
   Email VARCHAR(100) NOT NULL UNIQUE,
   RoleID INT NOT NULL,
   InstitutionID INT NOT NULL,
   Created_At DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   Deactivated_At DATETIME NULL,
   Account_Status VARCHAR(20) NOT NULL,
   CONSTRAINT fk_user_role
       FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
   CONSTRAINT fk_user_institution
       FOREIGN KEY (InstitutionID) REFERENCES Institution(InstitutionID),
   INDEX idx_user_role (RoleID),
   INDEX idx_user_institution (InstitutionID)
);

CREATE TABLE Advisor (
   AdvisorID INT AUTO_INCREMENT PRIMARY KEY,
   UserID INT NOT NULL UNIQUE,
   CONSTRAINT fk_advisor_user
       FOREIGN KEY (UserID) REFERENCES `User`(UserID),
   INDEX idx_advisor_user (UserID)
);

CREATE TABLE Recruiter (
   RecruiterID INT AUTO_INCREMENT PRIMARY KEY,
   UserID INT NOT NULL UNIQUE,
   CONSTRAINT fk_recruiter_user
       FOREIGN KEY (UserID) REFERENCES `User`(UserID),
   INDEX idx_recruiter_user (UserID)
);

CREATE TABLE Student (
   StudentID INT AUTO_INCREMENT PRIMARY KEY,
   UserID INT NOT NULL UNIQUE,
   Year INT NOT NULL,
   MajorID INT NULL,
   GPA DECIMAL(3,2) NULL,
   NumApplications INT NOT NULL DEFAULT 0,
   LastActivityDate DATETIME NULL,
   AdvisorID INT NULL,
   CONSTRAINT fk_student_user
       FOREIGN KEY (UserID) REFERENCES `User`(UserID),
   CONSTRAINT fk_student_major
       FOREIGN KEY (MajorID) REFERENCES Major(MajorID),
   CONSTRAINT fk_student_advisor
       FOREIGN KEY (AdvisorID) REFERENCES Advisor(AdvisorID),
   INDEX idx_student_user (UserID),
   INDEX idx_student_major (MajorID),
   INDEX idx_student_advisor (AdvisorID),
   INDEX idx_student_last_activity (LastActivityDate)
);

CREATE TABLE Student_Industry (
   StudentIndustryID INT AUTO_INCREMENT PRIMARY KEY,
   StudentID INT NOT NULL,
   IndustryID INT NOT NULL,
   PreferenceRank INT NULL,
   CONSTRAINT fk_studentindustry_student
       FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
   CONSTRAINT fk_studentindustry_industry
       FOREIGN KEY (IndustryID) REFERENCES Industry(IndustryID),
   CONSTRAINT uq_student_industry UNIQUE (StudentID, IndustryID),
   INDEX idx_studentindustry_student (StudentID),
   INDEX idx_studentindustry_industry (IndustryID)
);

CREATE TABLE Employer (
   EmployerID INT AUTO_INCREMENT PRIMARY KEY,
   IndustryID INT NOT NULL,
   Name VARCHAR(100) NOT NULL,
   Location VARCHAR(100) NULL,
   Size VARCHAR(50) NULL,
   RecruitingStatus VARCHAR(50) NULL,
   MinGPA DECIMAL(3,2) NULL,
   CONSTRAINT fk_employer_industry
       FOREIGN KEY (IndustryID) REFERENCES Industry(IndustryID),
   INDEX idx_employer_industry (IndustryID),
   INDEX idx_employer_name (Name)
);

CREATE TABLE `Position` (
   PositionID INT AUTO_INCREMENT PRIMARY KEY,
   EmployerID INT NOT NULL,
   Title VARCHAR(100) NOT NULL,
   CONSTRAINT fk_position_employer
       FOREIGN KEY (EmployerID) REFERENCES Employer(EmployerID),
   INDEX idx_position_employer (EmployerID),
   INDEX idx_position_title (Title)
);

CREATE TABLE Resume (
   ResumeID INT AUTO_INCREMENT PRIMARY KEY,
   StudentID INT NOT NULL,
   Version INT NOT NULL,
   InterviewConversionRate DECIMAL(5,2) NULL,
   DateSubmitted DATETIME NOT NULL,
   CONSTRAINT fk_resume_student
       FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
   CONSTRAINT uq_resume_version UNIQUE (StudentID, Version),
   INDEX idx_resume_student (StudentID)
);

CREATE TABLE Job_Application (
   ApplicationID INT AUTO_INCREMENT PRIMARY KEY,
   StudentID INT NOT NULL,
   PositionID INT NOT NULL,
   ResumeID INT NULL,
   Application_Date DATETIME NOT NULL,
   Status VARCHAR(50) NOT NULL,
   Notes TEXT NULL,
   IsArchived BOOLEAN NOT NULL DEFAULT FALSE,
   CONSTRAINT fk_application_student
       FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
   CONSTRAINT fk_application_position
       FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID),
   CONSTRAINT fk_application_resume
       FOREIGN KEY (ResumeID) REFERENCES Resume(ResumeID),
   INDEX idx_application_student (StudentID),
   INDEX idx_application_position (PositionID),
   INDEX idx_application_status (Status),
   INDEX idx_application_archived (IsArchived),
   INDEX idx_application_date (Application_Date)
);

CREATE TABLE Interview (
   InterviewID INT AUTO_INCREMENT PRIMARY KEY,
   ApplicationID INT NOT NULL,
   Date_Time DATETIME NOT NULL,
   Type VARCHAR(50) NULL,
   WeekReported DATETIME NULL,
   RecruiterFeedback TEXT NULL,
   CONSTRAINT fk_interview_application
       FOREIGN KEY (ApplicationID) REFERENCES Job_Application(ApplicationID),
   INDEX idx_interview_application (ApplicationID),
   INDEX idx_interview_date (Date_Time)
);

CREATE TABLE Job_Offer (
   OfferID INT AUTO_INCREMENT PRIMARY KEY,
   ApplicationID INT NOT NULL UNIQUE,
   Salary DECIMAL(10,2) NULL,
   Deadline DATETIME NULL,
   Location VARCHAR(100) NULL,
   Benefits TEXT NULL,
   StartDate DATETIME NULL,
   DateExtended DATETIME NULL,
   DateAccepted DATETIME NULL,
   TimeToOfferWeeks INT NULL,
   OfferAccepted BOOLEAN NULL,
   CONSTRAINT fk_joboffer_application
       FOREIGN KEY (ApplicationID) REFERENCES Job_Application(ApplicationID),
   INDEX idx_joboffer_deadline (Deadline)
);

CREATE TABLE Reminder (
   ReminderID INT AUTO_INCREMENT PRIMARY KEY,
   ApplicationID INT NOT NULL,
   Description TEXT NOT NULL,
   DueDate DATETIME NOT NULL,
   CONSTRAINT fk_reminder_application
       FOREIGN KEY (ApplicationID) REFERENCES Job_Application(ApplicationID),
   INDEX idx_reminder_application (ApplicationID),
   INDEX idx_reminder_duedate (DueDate)
);

CREATE TABLE Note (
   NoteID INT AUTO_INCREMENT PRIMARY KEY,
   ApplicationID INT NOT NULL,
   Note_Text TEXT NOT NULL,
   Created_At DATETIME NOT NULL,
   CONSTRAINT fk_note_application
       FOREIGN KEY (ApplicationID) REFERENCES Job_Application(ApplicationID),
   INDEX idx_note_application (ApplicationID),
   INDEX idx_note_created (Created_At)
);

CREATE TABLE Service_Component (
   ComponentID INT AUTO_INCREMENT PRIMARY KEY,
   Component_Name VARCHAR(100) NOT NULL,
   Component_Type VARCHAR(50) NOT NULL,
   Current_Status VARCHAR(20) NOT NULL,
   Last_Checked_At DATETIME NOT NULL
);

CREATE TABLE Error_Log (
   ErrorID INT AUTO_INCREMENT PRIMARY KEY,
   Error_Type VARCHAR(50) NOT NULL,
   Occurred_At DATETIME NOT NULL,
   Status VARCHAR(20) NOT NULL,
   Severity VARCHAR(20) NOT NULL,
   Message TEXT NOT NULL,
   ComponentID INT NOT NULL,
   CONSTRAINT fk_errorlog_component
       FOREIGN KEY (ComponentID) REFERENCES Service_Component(ComponentID),
   INDEX idx_errorlog_component (ComponentID),
   INDEX idx_errorlog_occurred (Occurred_At),
   INDEX idx_errorlog_status (Status)
);

CREATE TABLE Health_Metric (
   MetricID INT AUTO_INCREMENT PRIMARY KEY,
   Metric_Name VARCHAR(100) NOT NULL,
   Metric_Value DECIMAL(10,2) NOT NULL,
   Metric_Unit VARCHAR(30) NULL,
   Recorded_At DATETIME NOT NULL,
   ComponentID INT NOT NULL,
   CONSTRAINT fk_healthmetric_component
       FOREIGN KEY (ComponentID) REFERENCES Service_Component(ComponentID),
   INDEX idx_healthmetric_component (ComponentID),
   INDEX idx_healthmetric_recorded (Recorded_At)
);

CREATE TABLE Data_Correction (
   CorrectionID INT AUTO_INCREMENT PRIMARY KEY,
   UserID INT NOT NULL,
   Correction_Type VARCHAR(50) NOT NULL,
   Correction_Date DATETIME NOT NULL,
   Old_Value TEXT NULL,
   New_Value TEXT NULL,
   CorrectedByUserID INT NOT NULL,
   CONSTRAINT fk_datacorrection_user
       FOREIGN KEY (UserID) REFERENCES `User`(UserID),
   CONSTRAINT fk_datacorrection_correctedby
       FOREIGN KEY (CorrectedByUserID) REFERENCES `User`(UserID),
   INDEX idx_datacorrection_user (UserID),
   INDEX idx_datacorrection_correctedby (CorrectedByUserID),
   INDEX idx_datacorrection_date (Correction_Date)
);

INSERT INTO Institution (InstitutionName, InstitutionType, Status) VALUES
('Northeastern University', 'Private', 'Active'),
('Boston University', 'Private', 'Active'),
('Duke University', 'Private', 'Active');

INSERT INTO Role (RoleName, RoleDescription) VALUES
('Student', 'Job seeker using the platform'),
('Advisor', 'Career advisor helping students'),
('Recruiter', 'Company recruiter managing candidates'),
('Admin', 'System administrator managing the platform');

INSERT INTO Permission (PermissionName, PermissionDescription) VALUES
('VIEW_ALL_STUDENTS', 'Can view all student data'),
('EDIT_APPLICATIONS', 'Can modify job applications'),
('MANAGE_USERS', 'Can add/update/deactivate users'),
('VIEW_SYSTEM_LOGS', 'Can view platform logs and health metrics');

INSERT INTO Role_Permission (RoleID, PermissionID) VALUES
(2, 1),
(2, 2),
(3, 2),
(4, 3),
(4, 4);

INSERT INTO Major (MajorName) VALUES
('Computer Science'),
('Finance'),
('Business Administration');

INSERT INTO Industry (Title) VALUES
('Technology'),
('Finance'),
('Healthcare');

INSERT INTO `User`
(FirstName, LastName, Email, RoleID, InstitutionID, Created_At, Account_Status) VALUES
('Alex', 'Chen', 'alex.chen@northeastern.edu', 1, 1, '2026-01-15 10:00:00', 'Active'),
('Maria', 'Patel', 'maria.patel@northeastern.edu', 2, 1, '2026-01-10 09:00:00', 'Active'),
('John', 'Smith', 'john.smith@google.com', 3, 1, '2026-02-01 08:00:00', 'Active'),
('Evan', 'Carter', 'evan.carter@offerwatch.com', 4, 1, '2026-01-05 08:30:00', 'Active');

INSERT INTO Advisor (UserID) VALUES
(2);

INSERT INTO Recruiter (UserID) VALUES
(3);

INSERT INTO Student
(UserID, Year, MajorID, GPA, NumApplications, LastActivityDate, AdvisorID) VALUES
(1, 2026, 1, 3.75, 2, '2026-03-15 10:00:00', 1);

INSERT INTO Student_Industry (StudentID, IndustryID, PreferenceRank) VALUES
(1, 1, 1),
(1, 2, 2);

INSERT INTO Employer (IndustryID, Name, Location, Size, RecruitingStatus, MinGPA) VALUES
(1, 'Google', 'Mountain View, CA', 'Large', 'Active', 3.50),
(2, 'Goldman Sachs', 'New York, NY', 'Large', 'Active', 3.70),
(1, 'Microsoft', 'Redmond, WA', 'Large', 'Active', 3.40);

INSERT INTO `Position` (EmployerID, Title) VALUES
(1, 'Software Engineer Intern'),
(2, 'Financial Analyst Intern'),
(3, 'Program Manager Intern');

INSERT INTO Resume (StudentID, Version, InterviewConversionRate, DateSubmitted) VALUES
(1, 1, 20.50, '2026-01-15 10:00:00'),
(1, 2, 25.00, '2026-02-10 14:30:00');

INSERT INTO Job_Application
(StudentID, PositionID, ResumeID, Application_Date, Status, Notes, IsArchived) VALUES
(1, 1, 2, '2026-03-01 09:00:00', 'Interview Scheduled', 'Applied through career fair', FALSE),
(1, 2, 2, '2026-03-05 10:30:00', 'Applied', 'Online application', FALSE),
(1, 3, 1, '2025-10-10 11:15:00', 'Rejected', 'Old cycle application', TRUE);

INSERT INTO Interview (ApplicationID, Date_Time, Type, WeekReported, RecruiterFeedback) VALUES
(1, '2026-03-15 14:00:00', 'Technical', '2026-03-15 00:00:00', 'Strong coding skills'),
(1, '2026-03-22 15:30:00', 'Behavioral', '2026-03-22 00:00:00', 'Great communication');

INSERT INTO Job_Offer
(ApplicationID, Salary, Deadline, Location, Benefits, StartDate, DateExtended, TimeToOfferWeeks, OfferAccepted) VALUES
(1, 28.00, '2026-04-15 23:59:59', 'Mountain View, CA', 'Housing stipend, Free meals', '2026-07-07 09:00:00', '2026-04-01 09:00:00', 4, NULL);

INSERT INTO Reminder (ApplicationID, Description, DueDate) VALUES
(1, 'Follow up on Google offer', '2026-04-10 09:00:00'),
(2, 'Check application portal status', '2026-03-20 09:00:00');

INSERT INTO Note (ApplicationID, Note_Text, Created_At) VALUES
(1, 'Met recruiter at career fair - mentioned AI research', '2026-03-01 09:30:00'),
(2, 'Applied online, no referral', '2026-03-05 10:35:00');

INSERT INTO Service_Component (Component_Name, Component_Type, Current_Status, Last_Checked_At) VALUES
('Database', 'Infrastructure', 'Operational', '2026-04-06 12:00:00'),
('REST API', 'Service', 'Operational', '2026-04-06 12:00:00'),
('Notifications', 'Service', 'Degraded', '2026-04-06 12:00:00');

INSERT INTO Error_Log (Error_Type, Occurred_At, Status, Severity, Message, ComponentID) VALUES
('Connection Timeout', '2026-04-05 14:30:00', 'Resolved', 'Medium', 'Database connection timeout', 1),
('API Rate Limit', '2026-04-06 09:15:00', 'Unresolved', 'Low', 'Rate limit exceeded', 2),
('Email Failure', '2026-04-06 10:45:00', 'Unresolved', 'High', 'Reminder email delivery failed', 3);

INSERT INTO Health_Metric (Metric_Name, Metric_Value, Metric_Unit, Recorded_At, ComponentID) VALUES
('Response Time', 154.25, 'ms', '2026-04-06 12:00:00', 2),
('Active Connections', 45.00, 'count', '2026-04-06 12:00:00', 1),
('Delivery Success Rate', 92.50, '%', '2026-04-06 12:00:00', 3);

INSERT INTO Data_Correction
(UserID, Correction_Type, Correction_Date, Old_Value, New_Value, CorrectedByUserID) VALUES
(1, 'GPA Update', '2026-03-10 15:00:00', '3.70', '3.75', 2),
(1, 'Application Status Correction', '2026-03-18 16:30:00', 'Applied', 'Interview Scheduled', 4);