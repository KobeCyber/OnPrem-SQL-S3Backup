This project demonstrates how to automate backups from an on-premises Microsoft SQL Server to Amazon S3 for secure, durable, and cost-effective storage. By leveraging SQL Server’s native backup functionality and AWS tools, we ensure production data is safely stored offsite and can be restored when needed.

## Step 1: I created my S3 bucket - standard                                                                   
<img width="372" height="259" alt="image" src="https://github.com/user-attachments/assets/ac15037c-4e4a-4e7f-81cf-1ea482a4b33f" />

### S3 Security & Management Configuration
- **Blocked public access**  
- **Enabled bucket versioning** for restorability  
- **Created S3 Lifecycle policy** with 10-day retention before storage expires  
- **Kept S3's default encryption (SSE-S3)**
- **Create folder called dailybackup**

## Step 2: Create User and Set IAM Policy

<img width="372" height="259" alt="image" src="https://github.com/user-attachments/assets/e17dbbcb-b0ee-4e8a-a0fd-76785a3845fd" />

- Create a user you can use as a service account
- Set permissions to attach polciies directly
- Select create policy
- Manually specify permissionrs or use my json script in the repository **"s3-sql-iam-policy.json"**
- Create Access key for your service account
 #### Specify Permissions ***make sure to change name to your bucket name**
- **Service:** S3
- **Add Permissions:** ListBucket, GetObject, PutObject
- **Add Resources** | **Bucket:** arn:aws:s3:::kobecyber-s3-sqlbackup | **Object:** arn:aws:s3:::kobecyber-s3-sqlbackup /*

## Step 3: On-Prem Windows SQL Setup

<img width="372" height="259" alt="image" src="https://github.com/user-attachments/assets/88911899-3f8b-4ace-9ad2-46afcee773e5" />

- We will use a Windows Server 2022 running SQL
- Install AWS CLI on to your server - https://aws.amazon.com/cli/
- Run powershell as an admin and run aws configure(Follow input and output in screenshot above)
- next we will grab our **powershell script** copy it and configure it to your specifications
- drop powershell in a folder as "Backup-SQL-To-S3.ps1"
- open task scheduler
- create a new task
- run whether user is logged on or not
- run with highest privileges
- select it to trigger everyday
- set actions to "start a program:
- program/script to "powershell.exe"
- Arguments to "-File "C:\SetFilePathToYourBackupScript"
- Test run task

  ## Result: An SQL backup has been uploaded to our S3
  

   <img width="259" height="372" alt="image" src="https://github.com/user-attachments/assets/fb00d063-1f2b-45dd-bc37-b1816d903cac" />

  



