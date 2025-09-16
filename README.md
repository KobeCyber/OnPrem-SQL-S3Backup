SQL Server Backups to AWS S3
📌 Project Overview

This project demonstrates how to automate backups from an on-premises Microsoft SQL Server to Amazon S3 for secure, durable, and cost-effective storage. By leveraging SQL Server’s native backup functionality and AWS tools, we ensure production data is safely stored offsite and can be restored when needed.

🛠️ Tools & Services Used

Microsoft SQL Server (on-premises)

Windows Task Scheduler (to automate backup jobs)

AWS CLI (for uploading backups to S3)

Amazon S3 (storage destination for backups)

⚙️ How It Works

SQL Backup – A T-SQL script or SQL Agent job creates a .bak file of the database.

Upload Script – A PowerShell or batch script uses the AWS CLI to transfer the backup file to an S3 bucket.

Automation – Windows Task Scheduler runs the upload script on a set schedule (e.g., nightly).

Retention – S3 lifecycle policies manage old backups (e.g., move to Glacier after 30 days).

🚀 Steps to Reproduce

Install and configure AWS CLI on your SQL Server host.

Create an S3 bucket for database backups.

Write a SQL backup script that outputs .bak files to a folder.

Write an upload script (PowerShell or batch) to send files to S3.

Schedule both tasks with Windows Task Scheduler or SQL Server Agent.

(Optional) Configure S3 lifecycle policies for cost optimization.

🔒 Security Notes

Use an IAM user with least-privilege access to the S3 bucket.

Consider S3 bucket encryption for compliance.

Monitor backups with CloudWatch or scripts that log upload results.
