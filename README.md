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
- Manually specify permissionrs or use my json script
- Create Access key for your service account
 #### Specify Permissions ***make sure to change name to your bucket name**
- **Service:** S3
- **Add Permissions:** ListBucket, GetObject, PutObject
- **Add Resources** | **Bucket:** arn:aws:s3:::kobecyber-s3-sqlbackup | **Object:** arn:aws:s3:::kobecyber-s3-sqlbackup /*

